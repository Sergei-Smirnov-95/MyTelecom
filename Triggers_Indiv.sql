connect 'D:\7_sem\carservice.fdb' user 'SYSDBA' password 'masterkey';
commit;

SET TERM ^ ;


CREATE OR ALTER TRIGGER RECOMEND_TRIGGER FOR ID_Part AFTER INSERT
AS
BEGIN
	execute procedure Search_Rec(new.PID);
END
^


CREATE OR ALTER PROCEDURE Update_Price( WPID INT)
--returns (nums int)
AS 
DECLARE VARIABLE nums int;
DECLARE VARIABLE sum1 int;
DECLARE VARIABLE sum2 int;
BEGIN

	select sum(Works.Price*Id_Works.numWorks ) 
	from Id_Works natural join Works
	where Id_Works.ID in(
		select Id from Id_works where Id_works.WID= :WPID) 
	into :sum1;
	
	select sum(Parts.Price*Id_PArt.NumParts )
	from ID_Part natural join Parts
	where ID_Part.ID in (
		select Id from Id_part where Id_part.PID= :WPID)
	into :sum2;
	nums= :sum1 + :sum2;
	update Ser_Info set Ser_Info.Price=:nums where  Ser_Info.WPID= :WPID;

END
^
/*SELECT WID as w_pid,sum(Works.Price*Id_Works.NumWorks) as Works_Coast from
	Id_Works,works 
	where Id_Works.ID in(
	SELECT Id_works.Id from Id_Works,Ser_Info where Id_Works.WID=WPID )
	and 
	works.workId=id_works.workid
	group by WID*/

CREATE OR ALTER TRIGGER Update_TRIGGER1 FOR ID_Works AFTER INSERT or UPDATE or DELETE
AS
begin
	if(DELETING) then
	begin 
		execute procedure Update_Price(old.WID);
	end
	if(UPDATING or INSERTING)then
	begin
		execute procedure Update_Price(new.WID);
	end

end ^


CREATE OR ALTER TRIGGER Update_TRIGGER2 FOR ID_Part AFTER INSERT or UPDATE or DELETE
AS
begin
	if(DELETING) then
	begin 
		execute procedure Update_Price(old.PID);
	end
	if(UPDATING or INSERTING)then
	begin
		execute procedure Update_Price(new.PID);
	end

end ^

SET TERM ; ^