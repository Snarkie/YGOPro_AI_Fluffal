# YGOPro_AI_Fluffal
YGOPro - AI - Fluffal v0.0.0.5.5 (Estable) by neftalimich

Español: 
El desarrollo de la IA tendrá diferentes etapas etapas:

1. Crear el script para que pueda realizar sus jugadas en condiciones normales.
	1. Init: Secuencia de jugadas. 80%
	2. Filter: Filtros y contadores para realizar las condiciones. 70%
	3. Cond: Condiciones y prioridades a la mano, al campo, al cementerio, descartar y desterrar. 70%
	4. Use: Condiciones para usar los efectos. 70%
	5. Target: Objetivos para la selección de cartas. 75%
	6. Chain: Cadenas (encadenar). 85%
	7. Summon: Condiciones para realizar la invocación. 70%
	8. Battle: Fase de batalla. 35%
2. Mejorar la fase de batalla heredada. 0%
3. Mejorar los scripts para que juegue contra las cartas Floodgate mas comunes. 0%
4. Crear script para que al azar realice jugadas arriesgadas en caso de que tenga desventaja. 5%
5. Crear distintas maneras de jugar contra decks que le generen debilidades. Ejemplo: Monarcas o Masked Hero. 0%

Cada etapa irá mejorando conforme se encuentren errores, deficiencias en su algoritmo o mejoras en general.
Se colocará junto a la versión si es estable o no.

Problemas conocidos:
- Siempre invoica monstruo con toy vendor. Faltan colocar las condiciones.
- Fluffal Sheep tiene varios problemas de realizar su juego en el tiempo correcto.
- A veces, invoca a Patchwork sin necesidad.
- Octo no elige los mejores objetivos para la mano, pero no está del todo mal.
- Kraken suele ser invocado muy seguido.
- Varrios problemas con el cambio de posición de batalla.
- Varios otros.

Método de instalación:

1. Descomprime el paquete. Revisa que contiene las carpeta ai, deck, pics (opcional).
2. Copia las carpetas en el directorio raiz de YGOPro 1.033.AI (dentro están las carpetas por defecto: ai, deck)
3. Te preguntará si deseas combinar las carpetas y/o sobrescribir los archivos, elige que sí.

Nota: comprueba que sobrescribes los archivos ai.lua y AIHelperFunctions2.lua y combinas las carpetas "ai" y "deck".
de lo contrario no funcionará.

Hitos:
1. Iniciar este proyecto
2. La v0.0.0.4.5 fue cuando realemnte empecé a entender la arquitectura.
3. La v0.0.0.5.5 fue la más grande y satisfactoria actualización.


Preguntas Frecuentes:
- ¿Eres el único en el proyecto?
R: Sí, aunque en algunas ocaciones Snarky me ayuda un poco.
- ¿Por qué la IA es tan mala?
R: Cuando sepas programar IA haces la tuya.
- ¿Por qué la AI Fluffal es mala?
R: No soy experto, poco a poco iré mejorándola, paciencia.
- ¿En qué etapa vas?
R: En el primer punto, pero aún falta pulir detalles.
- ¿Cuánto tiempo tardarás en sacar la versión 1.0?
R: Trabajo, tengo capacitación constante, tengo familia, amigos, pasatiempos, me es difícil saber cuando, pero cuando algo me gusta lo hago.
- ¿Puedo ayudarte?
R: Sí, pero con algunas condiciones: Saber programación estructurada, tener ganas y estudiar el tutorial de Snarky.
- ¿Qué necesito saber para programar IA de YGOPro?
R: Saber programación estructurada, aprender un poco de LUA, leer el tutorial de Snarky.
- ¿Quién te conoce? 
R: Mi familia, mis amigos, mis compañeros y toda la gente de mi alrededor.
- ¿Qué estudiate, en qué trabajas? 
R: Ingeniería en sistemas, soy programador Senior (4.5 años de experiencia)
- ¿Programas algún otro juego?
R: No, soy consultor de TI, programador Full Stack de diversos tipos de sistemas, pero no programo juegos.
- ¿Me enseñas a programar?
R: No tengo tiempo, pero puedo decirte la lista de lo que debes a aprender,
pero primero dime que te gusta más: Front End, Back End o ambos (Fullstack).


Atte: Neftalí Michelet.
