DROP DATABASE IF EXISTS 'messaging';
CREATE DATABASE 'messaging'; 
USE 'messaging';

CREATE USER eko
IDENTIFIED BY 'vibcasub86y90';

CREATE USER caleb
IDENTIFIED BY 'bbcjan75647bkjgk';

SELECT * FROM messaging.user;

SET PASSWORD FOR caleb = 'gubjk6r679jd'


GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON messaging.*
TO caleb

GRANT CREATE VIEW
ON *.*
TO eko;

REVOKE CREATE VIEW
ON *.*
FROM eko;


/*Reconstructed Messaging Database from DAD220 Codio Assignment */
CREATE TABLE person(
	person_id INT(8) UNSIGNED NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;

CREATE TABLE contact_list ( 
    connection_id INT(8) UNSIGNED NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
	contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

CREATE TABLE message ( 
    message_id INT(8) UNSIGNED NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
	receiver_id INT(8) NOT NULL,
	message VARCHAR(255) NOT NULL,
	send_datetime datetime,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;


USE messaging;

SHOW TABLE FROM messaging;
SHOW COLUMNS FROM person;
SHOW COLUMNS FROM contact_list;
SHOW COLUMNS FROM message;

SELECT * FROM person;

INSERT INTO messaging.person (first_name, last_name, age)
VALUES
	("Michael", "Phelps", "36"),
	("Katie", "Ledecky", "30"),
	("Usain", "Bolt", "33"),
	("Allyson", "Feliix", "31"),
	("Kevin", "Durant", "32");


ALTER TABLE messaging.person 
ADD age VARCHAR(3) NOT NULL;

SELECT * FROM messaging.person;   

UPDATE messaging.person 
SET age = '38' 
WHERE 
	person.first_name = "Michael"
AND 
	person.last_name = "Phelps";

SHOW TABLE FROM meassaging.person;

DELETE FROM messaging.person

WHERE person_id = 6;

SHOW TABLE FROM meassaging.person;

SHOW COLUMNS FROM messaging.contact_list;

ALTER TABLE messaging.contact_list 

ADD favorite VARCHAR(10) DEFAULT NULL
;

SELECT * FROM messaging.contact_list;

UPDATE messaging.contact_list
SET favorite = "y"
WHERE contact_list.contact_id = 1
;

SELECT * FROM messaging.contact_list;

UPDATE messaging.contact_list
SET favorite = "n"
WHERE contact_list.contact_id <> 1
;

SELECT * FROM messaging.contact_list; 

SELECT * FROM messaging.person; 

INSERT INTO	messaging.contact_list (connection_id, person_id, contact_id, favorite)
VALUES
	("15", "7", "7", "y"),
	("16", "8", "8", "y"),
	("17", "9", "9", "y")
;


SELECT * FROM messaging.contact_list;


LOAD DATA LOCAL INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\contact_list.csv'

.headers on
.mode csv
.output data.csv
SELECT connection_id,
		person_id,
		contact_id,
		favorite
FROM messaging.contact_list;
.quit;

SHOW TABLES;

CREATE TABLE 
	image ( 
    image_id INT(8) NOT NULL auto_increment,
    image_name VARCHAR(50) NOT NULL,
	image_location VARCHAR(250) NOT NULL,
    PRIMARY KEY (image_id)
) AUTO_INCREMENT=1
;


SHOW TABLES;

CREATE TABLE 
	message_image ( 
    message_id INT(8) NOT NULL,
    image_id INT(8) NOT NULL,
PRIMARY KEY (message_id, image_id),
FOREIGN KEY (image_id) REFERENCES image(image_id)	
);

SHOW COLUMNS FROM messaging.message_image;

SELECT * FROM messaging.image;

INSERT INTO
	messaging.image (image_name, image_location)
VALUES
	("cat", "window"),
	("dog", "bed"),
	("balloon", "store"),
	("car", "“garage”"),
	("computer", "library")
;


SELECT * FROM messaging.message_image;

INSERT INTO
	messaging.message_image (message_id, image_id)
VALUES
	("1", "1"),
	("3", "5"),
	("5", "3"),
	("2", "2"),
	("4", "4,5")
;

SELECT * FROM messaging.message_image;

SELECT 
	pSender.first_name AS "Sender First Name",
	pSender.last_name AS "Sender Last Name", 
	pReceiver.first_name AS "Receiver First Name", 
	pReceiver.last_name AS "Receiver Last Name", 
	meassaging.message_id AS "Message ID", 
	meassaging.message AS "Message",
	meassaging.send_datetime AS "Message Timestamp"
FROM 
	messaging.message
JOIN 
	pSender.person_id  = meassaging.sender_id
AND 
	pReceiver.person_id = meassaging.receiver_id
WHERE
	sender_id = 1; 


SELECT 
	COUNT(*) AS "Count of Messages",
	person.person_id AS "Person ID",
	person.first_name AS "Sender First Name",
	person.last_name AS "Sender Last Name"
FROM 
	messaging.message
JOIN
	messaging.person
WHERE 
	messaging.message_id = person.person_id
GROUP BY 
	person.person_id, person.first_name, person.last_name;

SELECT
	messaging.message_id AS "Message ID", 
	messaging.message AS "Message",
	messaging.send_datetime AS "Message Timestamp",
	messaging.image_name AS "Image Name",
	messaging.image_location AS "Image Location"
FROM
	messaging.message
INNER JOIN 
	messaging.message_image
ON
	messaging.message_id = messaging.image_id 
INNER JOIN
	messaging.image
ON
	messaging.image_id = messaging.image_id
GROUP BY 
	messaging.message_id;