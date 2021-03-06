class Api::PartiesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!, except: :next_party
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    puts current_user.inspect
    @parties = Party.all
    render json: @parties
  end

  def next_party
    @party = Party.next
    render json: @party
  end
  # GET /parties/1
  def show
    render json: @party
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  def create
    @party = Party.new(party_params)

    if @party.save
      render json:  {message: 'Party was successfully saved', type: 'success'}
    else
      render json: { message: 'Party was not saved', type: 'fault'}
    end
  end

  # PATCH/PUT /parties/1
  def update
    if @party.update(party_params)
      render json:  {message: 'Party was successfully updated', type: 'success'}, status: 200
    else
      render json:  {message: 'Party was not updated', type: 'fault'}
    end
  end

  # DELETE /parties/1
  def destroy
    @party.destroy
    render json: {message: 'successfully destroyed', type: 'success'}
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:title, :date, :location)
    end
end
