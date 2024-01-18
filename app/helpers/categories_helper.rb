module CategoriesHelper
  def discussion_count(category)
    return unless category.discussions_count

    content_tag(:span, category.discussions_count,
                class: 'badge bg-secondary rounded-pill text-light')
  end
end
