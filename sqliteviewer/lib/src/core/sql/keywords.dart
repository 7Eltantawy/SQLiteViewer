import 'package:flutter/material.dart';

Color defaultKwyWordColor = Colors.deepOrange;
Map<String, Color> sqlLangKeyWordMap = {
  // Data Definition Language (DDL) keywords
  'CREATE': defaultKwyWordColor,
  'ALTER': defaultKwyWordColor,
  'DROP': defaultKwyWordColor,
  'TABLE': defaultKwyWordColor,
  'INDEX': defaultKwyWordColor,
  'VIEW': defaultKwyWordColor,

  // Data Manipulation Language (DML) keywords
  'SELECT': defaultKwyWordColor,
  'INSERT': defaultKwyWordColor,
  'UPDATE': defaultKwyWordColor,
  'DELETE': defaultKwyWordColor,
  'FROM': defaultKwyWordColor,
  'WHERE': defaultKwyWordColor,
  'SET': defaultKwyWordColor,

  // Data Control Language (DCL) keywords
  'GRANT': defaultKwyWordColor,
  'REVOKE': defaultKwyWordColor,
  'AUTHORIZATION': defaultKwyWordColor,

  // Transaction Control Language (TCL) keywords
  'BEGIN': defaultKwyWordColor,
  'COMMIT': defaultKwyWordColor,
  'ROLLBACK': defaultKwyWordColor,
  'SAVEPOINT': defaultKwyWordColor,
  'RELEASE': defaultKwyWordColor,

  // Other keywords
  'AND': defaultKwyWordColor,
  'OR': defaultKwyWordColor,
  'NOT': defaultKwyWordColor,
  'NULL': defaultKwyWordColor,
  'ORDER': defaultKwyWordColor,
  'BY': defaultKwyWordColor,
  'GROUP': defaultKwyWordColor,
  'HAVING': defaultKwyWordColor,
  'JOIN': defaultKwyWordColor,
  'INNER': defaultKwyWordColor,
  'OUTER': defaultKwyWordColor,
  'LEFT': defaultKwyWordColor,
  'RIGHT': defaultKwyWordColor,
  'ON': defaultKwyWordColor,
  'DISTINCT': defaultKwyWordColor,
  'AS': defaultKwyWordColor,
  'CASE': defaultKwyWordColor,
  'WHEN': defaultKwyWordColor,
  'THEN': defaultKwyWordColor,
  'ELSE': defaultKwyWordColor,
  'END': defaultKwyWordColor,
};
