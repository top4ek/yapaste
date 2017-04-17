class PostDecorator < Draper::Decorator
  delegate_all

  def forked
    h.link_to h.fa_icon('fw code-fork'), object.forked_from, title: h.t('post.forked') if object.forked_from.present?
  end
end
