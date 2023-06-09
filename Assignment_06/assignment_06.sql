	DROP DATABASE IF EXISTS TestingSystem;
	CREATE DATABASE TestingSystem;
	USE TestingSystem;
    
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName NVARCHAR(30) NOT NULL UNIQUE KEY
);

	DROP TABLE IF EXISTS Position;
	CREATE TABLE `Position` (
	PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PositionName ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);
	DROP TABLE IF EXISTS `Account`;
	CREATE TABLE `Account`(
	AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Email VARCHAR(50) NOT NULL UNIQUE KEY,
	Username VARCHAR(50) NOT NULL UNIQUE KEY,
	FullName NVARCHAR(50) NOT NULL,
	DepartmentID TINYINT UNSIGNED NOT NULL,
	PositionID TINYINT UNSIGNED NOT NULL,
	CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
	DROP TABLE IF EXISTS `Group`;
	CREATE TABLE `Group`(
	GroupID TINYINT UNSIGNED AUTO_INCREMENT
	PRIMARY KEY,

	GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
	CreatorID TINYINT UNSIGNED,
	CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)
);
	DROP TABLE IF EXISTS GroupAccount;
	CREATE TABLE GroupAccount(
	GroupID TINYINT UNSIGNED NOT NULL,
	AccountID TINYINT UNSIGNED NOT NULL,
	JoinDate DATETIME DEFAULT NOW(),
	PRIMARY KEY (GroupID,AccountID),
	FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
	FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);
	DROP TABLE IF EXISTS TypeQuestion;
	CREATE TABLE TypeQuestion (
	TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	TypeName ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);
	DROP TABLE IF EXISTS CategoryQuestion;
	CREATE TABLE CategoryQuestion(
	CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);
	DROP TABLE IF EXISTS Question;
	CREATE TABLE Question(
	QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content NVARCHAR(100) NOT NULL,
	CategoryID TINYINT UNSIGNED NOT NULL,
	TypeID TINYINT UNSIGNED NOT NULL,
	CreatorID TINYINT UNSIGNED NOT NULL,

	CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID)  ON DELETE CASCADE,
	FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)  ON DELETE CASCADE
);
	DROP TABLE IF EXISTS Answer;
	CREATE TABLE Answer(
	AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content NVARCHAR(100) NOT NULL,
	QuestionID TINYINT UNSIGNED NOT NULL,
	isCorrect BIT DEFAULT 1,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);
	DROP TABLE IF EXISTS Exam;
	CREATE TABLE Exam(
	ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY
	KEY,
	`Code` CHAR(10) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	CategoryID TINYINT UNSIGNED NOT NULL,
	Duration TINYINT UNSIGNED NOT NULL,
	CreatorID TINYINT UNSIGNED NOT NULL,
	CreateDate DATETIME DEFAULT NOW(),
    
	FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
	FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId) ON DELETE CASCADE
);
	DROP TABLE IF EXISTS ExamQuestion;
	CREATE TABLE ExamQuestion(
	ExamID TINYINT UNSIGNED NOT NULL,
	QuestionID TINYINT UNSIGNED NOT NULL,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE,

	FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE ,
	PRIMARY KEY (ExamID,QuestionID)
);
	INSERT INTO Department(DepartmentName)
	VALUES

('Marketing' ),
('Sale' ),
('Bảo vệ' ),
('Nhân sự' ),
('Kỹ thuật' ),
('Tài chính' ),
('Phó giám đốc'),
('Giám đốc' ),
('Thư kí' ),
('No person' ),
('Bán hàng' );

INSERT INTO Position (PositionName )
VALUES ('Dev' ),
('Test' ),
('Scrum Master'),
('PM' );

INSERT INTO `Account`(Email , Username, FullName , DepartmentID , PositionID,CreateDate)
VALUES 
('Email13@gmail.com' , 'Username13','Dino' , '10' , '1' , DEFAULT),
('Email1@gmail.com' ,'Username1' ,'Fullname1' , '5' , '1','2020-03-05'),

('Email2@gmail.com' ,'Username2' ,'Fullname2' , '1' , '2','2020-03-05'),

('Email3@gmail.com' , 'Username3' ,'Fullname3', '2' , '2' ,'2020-03-07'),

('Email4@gmail.com' , 'Username4' ,'Fullname4', '3' , '4' ,'2020-03-08'),

('Email5@gmail.com' , 'Username5' ,'Fullname5', '4' , '4' ,'2020-03-10'),

('Email6@gmail.com' , 'Username6' ,'Fullname6', '6' , '3' ,'2020-04-05'),

('Email7@gmail.com' , 'Username7' ,'Fullname7', '2' , '2' , NULL ),
('Email8@gmail.com' , 'Username8' ,'Fullname8', '8' , '1' ,'2020-04-07'),

