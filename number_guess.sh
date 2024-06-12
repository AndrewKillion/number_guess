#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

NUMBER=$((1 + $RANDOM %1000 ))

echo -e "Enter your username:"
read USERNAME

if [[ $USERNAME == $($PSQL "SELECT username FROM users WHERE username = '$USERNAME'") ]]
then
  # Retrieve the games played and best game for the user
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_guesses FROM users WHERE username = '$USERNAME'")
  
  # Welcome the returning user
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  # If the username does not exist, insert the new user
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW=$($PSQL "INSERT INTO users (username, games_played, best_guesses) VALUES ('$USERNAME', 0, 1001)")
fi

GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
GAME_COUNT=$((GAMES_PLAYED + 1))


UPDATE_GAMES=$($PSQL "UPDATE users SET games_played = $GAME_COUNT WHERE username = '$USERNAME'")


echo -e "Guess the secret number between 1 and 1000:"
read GUESS

while [[ ! $GUESS =~ ^[0-9]+$ ]] 
do
  echo "That is not an integer, guess again:"
  read GUESS
done

COUNTER=1
while [[ $GUESS != $NUMBER ]]
do
  ((COUNTER++))
  if [[ $GUESS > $NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else 
    echo "It's higher than that, guess again:"
  fi
  read GUESS
done

echo -e "You guessed it in $COUNTER tries. The secret number was $NUMBER. Nice job!"

BEST_GUESS=$($PSQL "SELECT best_guesses FROM users WHERE username = '$USERNAME'")

if [[ $COUNTER -lt $BEST_GUESS ]]
then
  UPDATE_COUNTER=$($PSQL "UPDATE users SET best_guesses = $COUNTER WHERE username = '$USERNAME'")
fi