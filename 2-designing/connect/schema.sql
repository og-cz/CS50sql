-- users = id, first_name, last_name, password
CREATE TABLE IF NOT EXISTS users (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- schools = name, type, address, founded_year
CREATE TABLE IF NOT EXISTS schools (
    "id",
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University')),
    "address" TEXT NOT NULL,
    "founded_year" INTEGER NOT NULL,
    PRIMARY KEY("id") 
);

-- companies =  name, industry, address
CREATE TABLE IF NOT EXISTS companies (
    "id",
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- connections of people = id, user_id, following_user_id
CREATE TABLE IF NOT EXISTS connections_people (
    "user_id" NOT NULL,
    "following_user_id" NOT NULL CHECK("user_id" != "user_id"),
    FOREIGN KEY("user_id") REFERENCES users("id"),
    FOREIGN KEY("following_user_id") REFERENCES users("id")
);
-- connections of schools = id, start_date, end_date, degree, user_id
CREATE TABLE IF NOT EXISTS connections_schools (
    "school_id" NOT NULL,
    "user_id" NOT NULL,
    "start_date" TEXT NOT NULL,
    "end_date" TEXT NOT NULL,
    "degree" TEXT NOT NULL CHECK("degree" IN ('BA', 'MA', 'PhD')),
    FOREIGN KEY("school_id") REFERENCES schools("id"),
    FOREIGN KEY("user_id") REFERENCES users("id")
);

-- connection of companies = id, start_date, end_date, title, user_id
CREATE TABLE IF NOT EXISTS connections_comapanies (
    "id",
    "user_id" NOT NULL,
    "start_date" TEXT NOT NULL,
    "end_date" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    PRIMARY KEY("ID"),
    FOREIGN KEY("user_id") REFERENCES users("id")
);