('Email9@gmail.com' , 'Username9' ,'Fullname9', '2' , '2' ,'2020-04-07'),
('Email10@gmail.com' , 'Username10' ,'Fullname10', '10' , '1' ,'2020-04-09'),

('Email11@gmail.com' , 'Username11' ,'Fullname11', '10' , '1' , DEFAULT),

('Email12@gmail.com' , 'Username12','Fullname12' , '10' , '1' , DEFAULT);

SELECT * FROM `account`;
INSERT INTO `Group` ( GroupName , CreatorID , CreateDate)
VALUES 
('Testing System' , 5,'2019-03-05'),

('Development' , 1,'2020-03-07'),
(N'VTI Sale 01' , 2 ,'2020-03-09'),
(N'VTI Sale 02' , 3 ,'2020-03-10'),
(N'VTI Sale 03' , 4 ,'2020-03-28'),
(N'VTI Creator' , 6 ,'2020-04-06'),
(N'VTI Marketing 01' , 7 ,'2020-04-07'),
(N'Management' , 8 ,'2020-04-08'),
(N'Chat with love' , 9 ,'2020-04-09'),
(N'Vi Ti Ai' , 10 ,'2020-04-10');
INSERT INTO `GroupAccount` ( GroupID , AccountID , JoinDate ) VALUES 
( 1 , 1,'2019-03-05'),

( 1 , 2,'2020-03-07'),

( 3 , 3,'2020-03-09'),

( 3 , 4,'2020-03-10'),

( 5 , 5,'2020-03-28'),

( 1 , 3,'2020-04-06'),

( 1 , 7,'2020-04-07'),

( 8 , 3,'2020-04-08'),

( 1 , 9,'2020-04-09'),

( 10 , 10,'2020-04-10');

INSERT INTO TypeQuestion (TypeName )
VALUES 
('Essay' ),('Multiple-Choice' );

INSERT INTO CategoryQuestion (CategoryName )
VALUES 
('Java' ),
('ASP.NET' ),
('ADO.NET' ),
('SQL' ),
('Postman' ),
('Ruby' ),
('Python' ),
('C++' ),
('C Sharp' ),
('PHP' );

INSERT INTO Question (Content , CategoryID, TypeID , CreatorID, CreateDate )VALUES 
('Câu hỏi về Java' , 1 ,'1' , '2' ,'2020-04-05'),

('Câu Hỏi về PHP' , 10 ,'2' , '2' ,'2020-04-05'),

('Hỏi về C#' , 9 ,'2' , '3' ,'2020-04-06'),

('Hỏi về Ruby' , 6 ,'1' , '4' ,'2020-04-06'),

('Hỏi về Postman' , 5 ,'1' , '5' ,'2020-04-06'),

('Hỏi về ADO.NET' , 3 ,'2' , '6' ,'2020-04-06'),

('Hỏi về ASP.NET' , 2 ,'1' , '7' ,'2020-04-06'),

('Hỏi về C++' , 8 ,'1' , '8' ,'2020-04-07'),

('Hỏi về SQL' , 4 ,'2' , '9' ,'2020-04-07'),

('Hỏi về Python' , 7 ,'1' , '10' ,'2020-04-07');
INSERT INTO Answer ( Content , QuestionID , isCorrect )
VALUES 
('Trả lời 01' , 1 , 0),

('Trả lời 02' , 1 , 1),
('Trả lời 03', 1 , 0 ),
('Trả lời 04', 1 , 1 ),
('Trả lời 05', 2 , 1 ),
('Trả lời 06', 3 , 1 ),
('Trả lời 07', 4 , 0 ),
('Trả lời 08', 8 , 0 ),
('Trả lời 09', 9 , 1 ),
('Trả lời 10', 10 , 1 );

INSERT INTO Exam (`Code` , Title , CategoryID, Duration , CreatorID , CreateDate )
VALUES 
('VTIQ001' , 'Đề thi C#' ,1 , 60 , '5' ,'2019-04-05'),
('VTIQ002' , 'Đề thi PHP' ,10 , 60 , '2' ,'2019-04-05'),
('VTIQ003' , 'Đề thi C++' , 9 ,120 , '2' ,'2019-04-07'),
('VTIQ004' , 'Đề thi Java' , 6 , 60, '3' ,'2020-04-08'),

('VTIQ005' , 'Đề thi Ruby' , 5 , 120, '4' ,'2020-04-10'),

('VTIQ006' , 'Đề thi Postman' , 3 ,60 , '6' ,'2020-04-05'),
('VTIQ007' , 'Đề thi SQL' , 2 ,60 , '7' ,'2020-04-05'),
('VTIQ008' , 'Đề thi Python' , 8 ,60 , '8' ,'2020-04-07'),
('VTIQ009' , 'Đề thi ADO.NET' , 4 ,90 , '9' ,'2020-04-07'),
('VTIQ010' , 'Đề thi ASP.NET' , 7 ,90 , '10' ,'2020-04-08');

