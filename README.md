# Prueba técnica

Esta es una aplicación móvil desarrollada en Flutter que permite visualizar los municipios del departamento del Tolima, las instituciones educativas ubicadas en cada municipio, las sedes de cada institución y los grupos registrados en cada sede.

## Características

- Visualizar el listado total de municipios registrados en la base de datos.
- Consultar las instituciones educativas ubicadas en un municipio específico.
- Consultar las sedes de cada institución educativa.
- Visualizar la información de los grupos registrados en cada sede.

## Estructura del Proyecto

- `main.dart`: Punto de entrada de la aplicación.
- `screens/municipio_screen.dart`: Pantalla para mostrar los municipios.
- `screens/instituciones_screen.dart`: Pantalla para mostrar las instituciones de un municipio.
- `screens/sedes_screen.dart`: Pantalla para mostrar las sedes de una institución.
- `screens/grupos_screen.dart`: Pantalla para mostrar los grupos de una sede.

## Instalación

### Requisitos Previos

- Flutter SDK
- Dart SDK

### Pasos

1. Clona el repositorio:
    ```sh
    git clone git@github.com:makyp/prueba_tecnica.git
    ```

2. Instala las dependencias:
    ```sh
    flutter pub get
    ```

3. Corre la aplicación:
    ```sh
    flutter run
    ```
