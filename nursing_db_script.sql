
-- create the database
DROP DATABASE IF EXISTS nursing;
CREATE DATABASE nursing;

-- select the database
USE nursing;

-- create the tables
CREATE TABLE student
(
  stu_id INT PRIMARY KEY AUTO_INCREMENT,
  stu_fname VARCHAR(50) NOT NULL,
  stu_lname VARCHAR(50) NOT NULL,
  stu_address VARCHAR(60) NOT NULL,
  city VARCHAR(30) NOT NULL,
  stu_state CHAR(2) NOT NULL,
  zip_code VARCHAR(12) NOT NULL,
  home_phone VARCHAR(15) NOT NULL,
  cell_phone_num VARCHAR(15),
  work_phone_num VARCHAR(15),
  stu_email VARCHAR(50) NOT NULL
);

CREATE TABLE agency
(
  agency_name VARCHAR(50) PRIMARY KEY,
  agency_affiliaction VARCHAR(60),
  rep_fname VARCHAR(50) NOT NULL,
  rep_lname VARCHAR(50) NOT NULL,
  stu_id INT NOT NULL AUTO_INCREMENT,
  CONSTRAINT agency_fk_stu_id
	FOREIGN KEY (stu_id)
	REFERENCES student (stu_id)
);

CREATE TABLE agency_address
(
  agency_address VARCHAR(50) PRIMARY KEY,
  city VARCHAR(50) NOT NULL,
  agency_state CHAR(2) NOT NULL,
  zip_code VARCHAR(12) NOT NULL,
  phone_num VARCHAR(15) NOT NULL,
  fax_num VARCHAR(15),
  agency_name VARCHAR(50) NOT NULL,
  CONSTRAINT agency_address_fk_agency_name
	FOREIGN KEY (agency_name)
	REFERENCES agency (agency_name)
);

CREATE TABLE agency_contact
(
  person_email VARCHAR(50) PRIMARY KEY,
  person_fname VARCHAR(50) NOT NULL,
  person_lname VARCHAR(50) NOT NULL,
  title VARCHAR(30),
  agency_name VARCHAR(50) NOT NULL,
  CONSTRAINT agency_contact_fk_agency_name
	FOREIGN KEY (agency_name)
	REFERENCES agency (agency_name)
);

CREATE TABLE preceptor
(
  license_id VARCHAR(30) PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL,
  title VARCHAR(50) NOT NULL,
  specialty VARCHAR(50) NOT NULL,
  agency_name VARCHAR(50) NOT NULL,
  CONSTRAINT preceptor_fk_agency_name
	FOREIGN KEY (agency_name)
	REFERENCES agency (agency_name)
);

CREATE TABLE preceptor_address
(
  address VARCHAR(50) PRIMARY KEY,
  city VARCHAR(50) NOT NULL,
  preceptor_state CHAR(2) NOT NULL,
  zip_code VARCHAR(12) NOT NULL,
  phone_num VARCHAR(15) NOT NULL,
  fax_num VARCHAR(15),
  license_id VARCHAR(30) NOT NULL,
  CONSTRAINT preceptor_address_fk_license_id
	FOREIGN KEY (license_id)
	REFERENCES preceptor (license_id)
);

CREATE TABLE reviewer
(
  date_recieved DATE PRIMARY KEY,
  reviewed BOOLEAN NOT NULL,
  fauculty_reviewer VARCHAR(70),
  stu_id INT NOT NULL,
  CONSTRAINT reviewer_fk_stu_id
	FOREIGN KEY (stu_id)
	REFERENCES student (stu_id)
);

CREATE INDEX students_stu_lname_ix
	ON student (stu_lname);

-- insert rows into the tables
INSERT INTO student VALUES
(111, 'John', 'Doe', '123 1st street', 'Central', 'IL', '123456', '123-123-1234', NULL, NULL, 'jdoe@email.com'),
(222, 'Jane', 'Doe', '222 2nd street', 'North', 'IL', '123123', '234-123-2345', NULL, NULL, 'janedoe@email.com'),
(333, 'Sam', 'Smith', '234 3rd street', 'South', 'IL', '443322', '123-456-7890', NULL, NULL, 'ssmith@email.com');

INSERT INTO agency VALUES
('Medical Group', NULL, 'Jeff', 'Bob', 111),
('ER Group', NULL, 'George', 'Person', 222),
('Rush Medical', NULL, 'Mark', 'Water', 333);

INSERT INTO agency_address VALUES
('90 Fort street', 'Chicago', 'IL', '324345', '847-234-2341', NULL, 'Medical Group'),
('23 West drive', 'Joliet', 'IL', '123332', '234-635-4344', NULL, 'ER Group'),
('12 North street', 'Plainfield', 'IL', '67586', '999-777-6545', NULL, 'Rush Medical');

INSERT INTO agency_contact VALUES
('test@email.com', 'Trevor', 'John', NULL, 'Medical Group'),
('test2@email.com', 'Ray', 'Smith', NULL, 'ER Group'),
('test3@email.com', 'Laura', 'Beth', NULL, 'Rush Medical');

INSERT INTO preceptor VALUES
('11223344', 'Tom', 'Potter', 'Doctor', 'Heart', 'Medical Group'),
('22334455', 'Scott', 'Pilgrim', 'Surgeon', 'Lungs', 'ER Group'),
('33442211', 'Carlos', 'Turner', 'Doctor', 'Throat', 'Rush Medical');

INSERT INTO preceptor_address VALUES
('435 Year Drive', 'Normal', 'IL', '234789', '997-556-4432', NULL, '11223344'),
('523 Month Street', 'Peoria', 'IL', '443322', '154-564-2222', NULL, '22334455'),
('458 Week Street', 'Springfield', 'IL', '998804', '910-543-0999', NULL, '33442211');

INSERT INTO reviewer VALUES
('2013-04-13', TRUE, 'Susan Smith', 111),
('2013-05-02', FALSE, 'Jody Susan', 222),
('2013-10-20', TRUE, 'Susan Smith', 333);

SELECT stu_fname, stu_lname, stu_id, stu_address, city, stu_state, zip_code, home_phone FROM student;

SELECT * FROM agency JOIN agency_address ON agency.agency_name = agency_address.agency_name JOIN agency_contact ON agency.agency_name = agency_contact.agency_name;

SELECT * FROM preceptor JOIN preceptor_address ON preceptor.license_id = preceptor_address.license_id;

SELECT * FROM student;
SELECT agency_name, stu_id FROM agency;

SELECT DISTINCT stu_fname, stu_lname, stu_email, reviewed FROM student JOIN reviewer ON student.stu_id = reviewer.stu_id WHERE reviewed = FALSE;