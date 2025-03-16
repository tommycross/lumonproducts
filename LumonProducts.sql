/* Create DB schema */

create table Users(
  ID int identity(1,1) not null,
  Name nvarchar(100) not null,
  Email nvarchar(255),
  CreatedAt datetime,

  constraint PK_Users primary key (ID)
)

create table Products(
  ID int identity(1,1) not null,
  Name nvarchar(255) not null,
  Price int, /* Store as cents, format to currency on display */
  StockQuantity int,

  constraint PK_Products primary key (ID)
)

create table Orders(
  ID int identity(1,1) not null,
  UserID int not null,
  TotalPrice int,
  CreatedAt datetime,

  constraint PK_Orders primary key (ID),
  constraint FK_Orders_Users foreign key (UserID) references Users(ID)
)

create table OrderItems(
  ID int identity(1,1) not null,
  OrderID int not null,
  ProductID int not null,
  Quantity int,
  PriceAtPurchase int,

  constraint PK_OrderItems primary key (ID),
  constraint FK_OrderItems_Orders foreign key (OrderID) references Orders(ID),
  constraint FK_OrderItems_Products foreign key (ProductID) references Products(ID)
)

/* Populate some test data */

insert into Users(Name, Email, CreatedAt) values 
  ('Mark', 'mark.s@lumon.com', current_timestamp),
  ('Dylan', 'dylan.r@lumon.com', current_timestamp),
  ('Irving', 'irving.r@lumon.com', current_timestamp),
  ('Helly', 'helly.r@lumon.com', current_timestamp),
  ('Burt', 'burt.g@lumon.com', current_timestamp),
  ('Carol', 'carol.d@lumon.com', current_timestamp),
  ('Petey', 'peter.k@lumon.com', current_timestamp)
  
insert into Orders(UserID, TotalPrice, CreatedAt) values
  (7, 15234, '2024-03-05 14:23:00'),
  (1, 342, '2023-07-21 09:15:30'),
  (2, 19045, '2023-12-10 18:40:00'),
  (3, 7650, '2024-01-15 12:05:45'),
  (5, 11800, '2023-11-03 20:10:10'),
  (3, 300, '2023-08-19 08:50:00'),
  (4, 9700, '2023-06-14 17:30:20'),
  (1, 4500, '2023-10-27 10:05:35'),
  (3, 20000, '2023-09-30 15:45:50'),
  (2, 13675, '2023-04-22 07:20:15'),
  (5, 5278, '2023-11-09 22:10:00'),
  (2, 8300, '2023-12-20 14:55:25'),
  (7, 1500, '2023-05-07 16:35:40'),
  (2, 19000, '2023-10-13 11:25:05'),
  (4, 2850, '2023-07-08 13:40:30'),
  (3, 10200, '2023-09-01 19:30:45'),
  (1, 800, '2024-02-14 08:55:00'),
  (2, 14500, '2023-06-27 20:15:20'),
  (7, 350, '2023-08-05 06:45:10'),
  (5, 17500, '2023-12-01 17:50:35');

/* Skip the other tables, they aren't needed by the exercise */

/* Select top 5 users by total spend */ 

select top 5 Users.Name, sum(Orders.TotalPrice) as TotalSpend
from Users 
right join Orders on (Users.ID = Orders.UserID)
group by Users.Name
order by TotalSpend desc