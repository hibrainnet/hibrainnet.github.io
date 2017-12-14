module Jekyll

class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Tag: "+tag.capitalize+""
    
    end
  end

  class TagsIndex < Page
    def initialize(site, base, dir, tags)
      @site = site
      @base = base
      @dir = dir
      @name = 'indexs.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tags.html')
      self.data['tags'] = tags
    end
  end

  class TagGenerator < Generator
    safe true


  def generate(site)
  dir = File.join('tags')
      site.tags.each_key do |tag|
        catdir = File.join(dir, tag)
        site.pages << TagIndex.new(site, site.source, catdir, tag)
        site.pages << TagsIndex.new(site, site.source, catdir, tag)
      end

        end
     
    end

  end


