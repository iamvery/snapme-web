step 'there is a team named :name' do |name|
  Team.create!(name: name)
end

step 'existing user is a part of team :name' do |name|
  team = Team.find_by_name(name)
  team.users << User.first
end

step 'I view the teams page' do
  visit teams_path
end

step 'I view the :name team page' do |name|
  team = Team.find_by_name(name)
  visit team_path(team.id)
end

step 'I add a team named :name' do |name|
  find('[rel~=add-team]').click
  fill_in 'Name', with: name
  click_on 'Create Team'
end

step 'I see the team :name' do |name|
  expect(page).to have_content(name)
end
