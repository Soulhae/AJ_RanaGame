# Plan de trabajo - Tirar a la Rana

## Objetivo

Con 5 programadores a 3 horas diarias hay unas **120 horas nominales** hasta el 16 de septiembre. Conviene planificar solo 80-90 horas de funcionalidades y reservar el resto para integración, errores y exportación web.

La meta será una run jugable de 10-15 minutos:

- 3 rivales normales y 1 jefe.
- 5 lanzamientos por duelo.
- Apuntar, fijar potencia y lanzar.
- Puntuación según el agujero.
- Un modificador por rival.
- Elección de 1 entre 3 mejoras después de cada victoria.
- Victoria, derrota y reinicio.
- Build web publicada y probada antes del día 16.

## Loop principal

1. El jugador entra a una fonda y encuentra un rival.
2. Cada duelo presenta una meta de puntuación y una regla especial.
3. El jugador dispone de 5 tejos para superar la puntuación del rival.
4. Primero fija la dirección horizontal del lanzamiento.
5. Después fija la potencia, que determina la profundidad.
6. El tejo cae, rebota o entra en un agujero.
7. Al ganar, el jugador elige 1 de 3 mejoras.
8. Después de varios rivales, enfrenta al campeón de la fonda.
9. Si pierde un duelo, termina la run y puede comenzar otra.

## Control del lanzamiento

La máquina de estados actual encaja con un control de dos pulsaciones:

- **Apuntar:** una mira oscila horizontalmente. El jugador presiona para fijarla.
- **Potencia:** una barra sube y baja. El jugador vuelve a presionar para fijar la fuerza.
- **Lanzamiento:** el tejo se dispara automáticamente.
- **Resolución:** se espera hasta que el tejo entre, caiga fuera o deje de moverse.

Este sistema permite jugar con un botón, clic o barra espaciadora. Es rápido de aprender y más sencillo de equilibrar que un lanzamiento manual.

## Puntuación propuesta

| Resultado | Puntos |
| --- | ---: |
| Tejo cae fuera | 0 |
| Queda sobre el tablero | 50 |
| Agujero exterior | 100 |
| Agujero intermedio | 200 |
| Agujero cercano a la rana | 500 |
| Boca de la rana | 2.000 |

La boca de la rana debe ser el tiro más difícil y espectacular. Puede activar cámara lenta breve, sonido especial, sacudida de cámara y una recompensa adicional.

## Estructura de los duelos

Cada rival funciona mediante una puntuación objetivo, sin necesidad de programar una IA que lance físicamente:

- El rival tiene una puntuación objetivo.
- El jugador tiene 5 tejos para superarla.
- El rival introduce una condición especial.
- La interfaz muestra el progreso del jugador frente a la meta.

Ejemplo: `La Tía de la Fonda consiguió 1.200 puntos. Tienes 5 tejos para superarla.`

## Rivales

| Rival | Personalidad | Regla |
| --- | --- | --- |
| El Principiante | Tutorial amistoso | Sin modificadores |
| La Tía de la Fonda | Exigente y rápida | La barra de potencia se mueve más rápido |
| El Cuequero | Impredecible | La mira cambia de velocidad |
| Campeón de la Rana | Jefe final | Mayor puntuación y combina dos modificadores |

Para la JAM, los personajes pueden representarse mediante retratos 2D y diálogos cortos. No necesitan modelos 3D ni animaciones complejas.

## Mejoras roguelite

Después de ganar, el jugador elige una de tres mejoras. Para el MVP se implementarán estas cinco:

1. **Pulso firme:** la mira se mueve 20% más lento.
2. **Brazo entrenado:** la barra de potencia se mueve 20% más lento.
3. **Tejo pesado:** el tejo rebota menos.
4. **Yapa:** se obtiene un lanzamiento adicional por duelo.
5. **Segunda oportunidad:** permite repetir un lanzamiento fallido una vez por duelo.

Posibles mejoras posteriores, solamente si el MVP está terminado:

- **Tejo liviano:** llega más lejos con menos potencia.
- **Mano de rana:** los agujeros cuentan como ligeramente más grandes.
- **Racha dieciochera:** los aciertos consecutivos aumentan el multiplicador.
- **Casero generoso:** cada duelo comienza con 100 puntos.
- **Ojo de huaso:** muestra parte de la trayectoria estimada.

