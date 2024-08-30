install_istio() {
  local namespace=$1
  local command="istioctl install --set meshConfig.accessLogFile=/dev/stdout --set meshConfig.accessLogEncoding=JSON --skip-confirmation"

  # Add the detailed JSON access log format
  command+=" --set meshConfig.accessLogFormat='{
    \"protocol\": \"%PROTOCOL%\",
    \"upstream_service_time\": \"%REQ(x-envoy-upstream-service-time)%\",
    \"upstream_local_address\": \"%UPSTREAM_LOCAL_ADDRESS%\",
    \"duration\": \"%DURATION%\",
    \"upstream_transport_failure_reason\": \"%UPSTREAM_TRANSPORT_FAILURE_REASON%\",
    \"route_name\": \"%ROUTE_NAME%\",
    \"downstream_local_address\": \"%DOWNSTREAM_LOCAL_ADDRESS%\",
    \"user_agent\": \"%REQ(USER-AGENT)%\",
    \"response_code\": \"%RESPONSE_CODE%\",
    \"response_flags\": \"%RESPONSE_FLAGS%\",
    \"start_time\": \"%START_TIME%\",
    \"method\": \"%REQ(:METHOD)%\",
    \"request_id\": \"%REQ(X-REQUEST-ID)%\",
    \"upstream_host\": \"%UPSTREAM_HOST%\",
    \"x_forwarded_for\": \"%REQ(X-FORWARDED-FOR)%\",
    \"client_ip\": \"%REQ(True-Client-Ip)%\",
    \"requested_server_name\": \"%REQUESTED_SERVER_NAME%\",
    \"bytes_received\": \"%BYTES_RECEIVED%\",
    \"bytes_sent\": \"%BYTES_SENT%\",
    \"upstream_cluster\": \"%UPSTREAM_CLUSTER%\",
    \"downstream_remote_address\": \"%DOWNSTREAM_REMOTE_ADDRESS%\",
    \"authority\": \"%REQ(:AUTHORITY)%\",
    \"path\": \"%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%\",
    \"response_code_details\": \"%RESPONSE_CODE_DETAILS%\"
  }'"

  # Include namespace profile if provided
  if [[ -n "$namespace" ]]; then
    command+=" --set profile=\"$namespace\""
  fi

  # Execute the istioctl command
  eval $command

  # Label the namespace for Istio sidecar injection
  # If no namespace is provided, default to 'default'
  local label_namespace=${namespace:-default}
  kubectl label namespace "$label_namespace" istio-injection=enabled --overwrite
}
