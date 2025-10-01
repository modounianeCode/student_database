#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

cat courses_test.csv | while IFS="," read MAJOR COURSE
do
  if [[ $MAJOR != major ]]
  then
    # get major_id
    MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")

    # if not found
    if [[ -z $MAJOR_ID ]]
    then
      # insert major
      INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
      if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
       then
       echo Inserted into majors, $MAJOR
      fi
      # get new major_id
      MAJOR_ID=$($PSQL "select major_id from majors where major='$MAJOR'")

    fi

    # get course_id
     COURSE_ID=$($PSQL "select course_id from courses where course='$COURSE'")

    # if not found
      if [[ -z $COURSE_ID ]]
       then
    # insert course
     INSERT_COURSE_RESULT=$($PSQL "insert into courses(course) values ('$COURSE')")
    if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
     then
     echo "Inserted into courses, $COURSE"
    fi
    # get new course_id
      fi

    # insert into majors_courses

  fi
done
