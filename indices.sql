-- other indexes were created when creating the table with the unique constraint
CREATE INDEX item_price_index ON item USING btree (item_price);
