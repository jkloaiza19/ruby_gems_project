require 'net/http'
require 'uri'
require 'json'

module Firebase
    # A class that is used to authenticate a user with Firebase.
    class Authenticator
        FIREBASE_URI = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{Rails.application.credentials.firebase_api_key}")
        FIREBASE_PUBLIC_KEY_URL = URI('https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com')
        JWT_ALGORITHM = 'RS256'.freeze

        # This is a class method that is used to sign up a user with Firebase.
        def self.sign_up(email, password)
            byebug
            response = Net::HTTP.post_form(FIREBASE_URI, "email": email, "password": password)

            if response.is_a?(Net::HTTPSuccess)
                byebug
                firebase_data = JSON.parse(response.body)

                return firebase_data
            end
        end

        # This is a class method that is used to verify a token.
        def self.verify_token(token)
            header = decode_header(token)
            alg = header['alg']
            kid = header['kid']

            raise StandardError.new "Invalid token alg header #{alg}" unless alg == JWT_ALGORITHM

            public_key = get_public_key(kid)
            byebug
            decoded_token = decode_token(token, public_key, Rails.application.credentials.firebase_project_id)

           is_valid_token?(decoded_token['exp'])
        end


        def self.decode_header(token)
            encoded_header = token.split('.').first

            JSON.parse(Base64.decode64(encoded_header))
        end

        ##
        # It fetches the public keys from Google, and then returns the public key that corresponds to the kid
        # header in the JWT
        #
        # Args:
        #   kid: The key ID of the public key that was used to sign the JWT.
        def self.get_public_key(kid)
            response = Net::HTTP.get(FIREBASE_PUBLIC_KEY_URL)

            raise StandardError.new "Failed to fetch JWT public keys from google" unless response.is_a?(String)

            public_keys = JSON.parse(response)

            raise StandardError.new "`invalid kid header" unless public_keys.include?(kid)

            OpenSSL::X509::Certificate.new(public_keys[kid]).public_key
        end

        ##
        # It takes a token, a public key, and a firebase project id, and returns the decoded token
        #
        # Args:
        #   token: The JWT token you want to verify.
        #   public_key: The public key for your Firebase project, which you can download from the Firebase
        # console.
        #   firebase_project_id: The project ID of your Firebase project.
        def self.decode_token(token, public_key, firebase_project_id)
            options = {
                algorithm: JWT_ALGORITHM,
                verify_iat: true,
                verify_aud: true,
                aud: firebase_project_id,
                verify_iss: true,
                iss: "https://securetoken.google.com/#{firebase_project_id}"
            }

            JWT.decode(token, public_key, true, options)
        end


      # Checking if the token is expired.
        def self.is_valid_token?(exp)
            current_time = Time.at(DateTime.now).utc.localtime
            token_expiration_time = Time.at(exp).utc.localtime

            token_expiration_time > current_time
        end
    end
end
