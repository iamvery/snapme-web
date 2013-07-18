step 'I view the homepage' do
  visit root_path
end

step 'I sign out' do
  find('[rel~=sign-out]').click
end

step 'I am signed in' do
  visit sign_in_path
  send 'I sign in with Github'
end

step 'I sign in with Github' do
  find('[rel~=github-sign-in]').click
end

step 'I am asked to sign in' do
  expect(current_path).to eq(sign_in_path)
end

step %q(I see that I'm signed in) do
  expect(page).to have_content(sign_in_success_notice)
end

step %q(I see that I'm signed out) do
  expect(page).to have_content(sign_out_success_notice)
end

def sign_in_success_notice
  I18n.t('sign_in.success')
end

def sign_out_success_notice
  I18n.t('sign_out.success')
end
