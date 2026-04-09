DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-0100002', 'ABC clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-0100003', 'PQR clinic', 'lorem', 'ipsum', 'dolor');

INSERT INTO customer (uid, name, mobile) VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('uid-002', 'Alice Smith', '98XXXXXXXX'),
('uid-003', 'Bob Johnson', '99XXXXXXXX');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'uid-002', 'cnc-0100001', 15000, '2021-09-24 10:00:00', 'walk-in'),
('ord-00100-00102', 'uid-003', 'cnc-0100002', 30000, '2021-09-25 14:00:00', 'online'),
('ord-00100-00103', 'uid-002', 'cnc-0100002', 5000, '2021-10-15 11:00:00', 'referral');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'electricity bill', 1200, '2021-09-30 09:00:00'),
('exp-0100-00102', 'cnc-0100002', 'rent', 10000, '2021-09-01 10:00:00'),
('exp-0100-00103', 'cnc-0100002', 'maintenance', 2500, '2021-10-05 12:00:00');
