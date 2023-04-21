-- CREATE DATABASE StudentTest;
-- USE StudentTest;
-- CREATE TABLE Student
-- (
-- 	RN INT PRIMARY KEY AUTO_INCREMENT,
--     `Name` VARCHAR(20) NOT NULL,
--     Age TINYINT
-- );

-- CREATE TABLE Test
-- (
-- 	TestID INT PRIMARY KEY AUTO_INCREMENT,
--     `Name` VARCHAR(20) NOT NULL
-- );

-- CREATE TABLE StudentTest
-- (
-- 	RN INT,
--     FOREIGN KEY (RN) REFERENCES Student(RN),
--     TestID INT,
--     FOREIGN KEY (TestID) REFERENCES Test(TestID),
--     `Date` DATETIME,
--     Mark FLOAT
-- );

-- INSERT INTO Student(`Name`, Age) VALUES
-- ("Nguyen Hong Ha", 20),
-- ("Truong Ngoc Anh", 30),
-- ("Tuan Minh", 25),
-- ("Dan Truong", 22);

-- INSERT INTO Test(`Name`) VALUES
-- ("EPC"),
-- ("DWMX"),
-- ("SQL1"),
-- ("SQL2");

-- INSERT INTO StudentTest VALUES
-- (1, 1, "2006-07-17", 8),
-- (1, 2, "2006-07-18", 5),
-- (1, 3, "2006-07-19", 7),
-- (2, 1, "2006-07-17", 7),
-- (2, 2, "2006-07-18", 4),
-- (2, 3, "2006-07-19", 2),
-- (3, 1, "2006-07-17", 10),
-- (3, 3, "2006-07-18", 1);

-- a.	Thêm ràng buộc dữ liệu cho cột age với giá trị thuộc khoảng: 15-55
-- alter table student
-- modify age int check (age>=15 and age<=55);

-- b.	Thêm giá trị mặc định cho cột mark trong bảng StudentTest là 0
-- alter table studenttest 
-- modify mark float default 0;

-- c.	Thêm khóa ngoại cho bảng studenttest là (RN,TestID) - thêm rồi

-- d.	Thêm ràng buộc duy nhất (unique) cho cột name trên bảng Test
-- alter table test
-- modify name varchar(255) unicode not null;

-- e.	Xóa ràng buộc duy nhất (unique) trên bảng Test
-- alter table test
-- modify name varchar(255) not null;

-- 3.	Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó, điểm thi và ngày thi 
-- select st.name as `tên học sinh`,  t.name as `môn thi`, stt.mark as `điểm`, stt.date as `ngày thi` from student st join studenttest stt on st.rn = stt.rn join test t on stt.testId = t.testId ;

-- 4.	Hiển thị danh sách các bạn học viên chưa thi môn nào 
-- select  (select @stt:=@stt+1) as `stt`, st.* from (select @stt:= 0) r, student st where st.rn not in (select st.rn from student st join studenttest stt on st.rn = stt.rn) ;

-- 5.	Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5) 
--  select (select @stt:=@stt + 1) as `stt`, st.*, t.name, stt.mark,  stt.date as `ngày thi` from (select @stt:=0) r, student st join studenttest stt on st.rn = stt.rn join test t on stt.testId = t.testId where stt.mark < 5

-- 6.	Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần
-- select rank() over(order by avg(mark) desc)as `stt`, st.name as `tên học sinh`, avg(mark) as `điểm trung bình` from  student st join studenttest stt on st.rn = stt.rn group by st.name;

-- 7.	Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất 
-- select (select @stt:=@stt + 1) as `stt`, st.name as `tên học sinh`, avg(mark) as `điểm trung bình` from (select @stt:= 0) r, student st join studenttest stt on st.rn = stt.rn group by st.name order by avg(mark) desc limit 1 ;

-- 8.	Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học 
-- select rank() over(order by max(mark) asc) as `stt`, t.`name`, max(mark) from test t join studenttest stt on t.testId = stt.testid group by t.name  ;

-- 9.	Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null 
-- select st.name as `tên học sinh`,  t.name as `môn thi`, stt.mark as `điểm`, stt.date as `ngày thi` from student st left join studenttest stt on st.rn = stt.rn left join test t on stt.testId = t.testId ;

-- 10.	Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi
-- update student 
-- set age = age+1;

-- 11.	Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.
-- alter table student
-- add column status varchar(10);

-- 12.	Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student
-- update student
-- set status = case 
-- when age < 30 then "young"
-- else "old"
-- end

-- 13.	Hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi 
-- select (select @stt:=@stt + 1) as `stt`, st.name as `tên học sinh`,  t.name as `môn thi`, stt.mark as `điểm`, stt.date as `ngày thi` from (select @stt:= 0) r, student st join studenttest stt on st.rn = stt.rn join test t on stt.testId = t.testId order by stt.date ;

-- 14. Hiển thị các thông tin sinh viên có tên bắt đầu bằng ký tự ‘T’ và điểm thi trung bình >4.5. Thông tin bao gồm Tên sinh viên, tuổi, điểm trung bình
-- select st.name, st.age, avg(mark) from student st join studenttest stt on st.rn = stt.rn group by st.rn having st.name like "T%"  and avg(mark) >4.5;

-- 15.	Hiển thị các thông tin sinh viên (Mã, tên, tuổi, điểm trung bình, xếp hạng). Trong đó, xếp hạng dựa vào điểm trung bình của học viên, điểm trung bình cao nhất thì xếp hạng 1
-- select  st.name as `tên học sinh`, avg(mark) as `điểm trung bình`, rank() over(order by avg(mark) desc)as `xếp hạng`from  student st join studenttest stt on st.rn = stt.rn group by st.name;

-- 16.	Sủa đổi kiểu dữ liệu cột name trong bảng student thành nvarchar(max)
-- alter table student
-- modify name varchar(255)

-- 17.	Cập nhật (sử dụng phương thức write) cột name trong bảng student với yêu cầu sau:
-- a.	Nếu tuổi >30 -> thêm ‘Old’ vào trước tên (cột name)
-- b.	Nếu tuổi <=30 thì thêm ‘Young’ vào trước tên (cột name)
-- update student
-- set name = case
-- when age > 30 then concat("old", `name`)
-- else concat("young", `name`)
-- end;

-- 18.Xóa tất cả các môn học chưa có bất kỳ sinh viên nào thi
-- delete from test
-- where testId not in (select testid from studenttest);

-- 19.	Xóa thông tin điểm thi của sinh viên có điểm <5. 
-- delete from studenttest
-- where mark < 5



