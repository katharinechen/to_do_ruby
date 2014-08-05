require './lib/list'
require './lib/task'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'to_do_extra'})

def intro
  list_menu
end

def list_menu
  puts "Please add a list"
  list_name = gets.chomp
  puts "Press 't' to add a new task to the list, 'd' to display all list', or 'l' to add a new list."
  answer = gets.chomp.downcase
  new_list = List.new({'name'=>list_name})
  # binding.pry
  new_list.save

  if answer == "t"
    task_menu(new_list.id)
  elsif answer == "l"
    list_menu
  elsif answer == "d"
    master_list = List.all
    master_list.each do |list|
      puts list.name
    end
  else
    puts "Please enter a valid option."
  end
end

def task_menu(id)

  puts "Please enter a task"
  task_description = gets.chomp
  new_task = Task.new({'name' => task_description, 'list_id' => id})
  new_task.save

  puts "You have sucessfully saved your task! Here is a list of all of your tasks."
  list_menu
end

intro
