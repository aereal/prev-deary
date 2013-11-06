# Helper methods defined here can be accessed in any controller or view in the application

Deary::App.helpers do
  def article_tag(options = {}, &block)
    unless article_permalink?
      options = options.merge(
        itemscope: true,
        itemtype:  article_type,
        itemprop:  :BlogPost,
      )
    end
    content_tag(:article, options, &block)
  end

  def article_permalink?
    (request.controller == 'entries') && (request.action == :show)
  end

  def article_type
    article_permalink? ? :Article : :BlogPosting
  end

  def page_type
    article_permalink? ? :Blog : :Article
  end

  def site_title
    settings.site_title
  end

  def page_title
    [@page_title, site_title].compact.join(' | ')
  end
end
