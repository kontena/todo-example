class Todo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :done, type: Boolean
  field :completed_at, type: DateTime
end
