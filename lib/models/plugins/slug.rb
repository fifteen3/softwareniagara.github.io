module Models::Plugins::Slug

  private

  def create_slug
    if self.respond_to? :title and self.respond_to? :slug
      if self.title.present? and self.slug.blank?
        self.slug = self.title.parameterize
      end
    end
  end
end