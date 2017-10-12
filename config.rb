###
# Page options, layouts, aliases and proxies
###
activate :i18n, :mount_at_root => :it
Time.zone = "Rome"


# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false


# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Change Compass configuration
compass_config do |config|
  config.add_import_path "bower_components/foundation-sites/scss/"
  config.output_style = :compact

  # Set this to the root of your project when deployed:
  config.http_path = "/"
  config.css_dir = "stylesheets"
  config.sass_dir = "stylesheets"
  config.images_dir = "images"
  config.javascripts_dir = "javascripts"
end

activate :sprockets
# Add bower's directory to sprockets asset path
after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

# Reload the browser automatically whenever files change
configure :development do
  #activate :livereload
end

# Use the correct vendor prefixes for foundation
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'ie >= 9', 'and_chr >= 2.3']
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :partials_dir, 'partials'

activate :directory_indexes

set :index_file, "index.html"

activate :prismic_middleman do |f|
  f.url = 'https://philips-defibrillatori.prismic.io/api'

  f.conf = {
        'blog'=> {
            'permalink'=> '/blog/{category}/{year}-{month}-{day}-{title}.html',
            'default_extension'=> ".erb",
            'template'=> "fdt_templates/blog.tt"
        },
        'news'=> {
            'permalink'=> '/news/view/{title}.html',
            'default_extension'=> ".erb",
            'template'=> "fdt_templates/news.tt"
        }
    }
end

activate :fdtCrm_middleman do |f|
  f.fdtCrm_url = 'https://blsdcrm.mod.bz/api/middleman'
end

activate :blog do |blog|
    blog.name = 'blog'
    blog.default_extension = ".erb"

    blog.tag_template = "tag.html"
    blog.calendar_template = "calendar.html"
    blog.sources = "/blog/{category}/{year}-{month}-{day}-{title}.html"
    blog.permalink = "/blog/{category}/{year}-{month}-{day}-{title}.html"

    # Enable pagination
    blog.paginate = true
    blog.per_page = 10
    blog.page_link = "page/{num}"

    blog.custom_collections = {
        category: {
            link: '/blog/categories/{category}.html',
            template: '/category.html'
        }
    }
end

activate :blog do |blog|
    blog.name = 'news'
    blog.default_extension = ".erb"

    blog.tag_template = "tag.html"
    blog.calendar_template = "calendar.html"
    blog.sources = "/news/view/{title}.html"
    blog.permalink = "/news/view/{title}.html"

    # Enable pagination
    blog.paginate = true
    blog.per_page = 10
    blog.page_link = "page/{num}"

end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :gzip

  # activate :minify_html

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
