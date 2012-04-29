When /^I run the step:$/ do |step_to_run|
  begin
    steps %Q{#{step_to_run}}
  rescue Exception => e
    # puts "e = #{e}"
    # puts "e.message = #{e.message}"
    @last_error_exception = e
  end
end

Then /^I should get a helpful error message containing:$/ do |error_msg|
  if @last_error_exception
    @last_error_exception.message.should include(error_msg)
  else
    raise "No exception found in @last_error_exception"
  end
end
