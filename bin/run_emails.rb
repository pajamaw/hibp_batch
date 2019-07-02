#!/bin/env ruby

require_relative '../lib/api.rb'
require_relative '../lib/http_client.rb'
require_relative '../lib/result.rb'

results = Result.new
results_counter = 0
clean_counter = 0
working_counter = 0
failed_counter = 0
# connect this to the actual file
emails = ['pjpeterww@gmail.com', 'pj_peter_ww@gmail.com']

emails.each do |email|
  begin
    if body = Api.breached_account?(email)
      results.add_breached_account(email, body)
      working_counter+=1
    else
      results.add_breached_account(email, [])
      clean_counter+=1
    end
  rescue => e
    results.add_failed_account(email, e)
    failed_counter+=1
  end
  results_counter+=1
end

puts "#{working_counter} email(s) added"
puts "#{clean_counter} email(s) clean"
puts "#{failed_counter} email(s) failed"
puts "#{results_counter} email(s) completed"

