USE biblioteca;

-- Inserción de usuarios
INSERT INTO usuario (correo, nombre, fecha_nacimiento, direccion) VALUES
('ana@mail.com', 'Ana Torres', '1990-05-12', 'Calle 1'),
('juan@mail.com', 'Juan Perez', '1985-03-22', 'Calle 2'),
('maria@mail.com', 'Maria Gomez', '1992-07-15', 'Calle 3'),
('luis@mail.com', 'Luis Benitez', '1988-11-30', 'Calle 4'),
('sofia@mail.com', 'Sofia Diaz', '1995-09-10', 'Calle 5'),
('carlos@mail.com', 'Carlos Ruiz', '1980-01-05', 'Calle 6'),
('laura@mail.com', 'Laura Sanchez', '1993-04-18', 'Calle 7'),
('pedro@mail.com', 'Pedro Fernandez', '1987-12-25', 'Calle 8'),
('lucia@mail.com', 'Lucia Castro', '1991-06-20', 'Calle 9'),
('diego@mail.com', 'Diego Lopez', '1989-08-14', 'Calle 10');

-- Inserción de autores
INSERT INTO autor (nombre, nacionalidad) VALUES
('Gabriel Garcia Marquez', 'Colombiana'),
('J.K. Rowling', 'Británica'),
('Stephen King', 'Estadounidense'),
('Isabel Allende', 'Chilena'),
('Mario Vargas Llosa', 'Peruana'),
('George Orwell', 'Británica'),
('Julio Cortázar', 'Argentina'),
('Haruki Murakami', 'Japonesa'),
('Jane Austen', 'Británica'),
('Ernest Hemingway', 'Estadounidense'),
('Yuval Noah Harari', 'Israelí'),
('T. Harv Eker', 'Canadiense'),
('Guido van Rossum', 'Holandesa');

-- Inserción de libros
INSERT INTO libro (titulo, anio_publicacion, genero, isbn) VALUES
('Cien años de soledad', 1967, 'Novela', '978-1'),
('Harry Potter y la piedra filosofal', 1997, 'Fantasia', '978-2'),
('It', 1986, 'Terror', '978-3'),
('La casa de los espíritus', 1982, 'Novela', '978-4'),
('La ciudad y los perros', 1963, 'Novela', '978-5'),
('1984', 1949, 'Distopía', '978-6'),
('Rayuela', 1963, 'Novela', '978-7'),
('Tokio Blues', 1987, 'Novela', '978-8'),
('Orgullo y prejuicio', 1813, 'Romance', '978-9'),
('El viejo y el mar', 1952, 'Novela', '978-10'),
('Sapiens: De animales a dioses', 2011, 'Historia', '978-11'),
('Los secretos de la mente millonaria', 2005, 'Autoayuda', '978-12'),
('Introducción a la programación', 2020, 'Tecnología', '978-13');

-- Inserción de libroAutor (relaciones)
INSERT INTO libroAutor (id_libro, id_autor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13);

-- Inserción de préstamos
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion, devuelto) VALUES
(1, 1, '2024-06-01', '2024-06-10', TRUE),
(2, 2, '2024-06-02', NULL, FALSE),
(3, 3, '2024-06-03', '2024-06-12', TRUE),
(4, 4, '2024-06-04', NULL, FALSE),
(5, 5, '2024-06-05', '2024-06-15', TRUE),
(6, 6, '2024-06-06', NULL, FALSE),
(7, 7, '2024-06-07', '2024-06-17', TRUE),
(8, 8, '2024-06-08', NULL, FALSE),
(9, 9, '2024-06-09', '2024-06-19', TRUE),
(10, 10, '2024-06-10', NULL, FALSE),
(1, 11, '2024-07-01', NULL, FALSE),
(2, 12, '2024-07-02', '2024-07-10', TRUE),
(3, 13, '2024-07-03', NULL, FALSE);

