CREATE DATABASE IF NOT EXISTS SalesManagement;

USE SalesManagement;

CREATE TABLE Product
(
    MaSP CHAR(6) PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    HangSanXuat VARCHAR(100) NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    SoLuongTonKho INT NOT NULL
);

CREATE TABLE Customer
(
    MaKH CHAR(6) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    SoDienThoai VARCHAR(20),
    DiaChi VARCHAR(200)
);

CREATE TABLE `Order`
(
    MaDH CHAR(6) PRIMARY KEY,
    NgayDatHang DATE NOT NULL,
    TongTien DECIMAL(18,2) NOT NULL,
    MaKH CHAR(6) NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES Customer(MaKH)
);

CREATE TABLE Order_Detail
(
    MaDH CHAR(6),
    MaSP CHAR(6),
    SoLuongMua INT NOT NULL,
    GiaBanTaiThoiDiem DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (MaDH, MaSP),
    FOREIGN KEY (MaDH) REFERENCES `Order`(MaDH),
    FOREIGN KEY (MaSP) REFERENCES Product(MaSP)
);

ALTER TABLE `Order`
ADD GhiChu TEXT;

ALTER TABLE Product
RENAME COLUMN HangSanXuat TO NhaSanXuat;

DROP TABLE Order_Detail;
DROP TABLE `Order`;

INSERT INTO Product (MaSP, TenSP, NhaSanXuat, DonGia, SoLuongTonKho)
VALUES
('SP001', 'MacBook Air M2', 'Apple', 28000000, 10),
('SP002', 'iPhone 15', 'Apple', 19000000, 15),
('SP003', 'Dell Inspiron', 'Dell', 15000000, 8),
('SP004', 'RAM Kingston 16GB', 'Kingston', 1500000, 20),
('SP005', 'SSD Samsung 1TB', 'Samsung', 2500000, 12);

INSERT INTO Customer (MaKH, HoTen, Email, SoDienThoai, DiaChi)
VALUES
('KH001', 'Nguyen Van A', 'a@gmail.com', '0901111111', 'TP.HCM'),
('KH002', 'Tran Thi B', 'b@gmail.com', '0902222222', 'Ha Noi'),
('KH003', 'Le Van C', 'c@gmail.com', NULL, 'Da Nang'),
('KH004', 'Pham Thi D', 'd@gmail.com', '0904444444', 'Can Tho'),
('KH005', 'Hoang Van E', 'e@gmail.com', NULL, 'Hai Phong');

INSERT INTO `Order` (MaDH, NgayDatHang, TongTien, MaKH, GhiChu)
VALUES
('DH001', '2026-04-01', 29500000, 'KH001', 'Giao nhanh'),
('DH002', '2026-04-02', 19000000, 'KH002', ''),
('DH003', '2026-04-03', 15000000, 'KH004', ''),
('DH004', '2026-04-04', 30500000, 'KH001', ''),
('DH005', '2026-04-05', 2500000, 'KH002', '');

INSERT INTO Order_Detail (MaDH, MaSP, SoLuongMua, GiaBanTaiThoiDiem)
VALUES
('DH001', 'SP001', 1, 28000000),
('DH001', 'SP004', 1, 1500000),
('DH002', 'SP002', 1, 19000000),
('DH003', 'SP003', 1, 15000000),
('DH004', 'SP001', 1, 28000000),
('DH004', 'SP005', 1, 2500000),
('DH005', 'SP005', 1, 2500000);

UPDATE Product
SET DonGia = DonGia * 1.1
WHERE NhaSanXuat = 'Apple';

DELETE FROM Customer
WHERE SoDienThoai IS NULL;

SELECT *
FROM Product
WHERE DonGia BETWEEN 10000000 AND 20000000;

SELECT Product.TenSP
FROM Order_Detail
JOIN Product ON Order_Detail.MaSP = Product.MaSP
WHERE Order_Detail.MaDH = 'DH001';

SELECT DISTINCT Customer.*
FROM Customer
JOIN `Order` ON Customer.MaKH = `Order`.MaKH
JOIN Order_Detail ON `Order`.MaDH = Order_Detail.MaDH
JOIN Product ON Order_Detail.MaSP = Product.MaSP
WHERE Product.TenSP = 'MacBook Air M2';
