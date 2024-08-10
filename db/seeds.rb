# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a new teacher
Teacher.create!(
  name: "John Doe",
  username: "johndoe",
  password: "password123" # Ensure you use a secure method for password handling in production
)