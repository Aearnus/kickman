SFML=/home/tyler/packages/kickman-hs/extra-libs/SFML-2.3.2

cmake -DSFML_ROOT="$SFML" -DSFML_INCLUDE_DIR="$SFML/include" -DCMAKE_MODULE_PATH="$SFML/cmake/Modules" .
