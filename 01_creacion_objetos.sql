CREATE SCHEMA biblioteca;
USE biblioteca;

CREATE TABLE usuario(
    id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    correo VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(255)
);

CREATE TABLE autor(
    id_autor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

CREATE TABLE libro(
    id_libro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    anio_publicacion INT,
    genero VARCHAR(50),
    isbn VARCHAR(20) UNIQUE
);

CREATE TABLE libroAutor(
    id_libro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_libro, id_autor)
);

CREATE TABLE prestamo(
    id_prestamo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    devuelto BOOLEAN DEFAULT FALSE
);

CREATE TABLE reserva(
    id_reserva INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    atendida BOOLEAN DEFAULT FALSE
);

CREATE TABLE multa(
    id_multa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    monto FLOAT NOT NULL,
    motivo VARCHAR(255),
    fecha_multa DATE NOT NULL,
    pagada BOOLEAN DEFAULT FALSE,
    id_metodo INT,
    FOREIGN KEY (id_metodo) REFERENCES metodos_pago (id_metodo)
);

CREATE TABLE metodos_pago(
    id_metodo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    tipo_metodo VARCHAR(50) NOT NULL,
    detalles VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE categoria(
    id_categoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

ALTER TABLE libro ADD COLUMN id_categoria INT;
ALTER TABLE libro ADD CONSTRAINT fk_idCategoria_libro
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);

ALTER TABLE libroAutor ADD CONSTRAINT fk_idLibro_libroAutor
    FOREIGN KEY (id_libro) REFERENCES libro (id_libro);
ALTER TABLE libroAutor ADD CONSTRAINT fk_idAutor_libroAutor
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor);

ALTER TABLE prestamo ADD CONSTRAINT fk_idUsuario_prestamo
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE prestamo ADD CONSTRAINT fk_idLibro_prestamo
    FOREIGN KEY (id_libro) REFERENCES libro (id_libro);

ALTER TABLE reserva ADD CONSTRAINT fk_idUsuario_reserva
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
ALTER TABLE reserva ADD CONSTRAINT fk_idLibro_reserva
    FOREIGN KEY (id_libro) REFERENCES libro (id_libro);

ALTER TABLE multa ADD CONSTRAINT fk_idUsuario_multa
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);

ALTER TABLE metodos_pago ADD CONSTRAINT fk_idUsuario_metodos_pago
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);

-- Vistas
CREATE VIEW vw_prestamos_activos AS
   SELECT
      p.id_prestamo,
      u.nombre AS usuario,
      l.titulo AS libro,
      p.fecha_prestamo
   FROM
      prestamo p
      JOIN usuario u ON p.id_usuario = u.id_usuario
      JOIN libro l ON p.id_libro = l.id_libro
   WHERE
      p.devuelto = FALSE;

CREATE VIEW vw_reservas_atendidas AS
   SELECT
      r.id_reserva,
      u.nombre AS usuario,
      l.titulo AS libro,
      r.fecha_reserva
   FROM
      reserva r
      JOIN usuario u ON r.id_usuario = u.id_usuario
      JOIN libro l ON r.id_libro = l.id_libro
   WHERE
      r.atendida = TRUE;

CREATE OR REPLACE VIEW vw_multas_impagas AS
   SELECT
      m.id_multa,
      u.nombre AS usuario,
      m.monto,
      m.motivo,
      m.fecha_multa,
      mp.tipo_metodo,
      mp.detalles
   FROM
      multa m
      JOIN usuario u ON m.id_usuario = u.id_usuario
      LEFT JOIN metodos_pago mp ON m.id_metodo = mp.id_metodo
   WHERE
      m.pagada = FALSE;

CREATE VIEW vw_libros_por_categoria AS
   SELECT
      c.nombre AS categoria,
      l.titulo,
      l.anio_publicacion,
      l.genero,
      l.isbn
   FROM
      libro l
      LEFT JOIN categoria c ON l.id_categoria = c.id_categoria
   ORDER BY c.nombre, l.titulo;

-- Funciones
DELIMITER $$
CREATE FUNCTION fn_cantidad_prestamos(id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad FROM prestamo WHERE id_usuario = id;
    RETURN cantidad;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION fn_total_multas_impagas(id INT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total FLOAT;
    SELECT SUM(monto) INTO total FROM multa WHERE id_usuario = id AND pagada = FALSE;
    RETURN IFNULL(total, 0);
END $$
DELIMITER ;

-- Triggers
DELIMITER $$
CREATE TRIGGER tr_multa_monto
BEFORE INSERT ON multa
FOR EACH ROW
BEGIN
    IF NEW.monto > 50 THEN
        SET NEW.pagada = FALSE;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_atender_reserva
AFTER UPDATE ON prestamo
FOR EACH ROW
BEGIN
    IF NEW.devuelto = TRUE THEN
        UPDATE reserva SET atendida = TRUE
        WHERE id_usuario = NEW.id_usuario AND id_libro = NEW.id_libro AND atendida = FALSE;
    END IF;
END $$
DELIMITER ;

-- Stored Procedures
DELIMITER $$
CREATE PROCEDURE sp_prestamos_por_usuario(IN id INT)
BEGIN
    SELECT p.id_prestamo, l.titulo, p.fecha_prestamo, p.fecha_devolucion, p.devuelto
    FROM prestamo p
    JOIN libro l ON p.id_libro = l.id_libro
    WHERE p.id_usuario = id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_multas_por_usuario(IN id INT)
BEGIN
    SELECT m.id_multa, m.monto, m.motivo, m.fecha_multa, m.pagada,
           mp.tipo_metodo, mp.detalles
    FROM multa m
    LEFT JOIN metodos_pago mp ON m.id_metodo = mp.id_metodo
    WHERE m.id_usuario = id;
END $$
DELIMITER ;