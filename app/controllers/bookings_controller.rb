class BookingsController < ApplicationController

  def index
    @bookings = policy_scope(Booking)

    # @bookings = Booking.where user = current_user
    # if current_user.id == params[:id],
      # redirect_to space_bookings_path
    # end
  end

  def new
    @space = Space.find(params[:space_id])
    @booking = Booking.new(space_id: @space.id)
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @space = Space.find(params[:space_id])
    @booking.space_id = @space.id
    authorize @booking
    if @booking.save
      redirect_to root_path
    else
      render :new
    end

  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @space = Space.find(params[:space_id])
    @booking = @space.bookings.destroy
    redirect_to @bookings.list
  end

  private

  def booking_params
    params.require(:booking).permit(:space_id, :user_id)
  end
end
