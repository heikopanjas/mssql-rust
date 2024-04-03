USE master;
GO

-- initialize database
DROP DATABASE IF EXISTS dbcaps;
GO

CREATE DATABASE dbcaps ON
  (NAME = dbcapsdata, FILENAME = '/var/opt/mssql/data/dbcaps.mdf', SIZE = 1GB, FILEGROWTH=1GB)
LOG ON
  (NAME = dbcapslog, FILENAME = '/var/opt/mssql/data/dbcaps.ldf', SIZE = 1GB, FILEGROWTH=1GB);
GO

USE dbcaps;
GO

-- initialize credentials
IF EXISTS (SELECT name
FROM master.sys.server_principals
WHERE name = 'dbcaps')
BEGIN
  DROP LOGIN dbcaps;
END;
GO

CREATE LOGIN dbcaps with password = N'Ultra!schall0';
GO

DROP USER IF EXISTS dbcaps;
GO

-- initialize user
CREATE USER dbcaps FOR LOGIN dbcaps;
GO

-- initialize table
DROP TABLE IF EXISTS dbcaps;
GO

CREATE TABLE dbcaps
(
  id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  -- modification_date DATETIME2 DEFAULT GETDATE(),
  num INT,
  str VARCHAR(100)
);
GO

INSERT INTO dbcaps
  (num, str)
VALUES
  (1, 'one');
INSERT INTO dbcaps
  (num, str)
VALUES
  (2, 'two');
INSERT INTO dbcaps
  (num, str)
VALUES
  (3, 'three');

GRANT INSERT, UPDATE, DELETE, SELECT ON dbcaps TO dbcaps;
GO
