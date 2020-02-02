# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者アカウント
Admin.create(email: "ayana43.iroha@gmail.com", password:"admins")

# 会員
User.create([
	{name: "Ayana", email: "a@a" , introduction: "よろしくお願いします！", password: "Ayana-43"},
	{name: "Taichi", email: "b@b" , introduction: "よろしくお願いします！", password: "Taichi-827"},
	{name: "Yurika", email: "c@c" , introduction: "よろしくお願いします！", password: "Yurika-1028"}
	])

# ギャラリー
Gallery.create!([
	{user_id: 1 , gallery_name: "ギャラリー１", concept: "絵と写真"},
	{user_id: 2 , gallery_name: "ギャラリー２" , concept: "絵と写真"},
	{user_id: 3 , gallery_name: "ギャラリー３" , concept: "絵と写真"},
	{user_id: 4 , gallery_name: "ギャラリー４" , concept: "絵と写真"}
	])


