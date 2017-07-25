module Layouts

  # Taken from https://github.com/github/help-docs/blob/master/lib/layouts.rb
  def process_category_articles(category_articles, prefix)
    output = ''
    puts "prefix #{prefix}"
    # FIXME: dumb hack to account for the fact that TOC listings are apparently
    # styled different on dotcom and Enterprise
    ul_style = prefix =~ /desktop|enterprise/ ? '' : 'chevron list'
    # category_articles can be false of the data is versioned out
    return output unless category_articles
    category_articles.each do |article|
      if article.is_a?(Hash)
        key = article.keys.first
        output << <<-HTML
        <li class="article">
          <a href="#{prefix}/#{key.parameterize}" class="km-article-link">#{key}</a>
          <ul class="#{ul_style}">
        HTML
         article[key].each do |subarticle|
           output << <<-HTML
               <li class="article">
                 <a href="#{prefix}/#{subarticle.parameterize}" class="km-article-link">#{subarticle}</a>
               </li>
           HTML
         end
         output << '</ul></li>'
      else
        output << <<-HTML
        <li class="article">
          <a href="#{prefix}/#{article.parameterize}" class="km-article-link">#{article}</a>
        </li>
        HTML
      end
    end
    output.gsub(/^\s*/m, '')
  end

  def generate_guide_toc(item, rep)
    output = "<ul>\n"
    output << process_category_articles(NanocConrefFS::Variables.fetch_data_file(item[:data_association], rep), guide_path(item.identifier))
    output << "</ul>\n"
  end


  def guide_path(identifier)
    dest = File.dirname(identifier.without_ext)
    inject_enterprise_version(dest)
  end

  def inject_enterprise_version(identifier)
    identifier.to_s.sub(/admin/, "#{@config[:latest_enterprise_version]}/admin")
  end
end

include Layouts
