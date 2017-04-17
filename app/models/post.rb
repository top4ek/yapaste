class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :forked_from, class_name: 'Post', optional: true

  validates_presence_of :snippet, message: I18n.t('post.validation.snippet')
  validates_presence_of :title, message: I18n.t('post.validation.title')
  validates_presence_of :name, message: I18n.t('post.validation.name')
end
