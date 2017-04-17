class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :message, message: I18n.t('comment.validation.message')

end
