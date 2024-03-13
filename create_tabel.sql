

CREATE DATABASE final;

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    user_email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    street_address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);

CREATE TABLE UserInterests (
    user_id INT REFERENCES Users(user_id),
    interest VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id, interest)
);

CREATE TABLE Company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    company_contact VARCHAR(100),
    company_contact_phone_nbr VARCHAR(20),
    company_contact_email VARCHAR(255),
    url VARCHAR(255) UNIQUE
);

CREATE TABLE CompanyLocation (
    company_id INT REFERENCES Company(company_id),
    location_id BIGINT PRIMARY KEY,
    street_address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    phone_nbr VARCHAR(20)
);

CREATE TABLE UserCompanyReview (
    company_id INT REFERENCES Company(company_id),
    user_id INT REFERENCES Users(user_id),
    rating_score DECIMAL(2, 1) CHECK (rating_score >= 1 AND rating_score <= 5),
    comments TEXT,
    PRIMARY KEY (company_id, user_id)
);

CREATE TABLE Item (
    item_id VARCHAR(20) PRIMARY KEY,
    item_type VARCHAR(50) CHECK (item_type IN ('service', 'product')),
    item_name VARCHAR(750) NOT NULL,
    item_description TEXT,
    item_price DECIMAL(10, 2),
    item_picture VARCHAR(255)
);

CREATE TABLE Discount (
    discount_id BIGINT PRIMARY KEY,
    discount_type VARCHAR(50) CHECK (discount_type IN ('freebie', 'percentage coupon', 'fixed coupon', 'other')),
    discount_amount DECIMAL(10, 2),
    discount_description TEXT,
    discount_start_date DATE,
    discount_end_date DATE
);

CREATE TABLE UserCheckin (
    checkin_id BIGINT PRIMARY KEY,
    checkin_date DATE,
    user_id INT REFERENCES Users(user_id),
    company_id INT REFERENCES Company(company_id),
    item_id INT REFERENCES Item(item_id),
    discount_id INT REFERENCES Discount(discount_id),
    CONSTRAINT uq_user_checkin UNIQUE (user_id, company_id, item_id, checkin_date)
);

CREATE TABLE Employee (
    employee_id BIGINT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_category VARCHAR(50),
    salary DECIMAL(10, 2),
    start_date DATE,
    street_address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);

CREATE TABLE CompanyTransaction (
    transaction_id BIGINT PRIMARY KEY,
    transaction_date DATE,
    charge_type VARCHAR(50) CHECK (charge_type IN ('annual fee', 'checkin fees')),
    transaction_amount DECIMAL(10, 2),
    surcharge DECIMAL(10, 2),
    total_charge DECIMAL(10, 2),
    is_paid BOOLEAN,
    paid_date DATE,
    company_id INT REFERENCES Company(company_id)
);

CREATE TABLE CompanyTransactionCheckin (
    transaction_id INT REFERENCES CompanyTransaction(transaction_id),
    checkin_id INT REFERENCES UserCheckin(checkin_id),
    checkin_charge DECIMAL(10, 2),
    PRIMARY KEY (transaction_id, checkin_id)
);

CREATE TABLE CompanyItem (
    company_id INT REFERENCES Company(company_id),
    item_id INT REFERENCES Item(item_id),
    is_discounted BOOLEAN,
    discount_id INT REFERENCES Discount(discount_id),
    PRIMARY KEY (company_id, item_id)
);

CREATE TABLE UserLocationPreference (
    user_id INT REFERENCES Users(user_id),
    preference_location_city VARCHAR(50),
    preference_location_state VARCHAR(50),
    PRIMARY KEY (user_id, preference_location_city, preference_location_state)
);

CREATE TABLE UserItemPreference (
    user_id INT REFERENCES Users(user_id),
    item_id INT REFERENCES Item(item_id),
    PRIMARY KEY (user_id, item_id)
);

CREATE TABLE UserCompanyPreference (
    user_id INT REFERENCES Users(user_id),
    preference_company_id INT REFERENCES Company(company_id),
    PRIMARY KEY (user_id, preference_company_id)
);



