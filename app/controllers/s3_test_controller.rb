class S3TestController < ApplicationController
  def upload_to_s3
    s3 = Aws::S3::Resource.new(
      region: 'ap-southeast-1',
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )

    bucket_name = 'hr-api-bucket'
    file_key = 'your_file_key'
    file_path = 'public/images/boy.png'

    obj = s3.bucket(bucket_name).object(file_key)

    obj.upload_file(file_path)

    render json: { message: 'File uploaded to S3 successfully' }
  end
end
