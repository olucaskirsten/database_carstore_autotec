# 🚗 Autotec Workshop Database

A relational database project designed for managing an automotive workshop system, including clients, vehicles, services, work orders, inventory, employees, and financial operations.

---

## 📌 Overview

This project was developed as part of an academic assignment and simulates a real-world automotive workshop management system.

It covers:

* Client and corporate client management
* Vehicle tracking
* Work orders and services
* Parts and inventory control
* Appointments and promotions
* Employees and training
* Payments and expenses
* Warranty tracking
* Audit logging

---

## 🧠 Database Structure

The database follows a normalized relational model and includes the following main entities:

* **Client / CorporateClient**
* **Vehicle / VehicleType**
* **WorkOrder / WorkOrderService / WorkOrderPart**
* **Service**
* **Part / Stock / Supplier**
* **Appointment**
* **Promotion / PromotionService**
* **Employee / Role / WorkSchedule**
* **Training / EmployeeTraining**
* **Payment / Expense**
* **Warranty / WarrantyPart**
* **Audit**

---

## ⚙️ Technologies Used

* SQL (MySQL)
* Relational Database Modeling

---

## 🗂️ Features Implemented

### ✔ Data Definition (DDL)

* Database and table creation
* Primary and foreign key relationships
* ENUM usage for controlled fields

### ✔ Data Manipulation (DML)

* Insert sample data
* Update records
* Delete conditions

### ✔ Queries & Business Logic

* Joins (INNER, LEFT)
* Aggregations (SUM, COUNT)
* Grouping and ordering
* Subqueries
* Real-world reporting queries

---

## 📊 Example Queries

### List all individual clients (PF)

```sql
SELECT name, cpfCnpj
FROM Client
WHERE clientType = 'PF'
ORDER BY name;
```

### Total revenue per service

```sql
SELECT s.description,
       SUM(wos.totalValue) AS totalSold,
       COUNT(*) AS executions
FROM WorkOrderService wos
JOIN Service s ON s.serviceId = wos.serviceId
GROUP BY s.description
ORDER BY totalSold DESC;
```

---

## 📈 Business Use Cases

This database supports:

* Workshop service management
* Inventory tracking
* Financial control (payments & expenses)
* Employee organization
* Customer relationship management
* Audit and traceability

---

## 🧩 Future Improvements

* Add indexes for performance optimization
* Implement stored procedures and triggers
* Create API integration (Node.js / Java backend)
* Build a front-end dashboard (React or similar)
* Add authentication and user roles

---

## 👨‍💻 Author

Developed by **Lucas Eduardo Abrantes Kirsten**
Web Developer & Digital Marketing Specialist

---

## 🌍 Notes

This project demonstrates intermediate-level knowledge in:

* Relational database design
* SQL querying
* Real-world system modeling

It can be used as part of a portfolio for international opportunities in software development or data-related roles.
