class Datatrans::Web::Transaction
  class AuthorizeResponse
    attr_accessor :params, :datatrans

    def initialize(datatrans, params)
      @datatrans = datatrans
      @params = params
    end

    def successful?
      response_code == '01' && response_message == 'Authorized' && !errors_occurred? && valid_signature?
    end

    def valid_signature?
      sign(self.datatrans.merchant_id, params[:amount], params[:currency], params[:uppTransactionId]) == params[:sign2]
    end

    def response_code
      params[:responseCode] rescue nil
    end

    def response_message
      params[:responseMessage] rescue nil
    end

    def transaction_id
      params[:uppTransactionId] rescue nil
    end

    def reference_number
      params[:refno] rescue nil
    end

    def authorization_code
      params[:acqAuthorizationCode] rescue nil
    end

    def payment_method
      params[:pmethod] rescue nil
    end

    def masked_cc
      params[:maskedCC] rescue nil
    end

    def exp_year
      params[:expy] rescue nil
    end

    def exp_month
      params[:expm] rescue nil
    end

    def creditcard_alias
      params[:aliasCC] rescue nil
    end

    def error_code
      params[:errorCode] rescue nil
    end

    def error_message
      params[:errorMessage] rescue nil
    end

    def error_detail
      params[:errorDetail] rescue nil
    end


    private

    def errors_occurred?
      error_code || error_message || error_detail
    end

    include Datatrans::Common
  end
end
