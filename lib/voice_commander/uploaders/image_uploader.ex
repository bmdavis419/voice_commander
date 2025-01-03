defmodule VoiceCommander.ImageUploader do
  require Logger

  def upload(image_params, bucket) do
    file_uuid = UUID.uuid4()
    file_name = "#{file_uuid}.png"

    operation =
      ExAws.S3.put_object(
        bucket,
        file_name,
        File.read!(image_params.path),
        content_type: "image/png",
        acl: "public-read"
      )

    case operation |> ExAws.request(region: "auto") do
      {:ok, response} ->
        Logger.info("Upload successful: #{inspect(response)}")
        {:ok, file_name}

      {:error, error} ->
        Logger.error("Upload failed: #{inspect(error)}")
        {:error, error}
    end
  end
end
