task :get_vundle do
	system('git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git')
end

task :bundle_install do
	system('vim -u bundles.vim +BundleInstall +q')
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
  :get_vundle,
  :bundle_install,
  :link_vimrc
]

