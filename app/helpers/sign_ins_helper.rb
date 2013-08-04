module SignInsHelper
  def provider_sign_in_link(provider)
    link_to(
      "Sign in with #{provider.titleize}",
      "/auth/#{provider}",
      rel: "#{provider}-sign-in",
      class: %i(btn btn-primary btn-large)
    )
  end
end
