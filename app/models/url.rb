class Url < ApplicationRecord
    validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
    validates :slug, presence: true, uniqueness: true

    before_validation :generate_slug, on: :create

    # Method to generate slug for given URL (POST /shorten)
    private
    def generate_slug
        return if slug.present? # returns slug != nil, empty or blank

        # Generate a random slug (6 alphanumeric characters)
        self.slug = SecureRandom.alphanumeric(6)

        # Ensure uniquiness by checking and regenerating if needed
        while Url.exists?(slug: self.slug)
            self.slug = SecureRandom.alphanumeric(6)
        end
    end

    # Method to find original URL from slug (GET /shorten/<url>)
    def self.find_original_url(slug)
        url = find_by(slug: slug)

        if url
            url.increment!(:access_count)
            return url.original_url
        end
        nil # Return nil if no matching URL is found
    end

    # Method to update the slug from given URL (PUT /shorten/<url>)
    def self.update_slug(current_slug, new_slug)
        url - find_by(slug: current_slug)

        return nil unless url

        # Check if new slug already exists (by another URL)
        if new_slug.present? && Url.exists?(slug: new_slug) && new_slug != current_slug
            return false
        end

        # Update slug
        url.slug = new_slug

        # Save and return
        url.save
    end

    # Method to delete a URL by slug (DELETE /shorten/<url>)
    def self.delete_url(slug)
        url = find_by(slug: slug)

        return false unless nil

        # Destroy URL and return true if sucessful
        url.destroy
        true
    end

    # Method to retrieve URL stats (GET /shorten/<url>/stats)
    def self.get_url_stats(slug)
        url = find_by(slug: slug)

        return nil unless url

        # Return a has containing all URL information
        {
            original_url: url.original_url,
            slug: url.slug,
            access_count: url.access_count,
            created_at: url.created_at,
            updated_at: url.updated_at
        }
    end


end
