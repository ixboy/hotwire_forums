module ApplicationHelper
  include Pagy::Frontend
  def display_msg
    concat content_tag(:div, alert, class: 'alert alert-danger') if alert.present?
    content_tag(:div, notice, class: 'alert alert-success') if notice.present?
  end

  def links_when_logged_in
    return unless signed_in?

    concat  link_to Current.user.username, edit_user_registration_path, class: 'nav-item nav-link'
    link_to 'log out', destroy_user_session_path, method: :delete, class: 'nav-item nav-link',
                                                  data: { turbo_method: :delete }
  end

  def links_when_logged_out
    return if signed_in?

    concat link_to 'Sign up', new_user_registration_path, class: 'nav-item nav-link'
    link_to 'Log in', new_user_session_path, class: 'nav-item nav-link'
  end
end
