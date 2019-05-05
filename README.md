# nurseapp
backend APIs of application for task logging for nurses 

1.  Create the database schema and populate it based on the scripts in scripts folder.
    Databse name: nursing
    User: root
    Password: password
    Port: 3306
    For relations:
    Worklog: id, dept_name, facility_name, Date(), hours, shift, nurse_name
    (To log the tasks completed by a nurse in a given shift with number of hours to complete
    the task, at a given facility and department in it)
    Tasksassigned: id, taskname, status, facility_name, department_name, nurse_name
    (DB relation containing all the tasks allocated to all the nurses at any given facility, with
    the department to which the task belongs)

2. Node.js set up and APIs
    1) Run npm install, this will create the node_modules folder by fetching the packages in
    package.jsonRun node index.js
    2) To access the APIs, go to
    localhost:3000/login from Postman and provide username and password in
    x-www-form-urlencoded as:
    username:Jessica
    password:password_jessica
    (existing user in the database)
    Or raw data in the JSON format:
    3) From Postman to /nurses/getList/{username}/{dept_name} to get the list of all the
    tasks assigned to a nurse
    For example,
    /getList/Monica/trauma
    4) To log the tasks, go to /addItem. This will log the data in the worklog database.
    Provide following details in the body in x-www-form-urlencoded format:
    nurse_name:
    task_name:
    shift:
    dept-name:
    facility_name:
    Hours:
    5) To update the task status, use /updateItem and provide following data with the POST
    request from Postman
    task_name:
    status:
    nurse_name:

3) Session management:
    The API will be accessible if and only if you provide the username for the same user who
    has previously logged in by accessing /login API.
    Once the server has stopped and restarted, the API is no longer accessible to any user.
    You must access /login first to access all the other APIs. The sessions continues for a
    the last user who has logged in using /login API till the server stops. If another user tries
    to access other APIs with his username as “nurse_name” field, the message “not
    authorized” is displayed.