Cada mejora del MVP debe modificar una sola variable. Se evitarán efectos que necesiten sistemas nuevos.

## Estructura de la run

- 3 rivales normales.
- 1 mejora después de cada victoria.
- 1 jefe final.
- Victoria al derrotar al campeón.
- Derrota al no superar la meta de cualquier rival.
- Las mejoras duran solamente durante la run.
- No habrá progresión permanente en el MVP.

La ruta será lineal. Un mapa con caminos alternativos solo se implementará si sobra tiempo después del cierre de funcionalidades.

## Distribución del equipo

| Responsable | Área principal |
| --- | --- |
| Programador 1 | Integración, flujo general, builds web y repositorio |
| Programador 2 | Apuntar, potencia, lanzamiento, cámara y feedback |
| Programador 3 | Tablero, agujeros, física, detección y puntuación |
| Programador 4 | HUD, menús, recompensas y pantallas finales |
| Programador 5 | Rivales, modificadores, mejoras y contenido |

Los nombres pueden reemplazar estos números. Cada persona debe ser responsable de escenas diferentes para reducir conflictos.

## Arquitectura propuesta

Separar el proyecto en sistemas independientes:

- `Player`: apuntado, potencia y lanzamiento.
- `Tejo`: física y estado del proyectil.
- `Board`: agujeros, zonas de puntuación y detección de fallos.
- `DuelManager`: turnos, tejos restantes, objetivo y resultado.
- `RunManager`: rival actual, mejoras activas y progreso de la run.
- `UI`: HUD, selección de mejoras, menú y resultados.
- `Content`: datos de rivales y mejoras.

La comunicación debería hacerse mediante señales como `tejo_lanzado`, `lanzamiento_resuelto`, `puntos_obtenidos`, `duelo_terminado` y `mejora_elegida`.

## Calendario

| Fecha | Objetivo | Resultado obligatorio |
| --- | --- | --- |
| 8 de septiembre | Cerrar diseño y probar export web | Reglas escritas, responsabilidades y build vacía funcionando en navegador |
| 9 de septiembre | Construir sistemas fundamentales | Apuntado, potencia, lanzamiento, tablero y detección básica |
| 10 de septiembre | Primera vertical slice | Duelo completo de 5 tejos con puntuación, victoria y derrota |
| 11 de septiembre | Implementar estructura de run | Secuencia de rivales, progreso, HUD y pantallas entre duelos |
| 12 de septiembre | Añadir mejoras y modificadores | Cinco mejoras y cuatro rivales funcionales |
| 13 de septiembre | Feature complete | Run completa desde el menú hasta el jefe y la pantalla final |
| 14 de septiembre | Presentación y balance | Feedback audiovisual, ajustes físicos, dificultad y claridad visual |
| 15 de septiembre | Congelamiento y publicación | Sin funciones nuevas, QA completo y build subida a itch.io |
| 16 de septiembre | Margen de emergencia | Corregir únicamente bloqueos y entregar varias horas antes del cierre |

## 8 de septiembre

Trabajo conjunto inicial, máximo 45 minutos:

- Confirmar reglas, puntuaciones y nombres provisionales.
- Definir interfaces y señales entre sistemas.
- Crear tareas pequeñas en el repositorio.
- Probar inmediatamente una exportación HTML5.

Después:

- P1 define el flujo `Menu -> Duel -> Reward -> End`.
- P2 implementa `Aiming -> Power -> Release`.
- P3 crea un tablero gris con agujeros funcionales.
- P4 construye un HUD provisional.
- P5 define rivales, mejoras y sus valores en datos simples.

## 9 de septiembre

- P1 integra las escenas sin agregar contenido.
- P2 completa controles con mouse y barra espaciadora.
- P3 resuelve puntuación, caída fuera y tejo detenido.
- P4 muestra potencia, puntuación y lanzamientos restantes.
- P5 prepara modificadores y pruebas de balance.

Criterio del día: lanzar repetidamente sin reiniciar manualmente la escena.

## 10 de septiembre

Este es el primer hito crítico. Debe existir un duelo completo:

