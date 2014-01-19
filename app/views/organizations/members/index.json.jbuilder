json.array!(@organization_members) do |organization_member|
  json.extract! organization_member, :id, :role, :user_id, :organization_id
  json.url organization_member_url(organization_member, format: :json)
end
