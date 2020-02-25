class BookCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id #bookからid をとり、comment のid を振る
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		comment = BookComment.find(params[:book_id]) #:book_id の理由、/books/:book_id/book_comments(.:format)より
		comment.destroy
		redirect_to book_path(comment.book_id) #comment カラムのbook_idを取得している
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment, :user_id, :book_id, :created_at)
	end
end
