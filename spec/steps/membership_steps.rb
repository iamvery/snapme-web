step 'I add myself to a team' do
  send 'I view the teams page'
  find(membership_checkbox).set(true)
end

step 'I am on a team' do
  User.first.teams << Team.first
end

step 'I remove myself from a team' do
  send 'I view the teams page'
  find(membership_checkbox).set(false)
end

step 'I see myself on that team' do
  send 'I view a team'
  expect(page).to have_css(user_snapshot_caption, text: User.first.username)
end

step 'I do not see myself on that team' do
  send 'I view a team'
  expect(page).to_not have_css(user_snapshot_caption, text: User.first.username)
end

def membership_checkbox
  '[rel~=team-membership]'
end

def user_snapshot_caption
  '.user .thumbnail .caption'
end
