require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { "user#{sn}@example.com" }
  password { "password123" }
  password_confirmation { object.password }
end

Organization.blueprint do
  name { "Organization #{sn}" }
  code { "code-#{sn}" }
end

Membership.blueprint do
  user { User.make }
  organization { Organization.make }
end

Beer.blueprint do
  barcode { "1234567" }
  name { "Samuel Adams Boston Lager" }
  volume { 0.355 }
end
