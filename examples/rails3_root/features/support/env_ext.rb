# email testing in cucumber
require 'email_spec/cucumber'

# patch to remove warnings like this :
# savingstar-web/vendor/bundle/ruby/1.9.1/gems/rack-1.2.5/lib/rack/utils.rb:16: warning: regexp match /.../n against to UTF-8 string
require 'rack_util_warnings_patch'
