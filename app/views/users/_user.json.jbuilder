json.(user, :id, :mobile, :nickname, :gender)

# Format birthday as "YYYY-MM-DD"
json.birthday user.birthday ? user.birthday.to_date.to_formatted_s : ''

# Show timestamps
json.(user, :created_at, :updated_at)
