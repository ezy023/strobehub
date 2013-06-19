class RelationshipsController < ApplicationController


  def create
    @user = User.find(params[:user_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(other_user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
