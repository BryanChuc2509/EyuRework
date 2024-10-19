CREATE DATABASE eyuRework;
USE eyuRework;

CREATE TABLE Cuentas(
ID_Cuenta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Correo VARCHAR(150) NOT NULL,
Nombre_de_Usuario VARCHAR(30) NOT NULL,
Contraseña VARCHAR(150) NOT NULL,
Fecha_Registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
Tipo_Cuenta VARCHAR(20) DEFAULT 'usuario' NOT NULL
);

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE Perfiles(
    ID_Perfil INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Id_cuenta INT NOT NULL,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    Descripcion TEXT ,
    FOREIGN KEY(Id_cuenta) REFERENCES Cuentas(ID_Cuenta) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS=0;
SET GLOBAL FOREIGN_KEY_CHECKS=0;

DROP TABLE Perfiles;

CREATE TABLE Direccion(
ID_Direccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Calle VARCHAR(200) NOT NULL,
Region SMALLINT,
Supermanzana SMALLINT,
Manzana SMALLINT,
Lote SMALLINT,
CP MEDIUMINT NOT NULL
);	

CREATE TABLE Universidades(
ID_Universidad INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(200) NOT NULL,
image TEXT,
Descripcion TEXT,
Tipo_de_Universidad VARCHAR(20) NOT NULL,
Id_direccion INT NOT NULL, 
URL_pagina TEXT NOT NULL,
Correo_contacto VARCHAR(150) NOT NULL,
FOREIGN KEY(Id_direccion) REFERENCES Direccion(ID_Direccion)
);

CREATE TABLE Carreras(
ID_Carrera INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(150) NOT NULL,
Duracion VARCHAR(150),
Descripcion TEXT NOT NULL
);

CREATE TABLE Universidad_Carrera(
Id_universidad INT NOT NULL,
Id_carrera INT NOT NULL,
FOREIGN KEY(Id_universidad) REFERENCES Universidades(ID_Universidad),
FOREIGN KEY(Id_carrera) REFERENCES Carreras(ID_Carrera)
);

CREATE TABLE Comentarios(
ID_Comentarios INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Contenido TEXT NOT NULL,
Id_cuenta INT NOT NULL,
Id_universidad INT NOT NULL,
Fecha_Publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
FOREIGN KEY(Id_cuenta) REFERENCES Cuentas(ID_Cuenta),
FOREIGN KEY(Id_universidad) REFERENCES Universidades(ID_Universidad)
);

CREATE TABLE frase(
id_frase INT PRIMARY KEY auto_increment,
frase TEXT);

CREATE TABLE Universidades_guardadas (
    Id_universidad INT NOT NULL,
    Id_cuenta INT NOT NULL,
    PRIMARY KEY (Id_universidad, Id_cuenta),
    FOREIGN KEY (Id_universidad) REFERENCES Universidades(ID_Universidad),
    FOREIGN KEY (Id_cuenta) REFERENCES cuentas(ID_Cuenta)
);

-- --------------------------- Inserts ------------------------

INSERT INTO Cuentas (Correo, Nombre_de_Usuario, Contraseña)
VALUES
('juan.perez@example.com', 'juanperez', 'password123'),
('maria.gomez@example.com', 'mariagomez', '1234abcd'),
('carlos.lopez@example.com', 'carloslopez', 'lopez7890'),
('ana.martinez@example.com', 'anamartinez', 'martinez2021'),
('luis.sanchez@example.com', 'luissanchez', 'sanchez!567'),
('laura.fernandez@example.com', 'laurafernandez', 'fernandez321');

INSERT INTO Perfiles (Id_cuenta, Nombre, Descripcion)
VALUES
(1, 'Juan', 'Recién egresado de bachillerato con interés en estudiar ingeniería en sistemas. Apasionado por la tecnología y el desarrollo de software.'),
(2, 'Maria', 'Egresada de bachillerato con talento para el diseño gráfico. Busca una universidad que ofrezca programas en arte digital y fotografía.'),
(3, 'Carlos', 'Acaba de terminar el bachillerato y quiere estudiar análisis de datos. Habilidades iniciales en SQL y Python.'),
(4, 'Ana', 'Recién egresada de bachillerato interesada en educación. Aspira a ser profesora de matemáticas.'),
(5, 'Luis', 'Egresado de bachillerato con interés en el ámbito financiero. Busca una universidad con un fuerte programa de economía.'),
(6, 'Laura', 'Recién egresada de bachillerato apasionada por el marketing digital. Interesada en programas enfocados en redes sociales y publicidad.');


INSERT INTO Direccion(Calle, Supermanzana, Manzana, Lote, CP) 
VALUES('Carretera Cancun-aeropuerto', 299, 5, 11, 77565), -- ut
('Av. Arco Bincentenario', 255, 11, 119, 77500), -- poli
('Esquina Fraccionamiento, Tabachines', 78, 1, 1, 77528), -- unicaribe
('Blvd. Luis Donaldo Colosio', 299, 2, 1, 77565), -- anahuac
('Cancún-Playa del Carmen', 299, 1, 1, 77560), -- lasalle
('Av. Rodrigo Gómez', 38, 9, 15, 77507); -- unid

SELECT * FROM Universidades;
INSERT INTO Universidades(Nombre, Descripcion, Tipo_de_Universidad, Id_direccion, URL_pagina, Correo_contacto) 
VALUES('Universidad Tecnológica de Cancún UT Cancún', 'Es una universidad pública que se especializa en la formación de profesionistas técnicos en áreas como gastronomía, turismo y tecnologías de la información. Su modelo educativo se basa en el aprendizaje basado en competencias, permitiendo a los estudiantes desarrollar habilidades necesarias para el éxito profesional. Cuenta con una amplia infraestructura de laboratorios y talleres.
Está acreditada por la FIMPES.','Pública', 1, 'http://www.utcancun.edu.mx/', '998 881 1900'),

('Universidad Politécnica de Quintana Roo', 'Es una universidad pública joven que se ha posicionado rápidamente como una de las mejores opciones educativas en Cancún. Se enfoca en la formación de profesionales en áreas como ingeniería, tecnología y ciencias sociales. Su modelo educativo se basa en el aprendizaje experiencial, permitiendo a los estudiantes aplicar conocimientos en situaciones reales. Está acreditada por la FIMPES.
', 'Pública', 2, 'https://upqroo.edu.mx/', ' 998 283 1859'),

('Universidad del Caribe (UNICARIBE)', 'Ofrece 9 carreras entre licenciaturas e ingenierías. Cada año otorga becas de apoyo económico, de excelencia, a estudiantes de comunidades indígenas, a mujeres jefas de familia e incentiva que estudiantes tanto mujeres como indígenas, estudien ingenierías. Se encuentra entre las 90 mejores universidades de México según la ANUIES.','Pública', 3, 'https://www.unicaribe.mx/', '998 881 4400'),

('Universidad Anáhuac Cancún', 'Cuenta con un modelo educativo vanguardista que combina teoría y práctica, preparando a sus estudiantes para los retos del mercado laboral. Posee un campus moderno y equipado con tecnología de punta, facilitando el aprendizaje y la investigación. Está acreditada por la FIMPES.', 'Privada', 4, 'https://www.anahuac.mx/cancun/', '998 881 7750' ),

('Universidad LaSalle Cancún', 'Forma parte de la Red La Salle, una red internacional de universidades católicas con más de 300 años de historia. Su modelo educativo se basa en el aprendizaje por competencias, permitiendo a sus estudiantes desarrollar habilidades necesarias para el éxito profesional. Se distingue por su formación integral, desarrollando en sus estudiantes valores éticos y sociales. Está acreditada por la FIMPES.', 'Privada', 5, 'https://lasallecancun.edu.mx/', '998 886 2201'),

('Universidad Interamericana para el Desarrollo (UNID)', 'Forma parte de la Federación de Instituciones Mexicanas Particulares de Educación Superior FIMPES. Recibió la Acreditación institucional por la SEP. La educación que se imparte en esta universidad va acorde con los valores de la iglesia católica.', 'Privada', 6, 'https://unid.talisis.com/campus/cancun', '998 889 9520');

INSERT INTO Carreras(Nombre, Duracion, Descripcion) VALUES('Licenciatura en Gastronomía','3 a 4 años','Carrera de nivel gerencial con sólidos valores y amplios conocimientos culturales; con habilidades y competencias en gestión empresarial, servicio, nutrición y artes culinarias que les permitan desarrollar, bajo estándares de calidad internacional y sustentabilidad, actividades de gestión en todos los ámbitos de la Industria gastronómica.'),

('Licenciatura en Terapia Física','3 a 4 años','Es una profesión dentro del área de salud y es entendida como la ciencia del movimiento aplicada a la rehabilitación. La terapia física brinda tratamiento a diferentes enfermedades de acuerdo a la evaluación previa de las habilidades y condiciones propias del paciente.'),

('Licenciatura en Psicología', '3 a 4 años ', 'La carrera de Psicología está enfocada en brindar solución a las problemáticas que surgen de la interacción entre los individuos. De esta manera, se busca el bienestar de la salud mental en diversos ámbitos: personal, educativo, social, laboral, entre otros.'),

('Ingeniería en Software', '3 a 4 años', 'En la carrera de Ingeniería en Software, el profesionista estará facultado para diseñar, desarrollar y mejorar la calidad de productos de software; especificar los métodos y las herramientas para aumentar la productividad de los desarrolladores de software; controlar los procesos de manera eficiente; aplicar los estándares internacionales para construir software de alta calidad. '),

('Ingeniería Civil', '3 a 4 años', 'Ingeniería Civil consiste en el mantenimiento, control y operación de construcciones. De igual manera, de realizar proyectos o dirigirlos en las obras de construcción o calcular y diseñar las estructuras para obtener una resistencia y durabilidad del establecimiento.'),

('Ingeniería Industrial', '3 a 4 años', 'La Ingeniería Industrial incluye tareas como el diseño y la construcción de maquinaria, la mejora de la eficiencia de los procesos de fabricación y la garantía de que las cadenas de suministro funcionen correctamente.');

INSERT INTO Universidad_carrera (Id_universidad, Id_carrera) VALUES 
(1,1),(1,2),(1,4),(2,2),(2,4),(3,1),(3,6),(4,1),(4,2),(4,3),(4,4),(4,5),(5,3),(5,5),(6,3),(6,4);

INSERT INTO Comentarios (Contenido, Id_cuenta, Id_universidad) 
VALUES
('Es una universidad pública que se especializa en la formación de profesionistas técnicos en áreas como gastronomía, turismo y tecnologías de la información. Su modelo educativo se basa en el aprendizaje basado en competencias, permitiendo a los estudiantes desarrollar habilidades necesarias para el éxito profesional. Cuenta con una amplia infraestructura de laboratorios y talleres. Está acreditada por la FIMPES.', 1, 1),
('Es una universidad pública joven que se ha posicionado rápidamente como una de las mejores opciones educativas en Cancún. Se enfoca en la formación de profesionales en áreas como ingeniería, tecnología y ciencias sociales. Su modelo educativo se basa en el aprendizaje experiencial, permitiendo a los estudiantes aplicar conocimientos en situaciones reales. Está acreditada por la FIMPES.', 2, 2),
('Ofrece 9 carreras entre licenciaturas e ingenierías. Cada año otorga becas de apoyo económico, de excelencia, a estudiantes de comunidades indígenas, a mujeres jefas de familia e incentiva que estudiantes tanto mujeres como indígenas, estudien ingenierías. Se encuentra entre las 90 mejores universidades de México según la ANUIES.', 3, 3),
('Cuenta con un modelo educativo vanguardista que combina teoría y práctica, preparando a sus estudiantes para los retos del mercado laboral. Posee un campus moderno y equipado con tecnología de punta, facilitando el aprendizaje y la investigación. Está acreditada por la FIMPES.', 4, 4),
('Forma parte de la Red La Salle, una red internacional de universidades católicas con más de 300 años de historia. Su modelo educativo se basa en el aprendizaje por competencias, permitiendo a sus estudiantes desarrollar habilidades necesarias para el éxito profesional. Se distingue por su formación integral, desarrollando en sus estudiantes valores éticos y sociales. Está acreditada por la FIMPES.', 5, 5),
('Forma parte de la Federación de Instituciones Mexicanas Particulares de Educación Superior FIMPES. Recibió la Acreditación institucional por la SEP. La educación que se imparte en esta universidad va acorde con los valores de la iglesia católica.', 6, 6);

INSERT INTO frase(frase) VALUES('El éxito no se mide por lo que has logrado, sino por los obstáculos que has superado para llegar allí. Cada desafío es una oportunidad para crecer y mejorar.'),
('A veces, el camino hacia el éxito está lleno de dificultades, pero cada obstáculo es una oportunidad para aprender y fortalecerse. Sigue adelante con determinación.'),
('No permitas que el miedo al fracaso te detenga. Cada error es un peldaño hacia el éxito, y cada desafío te hace más fuerte. Mantén tu enfoque y avanza con valentía.'),
('Cada día es una nueva oportunidad para cambiar tu vida y acercarte a tus metas. Aprovecha cada momento, enfrenta tus miedos y trabaja con pasión y dedicación.'),
('La perseverancia es la clave para alcanzar tus sueños. Aunque el camino sea arduo, cada pequeño paso te acerca más a tu objetivo. No te detengas y sigue adelante.');






-- Ejecutar en caso de que no se filtren por privadas
UPDATE universidades SET Tipo_de_Universidad = 'privada' WHERE Tipo_de_Universidad = 'Privada';

-- ! Ejecutar si o si. Ejecutar para ver las imagenes
UPDATE universidades SET image = './../image/utcancun.png' WHERE ID_Universidad = 1;
UPDATE universidades SET image = './../image/politec.jpg' WHERE ID_Universidad = 2;
UPDATE universidades SET image = './../image/ImagenesUni/unicaribe.jpg' WHERE ID_Universidad = 3;
UPDATE universidades SET image = './../image/anahuac.png' WHERE ID_Universidad = 4;
UPDATE universidades SET image = './../image/ImagenesUni/unicaribe.jpg' WHERE ID_Universidad = 5;
UPDATE universidades SET image = './../image/ImagenesUni/unid-cancun.jpg' WHERE ID_Universidad = 6;

-- ! Ejecutar para cambiar un registro en caso de que necesiten un admin
UPDATE cuentas SET Tipo_Cuenta = 'administrador' WHERE ID_Cuenta = 3;


