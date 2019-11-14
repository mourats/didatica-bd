from mysql.connector import connect

connection = connect(host='127.0.0.1',database='STUDYBD',user='thiago',password='123456', auth_plugin='mysql_native_password')

print('Attempting to connect to the database...')
if connection.is_connected():
    print("Connection to the database established successfully")

def display_all_users():
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM users;")
    records = cursor.fetchall()

    heading = "Total registered users in the system: " + str(cursor.rowcount)
    print(heading)
    print ("-" * len(heading))
    for row in records:
        print("ID: " + str(row[0]))
        print("Username: " + row[1])
        print("Email: " + row[2])
        print("Created At: " + str(row[4]) + "\n")
    
    cursor.close()

def add_new_user(user):
    sql_stmt = """INSERT INTO users (username,email,password) VALUES (%s,%s,%s)"""
    
    cursor = connection.cursor(prepared=True)
    cursor.execute(sql_stmt,user)
    connection.commit()
    cursor.close()
    print("Record successfully inserted into the database using prepared stament")


def search_users(query):
    sql_stmt = "SELECT * FROM users WHERE username LIKE '%" + query + "%' OR email LIKE '%" + query + "%'"

    cursor = connection.cursor()
    cursor.execute(sql_stmt)
    records = cursor.fetchall()

    heading = "search for '" + query + "' returned: " + str(cursor.rowcount) + " rows"
    print(heading)
    print ("-" * len(heading))
    for row in records:
        print("ID: " + str(row[0]))
        print("Username: " + row[1])
        print("Email: " + row[2])
        print("Created At: " + str(row[4]) + "\n")
    
    cursor.close()


def update_user(user):
    sql_stmt = "UPDATE users SET updated_at = NOW(), username = %s,email = %s,password = %s WHERE id = %s"

    cursor = connection.cursor(prepared=True)
    cursor.execute(sql_stmt,user)
    connection.commit()
    cursor.close()
    print("Record successfully updated in the database using prepared stament")

def delete_user(id):
    sql_stmt = "DELETE FROM users WHERE id = " + str(id)
    cursor = connection.cursor()
    cursor.execute(sql_stmt)
    connection.commit()
    cursor.close()
    print("Record successfully deleted from the database using prepared stament")

def create_table_user():
    sql = "CREATE OR REPLACE TABLE users (id INT NOT NULL AUTO_INCREMENT, username VARCHAR(45) NULL, email VARCHAR(45) NULL, password VARCHAR(45) NULL, created_at DATETIME NULL, updated_at DATETIME NULL, PRIMARY KEY (id));"
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()
    print ("Table users created successfully")

def close_connection():
    connection.close()
    print("MySQL connection is closed")