INSERT INTO ExamQuestion(ExamID , QuestionID ) VALUES 
( 1 , 5 ),
( 2 , 10 ),
( 3 , 4 ),
( 4 , 3 ),
( 5 , 7 ),
( 6 , 10 ),
( 7 , 2 ),
( 8 , 10 ),
( 9 , 9 ),
( 10 , 8 );


-- Assigment 6 : 

-- 1 : Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_lay_tai_khoan_phong_ban;
CREATE PROCEDURE sp_lay_tai_khoan_phong_ban(IN p_in_departmentName NVARCHAR(30))
BEGIN
    SELECT a.*
    FROM `account` a
    INNER JOIN Department d ON a.DepartmentID = d.DepartmentID
    WHERE d.DepartmentName = p_in_departmentName;
END $$
DELIMITER ;

CALL sp_lay_tai_khoan_phong_ban('Sale');

-- 2 Tạo store để in ra số lượng account trong mỗi group

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_so_acc_moi_group;
CREATE PROCEDURE sp_so_acc_moi_group()
BEGIN
    SELECT g.GroupName, COUNT(a.AccountID) AS AccountCount
    FROM `account` a
    INNER JOIN GroupAccount ag ON a.AccountID = ag.AccountID
    INNER JOIN `Group` g ON ag.GroupID = g.GroupID
    GROUP BY g.GroupName;
END $$
DELIMITER ;

CALL sp_so_acc_moi_group();

-- 4 Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_id_co_so_typequestion_nhieu_nhat;
CREATE PROCEDURE sp_id_co_so_typequestion_nhieu_nhat()
BEGIN
    SELECT q.TypeID
    FROM Question q
    WHERE q.TypeID = (
        SELECT TypeID FROM Question
        GROUP BY TypeID
        ORDER BY COUNT(*) DESC
       
    );
END $$
DELIMITER ;


CALL sp_id_co_so_typequestion_nhieu_nhat();

-- 5 tim loai cau hoi dua tren id cua cau hoi
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_tim_loai_cau_hoi_theo_id;
CREATE PROCEDURE sp_tim_loai_cau_hoi_theo_id(IN p_in_TypeID TINYINT , OUT p_out_TypeName VARCHAR(30))
BEGIN
    SELECT TypeName INTO p_out_TypeName FROM typequestion
    WHERE TypeID = p_in_TypeID

    ;
END $$
DELIMITER ;

SET @TypeName = 'Loai cau hoi' ;
CALL sp_tim_loai_cau_hoi_theo_id(2, @TypeName);
SELECT @TypeName;

-- 6 


-- 8 Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS sp_lay_cau_hoi_co_content_dai_nhat;
DELIMITER $$
CREATE PROCEDURE sp_lay_cau_hoi_co_content_dai_nhat(IN p_questionType VARCHAR(20))
BEGIN
    DECLARE v_max_length INT;
    
    -- Tìm độ dài lớn nhất của câu hỏi
    SELECT MAX(LENGTH(Content)) INTO v_max_length
    FROM Question
    WHERE TypeID = (
        SELECT TypeID FROM TypeQuestion WHERE TypeName = p_questionType
    );
    
    -- Lấy các câu hỏi có độ dài bằng với độ dài lớn nhất
    SELECT QuestionID, Content
    FROM Question
    WHERE LENGTH(Content) = v_max_length
        AND TypeID = (
            SELECT TypeID FROM TypeQuestion WHERE TypeName = p_questionType
        );
END$$
DELIMITER ;

CALL sp_lay_cau_hoi_co_content_dai_nhat('Essay');
CALL sp_lay_cau_hoi_co_content_dai_nhat('Multiple-Choice');




-- 9 Viết 1 store cho phép người dùng xóa exam dựa vào ID
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_xoa_exam_theo_id;
CREATE PROCEDURE sp_xoa_exam_theo_id(IN p_in_ExamID TINYINT)
BEGIN
    DELETE FROM exam
    WHERE examID = p_in_ExamID;
END$$
DELIMITER ;

    
CALL sp_xoa_exam_theo_id(2);
SELECT * FROM exam;

-- 10
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_xoa_exam_theo_id;
CREATE PROCEDURE sp_xoa_exam_theo_id(IN p_in_ExamID TINYINT)
BEGIN
    DECLARE affectedRows INT;
    
  
    DELETE FROM exam
    WHERE examID = p_in_ExamID;
    
    -- Lấy số lượng bản ghi bị ảnh hưởng từ bảng liên quan
    SET affectedRows = ROW_COUNT();
    
    -- In số lượng bản ghi đã bị xóa
    SELECT affectedRows AS 'Số lượng bản ghi đã xóa';
END$$
DELIMITER ;

CALL sp_xoa_exam_theo_id(2);

-- 11 Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay








-- 











