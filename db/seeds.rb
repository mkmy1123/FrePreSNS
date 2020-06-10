# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      email: 'master@test.com',
      optional_id: 'mkmy1123',
      name: '管理人',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test1@test.com',
      optional_id: 'yamadamada',
      name: 'やまだ',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test2@test.com',
      optional_id: 'yeswecando',
      name: 'できないことなんてない',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test3@test.com',
      optional_id: 'heybabyboy',
      name: 'こんにちは坊や',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test4@test.com',
      optional_id: 'goodgirl',
      name: 'いいこちゃん',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test5@test.com',
      optional_id: 'helloworld',
      name: '駆け出しエンジニア',
      password: 'testtest',
      password_confirmation: 'testtest'
    },
    {
      email: 'test6@test.com',
      optional_id: 'testtester',
      name: 'お試しアカウント',
      password: 'testtest',
      password_confirmation: 'testtest'
    }
  ]
)

Argument.create!(
  [
    {
      target: 4,
      topic: "AWSは使えるようになるべきだ"
    },
    {
      target: 1,
      topic: "政治に興味を持つ必要がある"
    }
  ]
)