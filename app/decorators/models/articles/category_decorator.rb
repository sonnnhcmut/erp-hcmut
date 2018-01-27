Erp::Articles::Category.class_eval do
  # class const
  ALIAS_ABOUT_US = 'about_us'
  
  # get alias for contact
  def self.get_alias_options()
    [
      {text: I18n.t('blog'),value: self::ALIAS_BLOG},
      {text: I18n.t('about_us'),value: self::ALIAS_ABOUT_US}
    ]
  end
end