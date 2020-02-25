class FavoritesController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		user = book.user
		favorite = current_user.favorites.new(book_id: book.id) #currentがないと、前行の本のuser idが周り続け、showページでcurrent_userの定義があるから、他者のいいねを押すとelseが適用される。
		favorite.save
		if request.referer&.include?(book_path(book)) #遷移元へ戻るコード
			redirect_to book_path(book)
		else
			redirect_to user_path(user)
		end
	end

	def destroy
		book = Book.find(params[:book_id])
		user = book.user
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		if request.referer&.include?(book_path(book))
			redirect_to book_path(book)
			else
			redirect_to user_path(user)
		end
	end
end
