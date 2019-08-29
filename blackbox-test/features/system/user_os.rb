When(/^I go to (sys_directory|work_directory)$/) do |directory|
  case directory
  when 'sys_directory'
    FileUtils.cd("#{CommonVars::SYS_TEST}")
  when 'work_directory'
    FileUtils.cd("#{directory}")
  else
    raise "#{directory} is not supported"
  end
end

And(/^I create (file|dir) with "([^"]*)"$/) do |object, name|
  case object
  when 'file'
    FileUtils.touch name
  when 'dir'
    FileUtils.mkdir name
  else
    raise "#{object} is not supported"
  end
end

And(/^I put "([^"]*)" in file with "([^"]*)"$/) do |text, file_name|
  File.write file_name, text
end

Then(/^file "([^"]*)" should exist$/) do |name|
  specific_directory = `ls #{CommonVars::SYS_TEST}`.split
  expect(specific_directory).to include name
end

And(/^file "([^"]*)" should contain "([^"]*)"$/) do |file_name, text|
  file = `cat #{CommonVars::SYS_TEST}/#{file_name}`
  expect(file).to include text
end

Given(/^I have created file with text$/) do
  steps %(
    When I go to sys_directory
    And I create file with "readme.md"
       )
end

Then(/^file should have permission$/) do
  current_permission = `ls -ld $pwd`.strip
  expect(current_permission).to match /drwxr-xr-x \d+ root/
end

And(/^I execute (.*?) in console with params:$/) do |command, param|
  file_path = "#{CommonVars::SYS_TEST}"
  console_command = "#{command} #{param} "
  `#{console_command} #{file_path}readme.md`
end
