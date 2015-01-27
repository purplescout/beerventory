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
