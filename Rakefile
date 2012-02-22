# Stolen from https://github.com/mislav/vimfiles and https://github.com/carlhuda/janus/blob/master/Rakefile

def vim_plugin_task(name, repo=nil)
  dir = File.expand_path("bundle/#{name}")

  namespace(name) do
    if repo
      file dir do
        if repo =~ /git$/ or repo =~ /^git:/
          sh "git clone #{repo} #{dir}"

        elsif repo =~ /download_script/
          if filename = `curl --silent --head #{repo} | grep attachment`[/filename=(.+)/,1]
            filename.strip!
            sh "curl #{repo} > bundle/#{filename}"
          else
            raise ArgumentError, 'unable to determine script type'
          end

        elsif repo =~ /(tar|gz|vba|zip)$/
          filename = File.basename(repo)
          sh "curl #{repo} > bundle/#{filename}"

        else
          raise ArgumentError, 'unrecognized source url for plugin'
        end

        case filename
        when /zip$/
          sh "unzip -o bundle/#{filename} -d #{dir}"

        when /tar\.gz$/
          dirname  = File.basename(filename, '.tar.gz')

          sh "tar zxvf bundle/#{filename}"
          sh "mv #{dirname} #{dir}"

        when /vba(\.gz)?$/
          if filename =~ /gz$/
            sh "gunzip -f bundle/#{filename}"
            filename = File.basename(filename, '.gz')
          end

          # TODO: move this into the install task
          mkdir_p dir
          lines = File.readlines("bundle/#{filename}")
          current = lines.shift until current =~ /finish$/ # find finish line

          while current = lines.shift
            # first line is the filename (possibly followed by garbage)
            # some vimballs use win32 style path separators
            path = current[/^(.+?)(\t\[{3}\d)?$/, 1].gsub '\\', '/'

            # then the size of the payload in lines
            current = lines.shift
            num_lines = current[/^(\d+)$/, 1].to_i

            # the data itself
            data = lines.slice!(0, num_lines).join

            # install the data
            Dir.chdir dir do
              mkdir_p File.dirname(path)
              File.open(path, 'w'){ |f| f.write(data) }
            end
          end
        end
      end

      task :pull => dir do
        if repo =~ /git$/
          Dir.chdir dir do
            sh "git pull"
          end
        end
      end

      task :install => [:pull] do
        Dir.chdir dir do
          if File.exists?("Rakefile") and `rake -T` =~ /^rake install/
            sh "rake install"
          elsif File.exists?("install.sh")
            sh "sh install.sh"
          end
        end

        yield if block_given?
      end
    end
  end

  desc "Install #{name} plugin"
  task name do
    puts
    puts "*" * 40
    puts "*#{"Installing #{name}".center(38)}*"
    puts "*" * 40
    puts
    Rake::Task["#{name}:install"].invoke
  end
  task :default => name
end

vim_plugin_task "ack.vim",          "git://github.com/mileszs/ack.vim.git"
# vim_plugin_task "conque",           "http://conque.googlecode.com/files/conque_1.1.tar.gz"
vim_plugin_task "nerdcommenter",    "git://github.com/ddollar/nerdcommenter.git"
vim_plugin_task "supertab-plugin",         "git://github.com/ervandew/supertab.git"
# vim_plugin_task "neocomplcache", "git://github.com/Shougo/neocomplcache.git"
# vim_plugin_task "fuzzy-finder",     "git://github.com/vim-scripts/FuzzyFinder.git"
# vim_plugin_task "l9", "git://github.com/vim-scripts/L9.git"
vim_plugin_task "bufkill", "git://github.com/vim-scripts/bufkill.vim.git"
vim_plugin_task "vim-latex", "git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex"
vim_plugin_task "pathogen", "git://github.com/tpope/vim-pathogen.git"
vim_plugin_task "ir-black", "git://github.com/wgibbs/vim-irblack.git"
vim_plugin_task "tagbar", "git://github.com/majutsushi/tagbar.git"
vim_plugin_task "solarized", "git://github.com/altercation/vim-colors-solarized.git"
vim_plugin_task "ctrlp", "git://github.com/kien/ctrlp.vim.git" 
vim_plugin_task "python-mode", "git://github.com/klen/python-mode.git"
vim_plugin_task "vim-markdown-preview", "git://github.com/rdeits/vim-markdown-preview.git"
vim_plugin_task "yankring", "git://github.com/vim-scripts/YankRing.vim.git"


# On ubuntu, this requires that you do "sudo apt-get install ruby1.8-dev" first
# vim_plugin_task "command-t",        "http://s3.wincent.com/command-t/releases/command-t-1.2.1.vba" do
#   Dir.chdir "bundle/command-t/ruby/command-t" do
#     if File.exists?("/usr/bin/ruby1.8") # prefer 1.8 on *.deb systems
#       sh "/usr/bin/ruby1.8 extconf.rb"
#     elsif File.exists?("/usr/bin/ruby") # prefer system rubies
#       sh "/usr/bin/ruby extconf.rb"
#     elsif `rvm > /dev/null 2>&1` && $?.exitstatus == 0
#       sh "rvm system ruby extconf.rb"
#     elsif `rbenv > /dev/null 2>&1` && $?.exitstatus == 0
#       sh "RBENV_VERSION=system ruby extconf.rb"
#     end
#     sh "make clean && make"
#   end
# end

desc "Update the documentation"
task :update_docs do
  puts "Updating VIM Documentation..."
  system "vim -e -s <<-EOF\n:Helptags\n:quit\nEOF"
end

task :link_vimrc do
  %w[vimrc gvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist? dotfile
      warn "~/.#{script} already exists"
    else
      ln_s File.join('.vim', script), dotfile
    end
  end
end

task :default => [
  :update_docs,
  :link_vimrc
]

