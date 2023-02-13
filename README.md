# Assignment 03
Sometimes, after you design a database, you need to change its structure. Unfortunately, changes aren’t correct every time, so they must be reverted. Your task is to create a versioning mechanism that allows you to easily switch between database versions.

Write SQL scripts that:
- modify the type of a column;
- add / remove a column;
- add / remove a DEFAULT constraint;
- add / remove a primary key;
- add / remove a candidate key;
- add / remove a foreign key;
- create / drop a table.

For each of the scripts above, write another one that reverts the operation. Place each script in a stored procedure. Use a simple, intuitive naming convention. Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number. Write a stored procedure that receives as a parameter a version number and brings the database to that version.
