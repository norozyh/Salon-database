#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nSelect the SALON services you want"
  echo -e "\n"
  echo "1) Hair"
  echo "2) Face"
  echo "3) Body"
  echo "4) EXIT"

  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) SERVICE 1;;
    2) SERVICE 2;;
    3) SERVICE 3;;
    4) EXIT;;
    *) MAIN_MENU "We dont have the service you want";;
  esac
  
}

SERVICE(){
  #input phone
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  echo $CUSTOMER_ID
  # if customer_id not found
  if [[ -z $CUSTOMER_ID ]]
  then
    # input customer name
    echo -e "\nWe dont have this number, please insert your name"
    
    read CUSTOMER_NAME
    # insert customer info
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE');")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id=$CUSTOMER_ID;")
  fi
  echo -e "\nGive a time you want"
  read SERVICE_TIME
  INSERT_NEW_APPOINTMENT=$($PSQL "INSERT INTO appointments(time,customer_id,service_id) VALUES('$SERVICE_TIME',$CUSTOMER_ID,$SERVICE_ID_SELECTED);")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
  echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."


  

}
FACE_SERVICE(){
  echo FACE
}
BODY_SERVICE(){
  echo BODY
}
EXIT(){
  echo Thank you
}
MAIN_MENU