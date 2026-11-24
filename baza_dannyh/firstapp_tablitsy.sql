-- Таблицы приложения firstapp из db.sqlite3 (проект Web_1_models)

BEGIN TRANSACTION;

-- ===== firstapp_account =====
CREATE TABLE "firstapp_account" ("login" varchar(20) NOT NULL, "password" varchar(20) NOT NULL, "user_id" bigint NOT NULL PRIMARY KEY REFERENCES "firstapp_user" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "firstapp_account" ("login", "password", "user_id") VALUES ('ironman', 'jarvis3000', 3);
INSERT INTO "firstapp_account" ("login", "password", "user_id") VALUES ('captain', 'shield1945', 4);
INSERT INTO "firstapp_account" ("login", "password", "user_id") VALUES ('blackwidow', 'redroom', 5);

-- ===== firstapp_company =====
CREATE TABLE "firstapp_company" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(30) NOT NULL);
INSERT INTO "firstapp_company" ("id", "name") VALUES (3, 'Stark Industries');
INSERT INTO "firstapp_company" ("id", "name") VALUES (4, 'Вакандский дизайн');

-- ===== firstapp_course =====
CREATE TABLE "firstapp_course" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(30) NOT NULL);
INSERT INTO "firstapp_course" ("id", "name") VALUES (3, 'Боевая подготовка');
INSERT INTO "firstapp_course" ("id", "name") VALUES (4, 'Пилотирование квинджета');
INSERT INTO "firstapp_course" ("id", "name") VALUES (5, 'Магия');

-- ===== firstapp_person =====
CREATE TABLE "firstapp_person" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(20) NOT NULL, "age" integer NOT NULL);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (12, 'Тони Старк', 48);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (13, 'Стив Роджерс', 105);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (14, 'Тор', 1500);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (15, 'Наташа Романофф', 35);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (16, 'Брюс Беннер', 49);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (17, 'Клинт Бартон', 46);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (18, 'Питер Паркер', 17);
INSERT INTO "firstapp_person" ("id", "name", "age") VALUES (19, 'Ванда Максимофф', 30);

-- ===== firstapp_product =====
CREATE TABLE "firstapp_product" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(30) NOT NULL, "price" integer NOT NULL, "company_id" bigint NOT NULL REFERENCES "firstapp_company" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE INDEX "firstapp_product_company_id_c605e986" ON "firstapp_product" ("company_id");
INSERT INTO "firstapp_product" ("id", "name", "price", "company_id") VALUES (5, 'Броня Mark 85', 9500000, 3);
INSERT INTO "firstapp_product" ("id", "name", "price", "company_id") VALUES (6, 'Дуговой реактор', 3000000, 3);
INSERT INTO "firstapp_product" ("id", "name", "price", "company_id") VALUES (7, 'Квинджет', 7200000, 3);
INSERT INTO "firstapp_product" ("id", "name", "price", "company_id") VALUES (8, 'Костюм Чёрной пантеры', 5000000, 4);

-- ===== firstapp_sotrudnik =====
CREATE TABLE "firstapp_sotrudnik" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "fio" varchar(50) NOT NULL, "email" varchar(254) NOT NULL, "birthday" date NOT NULL, "salary" decimal NOT NULL, "staj" smallint unsigned NOT NULL CHECK ("staj" >= 0), "is_active" bool NOT NULL, "site" varchar(200) NOT NULL, "about" text NOT NULL);
INSERT INTO "firstapp_sotrudnik" ("id", "fio", "email", "birthday", "salary", "staj", "is_active", "site", "about") VALUES (2, 'Тони Старк', 'tony@stark.com', '1970-05-29', 9999999.99, 25, 1, 'https://www.starkindustries.com', 'Гений, миллиардер, плейбой, филантроп');

-- ===== firstapp_student =====
CREATE TABLE "firstapp_student" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(30) NOT NULL);
INSERT INTO "firstapp_student" ("id", "name") VALUES (4, 'Питер Паркер');
INSERT INTO "firstapp_student" ("id", "name") VALUES (5, 'Ванда Максимофф');
INSERT INTO "firstapp_student" ("id", "name") VALUES (6, 'Сэм Уилсон');
INSERT INTO "firstapp_student" ("id", "name") VALUES (7, 'Скотт Лэнг');

-- ===== firstapp_student_courses =====
CREATE TABLE "firstapp_student_courses" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "student_id" bigint NOT NULL REFERENCES "firstapp_student" ("id") DEFERRABLE INITIALLY DEFERRED, "course_id" bigint NOT NULL REFERENCES "firstapp_course" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "firstapp_student_courses_student_id_course_id_8ab3aa74_uniq" ON "firstapp_student_courses" ("student_id", "course_id");
CREATE INDEX "firstapp_student_courses_student_id_f467e277" ON "firstapp_student_courses" ("student_id");
CREATE INDEX "firstapp_student_courses_course_id_6de45610" ON "firstapp_student_courses" ("course_id");
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (5, 4, 3);
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (6, 4, 4);
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (7, 5, 3);
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (8, 5, 5);
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (9, 6, 4);
INSERT INTO "firstapp_student_courses" ("id", "student_id", "course_id") VALUES (10, 7, 3);

-- ===== firstapp_user =====
CREATE TABLE "firstapp_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(20) NOT NULL);
INSERT INTO "firstapp_user" ("id", "name") VALUES (3, 'Тони Старк');
INSERT INTO "firstapp_user" ("id", "name") VALUES (4, 'Стив Роджерс');
INSERT INTO "firstapp_user" ("id", "name") VALUES (5, 'Наташа Романофф');

COMMIT;
