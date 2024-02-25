create table alltogether(a number, b number);
INSERT INTO alltogether(a,b)
SELECT 
TRUNC(dbms_random.value(1,999999)),
TRUNC(dbms_random.value(1,2000))
FROM DUAL
CONNECT BY  LEVEL<20000;

DECLARE
	TYPE alltogether_type IS TABLE OF alltogether%ROWTYPE;
	CURSOR all_cr IS SELECT a,b FROM alltogether;
	all_ty alltogether_type ;
BEGIN
	OPEN all_cr;
	LOOP
	FETCH all_cr 
	BULK COLLECT INTO all_ty
	LIMIT 200;

	FORALL i IN 1..all_ty.COUNT
	INSERT INTO s(x,y)
	VALUES(all_ty(i).a,all_ty(i).b);
	EXIT WHEN all_cr%NOTFOUND;

 	END LOOP;                                                   
	CLOSE all_cr;
END;  
/
---------
create sequence id_seq;
DECLARE
	TYPE alltogether_type IS TABLE OF alltogether%ROWTYPE;
	CURSOR all_cr IS SELECT x,y FROM s;
	all_ty alltogether_type ;
BEGIN
	OPEN all_cr;
	LOOP
	FETCH all_cr 
	BULK COLLECT INTO all_ty
	LIMIT 200;   

	FORALL i IN 1..all_ty.COUNT
	INSERT INTO ss(x,y,id)
	VALUES(all_ty(i).a,all_ty(i).b,id_seq.nextval);
	dbms_output.put_line(id_seq.currval);
	EXIT WHEN all_cr%NOTFOUND;

	END LOOP;                                                   
	CLOSE all_cr;
END;  
/
                             
-------------

DECLARE
	CURSOR cur_ss IS 
	SELECT x FROM ss;
BEGIN
	--FORALL i IN 1..cur_ss.COUNT
	FOR rec_ss IN cur_ss LOOP	
	UPDATE ss SET id = id_seq.nextval;
	END LOOP;

END;

create table collection_test(a number,entrydate date);


DECLARE
	TYPE alltogether_type IS TABLE OF collection_test%ROWTYPE;
	CURSOR all_cr IS SELECT a,sysdate entrydate FROM col_test;
	all_ty alltogether_type ;
BEGIN
	OPEN all_cr;
	LOOP
	FETCH all_cr 
	BULK COLLECT INTO all_ty
	LIMIT 200;

	FORALL i IN 1..all_ty.COUNT
	INSERT INTO collection_test(a,entrydate)
	VALUES(all_ty(i).a,all_ty(i).entrydate);
	EXIT WHEN all_cr%NOTFOUND;

	END LOOP;                                                   
	CLOSE all_cr;
END;  
/
----------------------

Declare
	TYPE t_x_number IS TABLE OF integer;
	x_type t_x_number;
	y_type t_x_number;
	sl_type t_x_number;
Begin
	SELECT x,y FROM BULK COLLECT INTO x_type,y_type,sl_type ss

End;