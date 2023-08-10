class CarsController < ApplicationController
    require 'aws-sdk-dynamodb'

  def new
    @car = Car.new
  end

  def create
    car_params = params.require(:car).permit(:propietario, :placa, :modelo, :color)

    if save_dynamo(car_params)
      redirect_to cars_path, notice: 'Usuario creado exitosamente.'
    else
      render :new
    end
  end

  private

  def save_dynamo (car_params)

    dynamodb_client = Aws::DynamoDB::Client.new(
      credentials: Aws::Credentials.new('3h4wl', 'dgr4e5'),
      region: 'localhost',  
      endpoint: 'http://localhost:8000'
      )
    table_name = 'Cars'

    dynamodb_client.put_item({
      table_name: table_name,
      item: {
        'propietario' => car_params[:propietario],
        'placa' => car_params[:placa],
        'modelo' => car_params[:modelo],
        'color' => car_params[:color]
      }
    })
    puts "El usuario se registro exitosamente"
    return true

  rescue Aws::DynamoDB::Errors::ServiceError => e
      puts "Error de DynamoDB: #{e.message}"
      return false
    end
end
