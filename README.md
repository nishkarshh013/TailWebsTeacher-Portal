# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# TailWebs-Teacher-Portal

1. Project Overview:
	This project is a Ruby on Rails application designed to manage students and their subjects. It includes features such as adding students, updating their subjects, and more.

2. Prerequisites:
	Before you begin, ensure you have the following installed:

	Ruby: Download and install Ruby
	Rails: Install Rails
	Node.js: Download and install Node.js
	Yarn: Install Yarn
	Database: SQLite3

3. Installation Steps
	1. Clone the Repository:
		git clone https://github.com/nishkarshh013/TailWebsTeacher-Portal.git
		cd TailWebsTeacher-Portal

	2.	Install Ruby Gems:
		Install the necessary Ruby gems:
			bundle install

	3.	Set Up the Database
		Create and migrate the database:
			rails db:create
			rails db:migrate
			rails db:seed (To create teacher where username is johndoe and password is password123)

	4.  Start the Rails Server:
			rails server
		Open your browser and go to http://localhost:3000 to see the application in action.

	5.  To ensure the application is functioning correctly, you should run the tests:
		rspec

	6. Common Issues:
		Database Connection Errors: Ensure your database configuration is correct and the database server is running.

		Missing Gems: Run bundle install to ensure all gems are installed.

Deployment Instructions
	For deploying the application to a production environment, follow the guidelines specific to your hosting provider (e.g., Heroku, AWS). Ensure to configure environment variables, database settings, and any additional services required.