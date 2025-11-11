-- ingredients = flour, yeast, oil, butter, type of sugar, amount
CREATE TABLE IF NOT EXISTS ingredients (
    "id",
    "flour" NUMERIC,
    "yeast" NUMERIC,
    "oil" NUMERIC,
    "butter" NUMERIC,
    "price" NUMERIC,
    PRIMARY KEY("id") 
);

-- donuts = name, is_gluten_free, price, ingredient_id
CREATE TABLE IF NOT EXISTS donuts (
    "id",
    "name" TEXT NOT NULL,
    "is_gluten_free" INTEGER NOT NULL CHECK("is_gluten_free" IN (0, 1)),
    "price" NUMERIC NOT NULL,
    "ingredient_id",
    PRIMARY KEY("id")
    FOREIGN KEY("ingredient_id") REFERENCES ingredients("id") 
);

-- orders = id, donut_id, customer_id
CREATE TABLE IF NOT EXISTS orders (
    "id",
    "donut_id",
    "customer_id",
    PRIMARY KEY("id")
    FOREIGN KEY("customer_id") REFERENCES customers("id")     
    FOREIGN KEY("donut_id") REFERENCES donuts("id")
);

-- customers = id, first_name, last_name, history_id
CREATE TABLE IF NOT EXISTS customers (
    "id",
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "order_id",
    PRIMARY KEY("id"),
    FOREIGN KEY("order_id") REFERENCES orders("id") 
);
