module Models::Plugins::Author
  def author
    if self.respond_to? :author and self.attributes['author'].blank?
      return 'Anonymous'
    end

    self.attributes['author']
  end

  private

  def create_author
    if self.respond_to? :user_id and self.respond_to? :author
      if self.user_id.present? and self.author.blank?
        user = User.find(self.user_id)
        self.author = user.name if user.present?
      end
    end
  end
end