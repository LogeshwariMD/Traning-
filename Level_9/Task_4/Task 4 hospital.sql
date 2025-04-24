USE hospital_management;

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender ENUM('M', 'F'),
    address VARCHAR(200),
    phone VARCHAR(15),
    email VARCHAR(100),
    doctor_id INT,
    room_id INT,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Room(room_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role ENUM('Nurse', 'Cleaner', 'Security', 'Technician'),
    phone VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10),
    type ENUM('General', 'ICU', 'Operation Theater'),
    status ENUM('Occupied', 'Available'),
    charges_per_day DECIMAL(10, 2)
);


CREATE TABLE Cashier (
    cashier_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100)
);


CREATE TABLE Bill (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    cashier_id INT,
    amount DECIMAL(10, 2),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cashier_id) REFERENCES Cashier(cashier_id) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO Doctor (first_name, last_name, specialization, phone, email) VALUES
('John', 'Smith', 'Cardiologist', '111-111-1111', 'john.smith@hospital.com'),
('Emily', 'Jones', 'Neurologist', '222-222-2222', 'emily.jones@hospital.com');


INSERT INTO Room (room_number, type, status, charges_per_day) VALUES
('101', 'General', 'Available', 2000),
('102', 'ICU', 'Occupied', 5000);


INSERT INTO Patient (first_name, last_name, dob, gender, address, phone, email, doctor_id, room_id) VALUES
('Alice', 'Brown', '1990-01-01', 'F', '123 Street', '555-555-5555', 'alice.brown@hospital.com', 1, 1),
('Bob', 'Green', '1985-05-05', 'M', '456 Avenue', '666-666-6666', 'bob.green@hospital.com', 2, 2);


INSERT INTO Cashier (first_name, last_name, phone, email) VALUES
('James', 'Carter', '777-777-7777', 'james.carter@hospital.com');


INSERT INTO Bill (patient_id, cashier_id, amount, bill_date) VALUES
(1, 1, 10000, '2023-03-01'),
(2, 1, 15000, '2023-03-02');


SELECT p.first_name AS Patient, d.first_name AS Doctor, r.room_number, r.type
FROM Patient p
JOIN Doctor d ON p.doctor_id = d.doctor_id
JOIN Room r ON p.room_id = r.room_id;


SELECT b.bill_id, p.first_name AS Patient, c.first_name AS Cashier, b.amount
FROM Bill b
JOIN Patient p ON b.patient_id = p.patient_id
JOIN Cashier c ON b.cashier_id = c.cashier_id;






