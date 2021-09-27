DROP DATABASE IF EXISTS BANCO_ALIMENTOS;
CREATE DATABASE BANCO_ALIMENTOS;
USE BANCO_ALIMENTOS;

CREATE TABLE USUARIO(
    id int AUTO_INCREMENT,
    nombre varchar(30),
    apellidoPaterno varchar(30),
    apellidoMaterno varchar(30),
    correo varchar(45),
    telefonoCasa int,
    telefonoCeluldar int, 
    username varchar(30),
    contrasena varchar(30),
    puesto enum('Administrador', 'Operador', 'Coordinador', 'Almacenista'),
    PRIMARY KEY(id)
);

CREATE TABLE ADMINISTRADOR(
    id int,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES USUARIO(id)
);

CREATE TABLE OPERADOR(
    id int,
    placaVehiculo varchar(10),
    latitud float,
    longuitud float,
    vencimiento_licencia date,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES USUARIO(id)
);

CREATE TABLE COORDINADOR(
    id int,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES USUARIO(id)
);

CREATE TABLE BODEGA(
    id int AUTO_INCREMENT, 
    nombre varchar(30),
    direccion varchar(40),
    municipio varchar(30),
    telefono int,
    latitud float,
    longuitud float,
    PRIMARY KEY (id)
);

CREATE TABLE ALMACENISTA(
    id int,
    idBodega int,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES USUARIO(id),
    FOREIGN KEY(idBodega) REFERENCES BODEGA(id)
);


CREATE TABLE RUTA(
    id int AUTO_INCREMENT,
    idOperador int,
    dia enum('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo') NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(idOperador) REFERENCES OPERADOR(id)
);

CREATE TABLE TIENDA(
    id int AUTO_INCREMENT,
    determinante int,
    cadena varchar(30),
    nombre varchar(50),
    direccion varchar(50),
    municipio varchar(30),
    telefono int,
    idAdmin int,
    idRuta int, 
    PRIMARY KEY(id),
    FOREIGN KEY(idAdmin) REFERENCES ADMINISTRADOR(id),
    FOREIGN KEY (idRuta) REFERENCES RUTA(id)
);

CREATE TABLE DONATIVO(
    id int AUTO_INCREMENT,
    kg_frutas_verduras int,
    kg_pan int, 
    kg_abarrotes int,
    kg_no_comestibles int,
    folio int,
    estatus enum('Pendiente', 'Completado'),
    fecha date,
    responsable varchar(45),
    puesto_responsable varchar(20), 
    idOperador int,
    idTienda int,
    PRIMARY KEY (id),
    FOREIGN KEY (idOperador) REFERENCES OPERADOR(id),
    FOREIGN KEY (idTienda) REFERENCES TIENDA(id)
);

CREATE TABLE ENTREGA_DONATIVO(
    idDonativo int, 
    idBodega int,
    kg_frutas_verduras int,
    kg_abarrotes int,
    kg_pan int,
    kg_no_comestibles int,
    estatus enum('Pendiente', 'Completado'),
    fecha date,
    PRIMARY KEY(idDonativo, idBodega),
    FOREIGN KEY(idDonativo) REFERENCES DONATIVO(id),
    FOREIGN KEY(idBodega) REFERENCES BODEGA(id)
);

CREATE TABLE DONATIVO_ESPONTANEO(
    id int AUTO_INCREMENT,
    kg_frutas_verduras int,
    kg_abarrotes int,
    kg_pan int, 
    kg_no_comestibles int,
    folio int,
    estatus enum('Pendiente', 'Completado'),
    fecha date,
    responsable varchar(45),
    puesto_responsable varchar(20),
    idOperador int, 
    idTienda int,
    PRIMARY KEY(id),
    FOREIGN KEY(idOperador) REFERENCES OPERADOR(id),
    FOREIGN KEY(idTienda) REFERENCES TIENDA(id)
);

CREATE TABLE entrega_donativo_espontaneo(
    idDonativo int, 
    idBodega int,
    kg_frutas_verduras int,
    kg_pan int,
    kg_abarrotes int,
    kg_no_comestibles int,
    estatus enum('Pendiente', 'Completado'),
    fecha date,
    PRIMARY KEY(idDonativo, idBodega),
    FOREIGN KEY(idDonativo) REFERENCES DONATIVO_ESPONTANEO(id),
    FOREIGN KEY(idBodega) REFERENCES BODEGA(id)
);
