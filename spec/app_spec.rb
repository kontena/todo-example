# spec/app_spec.rb
require_relative './spec_helper.rb'

describe "Todo Application" do
  describe '/' do
    it "redirects to /todos" do
      get '/'
      follow_redirect!
      expect(last_request.url).to eq('http://example.org/todos')
      expect(response).to be_ok
    end
  end

  describe 'GET /todos' do
    it "return todo items" do
      expect(Todo).to receive(:desc).with(:created_at).once.and_return [Todo.new(content: 'test')]
      get '/todos'
      expect(response).to be_ok
    end
  end

  describe 'POST /todos' do
    it "creates new todo item" do
      expect {
        post '/todos', {}, { 'todo' => { 'content' => 'test' } }
        follow_redirect!
      }.to change{Todo.count}.by(1)      
      expect(response).to be_ok
    end
  end
end
