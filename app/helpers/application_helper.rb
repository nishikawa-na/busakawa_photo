module ApplicationHelper
  def check_login
    if logged_in?
      render 'shared/header_login' 
    else
      link_to root_path do
        image_tag "profile.png", class: "header_icon"
      end
    end
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults')
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('profile.png')

    configs = {
      separator: '|',
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('profile.png')
      },
      og: {
        type: 'website',
        title:,
        description:,
        url: request.original_url,
        image:,
        keywords:,
        site_name: site
      },
      twitter: {
        card: 'summary',
        site:,
        title:,
        description:,
        keywords:,
        image:
      }
    }
    set_meta_tags(configs)
  end
end
