CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(100),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
    );
SELECT * FROM Books;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Counrty VARCHAR(150)
    );
    SELECT * FROM Customers;
    
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
    );
    SELECT * FROM Orders;
    
    -- Retrieve all books in the "Fiction" Genre:
    SELECT * FROM Books
    WHERE Genre = 'Fiction';
    
    -- Find books published after the year 1950:
    SELECT * FROM Books
    WHERE Published_Year>1950;
    
    -- List all customers from Canada:
    SELECT * FROM Customers
    WHERE Country = 'Canada';
    
    -- Show orders placed in November 2023:
    SELECT * FROM Orders
    WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30';
    
    -- Retrieve the total stock of books available:
    SELECT SUM(Stock) AS Total_Stock
    FROM Books;
    
    -- Find the details of the most expensive book:
    SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
    
    -- Show all customers who ordered more than 1 quantity of a book:
    SELECT * FROM Orders
    WHERE Quantity>1;
    
    -- Retrieve all orders where the total amount exceeds $20:
    SELECT * FROM Orders
    WHERE Total_Amount>20;
    
    -- List all genres available in the Books table:
    SELECT DISTINCT Genre FROM Books;
    
    -- Find the book with the lowest stock:
    SELECT * FROM Books ORDER BY Stock LIMIT 1;
    
    -- Calculate the total revenue generated from all orders:
    SELECT SUM(Total_Amount) AS Revenue 
    FROM Orders;
    
    -- Retrieve the total number of books sold for each genre:
    SELECT B.Genre, SUM(O.Quantity) AS Total_Book_Sold
    FROM Orders O
    JOIN Books B ON O.Book_ID = B.Book_ID
    GROUP BY B.Genre;
    
    -- Find the average price of books in the 'Fantasy' Genre:
    SELECT B.Genre, AVG(B.Price) AS Average_Price
    FROM Books B
    WHERE Genre = 'Fantasy';
    
    -- List customers who have played at least 2 orders:
    SELECT O.Customer_ID, C.Name,  COUNT(O.Order_ID) AS Order_Count
    FROM Orders O
   JOIN Customers C ON O.Customer_ID = C.Customer_ID
   GROUP BY O.Customer_ID, C.Name
    HAVING COUNT(Order_ID)>=2;
    
    -- Find the most frequenty ordered book:
    SELECT O.Book_ID, B.Title, COUNT(O.Order_ID) AS Order_Count
    FROM Orders O
    JOIN Books B ON O.Book_ID = B.Book_ID
    GROUP BY O.Book_ID, B.Title
    ORDER BY Order_Count DESC LIMIT 1;
    
    -- Show the top 3 most expensive books of 'Fantasy' Genre:
    SELECT * FROM Books
    WHERE Genre = 'Fantasy'
    ORDER BY Price DESC LIMIT 3;
    
    -- Retrieve the most total quantity of books sold by each author:
    SELECT B.Author, SUM(O.Quantity)
    FROM Orders O
    JOIN Books B ON B.Book_ID = O.Order_ID
    GROUP BY B.Author;
    
    -- List the cities where customers who spent over $30 are located:
    SELECT DISTINCT C.City, O.Total_Amount
    FROM Orders O
    JOIN Customers C ON C.Customer_ID = O.Customer_ID
    WHERE O.Total_Amount>30;
    
    -- Find the custome who spent the most on orders:
    SELECT C.Customer_ID, C.Name, SUM(O.Total_Amount) AS Total_Spent
    FROM Orders O
    JOIN Customers C ON O.Customer_ID = C.Customer_ID
    GROUP BY C.Customer_ID, C.Name
    ORDER BY Total_Spent DESC LIMIT 1;
    
    -- Calculate the stock remaining after fulfiling all orders:
    SELECT B.Book_ID, B.Title, B.Stock, COALESCE(SUM(O.Quantity),0) AS Order_Quantity, B.Stock-COALESCE(SUM(O.Quantity),0) AS Remaining_Quantity
	FROM Books B
    LEFT JOIN Orders O ON B.Book_ID = O.Book_ID
    GROUP BY B.Book_ID ORDER BY B.Book_ID;
    
    
    


    
    

      