
CREATE OR REPLACE FUNCTION item_update_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO item_archive (attribute_name, item_id, old_value, new_value, update_datetime)
        VALUES (TG_ARGV[0], NEW.item_id, OLD.*::text, NEW.*::text, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER item_update
AFTER UPDATE ON item
FOR EACH ROW
EXECUTE FUNCTION item_update_trigger('item_name');



CREATE OR REPLACE FUNCTION my_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    -- Your trigger logic here
    -- For example, you can perform some actions before or after an INSERT, UPDATE, or DELETE operation

    RETURN NEW; -- or RETURN NULL; if you want to cancel the operation
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER my_trigger
AFTER INSERT OR UPDATE OR DELETE ON my_table
FOR EACH ROW
EXECUTE FUNCTION my_trigger_function();