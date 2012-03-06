task :get_vundle do
	system('git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle')
end

task :bundle_install do
	system('gvim -u bundles.vim +BundleInstall +q +q')
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
  :link_vimrc,
  :get_vundle,
  :bundle_install
]

