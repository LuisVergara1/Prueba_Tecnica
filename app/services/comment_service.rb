class CommentService
  def self.get_all
    comments = Comment.all.map { |comment| comment.as_json(only: [:id, :body,:earthquake_id]) }
    comments
  end

  def self.get_by_id(feature_id)
    feature = Earthquake.find(feature_id)
    comments = feature.comments.map { |comment| comment.as_json(only: [:id, :body ,:earthquake_id]) }
    comments
  end

end
