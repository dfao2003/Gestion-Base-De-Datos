-------------------------Creacion de usuario con privilegios de transacciones-------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
alter session set "_ORACLE_SCRIPT"=true;
CREATE USER usr_compras
IDENTIFIED by clave;
GRANT SELECT ANY TABLE TO usr_compras;
GRANT UPDATE ANY TABLE TO usr_compras;
GRANT INSERT ANY TABLE TO usr_compras;



-------------------------------------------Creacion de tablas-----------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
CREATE TABLE PROVEEDORES(
 PROVEEDORID int NOT NULL,
 NOMBREPROV char(50) NOT NULL,
 CONTACTO char(50) NOT NULL,
 CELUPROV char(12) NULL,
 FIJOPROV char(12) NULL,
 CONSTRAINT PK_PROVEEDORES PRIMARY KEY (PROVEEDORID ) );

 CREATE TABLE EMPLEADOS(
 EMPLEADOID int NOT NULL,
 NOMBRE char(30) NULL,
 APELLIDO char(30) NULL,
 FECHA_NAC date NULL,
 REPORTA_A int NULL,
 EXTENSION int NULL,
 CONSTRAINT PK_EMPLEADOS PRIMARY KEY (EMPLEADOID),
CONSTRAINT FK_EMPLEADO_REPORTA FOREIGN KEY (REPORTA_A) REFERENCES EMPLEADOS(EMPLEADOID));

CREATE TABLE CATEGORIAS(
 CATEGORIAID int NOT NULL,
 NOMBRECAT char(50) NOT NULL,
 CONSTRAINT PK_CATEGORIAS PRIMARY KEY
(CATEGORIAID));

CREATE TABLE CLIENTES(
 CLIENTEID int NOT NULL,
 CEDULA_RUC char(10) NOT NULL,
 NOMBRECIA char(30) NOT NULL,
 NOMBRECONTACTO char(50) NOT NULL,
 DIRECCIONCLI char(50) NOT NULL,
 FAX char(12) NULL,
 EMAIL char(50) NULL,
 CELULAR char(12) NULL,
 FIJO char(12) NULL,
 CONSTRAINT PK_CLIENTES PRIMARY KEY(CLIENTEID) );
 
CREATE TABLE ORDENES(
 ORDENID int NOT NULL,
 EMPLEADOID int NOT NULL,
 CLIENTEID int NOT NULL,
 FECHAORDEN date NOT NULL,
 DESCUENTO int NULL,
 CONSTRAINT PK_ORDENES PRIMARY KEY(ORDENID),
CONSTRAINT FK_ORDENES_CLIEN_ORD_CLIENTES FOREIGN KEY (CLIENTEID) REFERENCES CLIENTES(CLIENTEID),
CONSTRAINT FK_ORDENES_EMPLE_ORD_EMPLEADO FOREIGN KEY (EMPLEADOID) REFERENCES EMPLEADOS(EMPLEADOID)
);

CREATE TABLE PRODUCTOS(
 PRODUCTOID int NOT NULL,
 PROVEEDORID int NOT NULL,
 CATEGORIAID int NOT NULL,
 DESCRIPCION char(50) NULL,
 PRECIOUNIT number NOT NULL,
 EXISTENCIA int NOT NULL,
 CONSTRAINT PK_PRODUCTOS PRIMARY KEY(PRODUCTOID),
CONSTRAINT FK_PRODUCTO_CATE_PROD_CATEGORI FOREIGN KEY (CATEGORIAID) REFERENCES CATEGORIAS(CATEGORIAID),
CONSTRAINT FK_PRODUCTO_PROV_PROD_PROVEEDO FOREIGN KEY (PROVEEDORID) REFERENCES PROVEEDORES(PROVEEDORID)
);

CREATE TABLE DETALLE_ORDENES(
 ORDENID int NOT NULL,
 DETALLEID int NOT NULL,
 PRODUCTOID int NOT NULL,
 CANTIDAD int NOT NULL,
 CONSTRAINT PK_DETALLE_ORDENES PRIMARY KEY (ORDENID,DETALLEID ),
CONSTRAINT FK_DETALLE__ORDEN_DET_ORDENES FOREIGN KEY (ORDENID) REFERENCES ORDENES(ORDENID),
CONSTRAINT FK_DETALLE__PROD_DETA_PRODUCTO FOREIGN KEY (PRODUCTOID) REFERENCES PRODUCTOS(PRODUCTOID)
 );
 
