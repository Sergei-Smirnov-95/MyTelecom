connect 'D:\7_sem\carservice.fdb' user 'SYSDBA' password 'masterkey';
commit

SET TERM ^ ;


CREATE generator increment^
CREATE OR ALTER TRIGGER auto_gen FOR Parts BEFORE INSERT
AS
BEGIN
 new.PartID = gen_id(increment,1);
END^


CREATE EXCEPTION ERROR_STAGE 'ERROR_1: CANNOT DELETE STAGE TYPE'^
CREATE OR ALTER TRIGGER CHECK_TRIGGER FOR ID_Works BEFORE DELETE OR UPDATE
AS
BEGIN
 IF (OLD.WorkID IN (SELECT WorkID FROM Works)) THEN
 EXCEPTION ERROR_STAGE;
END^



SET TERM ; ^