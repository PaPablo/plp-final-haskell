## Paquetes necesarios

- `make`
- `texlive`
- `biber` (para compilar la bibliografía de `BiBLaTeX`, instalable via `pacman -S biber`)

## Compilación

- Compilar el *.pdf* haciendo `make`
- Borrar el *.pdf* con `make realclean`

### Estructura de archivos

- `informe.tex`: archivo principal; incluye los archivos de configuración necesarios.
- `references.bib`: tiene las referencias de bibliografía (un sitio que está piola para generar las entradas es [este](http://truben.no/latex/bibtex/#)).
- `settings.tex`: configuraciones varias
- `listings_settings.tex`: configuraciones propias del paquete `listings` (usado para incrustar bloques de código y que queden lindos).
- `includes.tex`: importaciones de paquetes.
- `titlepage.tex`: definición de la carátula.

