const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'db',
  user: 'root',
  password: '1234',
  database: 'recycling_points'
});

// REGISTRO
app.post('/register', (req, res) => {
  const { usuario, password } = req.body;

  db.query(
    'INSERT INTO usuarios (usuario, password) VALUES (?, ?)',
    [usuario, password],
    (err, result) => {
      if (err) return res.status(500).send(err);
      res.send('Usuario registrado');
    }
  );
});

// LOGIN
app.post('/login', (req, res) => {
  const { usuario, password } = req.body;

  db.query(
    'SELECT * FROM usuarios WHERE usuario=? AND password=?',
    [usuario, password],
    (err, result) => {
      if (err) return res.status(500).send(err);

      if (result.length > 0) {
        res.send('Login correcto');
      } else {
        res.status(401).send('Datos incorrectos');
      }
    }
  );
});

app.listen(3000, () => {
  console.log('Backend corriendo en puerto 3000');
});