----------------TABLAS NUEVAS--------------------
-------------------------------------------------
-------------------------------------------------
 CREATE TABLE COMPRAS (
  COMPRAID int NOT NULL,
  PROVEEDORID int NOT NULL,
  FECHA_COMPRA date NOT NULL,
  CONSTRAINT PK_COMPRAS PRIMARY KEY (COMPRAID),
  CONSTRAINT FK_COMPRAS_PROVEEDOR FOREIGN KEY (PROVEEDORID) REFERENCES PROVEEDORES(PROVEEDORID)
);

CREATE TABLE DETALLE_COMPRAS (
  COMPRAID int NOT NULL,
  DETALLEID int NOT NULL,
  PRODUCTOID int NOT NULL,
  CANTIDAD int NOT NULL,
  PRECIO_UNITARIO number NOT NULL,
  CONSTRAINT PK_DETALLE_COMPRAS PRIMARY KEY (COMPRAID, DETALLEID),
  CONSTRAINT FK_DETALLE_COMPRAS_COMPRA FOREIGN KEY (COMPRAID) REFERENCES COMPRAS(COMPRAID),
  CONSTRAINT FK_DETALLE_COMPRAS_PRODUCTO FOREIGN KEY (PRODUCTOID) REFERENCES PRODUCTOS(PRODUCTOID)
);

--------------------------------------Insercion de tuplas--------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
insert into categorias (categoriaid, nombrecat) values (100, 'CARNICOS');
insert into categorias (categoriaid, nombrecat) values (200, 'LACTEOS');
insert into categorias (categoriaid, nombrecat) values (300, 'LIMPIEZA');
insert into categorias (categoriaid, nombrecat) values (400, 'HIGINE PERSONAL');
insert into categorias (categoriaid, nombrecat) values (500, 'MEDICINAS');
insert into categorias (categoriaid, nombrecat) values (600, 'COSMETICOS');
insert into categorias (categoriaid, nombrecat) values (700, 'REVISTAS');

insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(10, 'DON DIEGO', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(20, 'PRONACA', 'JUAN PEREZ', '0923434467','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(30, 'TONY', 'JORGE BRITO', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(40, 'MIRAFLORES', 'MARIA PAZ', '098124498','2458799');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(50, 'ALMAY', 'PEDRO GONZALEZ', '097654567','2507190');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(60, 'REVLON', 'MONICA SALAS', '099245678','2609876');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(70, 'YANBAL', 'BETY ARIAS', '098124458','2450887');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(120, 'JURIS', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(80, 'CLEANER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(90, 'BAYER', 'MANUEL ANDRADE', '099234567','2124456');
insert into proveedores (proveedorid, nombreprov, contacto,celuprov,fijoprov) values
(110, 'PALMOLIVE', 'MANUEL ANDRADE', '099234567','2124456');


INSERT INTO PRODUCTOS VALUES (1,10,100,'SALCHICHAS VIENESAS',2.60,200);
INSERT INTO PRODUCTOS VALUES (2,10,100,'SALAMI DE AJO',3.60,300);
INSERT INTO PRODUCTOS VALUES (3,10,100,'BOTON PARA ASADO',4.70,400);
INSERT INTO PRODUCTOS VALUES (4,20,100,'SALCHICHAS DE POLLO',2.90,200);
INSERT INTO PRODUCTOS VALUES (5,20,100,'JAMON DE POLLO',2.80,100);
INSERT INTO PRODUCTOS VALUES (6,30,200,'YOGURT NATURAL',4.30,80);
INSERT INTO PRODUCTOS VALUES (7,30,200,'LECHE CHOCOLATE',1.60,90);
INSERT INTO PRODUCTOS VALUES (8,40,200,'YOGURT DE SABORES',1.60,200);
INSERT INTO PRODUCTOS VALUES (9,40,200,'CREMA DE LECHE',3.60,30);
INSERT INTO PRODUCTOS VALUES (10,50,600,'BASE DE MAQUILLAJE',14.70,40);
INSERT INTO PRODUCTOS VALUES (11,50,600,'RIMMEL',12.90,20);
INSERT INTO PRODUCTOS VALUES (12,60,600,'SOMBRA DE OJOS',9.80,100);

INSERT INTO EMPLEADOS VALUES (1,'JUAN', 'CRUZ', TO_DATE('18-01-1967', 'dd-mm-yyyy'),null, 231);
INSERT INTO EMPLEADOS VALUES (2,'MARIO', 'SANCHEZ', TO_DATE('01-mar-79', 'DD-MON-YY'),1,144);
INSERT INTO EMPLEADOS VALUES (3,'VERONICA', 'ARIAS', TO_DATE('23-jun-77', 'DD-MON-YY'),1, 234);
INSERT INTO EMPLEADOS VALUES (4,'PABLO', 'CELY', TO_DATE('28-ene-77', 'DD-MON-YY'),2, 567);
INSERT INTO EMPLEADOS VALUES (5,'DIEGO', 'ANDRADE', TO_DATE('15-may-70', 'DD-MON-YY'),2, 890);
INSERT INTO EMPLEADOS VALUES (6,'JUAN', 'ANDRADE', TO_DATE('17-nov-76', 'DD-MON-YY'),3, 230);
INSERT INTO EMPLEADOS VALUES (7,'MARIA', 'NOBOA', TO_DATE('21-dic-79', 'DD-MON-YY'),3, 261);


INSERT INTO CLIENTES VALUES (1,'1890786576','SUPERMERCADO ESTRELLA','JUAN ALBAN','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (2,'1298765477','EL ROSADO','MARIA CORDERO','AV.AEL INCA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (3,'1009876567','DISTRIBUIDORA PRENSA','PEDRO PINTO','EL PINAR',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (4,'1876090006','SU TIENDA','PABLO PONCE','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (5,'1893456776','SUPERMERCADO DORADO','LORENA PAZ','AV.6 DICIEMBRE',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (6,'1678999891','MI COMISARIATO','ROSARIO UTRERAS','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (7,'1244567888','SUPERMERCADO DESCUENTO','LETICIA ORTEGA','AV.LA PRENSA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (8,'1456799022','EL DESCUENTO','JUAN TORRES','AV.PATRIA',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (9,'1845677777','DE LUISE','JORGE PARRA','AV.AMAZONAS',NULL,NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES (10,'183445667','YARBANTRELLA','PABLO POLIT','AV.REPUBLICA',NULL,NULL,NULL,NULL);



INSERT INTO ORDENES VALUES(1,3,4,'17-jun-07', 5);
INSERT INTO ORDENES VALUES(2,3,4,'02-jun-07', 10);
INSERT INTO ORDENES VALUES(3,4,5,'05-jun-07', 6);
INSERT INTO ORDENES VALUES(4,2,6,'06-jun-07', 2);
INSERT INTO ORDENES VALUES(5,2,7,'09-jun-07', NULL);
INSERT INTO ORDENES VALUES(6,4,5,'12-jun-07', 10);
INSERT INTO ORDENES VALUES(7,2,5,'14-jun-07', 10);
INSERT INTO ORDENES VALUES(8,3,2,'13-jun-07', 10);
INSERT INTO ORDENES VALUES(9,3,2,'17-jun-07', 3);
INSERT INTO ORDENES VALUES(10,2,2,'18-jun-07', 2);
INSERT INTO ORDENES VALUES(11,2,2,'20-06-07', NULL);



insert into detalle_ordenes values(1,1,1,2);
insert into detalle_ordenes values(1,2,4,1);
insert into detalle_ordenes values(1,3,6,1);
insert into detalle_ordenes values(1,4,9,1);

insert into detalle_ordenes values(2,1,10,10);
insert into detalle_ordenes values(2,2,13,20);
insert into detalle_ordenes values(3,1,3,10);
insert into detalle_ordenes values(4,1,9,12);

insert into detalle_ordenes values(5,1,1,14);
insert into detalle_ordenes values(5,2,4,20);
insert into detalle_ordenes values(6,1,3,12);
insert into detalle_ordenes values(7,1,11,10);

insert into detalle_ordenes values(8,1,2,10);
insert into detalle_ordenes values(8,2,5,14);
insert into detalle_ordenes values(8,3,7,10);
insert into detalle_ordenes values(9,1,11,10);

insert into detalle_ordenes values(10,1,1,5);


------------------------------ORDENES--------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

INSERT INTO ORDENES VALUES(12,4,2,'01-01-20',10);
INSERT INTO ORDENES VALUES(13,1,8,'02-01-20',6);
INSERT INTO ORDENES VALUES(14,3,5,'03-01-20',7);
INSERT INTO ORDENES VALUES(15,5,7,'04-01-20',9);
INSERT INTO ORDENES VALUES(16,7,5,'05-01-20',6);
INSERT INTO ORDENES VALUES(17,5,4,'06-01-20',1);
INSERT INTO ORDENES VALUES(18,2,4,'07-01-20',4);
INSERT INTO ORDENES VALUES(19,5,1,'08-01-20',9);
INSERT INTO ORDENES VALUES(20,1,8,'09-01-20',9);
INSERT INTO ORDENES VALUES(21,2,2,'10-01-20',5);
INSERT INTO ORDENES VALUES(22,5,5,'11-01-20',2);

INSERT INTO DETALLE_ORDENES VALUES(12,1,1,2);
INSERT INTO DETALLE_ORDENES VALUES(12,2,2,1);
INSERT INTO DETALLE_ORDENES VALUES(12,3,3,2);
INSERT INTO DETALLE_ORDENES VALUES(12,4,4,1);
INSERT INTO DETALLE_ORDENES VALUES(12,5,5,3);
INSERT INTO DETALLE_ORDENES VALUES(13,1,6,1);
INSERT INTO DETALLE_ORDENES VALUES(13,2,7,3);
INSERT INTO DETALLE_ORDENES VALUES(13,3,1,1);
INSERT INTO DETALLE_ORDENES VALUES(13,4,2,2);
INSERT INTO DETALLE_ORDENES VALUES(13,5,3,3);
INSERT INTO DETALLE_ORDENES VALUES(14,1,4,2);
INSERT INTO DETALLE_ORDENES VALUES(14,2,5,1);
INSERT INTO DETALLE_ORDENES VALUES(14,3,6,1);
INSERT INTO DETALLE_ORDENES VALUES(14,4,7,2);
INSERT INTO DETALLE_ORDENES VALUES(14,5,1,3);
INSERT INTO DETALLE_ORDENES VALUES(15,1,2,2);
INSERT INTO DETALLE_ORDENES VALUES(15,2,3,2);
INSERT INTO DETALLE_ORDENES VALUES(15,3,4,3);
INSERT INTO DETALLE_ORDENES VALUES(15,4,5,3);
INSERT INTO DETALLE_ORDENES VALUES(15,5,6,2);
INSERT INTO DETALLE_ORDENES VALUES(16,1,7,2);
INSERT INTO DETALLE_ORDENES VALUES(16,2,1,1);
INSERT INTO DETALLE_ORDENES VALUES(16,3,2,2);
INSERT INTO DETALLE_ORDENES VALUES(16,4,3,2);
INSERT INTO DETALLE_ORDENES VALUES(16,5,4,2);
INSERT INTO DETALLE_ORDENES VALUES(17,1,5,2);
INSERT INTO DETALLE_ORDENES VALUES(17,2,6,3);
INSERT INTO DETALLE_ORDENES VALUES(17,3,7,1);
INSERT INTO DETALLE_ORDENES VALUES(17,4,1,3);
INSERT INTO DETALLE_ORDENES VALUES(17,5,2,1);
INSERT INTO DETALLE_ORDENES VALUES(18,1,3,1);
INSERT INTO DETALLE_ORDENES VALUES(18,2,4,2);
INSERT INTO DETALLE_ORDENES VALUES(18,3,5,2);
INSERT INTO DETALLE_ORDENES VALUES(18,4,6,1);
INSERT INTO DETALLE_ORDENES VALUES(18,5,7,3);
INSERT INTO DETALLE_ORDENES VALUES(19,1,1,2);
INSERT INTO DETALLE_ORDENES VALUES(19,2,2,1);
INSERT INTO DETALLE_ORDENES VALUES(19,3,3,2);
INSERT INTO DETALLE_ORDENES VALUES(19,4,4,1);
INSERT INTO DETALLE_ORDENES VALUES(19,5,5,2);
INSERT INTO DETALLE_ORDENES VALUES(20,1,6,1);
INSERT INTO DETALLE_ORDENES VALUES(20,2,7,2);
INSERT INTO DETALLE_ORDENES VALUES(20,3,1,2);
INSERT INTO DETALLE_ORDENES VALUES(20,4,2,1);
INSERT INTO DETALLE_ORDENES VALUES(20,5,3,1);
INSERT INTO DETALLE_ORDENES VALUES(21,1,4,3);
INSERT INTO DETALLE_ORDENES VALUES(21,2,5,2);
INSERT INTO DETALLE_ORDENES VALUES(21,3,6,3);
INSERT INTO DETALLE_ORDENES VALUES(21,4,7,1);
INSERT INTO DETALLE_ORDENES VALUES(21,5,1,3);
INSERT INTO DETALLE_ORDENES VALUES(22,1,2,2);
INSERT INTO DETALLE_ORDENES VALUES(22,2,3,3);
INSERT INTO DETALLE_ORDENES VALUES(22,3,4,3);
INSERT INTO DETALLE_ORDENES VALUES(22,4,5,2);
INSERT INTO DETALLE_ORDENES VALUES(22,5,6,3);




----------------------------------------DATOS DE COMPRAS-------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--4. CON EL USUARIO LLAMADO USR_COMPRAS, INGRESAR DATOS DE COMPRAS(AL MENOS 10)
-- Insertar datos en la tabla COMPRAS en consultas separadas
INSERT INTO COMPRAS VALUES (1, 10, TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (2, 20, TO_DATE('2023-11-02', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (3, 30, TO_DATE('2023-11-03', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (4, 40, TO_DATE('2023-11-04', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (5, 50, TO_DATE('2023-11-05', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (6, 60, TO_DATE('2023-11-06', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (7, 70, TO_DATE('2023-11-07', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (8, 120, TO_DATE('2023-11-08', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (9, 80, TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO COMPRAS VALUES (10, 90, TO_DATE('2023-11-10', 'YYYY-MM-DD'));



-- Insertar datos en la tabla DETALLE_COMPRAS en consultas separadas
INSERT INTO DETALLE_COMPRAS VALUES (1, 1, 1, 50, 2.10);
INSERT INTO DETALLE_COMPRAS VALUES (1, 2, 2, 30, 3.10);
INSERT INTO DETALLE_COMPRAS VALUES (2, 3, 3, 40, 4.20);
INSERT INTO DETALLE_COMPRAS VALUES (2, 4, 4, 60, 2.40);
INSERT INTO DETALLE_COMPRAS VALUES (3, 5, 5, 20, 2.30);
INSERT INTO DETALLE_COMPRAS VALUES (3, 6, 6, 25, 3.80);
INSERT INTO DETALLE_COMPRAS VALUES (4, 7, 7, 15, 1.10);
INSERT INTO DETALLE_COMPRAS VALUES (4, 8, 8, 10, 3.10);
INSERT INTO DETALLE_COMPRAS VALUES (5, 9, 9, 12, 14.20);
INSERT INTO DETALLE_COMPRAS VALUES (5, 10, 10, 8, 12.40);
INSERT INTO DETALLE_COMPRAS VALUES (6, 11, 11, 10, 9.30);

INSERT INTO DETALLE_COMPRAS VALUES (7, 12, 3, 15, 4.20);
INSERT INTO DETALLE_COMPRAS VALUES (7, 13, 4, 25, 1.60);
INSERT INTO DETALLE_COMPRAS VALUES (8, 14, 5, 10, 2.30);
INSERT INTO DETALLE_COMPRAS VALUES (8, 15, 6, 20, 4.00);
INSERT INTO DETALLE_COMPRAS VALUES (9, 16, 7, 5, 1.10);
INSERT INTO DETALLE_COMPRAS VALUES (9, 17, 8, 8, 3.10);
INSERT INTO DETALLE_COMPRAS VALUES (10, 18, 9, 7, 14.20);
INSERT INTO DETALLE_COMPRAS VALUES (10, 19, 10, 6, 12.30);

----------------------------------------------TRIGGERS--------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

---------------------PRIMER TRIGGER-------------------------
-- Crear el trigger

CREATE TABLE AUDITORIA_CLIENTES (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    ACCION VARCHAR2(10),
    FECHA TIMESTAMP
);
/
CREATE OR REPLACE TRIGGER trgger1
BEFORE INSERT OR UPDATE OR DELETE ON CLIENTES
FOR EACH ROW
DECLARE
    v_accion VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_accion := 'INSERCI�N';
            DBMS_OUTPUT.PUT_LINE('Accion: ' || v_accion);
    ELSIF UPDATING THEN
        v_accion := 'ACTUALIZACI�N';
            DBMS_OUTPUT.PUT_LINE('Accion: ' || v_accion);
    ELSIF DELETING THEN
        v_accion := 'ELIMINACI�N';
            DBMS_OUTPUT.PUT_LINE('Accion: ' || v_accion);
    END IF;
    INSERT INTO AUDITORIA_CLIENTES (ACCION, FECHA)
    VALUES (v_accion, SYSTIMESTAMP);
END;
/
INSERT INTO CLIENTES VALUES (11,'183445667','YARBANTRELLA','PABLO POLIT','AV.REPUBLICA',NULL,NULL,NULL,NULL);
SELECT * FROM AUDITORIA_CLIENTES;

---------------------SEGUNDO TRIGGER-------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER trigger_DetCompras
    BEFORE INSERT OR UPDATE ON detalle_compras
    FOR EACH ROW
DECLARE
    accionT varchar2(10);
BEGIN
    CASE
        WHEN INSERTING THEN
            accionT := 'INSERT';
            UPDATE PRODUCTOS SET EXISTENCIA = EXISTENCIA + :new.CANTIDAD WHERE PRODUCTOID = :new.PRODUCTOID;
        WHEN UPDATING('CANTIDAD') THEN
            accionT := 'UPDATE';
            UPDATE PRODUCTOS SET EXISTENCIA = EXISTENCIA + :new.CANTIDAD WHERE PRODUCTOID = :new.PRODUCTOID;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('ACCION:'|| accionT);
END;
/
--INSERT INTO DETALLE_COMPRAS VALUES (10, 22, 3, 13, 4.70);
UPDATE DETALLE_COMPRAS SET CANTIDAD = 20 WHERE COMPRAID = 6;

---------------------TERCER TRIGGER-------------------------


CREATE Table EMPLEADOSREPORTA(
    EMPREPID int NOT NULL,
    EMPLEADOID INT NOT NULL,
    FECHA date NOT NULL,
    REPORANT int NOT NULL,
    REPORDES int NOT NULL,
    ACCION char(50) NOT NULL,
    CONSTRAINT PK_EMPLEADOSREP PRIMARY KEY(EMPREPID),
    CONSTRAINT FK_EMPLEADOID_EMPLEADOS FOREIGN KEY(EMPLEADOID) REFERENCES EMPLEADOS(EMPLEADOID),
    CONSTRAINT FK_EMPLEADOSREPORANT_EMPLEADOS FOREIGN KEY (REPORANT) REFERENCES EMPLEADOS(EMPLEADOID),
    CONSTRAINT FK_EMPLEADOSREPORDES_EMPLEADOS FOREIGN KEY (REPORDES) REFERENCES EMPLEADOS(EMPLEADOID)
);

CREATE SEQUENCE seq_empleadosreporta
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TR_EMPLEADOSROL
BEFORE UPDATE OF REPORTA_A ON EMPLEADOS
FOR EACH ROW
DECLARE 
    idempleado int;
    reportaAnt int;
    reportaDes int;
    fechaAct date;
    idSec int;
BEGIN
    SELECT SYSDATE INTO fechaAct FROM DUAL;
    idempleado := :NEW.empleadoid;
    reportaAnt := :OLD.reporta_a;
    reportaDes := :NEW.reporta_a;
    idSec := seq_empleadosreporta.nextval;
    CASE
        WHEN UPDATING ('REPORTA_A')THEN
			DBMS_OUTPUT.put_line('Actualizando');
            INSERT INTO EMPLEADOSREPORTA VALUES (idSec, idempleado, fechaAct, reportaAnt, reportaDes, 'Actualizacion de rol');
    END CASE;
END;

UPDATE EMPLEADOS SET REPORTA_A = 3 WHERE empleadoid = 6;

SELECT * FROM empleadosreporta;


------------------------------------------FUNCIONES----PROCEDIMIENTOS-----------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------


--------------------EJERCICIO 1------------------------------
--a.	El cliente que adquiere mayor cantidad de productos--
set serveroutput on
CREATE OR REPLACE FUNCTION cantProdMayor RETURN CHAR IS 
    mayor CHAR(50);
BEGIN
    SELECT NOMBRECONTACTO
    INTO mayor
FROM (
    SELECT c.CLIENTEID, c.NOMBRECONTACTO, SUM(do.CANTIDAD) AS TOTAL_PRODUCTOS
    FROM CLIENTES c
    JOIN ORDENES o ON c.CLIENTEID = o.CLIENTEID
    JOIN DETALLE_ORDENES do ON o.ORDENID = do.ORDENID
    GROUP BY c.CLIENTEID, c.NOMBRECONTACTO
    ORDER BY TOTAL_PRODUCTOS DESC)
WHERE ROWNUM = 1;  
    RETURN mayor;  
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN -1;
        WHEN OTHERS THEN
            RETURN 0;   
END;
/
DECLARE
    total CHAR(50);
BEGIN
    total := cantProdMayor();
    DBMS_OUTPUT.PUT_LINE('El Cliente es: ' || total);
END;


--------------------EJERCICIO 2------------------------------
--b.	El proveedor a quien se le compra en mayor cantidad (valor de la compra)--
CREATE OR REPLACE PROCEDURE ComprasProveedor(provID OUT NUMBER, nombre OUT VARCHAR, cantidad OUT NUMBER) IS 
BEGIN
    SELECT PROVEEDORID, NOMBREPROV, NVL(CANTIDAD_TOTAL_VALOR, 0) AS VALOR_TOTAL_COMPRADO INTO provID, nombre, cantidad
FROM (
    SELECT P.PROVEEDORID, P.NOMBREPROV, NVL((SELECT SUM(D.CANTIDAD * PR.PRECIOUNIT) FROM DETALLE_COMPRAS D JOIN PRODUCTOS PR ON D.PRODUCTOID = PR.PRODUCTOID WHERE D.COMPRAID IN (
                    SELECT CM.COMPRAID FROM COMPRAS CM WHERE CM.PROVEEDORID = P.PROVEEDORID )),0) AS CANTIDAD_TOTAL_VALOR FROM PROVEEDORES P ORDER BY CANTIDAD_TOTAL_VALOR DESC) WHERE ROWNUM = 1;
END ComprasProveedor;
/

DECLARE
  provID NUMBER;
  nombre VARCHAR(50);
  cantidad NUMBER;
BEGIN
  ComprasProveedor(provID, nombre, cantidad);
  DBMS_OUTPUT.PUT_LINE('El proveedor al que más se le compra es:');
  DBMS_OUTPUT.PUT_LINE('PROVEEDOR ID: ' || provID);
  DBMS_OUTPUT.PUT_LINE('NOMBRE PROVEEDOR: ' || nombre);
  DBMS_OUTPUT.PUT_LINE('CANTIDAD DE VALOR COMPRADO: ' || cantidad);
END;
/

--------------------EJERCICIO 3------------------------------
--c.	La ganancia por producto(diferencia entre precio y venta y precio de compra)--
CREATE OR REPLACE 
PROCEDURE Ganancia_Producto(a IN NUMBER, c OUT CHAR, d OUT number) IS
    prodId NUMBER;
BEGIN
    SELECT s.productoid, s.descripcion, (s.precioventa - s.preciocompra) AS Ganancia
    INTO prodId, c ,d 
    FROM(SELECT p.productoid, p.descripcion,p.preciounit precioVenta, d.precio_unitario precioCompra 
    FROM productos p, detalle_compras d WHERE p.productoid = d.productoid)s
    WHERE s.productoid = a;
END Ganancia_Producto;


DECLARE
      idP number;
      descripcion char(50);
      ganancia number;
   BEGIN
      idP := 1;
      Ganancia_Producto(idP, descripcion, ganancia);
      DBMS_OUTPUT.PUT_LINE('ID Producto: ' || idP || ' - Descripcion: ' || descripcion ||' Ganancia: $' || ganancia);
END;
