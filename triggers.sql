
CREATE TABLE ItemArchive (
    archive_id SERIAL PRIMARY KEY,
    item_id VARCHAR(20) REFERENCES Item(item_id),
    attribute_name VARCHAR(50),
    old_value TEXT,
    new_value TEXT,
    update_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION item_update_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
        VALUES (NEW.item_id, TG_ARGV[0], OLD.*::text, NEW.*::text);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER item_update
AFTER UPDATE ON Item
FOR EACH ROW
EXECUTE FUNCTION item_update_trigger('item_name');


--to test the triger for item update 
UPDATE Item 
SET item_type = 'service',
    item_name = 'a hug',
    item_description = 'hello',
    item_price = 0,
    item_picture = ''
WHERE item_id = 'B00029V00I';