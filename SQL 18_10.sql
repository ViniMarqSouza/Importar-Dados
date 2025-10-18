create database ERP;
use ERP;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY auto_increment,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(100),
    Description TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Categories.csv'
INTO TABLE Categories
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY auto_increment,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    BirthDate DATE,
    Photo VARCHAR(255),
    Notes TEXT
    
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees.csv'
INTO TABLE Employees
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID, LastName, FirstName, @BirthDate, Photo, Notes)
    set BirthDate = STR_TO_DATE(@BirthDate, '%d/%m/%Y');


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY auto_increment,
    OrderID INT,
    ProductID INT,
    Quantity INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY auto_increment,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, CustomerID, EmployeeID, @OrderDate, ShipperID)
    set OrderDate = STR_TO_DATE(@OrderDate, '%d/%m/%Y');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY auto_increment,
    ProductName VARCHAR(100),
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(50),
    Price DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID, ProductName, SupplierID, CategoryID, Unit, @price)
set price = replace(@price, ",",".");

CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY auto_increment,
    ShipperName VARCHAR(100),
    Phone VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shippers.csv'
INTO TABLE Shippers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY auto_increment,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Suppliers.csv'
INTO TABLE Suppliers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

alter table orderdetails
add constraint fk_orderdetails_prod foreign key (ProductID) references products(ProductID);

alter table orders
add constraint fk_order_employees foreign key (EmployeeID) references employees(EmployeeID);

alter table products
add constraint fk_prod_sup foreign key (SupplierID) references suppliers(SupplierID);

alter table orders
add constraint fk_orders_ship foreign key (ShipperID) references shippers(ShipperID);

alter table orderdetails
add constraint fk_orders_orderdetails foreign key (OrderID) references orders(OrderID);

alter table products
add constraint fk_prod_cat foreign key (CategoryID) references categories(CategoryID);

alter table orders
add constraint fk_order_cust foreign key (CustomerID) references customers(CustomerID);