class Post < ActiveRecord::Base
  has_attached_file :picture, styles: { medium: '300x300>' },
                    storage: :s3,
                    s3_credentials: {
                              bucket: 'instagram_march',
                              access_key_id: Rails.application.secrets.s3_access_key,
                              secret_access_key: Rails.application.secrets.s3_secret_key
                            }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :likes
  has_and_belongs_to_many :tags

  def tag_names; end

  # Creates (if needed) and assigns the given tags to the
  # current post.
  #
  # Also strips all the '#' characters from the provided
  # tag names.
  def tag_names=(tag_names)
    tag_names.gsub('#', '').split(',').map(&:strip).uniq.each do |tag_name|
      tags << Tag.find_or_create_by(name: tag_name)
    end
  end
end
