class SpicesController < ApplicationController
    def index
        spices = Spice.all
        render json: spices, status: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end 

    def update
        spice = spice_find
        spice.update(spice_params)
        render json: spice
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end

    def destroy
        spice = spice_find
        spice.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end

    private

    def spice_find
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: {error: "spice not found"}, status: :not_found
    end
end