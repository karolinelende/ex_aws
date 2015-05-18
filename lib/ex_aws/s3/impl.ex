defmodule ExAws.S3.Impl do

  @moduledoc false
  # Implementation of the AWS S3 API.
  #
  # See ExAws.S3.Client for usage.

  ## Buckets
  #############

  def list_buckets(client, opts \\ %{}) do
    request(client, :get, "", "/", params: opts)
  end

  def delete_bucket(client, bucket) do
    request(client, :delete, bucket, "/")
  end

  def delete_bucket_cors(client, bucket) do
    request(client, :delete, bucket, "/", resource: "cors")
  end

  def delete_bucket_lifecycle(client, bucket) do
    request(client, :delete, bucket, "/", resource: "lifecycle")
  end

  def delete_bucket_policy(client, bucket) do
    request(client, :delete, bucket, "/", resource: "policy")
  end

  def delete_bucket_replication(client, bucket) do
    request(client, :delete, bucket, "/", resource: "replication")
  end

  def delete_bucket_tagging(client, bucket) do
    request(client, :delete, bucket, "/", resource: "tagging")
  end

  def delete_bucket_website(client, bucket) do
    request(client, :delete, bucket, "/", resource: "website")
  end

  def list_objects(client, bucket, opts \\ %{}) do
    request(client, :get, bucket, "/", params: opts)
  end

  def get_bucket_acl(client, bucket) do
    request(client, :get, bucket, "/", resource: "acl")
  end

  def get_bucket_cors(client, bucket) do
    request(client, :get, bucket, "/", resource: "cors")
  end

  def get_bucket_lifecycle(client, bucket) do
    request(client, :get, bucket, "/", resource: "lifecycle")
  end

  def get_bucket_policy(client, bucket) do
    request(client, :get, bucket, "/", resource: "policy")
  end

  def get_bucket_location(client, bucket) do
    request(client, :get, bucket, "/", resource: "location")
  end

  def get_bucket_logging(client, bucket) do
    request(client, :get, bucket, "/", resource: "logging")
  end

  def get_bucket_notification(client, bucket) do
    request(client, :get, bucket, "/", resource: "notification")
  end

  def get_bucket_replication(client, bucket) do
    request(client, :get, bucket, "/", resource: "replication")
  end

  def get_bucket_tagging(client, bucket) do
    request(client, :get, bucket, "/", resource: "tagging")
  end

  def get_bucket_object_versions(client, bucket, opts \\ %{}) do
    request(client, :get, bucket, "/", resource: "versions", params: opts)
  end

  def get_bucket_request_payment(client, bucket) do
    request(client, :get, bucket, "/", resource: "requestPayment")
  end

  def get_bucket_versioning(client, bucket) do
    request(client, :get, bucket, "/", resource: "versioning")
  end

  def get_bucket_website(client, bucket) do
    request(client, :get, bucket, "/", resource: "website")
  end

  def head_bucket(client, bucket) do
    request(client, :head, bucket, "/")
  end

  def list_multipart_uploads(client, bucket, opts \\ %{}) do
    request(client, :get, bucket, "/", resource: "uploads", params: opts)
  end

  def put_bucket(client, bucket, region, opts \\ %{}) do
    body = """
    <CreateBucketConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <LocationConstraint>#{region}</LocationConstraint>
    </CreateBucketConfiguration>
    """
    request(client, :put, bucket, "/", body: body, headers: opts)
  end

  def put_bucket_acl(client, bucket, _owner_id, _owner_email, _grants) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_cors(client, bucket, _cors_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_lifecycle(client, bucket, _livecycle_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_policy(client, bucket, _policy) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_logging(client, bucket, _logging_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_notification(client, bucket, _notification_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_replication(client, bucket, _replication_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_tagging(client, bucket, _tags) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_requestpayment(client, bucket, _payer) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_versioning(client, bucket, _version_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  def put_bucket_website(client, bucket, _website_config) do
    raise "not yet implemented"
    request(client, :put, bucket, "/")
  end

  ## Objects
  ###########

  def delete_object(client, bucket, object, opts \\ %{}) do
    request(client, :delete, bucket, object, headers: opts)
  end

  def delete_multiple_objects(client, bucket, _objects) do
    raise "not yet implemented"
    request(client, :post, bucket, "/?delete")
  end

  def get_object(client, bucket, object, opts \\ %{}) do
    param_keys = ["response-content-type", "response-content-language", "response-expires", "response-cache-control", "response-content-disposition", "response-content-encoding"]
    response_opts = opts
    |> Map.take(param_keys)
    headers = opts
    |> Map.drop(param_keys)
    |> Enum.to_list
    request(client, :get, bucket, object, headers: headers, params: response_opts)
  end

  def get_object_acl(client, bucket, object, opts \\ %{}) do
    request(client, :get, bucket, object, resource: "acl", headers: opts)
  end

  def get_object_torrent(client, bucket, object) do
    request(client, :get, bucket, object, resource: "torrent")
  end

  def head_object(client, bucket, object, opts \\ %{}) do
    request(client, :head, bucket, object, headers: opts)
  end

  def options_object(client, bucket, object, origin, request_method, request_headers \\ []) do
    headers = [
      {"Origin", origin},
      {"Access-Control-Request-Method", request_method},
      {"Access-Control-Request-Headers", request_headers |> Enum.join(",")},
    ]
    request(client, :options, bucket, object, headers: headers)
  end

  def post_object(client, bucket, object, _opts \\ %{}) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def post_object_restore(client, bucket, object, _version_id, _number_of_days) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def put_object(client, bucket, object, body, opts \\ %{}) do
    headers = [
      {"Content-Type", "binary/octet-stream"} |
      opts |> Map.to_list
    ]
    request(client, :put, bucket, object, body: body, headers: headers)
  end

  def put_object_acl(client, bucket, object, _acl) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def put_object_copy(client, dest_bucket, dest_object, _src_bucket, _src_object, _opts \\ %{}) do
    raise "not yet implemented"
    request(client, :get, dest_bucket, dest_object)
  end

  def initiate_multipart_upload(client, bucket, object, _opts \\ %{}) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def upload_part(client, bucket, object, _upload_id, _part_number) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def upload_part_copy(client, dest_bucket, dest_object, _src_bucket, _src_object, _opts \\ %{}) do
    raise "not yet implemented"
    request(client, :get, dest_bucket, dest_object)
  end

  def complete_multipart_upload(client, bucket, object, _upload_id, _parts) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def abort_multipart_upload(client, bucket, object, _upload_id) do
    raise "not yet implemented"
    request(client, :get, bucket, object)
  end

  def list_parts(client, bucket, object, upload_id, opts \\ %{}) do
    params = %{"uploadId" => upload_id}
    |> Map.merge(opts)
    request(client, :get, bucket, object, params: params)
  end

  defp request(%{__struct__: client_module} = client, action, bucket, path, data \\ []) do
    client_module.request(client, action, bucket, path, data)
  end

end