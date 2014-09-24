#To Do List (PSQL)

##About
This project was completed by Katharine Chen and Sanjeev Sekar for Epicodus.

##Description
This project is to create a simple to do list with PSQL.

##Installation
Clone the repository in your terminal.

    git clone https://github.com/katharinechen/to_do_ruby.git

After installing Postgres, enter the following code to create the apprropriate databases and files.

```psql
psql
CREATE DATABASE to_do_list;
\c to_do_list;
CREATE TABLE list (id serial PRIMARY KEY, name varchar);
CREATE TABLE TASK (id serial PRIMARY KEY, name varchar, line_id int);
```

After creating the necessary table in to_do_list database, clone the database for testing.

```psql
\c epicodus;
CREATE DATABASE to_do_list_test WITH TEMPLATE to_do_list;
```

To run the program, run ui.rb after installing Ruby.

    ruby ui.rb

##License
MIT