- Comienza con el objetivo visible.
- Permite exactamente 5 lanzamientos.
- Cada lanzamiento siempre termina.
- El resultado se contabiliza una sola vez.
- Se declara victoria o derrota.
- Puede reiniciarse.
- Funciona en navegador.

Si esto no está terminado, se pausa todo el trabajo de mejoras y personajes.

## 11 de septiembre

- Implementar `RunManager`.
- Encadenar los cuatro encuentros.
- Conservar mejoras durante la run.
- Crear pantalla de rival.
- Crear pantalla de recompensa.
- Crear victoria final y derrota.

Los rivales todavía pueden utilizar texto y retratos provisionales.

## 12 de septiembre

- Implementar las cinco mejoras del MVP.
- Implementar los cuatro modificadores de rivales.
- Comprobar que las mejoras se mantienen entre duelos.
- Comprobar que los modificadores no cambian permanentemente los valores base.
- Realizar una prueba completa en navegador.

## 13 de septiembre

Fecha límite absoluta para funcionalidades.

Criterios:

- La run puede terminarse sin usar el editor.
- No existen pantallas sin salida.
- Las mejoras aparecen aleatoriamente sin duplicarse.
- Los rivales aumentan claramente la dificultad.
- Reiniciar limpia completamente el estado anterior.
- La build web funciona con teclado y mouse.

Todo lo que no esté integrado al finalizar el día pasa a la lista de recortes.

## 14 de septiembre

Pulido de alto impacto:

- Sonido al lanzar, rebotar, puntuar y acertar la rana.
- Cámara lenta breve al acertar la rana.
- Indicadores claros del agujero y la puntuación obtenida.
- Animación sencilla de las barras.
- Diálogos cortos de presentación y derrota.
- Iluminación y materiales simples.
- Balance de potencia, rebote y tamaño de colisiones.

No se invertirá tiempo en modelos detallados. Un estilo consistente con primitivas 3D, colores cálidos y retratos 2D será suficiente.

## 15 de septiembre

Congelamiento total de funciones.

Pruebas obligatorias:

- Completar tres runs desde cero.
- Perder en cada tipo de duelo.
- Probar todas las mejoras.
- Probar reinicio después de victoria y derrota.
- Probar Chrome y Firefox.
- Probar distintas resoluciones.
- Verificar audio, controles y tiempos de carga.
- Subir una build privada a itch.io.
- Pedir a alguien externo que juegue sin instrucciones.
- Corregir solamente errores que impidan jugar o comprender el juego.

## 16 de septiembre

- Ejecutar una última run sobre la build publicada.
- Verificar página, descripción, controles y créditos.
- No actualizar Godot ni dependencias.
- No cambiar física ni balance salvo que exista un error crítico.
- Publicar varias horas antes del cierre.

## Reglas de equipo

- Reunión diaria de 10 minutos al comenzar.
- Integración diaria durante los últimos 30 minutos.
- Cambios pequeños y revisables.
- Una persona es responsable de aprobar integraciones.
- Nadie trabaja directamente sobre la misma escena que otra persona.
- Toda función debe probarse también en la build web.
- `main.tscn` debe tener un único responsable.
- Las ramas incompletas no se integran por presión de tiempo.

## Orden de recorte

Si el equipo se retrasa, eliminar en este orden:

1. Caminos alternativos entre rivales.
2. Retratos y diálogos adicionales.
3. Cámara lenta y efectos especiales.
4. Mejoras sexta en adelante.
5. Modificadores complejos.
6. Cuarto rival normal.

Nunca recortar:

- Lanzamiento.
- Puntuación.
- Resolución fiable de cada tejo.
- Victoria y derrota.
- Reinicio.
- Exportación web.

## Fuera del alcance inicial

- Rival lanzando físicamente.
- Movimiento del jugador.
- Modelos 3D detallados.
- Inventario complejo.
- Progresión permanente.
- Tienda y moneda.
- Historia extensa.
- Multijugador.
- Generación procedural compleja.

## Definición de terminado

El juego está terminado cuando una persona puede abrir la página, comprender los controles, completar o perder una run y volver a jugar sin intervención del equipo ni acceso al editor.
