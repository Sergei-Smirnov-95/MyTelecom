connect 'D:\7_sem\carservice.fdb' user 'SYSDBA' password 'masterkey';
commit

--drop procedure Search_Sim;
--drop procedure Search_idd;
SET TERM ^ ;

CREATE OR ALTER PROCEDURE Search_idd( ClietI_d INT)
returns (idd int)
AS 
BEGIN
for
	select Id_works.WorkId from Id_works where Id_works.WID in(
	select Ser_Info.WPID from Ser_Info where ser_info.sid in( 
	select car.carId from car,client where client.clientId=:ClietI_d))--;
	into :idd
do begin
	suspend;
end

END
^
CREATE OR ALTER PROCEDURE Search_Sim(ClientI_d INT)
returns(Work_Id int,SUMM int)
AS
BEGIN

for
	select idd,counter from (select idd,count(idd) as counter  from  Search_idd(:ClientI_d) group by idd ) where counter>1 into :Work_Id,:SUMM
do begin
suspend;
end
END
^
SET TERM ; ^

--commit

