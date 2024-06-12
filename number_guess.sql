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
  # If the username does --
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(22),
    games_played integer,
    best_guesses integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('mom', 2, 13);
INSERT INTO public.users VALUES ('callie', 1, 1);
INSERT INTO public.users VALUES ('andrew', 9, 6);
INSERT INTO public.users VALUES ('user_1718206663112', 2, 468);
INSERT INTO public.users VALUES ('user_1718207077514', 2, 494);
INSERT INTO public.users VALUES ('user_1718206663113', 5, 221);
INSERT INTO public.users VALUES ('user_1718207077515', 5, 29);
INSERT INTO public.users VALUES ('user_1718206736316', 2, 808);
INSERT INTO public.users VALUES ('user_1718206736317', 5, 242);
INSERT INTO public.users VALUES ('user_1718207116380', 2, 500);
INSERT INTO public.users VALUES ('user_1718206752907', 2, 14);
INSERT INTO public.users VALUES ('user_1718207116381', 5, 252);
INSERT INTO public.users VALUES ('user_1718206752908', 5, 249);
INSERT INTO public.users VALUES ('user_1718207128311', 0, 122);
INSERT INTO public.users VALUES ('user_1718206490934', 2, 341);
INSERT INTO public.users VALUES ('user_1718207128312', 0, 66);
INSERT INTO public.users VALUES ('user_1718206802577', 2, 337);
INSERT INTO public.users VALUES ('user_1718206490935', 5, 9);
INSERT INTO public.users VALUES ('user_1718206802578', 5, 443);
INSERT INTO public.users VALUES ('user_1718207144030', 2, 325);
INSERT INTO public.users VALUES ('user_1718206835935', 2, 212);
INSERT INTO public.users VALUES ('user_1718207144031', 5, 97);
INSERT INTO public.users VALUES ('user_1718206835936', 5, 10);
INSERT INTO public.users VALUES ('user_1718207389313', 2, 466);
INSERT INTO public.users VALUES ('user_1718207389314', 5, 59);
INSERT INTO public.users VALUES ('user_1718207415630', 2, 495);
INSERT INTO public.users VALUES ('user_1718207415631', 5, 79);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

not exist, insert the new user
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