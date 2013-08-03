step 'I view the homepage' do
  visit root_path
end

step 'I view the sign in page with invitation :token' do |token|
  visit sign_in_path(invitation_token: token)
end

step 'I view the sign in page without invitation token' do
  send 'I view the sign in page with invitation :token', nil
end

step 'I view the sign in page with an invalid invitation token' do
  send 'I view the sign in page with invitation :token', 'deadbeef'
end

step 'I view the sign in page with a valid invitation token' do
  send 'I view the sign in page with invitation :token', invitation.token
end

step 'I sign out' do
  find('[rel~=sign-out]').click
end

step 'I am signed in' do
  visit sign_in_path(invitation_token: invitation.token)
  send 'I sign in with Github'
end

step 'I have signed in before' do
  send 'I am signed in'
  send 'I sign out'
end

step 'I sign in with Github' do
  find('[rel~=github-sign-in]').click
end

step 'I am asked to sign in' do
  expect(current_path).to eq(sign_in_path)
end

step %q(I see that I'm not signed in) do
  expect(page).to have_content(sign_in_failure_alert)
end

step %q(I see that I'm signed in) do
  expect(page).to have_content(sign_in_success_notice)
end

step %q(I see that I'm signed out) do
  expect(page).to have_content(sign_out_success_notice)
end

def sign_in_failure_alert
  I18n.t('sign_in.failure')
end

def sign_in_success_notice
  I18n.t('sign_in.success')
end

def sign_out_success_notice
  I18n.t('sign_out.success')
end

def invitation
  Invitation.create!
end
