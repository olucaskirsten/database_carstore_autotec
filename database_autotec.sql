/* QUESTION 001 */
CREATE DATABASE AutotecWorkshopDB;

USE AutotecWorkshopDB;

/* QUESTION 002 */
CREATE TABLE Client (
    clientId INT AUTO_INCREMENT,
    name VARCHAR(100),
    cpfCnpj CHAR(14),
    clientType ENUM('PF', 'PJ'),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200),
    PRIMARY KEY (clientId)
);

CREATE TABLE CorporateClient (
    corporateClientId INT AUTO_INCREMENT,
    companyName VARCHAR(120),
    cnpj CHAR(14),
    stateRegistration VARCHAR(20),
    contact VARCHAR(80),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(200),
    PRIMARY KEY (corporateClientId)
);

CREATE TABLE VehicleType (
    vehicleTypeId INT AUTO_INCREMENT,
    description VARCHAR(50),
    PRIMARY KEY (vehicleTypeId)
);

CREATE TABLE Vehicle (
    vehicleId INT AUTO_INCREMENT,
    clientId INT,
    vehicleTypeId INT,
    plate VARCHAR(10),
    brand VARCHAR(50),
    model VARCHAR(50),
    year YEAR,
    color VARCHAR(30),
    chassis VARCHAR(30),
    PRIMARY KEY (vehicleId),
    FOREIGN KEY (clientId) REFERENCES Client(clientId),
    FOREIGN KEY (vehicleTypeId) REFERENCES VehicleType(vehicleTypeId)
);

