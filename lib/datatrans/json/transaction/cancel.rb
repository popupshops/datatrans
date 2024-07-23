require "httparty"
require "datatrans/json/transaction/response"

class Datatrans::JSON::Transaction
  class Cancel
    # Class to cancel a transaction https://api-reference.datatrans.ch/#tag/v1transactions/operation/cancel
    attr_accessor :params, :datatrans

    def initialize(datatrans, params)
      @datatrans = datatrans
      @params = params
    end

    def post(url, options = {})
      options = options
                  .merge(datatrans.proxy)
                  .merge(basic_auth: {username: datatrans.merchant_id, password: datatrans.password})
      HTTParty.post(url, **options)
    end

    def process
      post(datatrans.url(:json_cancel_url, transaction_id: params[:transaction_id]),
           headers: {"Content-Type" => "application/json"},
           body: request_body.to_json).parsed_response
    end

    def request_body
      {}
    end
  end

  class CancelResponse < Response
    def successful?
      params&.[]("error").blank?
    end
  end
end
