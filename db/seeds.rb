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
	])

# 個展
Exhibition.create!([
	{user_id: 1 , gallery_id:1,title: "猫" , caption: "飼い猫たち" , is_active: true},
	{user_id: 2 , gallery_id:3,title: "犬" , caption: "飼い犬たち" , is_active: true}
	])


# 作品
Work.create!([
	{user_id: 1 ,exhibition_id: 1 , work_title: "いろは" , description: "飼い猫です"},
	{user_id: 3 ,exhibition_id: 2 , work_title: "ポチ" , description: "飼い犬です"},
	{user_id: 3 ,exhibition_id: 2 , work_title: "太郎" , description: "飼い犬です"}
	])

# コメント
Comment.create!([
	{exhibition_id: 1,user_id: 3,comment: "いいですね"},
	{exhibition_id: 2,user_id: 1,comment: "素敵ですね"}
	])

# フォルダ
Folder.create!([
	{user_id:1 ,folder_name: "お気に入り"},
	{user_id:1 ,folder_name: "参考"},
	{user_id:2 ,folder_name: "アイデア"}
	])

# クリップ
Clip.create!([
	{folder_id: 1 ,exhibition_id: 2 , memo: "参考になる" , is_active: true},
	{folder_id: 1 ,exhibition_id: 1 , memo: "参考になる" , is_active: true},
	{folder_id: 2 ,exhibition_id: 2 , memo: "参考になる" , is_active: true}
	])
