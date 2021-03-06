PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
ANALYZE sqlite_master;
INSERT INTO "sqlite_stat1" VALUES('sessions',NULL,'1');
CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username CHAR(255), email CHAR(255), hashed_password CHAR(255));
INSERT INTO "users" VALUES(3,'Walle','testingsave@testing.com','123');
INSERT INTO "users" VALUES(4,'tedxx','ted@comdots.com','123');
INSERT INTO "users" VALUES(5,'TestTed','test@ted.com','123');
INSERT INTO "users" VALUES(7,'diegos','die@go.com','123');
INSERT INTO "users" VALUES(8,'ted2','ted@comdot.com','123');
INSERT INTO "users" VALUES(9,'test@test.com','test','123');
INSERT INTO "users" VALUES(10,'test@test.com','test','123');
INSERT INTO "users" VALUES(11,'test@test.com','test','123');
INSERT INTO "users" VALUES(12,'test@test.com','test','123');
INSERT INTO "users" VALUES(13,'test@test.com','test','123');
INSERT INTO "users" VALUES(14,'testy@test.com','test','test
');
INSERT INTO "users" VALUES(15,'test','testy2@test.com','test');
INSERT INTO "users" VALUES(16,'test','testy2@test.com','test');
INSERT INTO "users" VALUES(17,'test','testy2@test.com','test');
INSERT INTO "users" VALUES(18,'test','testy2@test.com','test');
INSERT INTO "users" VALUES(19,'test','testy3@test.com','test');
INSERT INTO "users" VALUES(20,'test','testy4@test.com','test');
INSERT INTO "users" VALUES(21,'test','testy2@test.com','test');
INSERT INTO "users" VALUES(22,'test','test@test.com','123');
INSERT INTO "users" VALUES(23,'test','test@test.com','123');
INSERT INTO "users" VALUES(24,'test','test@test.com','123');
INSERT INTO "users" VALUES(25,'test','test@test.com','123');
INSERT INTO "users" VALUES(26,'test','test@test.com','123');
INSERT INTO "users" VALUES(27,'test','test@test.com','123');
INSERT INTO "users" VALUES(28,'test','test@test.com','123');
INSERT INTO "users" VALUES(29,'test','testingupdate-1430345960@test.com','123');
INSERT INTO "users" VALUES(30,'test','testingupdate-1430346180@test.com','123');
INSERT INTO "users" VALUES(31,'test','testingupdate-1430346220@test.com','123');
INSERT INTO "users" VALUES(32,'test','testingupdate-1430346250@test.com','123');
INSERT INTO "users" VALUES(33,'test','testingupdate-1430346266@test.com','123');
INSERT INTO "users" VALUES(34,'test','testingupdate-1430346298@test.com','123');
INSERT INTO "users" VALUES(35,'test','testingupdate-1430346430@test.com','123');
INSERT INTO "users" VALUES(36,'test','testingupdate-1430348779@test.com','123');
INSERT INTO "users" VALUES(37,'test','testingupdate-1430348999@test.com','123');
INSERT INTO "users" VALUES(38,'test','testingupdate-1430349041@test.com','123');
INSERT INTO "users" VALUES(39,'test','testingupdate-1430349119@test.com','123');
INSERT INTO "users" VALUES(40,'test','testingupdate-1430359550@test.com','123');
INSERT INTO "users" VALUES(41,'test','testingupdate-1430360222@test.com','123');
INSERT INTO "users" VALUES(42,'test','testingupdate-1430360387@test.com','123');
INSERT INTO "users" VALUES(43,'test','testingupdate-1430360409@test.com','123');
INSERT INTO "users" VALUES(44,'test','testingupdate-1430360477@test.com','123');
INSERT INTO "users" VALUES(45,'test','testingupdate-1430360521@test.com','123');
INSERT INTO "users" VALUES(46,'test','testingupdate-1430360551@test.com','123');
INSERT INTO "users" VALUES(47,'test','testingupdate-1430360658@test.com','123');
INSERT INTO "users" VALUES(48,'test','testingupdate-1430361854@test.com','123');
INSERT INTO "users" VALUES(49,'test','testingupdate-1430363742@test.com','123');
INSERT INTO "users" VALUES(50,'test','testingupdate-1430516876@test.com','123');
CREATE TABLE sessions(id CHAR(255) NOT NULL, user_id INT NOT NULL, created_at DATETIME NOT NULL);
INSERT INTO "sessions" VALUES('BL6oJwCd3Ib8G1iqWw3omA',1,'2015-03-18 21:41:39 -0400');
INSERT INTO "sessions" VALUES('BL6oJwCd3Ib8G1iqWw3omA',7,'2015-03-18 22:57:12 -0400');
INSERT INTO "sessions" VALUES('gD8D5PBV--OM2XWZzgrMUw',3,'Thu, 30 Apr 2015 03:15:06 GMT')
;
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:13:40 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:15:18 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:15:45 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:15:50 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:16:49 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:23:43 GMT');
INSERT INTO "sessions" VALUES('9000',0,'Thu, 30 Apr 2015 04:28:06 GMT');
INSERT INTO "sessions" VALUES('9000',0,'Thu, 30 Apr 2015 04:28:20 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:29:12 GMT');
INSERT INTO "sessions" VALUES('0',0,'Thu, 30 Apr 2015 04:29:46 GMT');
INSERT INTO "sessions" VALUES('0',0,'Fri, 01 May 2015 21:47:44 GMT');
INSERT INTO "sessions" VALUES('0',0,'Fri, 01 May 2015 21:47:56 GMT');
INSERT INTO "sessions" VALUES('0',0,'Sat, 02 May 2015 22:18:31 GMT');
INSERT INTO "sessions" VALUES('0',0,'Sat, 02 May 2015 22:25:59 GMT');
INSERT INTO "sessions" VALUES('0',0,'Sat, 02 May 2015 22:26:00 GMT');
INSERT INTO "sessions" VALUES('asd',100,'Sat, 02 May 2015 22:31:56 GMT');
INSERT INTO "sessions" VALUES('0',0,'Sat, 02 May 2015 22:32:09 GMT');
INSERT INTO "sessions" VALUES('0',0,'Sat, 02 May 2015 22:33:18 GMT');
CREATE TABLE posts (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INT NOT NULL, content TEXT NOT NULL, created_at DATETIME NOT NULL);
INSERT INTO "posts" VALUES(10,7,'''user_id'' => current_user.id, ''created_at'' => Time.now.httpdate','Thu, 19 Mar 2015 05:50:04 GMT');
INSERT INTO "posts" VALUES(11,7,'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.','Thu, 19 Mar 2015 06:10:07 GMT');
INSERT INTO "posts" VALUES(12,7,'Kitten Ipsum dolor sit amet venenatis terrified flying keyboard life tellus kitty, meowschwitz cat kitty redditor Sed vestibulum tux venenatis cats sodales cat kitten persian faucibus long. Integer, quam odio cat success quam cat. Eu justo aliquet magnis birdwatching blandit standing fluff potenti justo consectetur ac consectetur tongue here best cat, prrrrr cursus turpis likes.','Thu, 19 Mar 2015 06:13:55 GMT');
INSERT INTO "posts" VALUES(13,7,'Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and Stuff and stuff and ','Thu, 19 Mar 2015 15:13:22 GMT');
INSERT INTO "posts" VALUES(14,3,'Stuff and stuff and hey Stuff and stuff and hey Stuff and stuff and hey Stuff and stuff and hey Stuff and stuff and hey Stuff and stuff and hey Stuff and stuff and hey ','Thu, 19 Mar 2015 17:17:02 GMT');
INSERT INTO "posts" VALUES(15,3,'Bacon ipsum dolor amet leberkas tail salami, beef ribs ham tenderloin jerky filet mignon pork belly. Sirloin venison cow doner leberkas beef sausage drumstick hamburger picanha tri-tip ribeye corned beef. Pork loin jerky sausage, shank pork bresaola fatback. Tail strip steak hamburger cupim andouille. Andouille kevin tri-tip short loin pork fatback filet mignon. Bacon salami bresaola swine pancetta jowl biltong shank.','Thu, 19 Mar 2015 21:51:22 GMT');
INSERT INTO "posts" VALUES(16,3,'Jelly-o ice cream chocolate cake candy canes pie. Fruitcake biscuit cotton candy. Danish dessert gingerbread pudding gingerbread chocolate lemon drops bonbon chocolate. Cake bonbon chocolate bar jujubes sugar plum. Cotton candy danish tootsie roll tootsie roll carrot cake. Cotton candy marzipan dessert marzipan. Sesame snaps topping cake liquorice ice cream oat cake tart sweet croissant. Sweet roll gummies gingerbread carrot cake toffee biscuit dessert chupa chups pastry. Chocolate cake jelly beans bear claw cookie. Jelly beans wafer gummi bears pastry sugar plum. Biscuit toffee gummies caramels tootsie roll caramels cookie. Lollipop cupcake liquorice biscuit cheesecake.','Thu, 19 Mar 2015 21:51:42 GMT');
INSERT INTO "posts" VALUES(17,3,'Now were up in the big leagues getting'' our turn at bat., Baby if you''ve ever wondered - wondered whatever became of me. I''m living on the air in Cincinnati. Cincinnati WKRP. Well we''re movin'' on up to the east side to a deluxe apartment in the sky. Were gonna do it. Give us any chance well take it. Give us any rule we''ll break it. We''re gonna make our dreams come true?','Thu, 19 Mar 2015 21:52:14 GMT');
INSERT INTO "posts" VALUES(18,3,'So lets make the most of this beautiful day. Since we''re together So join us here each week my friends you''re sure to get a smile from seven stranded castaways here on Gilligans Isle.','Thu, 19 Mar 2015 21:52:27 GMT');
INSERT INTO "posts" VALUES(19,7,'hello world','Mon, 23 Mar 2015 16:02:37 GMT');
INSERT INTO "posts" VALUES(20,7,'Just testing and repeating myself Just testing and repeating myself Just testing and repeating myself Just testing and repeating myself Just testing and repeating myself Just testing and repeating myself Just testing and repeating myself ','Wed, 25 Mar 2015 03:30:04 GMT');
INSERT INTO "posts" VALUES(21,7,'and stuff and stuff and stuff and stuff and stuff and stuff and stuff and stuff and stuff and stuff ','Wed, 25 Mar 2015 03:34:21 GMT');
INSERT INTO "posts" VALUES(22,3,'heeyyyyy','Sun, 03 May 2015 21:40:42 GMT');
INSERT INTO "posts" VALUES(23,3,'Testing new kwip','Mon, 04 May 2015 04:53:44 GMT');
CREATE TABLE comments (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INT NOT NULL, post_id INT NOT NULL, content TEXT NOT NULL, created_at DATETIME NOT NULL);
INSERT INTO "comments" VALUES(1,7,12,'testing testing','Thu, 19 Mar 2015 15:02:19 GMT');
INSERT INTO "comments" VALUES(2,7,12,'asdasdasd','Thu, 19 Mar 2015 15:10:46 GMT');
INSERT INTO "comments" VALUES(3,7,12,'omg dude','Thu, 19 Mar 2015 15:12:36 GMT');
INSERT INTO "comments" VALUES(4,7,12,' venenatis cats sodales cat kitten persian faucibus long. Integer, quam odio cat success quam cat. Eu justo aliquet magnis birdwatching blandit stand','Thu, 19 Mar 2015 15:13:04 GMT');
INSERT INTO "comments" VALUES(5,7,13,'asdasdasd','Thu, 19 Mar 2015 15:22:45 GMT');
INSERT INTO "comments" VALUES(6,7,12,'Stuffity stuff Stuffity stuff Stuffity stuff Stuffity stuff Stuffity stuff Stuffity stuff Stuffity stuff Stuffity stuff ','Thu, 19 Mar 2015 15:36:42 GMT');
INSERT INTO "comments" VALUES(7,3,14,'I dont know.','Thu, 19 Mar 2015 17:17:11 GMT');
INSERT INTO "comments" VALUES(8,3,13,'Holy whoa!
','Thu, 19 Mar 2015 20:00:16 GMT');
INSERT INTO "comments" VALUES(9,7,18,'Stuff, you know?','Thu, 19 Mar 2015 22:03:59 GMT');
INSERT INTO "comments" VALUES(10,7,21,'stuff','Wed, 25 Mar 2015 16:49:47 GMT');
INSERT INTO "comments" VALUES(11,3,21,'hello','Thu, 30 Apr 2015 03:10:44 GMT');
INSERT INTO "comments" VALUES(12,3,21,'asd','Sun, 03 May 2015 08:29:31 GMT');
CREATE TABLE post_favorites (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INT NOT NULL, post_id INT NOT NULL);
INSERT INTO "post_favorites" VALUES(1,7,13);
INSERT INTO "post_favorites" VALUES(2,7,12);
INSERT INTO "post_favorites" VALUES(3,3,12);
INSERT INTO "post_favorites" VALUES(4,3,13);
INSERT INTO "post_favorites" VALUES(5,7,17);
INSERT INTO "post_favorites" VALUES(6,7,18);
INSERT INTO "post_favorites" VALUES(7,7,15);
INSERT INTO "post_favorites" VALUES(8,3,21);
INSERT INTO "post_favorites" VALUES(9,3,21);
INSERT INTO "post_favorites" VALUES(10,3,21);
INSERT INTO "post_favorites" VALUES(11,3,21);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('users',50);
INSERT INTO "sqlite_sequence" VALUES('posts',23);
INSERT INTO "sqlite_sequence" VALUES('comments',12);
INSERT INTO "sqlite_sequence" VALUES('post_favorites',11);
COMMIT;
