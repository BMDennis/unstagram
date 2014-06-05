json.comment @comment.comment
json.email   @comment.user.email
json.post_id @comment.post_id
json.comment_count pluralize(@post.comments.count, 'comment')