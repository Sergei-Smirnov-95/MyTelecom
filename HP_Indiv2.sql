connect 'D:\7_sem\carservice.fdb' user 'SYSDBA' password 'masterkey';
--connect 'D:\Univer\serbase\carservice.fdb' user 'SYSDBA' password 'masterkey';
--commit;
--drop table recommended_works;
--create table recommended_works (work_id int, summ int);
commit;

SET TERM ^ ;

CREATE OR ALTER PROCEDURE Recom_help( WPID INT)
returns (Recomend_Work int)
AS 
BEGIN
for
	select WorkID from ID_Works where WID in(
	select PID from ID_Part where PartID in (
	select PartID from ID_Part where PID= :WPID))
	
	into :Recomend_Work
do begin
	suspend;
end
END
^

CREATE OR ALTER PROCEDURE Search_Rec(PI_d INT)
--returns(Work_Id int,SUMM int)
AS
DECLARE VARIABLE Work_Id int;
DECLARE VARIABLE SUMM int;
--AS
BEGIN
delete from recommended_works;
for
	select first 5 Recomend_Work,counter 
	from 
	(
		select Recomend_Work,count(Recomend_Work) as counter  
		from  Recom_help(:PI_d) 
		group by Recomend_Work 
	)  
		into :Work_Id,:SUMM
do begin
	insert into recommended_works values (:Work_Id,:SUMM);
	--suspend;
end
END
^


SET TERM ; ^