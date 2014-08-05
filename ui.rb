require './lib/list'
require './lib/task'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'to_do_extra'})
DB.exec("DELETE FROM lists *;")
DB.exec("DELETE FROM tasks *;")

def intro
  loop do
    list_menu
  end
end

def list_menu
  puts "Please add a list"
  list_name = gets.chomp
  puts "Press 't' to add a new task to the list, 'd' to display all list', or 'l' to add a new list."
  answer = gets.chomp.downcase
  @new_list = List.new({'name'=>list_name})
  @new_list.save

  if answer == "t"
    task_menu(@new_list.id)
  elsif answer == "l"
    list_menu
  elsif answer == "d"
    list_list
    delete_list
  else
    puts "Please enter a valid option."
  end
end

def delete_list

  puts "Would you like to delete a list? Y/N"
  answer = gets.chomp.downcase

  if answer == "y"
    puts "Please enter the name of the list you want to delete"
    puts "Here are all of your lists:"
    list_list
    list_delete = gets.chomp
    @new_list.delete(list_delete)
    puts "You have successfully deleted the list."
  elsif answer == "n"
    list_menu
  else
    puts "Please enter a valid input."
  end
end

def list_list
  master_list = List.all
  master_list.each do |list|
    puts list.name
  end
end

def task_menu(id)

  puts "Please enter a task"
  task_description = gets.chomp
  new_task = Task.new({'name' => task_description, 'list_id' => id})
  new_task.save

  puts "You have sucessfully saved your task! Here is a list of all of your tasks."
  list_task(id)
  list_menu
end

def list_task(id)
  task_list = Task.list_tasks(id)
  task_list.each do |task|
    puts task.name
  end
end

intro
