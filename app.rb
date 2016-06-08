require 'sinatra'
require_relative 'boot'
require_relative './models/todo'

  get "/?" do
    @todos = Todo.desc(:created_at)
    erb :"todo/index"
  end

  # Get all of our todos
  get "/todos" do
    @todos = Todo.desc(:created_at)
    erb :"todo/index"
  end

  # Add the todo to the database
  post "/todos" do
    todo = Todo.new(params[:todo])
    if todo.save
      redirect "/"
    else
      erb :"todo/new"
    end
  end

  # Updates the todo with id in the database
  put "/todos/:id" do
    todo = Todo.find(params[:id])
    if params[:todo] && params[:todo][:done]
      todo.completed_at = Time.now
      todo.done = true
    else
      todo.done = false
      todo.completed_at = nil
    end
    todo.save
    redirect "/"
  end

  # Deletes the todo with id in the database
  delete '/todos/delete/:id' do
    todo = Todo.find(params[:id])
    todo.delete
    redirect '/'
  end
