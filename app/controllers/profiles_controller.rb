class ProfilesController < ApplicationController
    #GET to user/:user_id/profile/new
    def new
        @profile = Profile.new
    end

    #POST to user/:user_id/profile
    def create
        @user=User.find(params[:user_id])
        @profile = @user.build_profile(profile_params)

        if @profile.save
            flash[:success] = 'Profile created successfully.'
            redirect_to user_path(@user)
        else
            flash.now[:danger] = @profile.errors.full_messages.to_sentence
            render :new, status: :unprocessable_entity
        end
    end

    #GET to user/:user_id/profile/edit
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end

    #PATCH to user/:user_id/profile
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if @profile.update(profile_params)
            flash[:success] = 'Profile updated successfully.'
            redirect_to user_path(@user)
        else
            flash.now[:danger] = @profile.errors.full_messages.to_sentence
            render :edit, status: :unprocessable_entity
        end
    end

    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description, :avatar)
        end
end