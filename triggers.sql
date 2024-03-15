
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
        IF OLD.item_name <> NEW.item_name THEN
            INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
            VALUES (NEW.item_id, 'item_name', OLD.item_name::text, NEW.item_name::text);
        END IF;
        
        IF OLD.item_type <> NEW.item_type THEN
            INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
            VALUES (NEW.item_id, 'item_type', OLD.item_type::text, NEW.item_type::text);
        END IF;

         IF OLD.item_description <> NEW.item_description THEN
            INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
            VALUES (NEW.item_id, 'item_description', OLD.item_description::text, NEW.item_description::text);
        END IF;
         IF OLD.item_price <> NEW.item_price THEN
            INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
            VALUES (NEW.item_id, 'item_price', OLD.item_price::text, NEW.item_price::text);
        END IF;
         IF OLD.item_picture <> NEW.item_picture THEN
            INSERT INTO ItemArchive (item_id, attribute_name, old_value, new_value)
            VALUES (NEW.item_id, 'item_picture', OLD.item_picture::text, NEW.item_picture::text);
        END IF;
        
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER item_update
AFTER UPDATE ON Item
FOR EACH ROW
EXECUTE FUNCTION item_update_trigger();




UPDATE Item 
SET 
    item_name = 'a pooperest head',
    item_type = 'service',
    item_description = 'i am da best',
    item_price = 50,
    item_picture = 'is this a picture'
   
WHERE item_id = 'B00029V00I';
--B00029V00I is a item_id 