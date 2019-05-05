const express = require("express"),
  bodyParser = require("body-parser"),
  app = express(),
  port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

var mysql = require("mysql");

//creating and configuring session variable

var expressSession = require("express-session");
var sessionConfig = expressSession({
  secret: "carpe diem",
  resave: true,
  saveUninitialized: false
});

app.use(sessionConfig);

//defining sql connection, running on localhost port 3306
var mysqlConnection;
mysqlConnection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "nursing",
  multipleStatements: "true"
});

//connecting to mysql database

mysqlConnection.connect(function(err) {
  if (err) {
    console.error("error connecting: " + err.stack);
    return;
  }

  console.log("connected as id " + mysqlConnection.threadId);
});

/*
Function that authorizes the user based on the unique session key.
Every time a new user logs in, only that user can access /updateItem, /getList and /addItem APIS
attempted access by any other user will result in a "Not Authorized" response.
*/

var authorize = (req, res, next) => {

  console.log(req.query.username);
  if (req.session.identity) {
    if (
      req.session.identity === req.params.username ||
      req.session.identity === req.body.nurse_name ||
      req.session.identity === req.query.username
    )
      next();
    else res.status(401).end("Not Authorized.");
  } else res.status(401).end("Not Authorized.");
};

/*
API to fetch the list of all the assigned tasks to the given user.
A user can only access their own tasks. this is ensured by the session id that's unique to the user
*/

app.get("/nurse/getList/:username/:dept", authorize, function(req, res) {

  console.log(req.query);
  let query =
    "SELECT * FROM tasksassigned WHERE nurse_name = ? AND dept_name= ?";

  mysqlConnection.query(query, [req.params.username, req.params.dept], function(
    error,
    results,
    fields
  ) {
    if (error) throw err;
    else res.send(results);
  });
});

app.get('/nurse/getList', authorize, function(req, res) {

  console.log(req.query.username);
  console.log(req.query.dept);
  let query =
    "SELECT * FROM tasksassigned WHERE nurse_name = ? AND dept_name= ?";

  mysqlConnection.query(query, [req.query.username, req.query.dept], function(
    error,
    results,
    fields
  ) {
    if (error) throw err;
    else res.send(results);
  });
});

/*API to login the user. Here, the unique session key is generated*/ 

app.post("/login", function(req, res) {


  let query = "SELECT * FROM nurses WHERE nurse_name = ?";

  mysqlConnection.query(query, [req.body.username], function(
    error,
    results,
    fields
  ) {
    if (error) {
      console.log(error);
      res.err("login failed!");
    } else {
      let user = results[0];
      if (user.password === req.body.password) {
        req.session.regenerate(() => {
          req.session.identity = user.nurse_name;

          res.json({
            ok: true
          });
        });
      } else {
        res.err("login failed!");
      }
    }
  });
});

/** API to let the user add items into the work log. This includes the tasks performed by them
 * in a given shift, with number of hours logged and today's Date
 * 
*/

app.post("/nurse/addItem", authorize, (req, res) => {

//function to log today's date
//to get Date in proper MySQL format
    var date;
    date = new Date();
    date = date.getUTCFullYear() + '-' +
        ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' +
        ('00' + date.getUTCDate()).slice(-2) + ' ' + 
        ('00' + date.getUTCHours()).slice(-2) + ':' + 
        ('00' + date.getUTCMinutes()).slice(-2) + ':' + 
        ('00' + date.getUTCSeconds()).slice(-2);
    console.log(date);
  

  let query = "INSERT INTO worklog(nurse_name, dept_name, date, hours, task_name,shift,facility_name) VALUES (?,?,?,?,?,?,?)";
  let taskname = req.body.task_name;
  let shift = req.body.shift;
  let hours = req.body.hours;
  let dept_name = req.body.dept_name;
  let facility_name = req.body.facility_name;
  let nurse_name = req.session.identity;
  //let date = req.body.date;

  if (
    taskname == "" ||
    taskname == null ||
    hours == "" ||
    hours == null ||
    dept_name == "" ||
    dept_name == null ||
    facility_name == "" ||
    facility_name == null || shift == null || shift == ""
  ) {
    res.status(400).end("Bad Request.");
  } else {
    mysqlConnection.query(
      query,
      [nurse_name, dept_name, date, hours, taskname, shift, facility_name],
      function(error, results, fields) {
        if (error) {
          console.log(error);
          res.status(500).end("Unable to log task");
        } else {
            res.status(201).end("Task logged");
        }
      }
    );
  }
});


/**
 * API to update the status of the current tasks, assigned to nurses
 * Only a logged-in nurse can update the status for now.
 */


app.post("/nurse/updateItem",authorize, (req,res)=>{
    console.log('Inside Update Items');
    let query = "UPDATE tasksassigned SET status= ? WHERE taskname= ? AND nurse_name= ?";
    let taskname = req.body.task_name;
    let status = req.body.status;
    let nurse_name = req.session.identity;

    if(taskname=="" || taskname==null || status=="null" || status=="")
    {
        res.status(400).end("Bad Request.");
    }
    else{
        mysqlConnection.query(
            query,
            [status,taskname, nurse_name],
            function(error, results, fields) {
                if(error){
                    console.log(error)
                } else{
                    if(results.changedRows==0)
                    {
                        console.log('Unaffected');
                        res.status(400).end("Bad Request");
                    }
                    //console.log(results);
                    res.status(201).end("Record Updated");
                    
                }
            });

    }
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
