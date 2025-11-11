CREATE TABLE IF NOT EXISTS passenger (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS check_ins (
    "id",
    "date" TEXT NOT NULL,
    "time" TEXT NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "passenger_id" INTEGER NOT NULL,
    "flight_id" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES passenger("id")
    FOREIGN KEY("flight_id") REFERENCES flights("id")
);

CREATE TABLE IF NOT EXISTS airlines (
    "id",
    "name" TEXT NOT NULL,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ('A','B','C','D','E','F','T')),
    PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS flights (
    "id",
    "flight_number" TEXT NOT NULL,
    "airline_id" INTEGER NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "departure_date_time" TEXT NOT NULL,
    "arrival_date_time" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airliens"("id")

);