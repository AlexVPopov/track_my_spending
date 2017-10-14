# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    names = if params[:query].present?
              current_user.owned_tags.where('name LIKE ?', '%' + params[:query] + '%').pluck(:name)
            else
              current_user.owned_tags.order(:name).pluck(:name)
            end
    names.map! { |name| { id: name, text: name } }

    render json: names
  end
end
