class UrlsController < ApplicationController
  def generate_slug
    url = Url.new(url_params)

    if url.save
      render json: { original_url: url.original_url, slug: url.slug }, status: :created
    else
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def find_original
    original_url = Url.find_original_url(params[:slug])

    if original_url
      render json: { original_url: original_url }
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  def update_slug
    result = Url.update_slug(params[:slug], params[:new_slug])

    case result
    when true
      render json: { message: "Slug updated successfully", new_slug: params[:new_slug] }
    when false
      render json: { error: "Slug already exists" }, status: :conflict
    when nil
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  def delete_slug
    result = Url.delete_url(params[:slug])

    if result
      render json: { message: "URL deleted successfully" }, status: :ok
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  def get_stats
    stats = Url.get_url_stats(params[:slug])

    if stats
      render json: stats
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  def url_params
    params.require(:url).permit(:original_url, :slug)
  end
end
