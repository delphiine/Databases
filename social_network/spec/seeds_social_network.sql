DROP TABLE IF EXISTS "public"."accounts" CASCADE; 

CREATE SEQUENCE IF NOT EXISTS accounts_id_seq;

CREATE TABLE "public"."accounts" (
  "id" SERIAL PRIMARY KEY,
  "email" text,
  "username" text,
  "post" text
);

INSERT INTO "public"."accounts" ("id", "email", "username", "post") VALUES
(1, 'test1@email.com', 'username1', 'post1'),
(2, 'test2@email.com', 'username2', 'post2'),
(3, 'test3@email.com', 'username3', 'post3');

-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS posts CASCADE;

CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

CREATE TABLE posts (
  "id" SERIAL PRIMARY KEY,
  "title" text,
  "content" text,
  "views" int,
  "account_id" int,
  constraint "fk_account" foreign key("account_id") references "accounts"("id")
);

INSERT INTO posts ("id", "title", "content", "views", "account_id") VALUES
(1, 'title1', 'content1', 3, 1),
(2, 'title2', 'content2', 7, 1),
(3, 'title3', 'content3', 8, 1);

