# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :tables => true, :footnotes => true

activate :directory_indexes
activate :syntax

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings
configure :build do
  activate :minify_css
  activate :minify_javascript
end

# Generate "prev" and "next" links for each page
ready do
  chaps = [ "I", "II", "III", "IV", "V", "VI" ]
  pages = {}
  for r in sitemap.resources do
    c = r.destination_path.split("/")[0]
    if chaps.include?(c)
      if pages[c] == nil
        pages[c] = []
      end
      pages[c].push(r)
      pages[c] = pages[c].sort_by { |x| x.destination_path }
    end
  end

  for i in 0..(chaps.size - 1) do
    p = i - 1
    n = i + 1
    prev_chap = if p >= 0 then pages[chaps[p]] else nil end
    next_chap = if n < chaps.size then pages[chaps[n]] else nil end
    j = 0
    for p in pages[chaps[i]] do
      prev_page = if j == 0
                    if prev_chap == nil
                      nil
                    else
                      prev_chap[-1]
                    end
                  else
                    pages[chaps[i]][j - 1]
                  end
      next_page = if (j + 1) == pages[chaps[i]].size
                    if next_chap == nil
                      nil
                    else
                      next_chap[0]
                    end
                  else
                    pages[chaps[i]][j + 1]
                  end
      p.data.prev = if prev_page != nil then prev_page.destination_path.delete_suffix("/index.html") else nil end
      p.data.next = if next_page != nil then next_page.destination_path.delete_suffix("/index.html") else nil end
      puts p.data
      j += 1
    end
  end
end
