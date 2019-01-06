class Article < ApplicationRecord
  has_many :comments
  
  before_validation :strip_html_tags, if: :text
  before_save :bold_markdown, if: :text

  validates :title, :text, :author, presence: true
  validates :title, length: { minimum: 5, maximum: 40 }
  validates :title, uniqueness: true, if: :title_changed?
  validate :custom_validation, if: :text

  def custom_validation
    if text.index(title)
      
      errors.add(:text, :cannot_contain_title)
    end
  end

  private

  def strip_html_tags
    text.gsub!(/<[^>]*>/, '')
  end
  
  def bold_markdown
    text.gsub!(/\*(.+?)\*/, '<b>\1</b>')
  end

end