-- Inserción de reservas
INSERT INTO reserva (id_usuario, id_libro, fecha_reserva, atendida) VALUES
(1, 2, '2024-06-11', FALSE),
(2, 3, '2024-06-12', TRUE),
(3, 4, '2024-06-13', FALSE),
(4, 5, '2024-06-14', TRUE),
(5, 6, '2024-06-15', FALSE),
(6, 7, '2024-06-16', TRUE),
(7, 8, '2024-06-17', FALSE),
(8, 9, '2024-06-18', TRUE),
(9, 10, '2024-06-19', FALSE),
(10, 1, '2024-06-20', TRUE),
(4, 11, '2024-07-04', FALSE),
(5, 12, '2024-07-05', TRUE),
(6, 13, '2024-07-06', FALSE);

-- Inserción de métodos de pago
INSERT INTO metodos_pago (id_usuario, tipo_metodo, detalles, activo) VALUES
(1, 'Tarjeta', 'Visa 1234', TRUE),
(2, 'Efectivo', 'Pago en mostrador', TRUE),
(3, 'Transferencia', 'Banco Nación', TRUE),
(4, 'Tarjeta', 'Mastercard 5678', TRUE),
(5, 'Efectivo', 'Pago en mostrador', TRUE),
(6, 'Transferencia', 'Banco Galicia', TRUE),
(7, 'Tarjeta', 'Visa 4321', TRUE),
(8, 'Efectivo', 'Pago en mostrador', TRUE),
(9, 'Transferencia', 'Banco Santander', TRUE),
(10, 'Tarjeta', 'Mastercard 8765', TRUE);

-- Inserción de multas
INSERT INTO multa (id_usuario, monto, motivo, fecha_multa, pagada, id_metodo) VALUES
(1, 50, 'Retraso', '2024-06-21', FALSE, 1),
(2, 30, 'Libro dañado', '2024-06-22', TRUE, 2),
(3, 40, 'Retraso', '2024-06-23', FALSE, 3),
(4, 25, 'Pérdida', '2024-06-24', TRUE, 4),
(5, 60, 'Retraso', '2024-06-25', FALSE, 5),
(6, 35, 'Libro dañado', '2024-06-26', TRUE, 6),
(7, 45, 'Retraso', '2024-06-27', FALSE, 7),
(8, 20, 'Pérdida', '2024-06-28', TRUE, 8),
(9, 55, 'Retraso', '2024-06-29', FALSE, 9),
(10, 65, 'Libro dañado', '2024-06-30', TRUE, 10);

-- Insertar categorías
INSERT INTO categoria (nombre, descripcion) VALUES
('Novela', 'Libros de narrativa extensa'),
('Ciencia', 'Libros de divulgación científica'),
('Infantil', 'Libros para niños'),
('Historia', 'Libros históricos'),
('Autoayuda', 'Libros de desarrollo personal'),
('Tecnología', 'Libros sobre informática y tecnología');

-- Insertar libros con categoría (ejemplo)
INSERT INTO libro (titulo, anio_publicacion, genero, isbn, id_categoria) VALUES
('Cien años de soledad', 1967, 'Novela', '1234567890', 1),
('Breves respuestas a las grandes preguntas', 2018, 'Ciencia', '0987654321', 2),
('El principito', 1943, 'Infantil', '1122334455', 3),
('Sapiens: De animales a dioses', 2011, 'Historia', '978-11', 4),
('Los secretos de la mente millonaria', 2005, 'Autoayuda', '978-12', 5),
('Introducción a la programación', 2020, 'Tecnología', '978-13', 6);

SELECT 
    u.nombre AS Usuario,
    COUNT(p.id_prestamo) AS Cantidad_Prestamos
FROM 
    usuario u
    JOIN prestamo p ON u.id_usuario = p.id_usuario
GROUP BY 
    u.nombre
ORDER BY 
    Cantidad_Prestamos DESC;
