
CREATE TABLE Users
(
	username VARCHAR(50) PRIMARY KEY,
	password VARCHAR(100) NOT NULL UNIQUE,
	account_type VARCHAR(20) NOT NULL
);

CREATE TABLE Donor
(
	donor_email VARCHAR(60) PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	address VARCHAR(60),
	city VARCHAR(50) NOT NULL,
	donor_state CHAR(2) NOT NULL,
	zip_code VARCHAR(20) NOT NULL,
	phone_number VARCHAR(50),
	total_donations	 INT,
	amount_donated	 DECIMAL(10,2),
	donor_username VARCHAR(50),
	FOREIGN KEY (donor_username)
		REFERENCES Users(username)
);

CREATE TABLE Organization
(
	org_email VARCHAR(60) PRIMARY KEY,
	organization_type VARCHAR(30) NOT NULL,
	organization_name VARCHAR(50) NOT NULL,
	address VARCHAR(60),
	city VARCHAR(50) NOT NULL,
	org_state CHAR(2) NOT NULL,
	zip_code VARCHAR(20) NOT NULL,
	phone_number VARCHAR(50),	
	total_donors INT,
	total_donations	 DECIMAL(10,2),
	org_username VARCHAR(50),
	FOREIGN KEY (org_username)
		REFERENCES Users(username)
);

CREATE TABLE Events
(
	event_id INT PRIMARY KEY AUTO_INCREMENT,
	event_name VARCHAR(50) NOT NULL,
	location VARCHAR(70) NOT NULL,
	event_date DATE NOT NULL,
	org_email VARCHAR(60),
	FOREIGN KEY (org_email)	
	REFERENCES Organization(org_email)
);

CREATE TABLE Donation
(
	donation_id INT PRIMARY KEY AUTO_INCREMENT,
	donation_date DATE NOT NULL,
	amount_donated DECIMAL(10,2) NOT NULL,
	donation_type VARCHAR(40),
	donor_email VARCHAR(60),
	org_email VARCHAR(60),
	FOREIGN KEY (org_email)	
	REFERENCES Organization(org_email)
);

CREATE TABLE EventDonations
(
	event_id INT,
	donation_id INT,
	FOREIGN KEY (event_id)	
	REFERENCES Events(event_id),
	FOREIGN KEY (donation_id)	
	REFERENCES Donation(donation_id)
);