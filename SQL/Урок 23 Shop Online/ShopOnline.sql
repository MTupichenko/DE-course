--CREATE DATABASE ShopOnline
USE ShopOnline

CREATE INDEX idx_products_category ON products (category_id)
CREATE INDEX idx_order_items_product_id ON order_items (product_id)
CREATE INDEX idx_orders_id ON orders(id)

SELECT ct.name AS Category
		, SUM (ot.quantity * pr.price) AS TotalSum
		, SUM (ot.quantity) AS Quantity
		, AVG (pr.price) AS AveragePrice
FROM products pr
JOIN categories ct ON ct.id = pr.category_id
JOIN order_items ot ON ot.product_id = pr.id
JOIN orders ord ON ord.id = ot.order_id
GROUP BY ct.name
ORDER BY TotalSum DESC


SELECT * FROM [dbo].[categories]
SELECT * FROM [dbo].[order_items]
SELECT * FROM [dbo].[orders]
SELECT * FROM [dbo].[products]