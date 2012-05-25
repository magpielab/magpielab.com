class BodyClassTag < Liquid::Tag  

  def prefixed_body_class(prefix, id)
    id = id.gsub(/\.\w*?$/, '') # Remove extension from url
    id = id.gsub(/[-\/]/, '_')  # Replace '-' and '/' with underscore
    id = id.gsub(/^_/, '')      # Remove leading '_'

    case prefix
    when "class"
      prefix = ""
    else
      prefix = "#{prefix}_"
    end

    "#{prefix}#{id}"
  end

  def render(context)
    page = context.environments.first["page"]
    classes = []

    %w[class url categories tags layout].each do |prop|
      next unless page.has_key?(prop)
      if page[prop].kind_of?(Array)
        page[prop].each { |proper| classes.push prefixed_body_class(prop, proper) }
      else
        classes.push prefixed_body_class(prop, page[prop])
      end
    end

    classes.join(" ")
  end

end
Liquid::Template.register_tag('body_class', BodyClassTag)