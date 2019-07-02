class Result

  attr_reader :breached_accounts, :failed_accounts
  # connect this to redis
  def initialize
    @breached_accounts = {}
    @failed_accounts   = {}
  end

  def add_breached_account(email, pwned_websites)
    @breached_accounts[email] = pwned_websites
  end

  def add_failed_account(email, exception)
    @failed_accounts[email] = exception
  end
end
