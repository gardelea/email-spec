require 'rubygems'

class EmailSpecWorld
  def self.root_dir
    @root_dir ||= File.join(File.expand_path(File.dirname(__FILE__)), "..", "..")
  end

  def root_dir
    EmailSpecWorld.root_dir
  end
  
  def setup_bundler_for_example_app(app_name)
    puts "setup_bundler_for_example_app : `bundle check` = #{`bundle check`}"
    puts "setup_bundler_for_example_app : `bundle list` = #{`bundle list`}"
    app_path = File.join(root_dir, 'examples', "#{app_name}_root")
    app_path = File.absolute_path(app_path)
    app_specific_gemfile = File.join(app_path,'Gemfile')

    puts "app_specific_gemfile = #{app_specific_gemfile.inspect}"

    # Bundler.with_clean_env do
      Dir.chdir(app_path) do
        puts "pwd = #{`pwd`}"
        # puts "$HOME/.rvm/scripts/rvm : #{`[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && . \"$HOME/.rvm/scripts/rvm\"`}"
        # puts "`rvm rvmrc load #{root_dir}` = #{`rvm rvmrc load #{root_dir}`}"
        # puts "`rvm info` = #{`rvm info`}"

        #hack to fight competing bundles (email specs vs rails3_root's
        if File.exists? app_specific_gemfile
          orig_gemfile = ENV['BUNDLE_GEMFILE']

          begin
            puts "orig_gemfile = #{orig_gemfile.inspect}"
            ENV['BUNDLE_GEMFILE'] = app_specific_gemfile
            Bundler.rubygems.refresh
            puts "`echo $BUNDLE_GEMFILE` = #{`echo $BUNDLE_GEMFILE`}"
            print "`env` = #{`env`}"
            puts "`bundle install --path ./vendor/bundle` = #{`bundle install --path ./vendor/bundle`}"
            puts "`bundle check` = #{`bundle check`}"
            puts "`bundle list` = #{`bundle list`}"

            yield app_specific_gemfile if block_given?
          ensure
            ENV['BUNDLE_GEMFILE'] = orig_gemfile
          end
        else
          yield if block_given?
        end
      end
    # end # Bundler.with_clean_env do

  end
end

World do
  EmailSpecWorld.new
end
