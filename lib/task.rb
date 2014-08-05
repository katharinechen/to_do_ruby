require 'pg'
require 'pry'


class Task
  attr_reader :name, :list_id

  def initialize(attributes)
    @name = attributes['name']
    @list_id = attributes['list_id']
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      tasks << Task.new({'name' => name, 'list_id' => list_id})
    end
    tasks
  end

  def self.list_tasks(id)
    list_result = DB.exec("SELECT * FROM tasks WHERE list_id = #{id};")
    list = []
    list_result.each do |task|
      name = task['name']
      list_id = task['list_id'].to_i
      list << Task.new({'name' => name, 'list_id' => list_id})
    end
    list
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', #{@list_id});")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end
end
