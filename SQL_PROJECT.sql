-- DATABASE OnlineBookStore;

--create tables 
DROP TABLE IF EXISTS BOOks;
CREATE TABLE Books(
	Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
	Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID INT REFERENCES Customers(Customer_ID),
	Book_ID INT REFERENCES BookS(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

/*COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'C:/Users/hpdel/OneDrive/Desktop/All Excel Practice Files/Books.csv'
DELIMITER ','
CSV HEADER;
 */

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country='Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_date BETWEEN '2023-11-1' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
ASC LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as revenue
from Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select * from Orders;

select b.Genre, sum(o.Quantity)
from Orders o
join Books b on b.book_id=o.book_id
group by b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select * from Books;
select avg(price) as average_price
from Books
where Genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
select o.Customer_id, c.name, count(o.Order_id) as count_order
from Orders o
join Customers c on o.Customer_id=c.Customer_id
group by o.Customer_id, c.name
having count(order_id)>=2;

-- 4) Find the most frequently ordered book:
select o.book_id, b.Title, count(o.Order_id) as count_order
from Books b
join Orders o on o.book_id=b.book_id
group by o.book_id, b.Title
order by count_order desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from Books
where Genre='Fantasy'
order by price Desc limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select b.author, sum(o.quantity) as total_books_solf
from books b
join orders o on o.book_id=b.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select c.city, o.total_amount
from orders o
join Customers c on o.Customer_id=c.Customer_id
where o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name, sum(o.total_amount) as total_spent
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 1;

--9) Calculate the stock remaining after fulfilling all orders:
select b.book_id, b.title, b.stock,coalesce(sum(o.quantity),0) as Order_quantity,
	b.stock-coalesce(sum(o.quantity),0) as Remaining_Quantity
from books b
join orders o on o.book_id=b.book_id
group by b.book_id
order by b.book_id;
	

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;














