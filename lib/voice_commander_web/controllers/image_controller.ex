defmodule VoiceCommanderWeb.ImageController do
  use VoiceCommanderWeb, :controller

  def create(conn, %{"image" => image_params}) do
    case VoiceCommander.ImageUploader.upload(image_params, "images") do
      {:ok, file_name} ->
        conn
        |> put_status(:ok)
        |> json(%{file_name: file_name})

      {:error, error} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Failed to upload image: #{inspect(error)}"})
    end
  end
end
