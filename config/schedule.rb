require File.expand_path(File.dirname(__FILE__) + "/environment")
set :output, 'log/cron.log'

every 1.minute do
  command "echo '============================================================='"
  command "echo 'テスト'"
  command "echo '============================================================='"
end

every 1.day, :at => '3:30 am' do
  runner "User.task_to_run_at_three_thirty_in_the_morning"
end
