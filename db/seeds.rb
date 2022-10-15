# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(email: 'jkloaiza19+6@gmail.com', password: 'wipip123', password_confirmation: 'wipip123')

3.times do
    Course.create!([{
        title: Faker::Educator.course_name,
        description: Faker::Marketing.buzzwords,
        short_description: Faker::Company.catch_phrase,
        user: user,
        price: Faker::Number.decimal(l_digits: 2),
        level: 'Beginer'
    }])
end
