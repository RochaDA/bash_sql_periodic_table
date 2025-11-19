#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PTABLE_LOOKUP(){
  # Look up logic here
  # Store element input
  ELEMENT_INPUT=$1
  if [[  -z $ELEMENT_INPUT  ]]
    then
      echo Please provide an element as an argument.
      exit 0
    else
    # Check if it is an atomic number, symbol or name
    if [[ $ELEMENT_INPUT =~ ^[0-9]+$ ]]
      then
        IFS="|" read -r -a ELEMENT_INFO <<< "$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number = $ELEMENT_INPUT")"
      
    # Check if it is the element symbol
    elif [[ $ELEMENT_INPUT =~ ^[A-Z][a-z]?$ ]]
      then
        IFS="|" read -r -a ELEMENT_INFO <<< "$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE symbol = '$ELEMENT_INPUT'")"
        
    else
      # Check if it is an element's name present in the database
      IFS="|" read -r -a ELEMENT_INFO <<< "$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE name = '$ELEMENT_INPUT'")"
    fi

    # Check if valis input
    if [[ -z ${ELEMENT_INFO[0]} ]]
      then
        echo -e "I could not find that element in the database."
        exit 0
    fi

    # If it's in the database, fetch properties and type
    IFS="|" read -r -a ELEMENT_PROPERTIES <<< "$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number = ${ELEMENT_INFO[0]}")"
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = ${ELEMENT_PROPERTIES[3]}")
    # Output with format
    echo -e "The element with atomic number ${ELEMENT_INFO[0]} is ${ELEMENT_INFO[2]} (${ELEMENT_INFO[1]}). It's a $TYPE, with a mass of ${ELEMENT_PROPERTIES[0]} amu. ${ELEMENT_INFO[2]} has a melting point of ${ELEMENT_PROPERTIES[1]} celsius and a boiling point of ${ELEMENT_PROPERTIES[2]} celsius."
  fi
}
PTABLE_LOOKUP $1