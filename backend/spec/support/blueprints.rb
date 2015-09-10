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
  barcode { "1234567#{sn}" }
  name { "Samuel Adams Boston Lager" }
  volume { 0.355 }
end

History.blueprint do
  user { User.make }
  organization { Organization.make }
  beer { Beer.make }
  out { 20 }
end

Inventory.blueprint do
  organization { Organization.make }
  beer { Beer.make }
  amount { 20 }
end