CREATE TABLE WorkOrder (
    workOrderId INT AUTO_INCREMENT,
    clientId INT,
    vehicleId INT,
    openingDate DATETIME,
    status ENUM('OPEN', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'),
    totalValue DECIMAL(10,2),
    notes VARCHAR(255),
    PRIMARY KEY (workOrderId),
    FOREIGN KEY (clientId) REFERENCES Client(clientId),
    FOREIGN KEY (vehicleId) REFERENCES Vehicle(vehicleId)
);

CREATE TABLE Service (
    serviceId INT AUTO_INCREMENT,
    description VARCHAR(120),
    basePrice DECIMAL(10,2),
    estimatedTime INT,
    PRIMARY KEY (serviceId)
);

CREATE TABLE WorkOrderService (
    workOrderId INT,
    serviceId INT,
    quantity INT,
    unitValue DECIMAL(10,2),
    totalValue DECIMAL(10,2),
    PRIMARY KEY (workOrderId, serviceId),
    FOREIGN KEY (workOrderId) REFERENCES WorkOrder(workOrderId),
    FOREIGN KEY (serviceId) REFERENCES Service(serviceId)
);

CREATE TABLE Supplier (
    supplierId INT AUTO_INCREMENT,
    name VARCHAR(100),
    cnpj CHAR(14),
    phone VARCHAR(15),
    email VARCHAR(100),
    PRIMARY KEY (supplierId)
);

CREATE TABLE Part (
    partId INT AUTO_INCREMENT,
    description VARCHAR(100),
    manufacturerCode VARCHAR(50),
    unitPrice DECIMAL(10,2),
    supplierId INT,
    PRIMARY KEY (partId),
    FOREIGN KEY (supplierId) REFERENCES Supplier(supplierId)
);

CREATE TABLE Stock (
    stockId INT AUTO_INCREMENT,
    partId INT,
    availableQuantity INT,
    location VARCHAR(100),
    PRIMARY KEY (stockId),
    FOREIGN KEY (partId) REFERENCES Part(partId)
);

CREATE TABLE WorkOrderPart (
    workOrderId INT,
    partId INT,
    quantity INT,
    unitValue DECIMAL(10,2),
    totalValue DECIMAL(10,2),
    PRIMARY KEY (workOrderId, partId),
    FOREIGN KEY (workOrderId) REFERENCES WorkOrder(workOrderId),
    FOREIGN KEY (partId) REFERENCES Part(partId)
);

CREATE TABLE Appointment (
    appointmentId INT AUTO_INCREMENT,
    clientId INT,
    vehicleId INT,
    dateTime DATETIME,
    status ENUM('SCHEDULED', 'COMPLETED', 'CANCELLED'),
    note VARCHAR(200),
    PRIMARY KEY (appointmentId),
    FOREIGN KEY (clientId) REFERENCES Client(clientId),
    FOREIGN KEY (vehicleId) REFERENCES Vehicle(vehicleId)
);

CREATE TABLE Promotion (
    promotionId INT AUTO_INCREMENT,
    description VARCHAR(100),
    startDate DATE,
    endDate DATE,
    discountPercent DECIMAL(5,2),
    PRIMARY KEY (promotionId)
);

CREATE TABLE PromotionService (
    promotionId INT,
    serviceId INT,
    PRIMARY KEY (promotionId, serviceId),
    FOREIGN KEY (promotionId) REFERENCES Promotion(promotionId),
    FOREIGN KEY (serviceId) REFERENCES Service(serviceId)
);

CREATE TABLE Role (
    roleId INT AUTO_INCREMENT,
    description VARCHAR(50),
    baseSalary DECIMAL(10,2),
    PRIMARY KEY (roleId)
);

CREATE TABLE Employee (
    employeeId INT AUTO_INCREMENT,
    name VARCHAR(100),
    cpf CHAR(11),
    roleId INT,
    salary DECIMAL(10,2),
    hireDate DATE,
    PRIMARY KEY (employeeId),
    FOREIGN KEY (roleId) REFERENCES Role(roleId)
);

CREATE TABLE WorkSchedule (
    workScheduleId INT AUTO_INCREMENT,
    employeeId INT,
    startTime TIME,
    endTime TIME,
    weekDays VARCHAR(50),
    PRIMARY KEY (workScheduleId),
    FOREIGN KEY (employeeId) REFERENCES Employee(employeeId)
);

CREATE TABLE Training (
    trainingId INT AUTO_INCREMENT,
    description VARCHAR(100),
    date DATE,
    workload INT,
    PRIMARY KEY (trainingId)
);

CREATE TABLE EmployeeTraining (
    employeeId INT,
    trainingId INT,
    PRIMARY KEY (employeeId, trainingId),
    FOREIGN KEY (employeeId) REFERENCES Employee(employeeId),
    FOREIGN KEY (trainingId) REFERENCES Training(trainingId)
);

CREATE TABLE Payment (
    paymentId INT AUTO_INCREMENT,
    workOrderId INT,
    amount DECIMAL(10,2),
    paymentDate DATE,
    paymentMethod ENUM('CASH', 'CARD', 'PIX', 'BOLETO'),
    PRIMARY KEY (paymentId),
    FOREIGN KEY (workOrderId) REFERENCES WorkOrder(workOrderId)
);

CREATE TABLE Expense (
    expenseId INT AUTO_INCREMENT,
    description VARCHAR(100),
    amount DECIMAL(10,2),
    date DATE,
    expenseType ENUM('FIXED', 'VARIABLE'),
    PRIMARY KEY (expenseId)
);

CREATE TABLE Warranty (
    warrantyId INT AUTO_INCREMENT,
    workOrderId INT,
    type ENUM('SERVICE', 'PART'),
    startDate DATE,
    endDate DATE,
    status ENUM('ACTIVE', 'EXPIRED', 'CANCELLED'),
    PRIMARY KEY (warrantyId),
    FOREIGN KEY (workOrderId) REFERENCES WorkOrder(workOrderId)
);

CREATE TABLE WarrantyPart (
    warrantyId INT,
    partId INT,
    PRIMARY KEY (warrantyId, partId),
    FOREIGN KEY (warrantyId) REFERENCES Warranty(warrantyId),
    FOREIGN KEY (partId) REFERENCES Part(partId)
);

CREATE TABLE Audit (
    auditId INT AUTO_INCREMENT,
    affectedTable VARCHAR(50),
    action ENUM('INSERT', 'UPDATE', 'DELETE'),
    user VARCHAR(50),
    dateTime DATETIME,
    description TEXT,
    PRIMARY KEY (auditId)
);