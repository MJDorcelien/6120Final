import mysql.connector

def createDBConnection():
    try:
        db = mysql.connector.connect(
            host = 'localhost',
            user = 'root',
            password = 'abc123',
            database = '6120_project_2'
        )
        if db.is_connected():
            print("Connected to the MySQL database")
            return db
    except error as e:
        print("Error when connecting to the MySQL database", e)
        return None
    
def showStoredProcesses():
    print("implemented stored processes")

def showTrigers(db):
    print("\n showing triggers")
    cursor = db.cursor()
    try:
        query = "SELECT * FROM event_log"
        cursor.execute(query)
        rows = cursor.fetchall()
        if rows:
            for row in rows:
                print(row)
        else:
            print("No Log Entries")
    except mysql.connector.Error as err:
        print(f"An error occurred: {err}")
    finally:
        cursor.close()

def showViews(db):
    patient_id = input("\nEnter the patient id:\n")
    
    print("\nChoose an view you'd like to see")
    print("1. View Visit Details")
    choice = input("Enter your choice: ")

    cursor = db.cursor()
    if choice == '1':
        query = ("select * from view_visit_details where patient_id = %s")
        cursor.execute(query, (patient_id,))

def main():
    db = createDBConnection()
    if db is None:
        print("Could not establish connection")

    try:
        while True:
            print("\nMain Menu:")
            print("1. stored processes")
            print("2. triggers")
            print("3. views")
            print("4. end app")
            
            choice = input("Enter your choice: ")

            if choice == '1':
                cursor = db.cursor()
                try:
                    query = "SELECT * FROM patients"
                    cursor.execute(query)
                    rows = cursor.fetchall()
                    if rows:
                        for row in rows:
                            print(row)
                    else:
                        print("No Log Entries")
                except mysql.connector.Error as err:
                    print(f"An error occurred: {err}")
                finally:
                    cursor.close()

            elif choice == '2':
                showTrigers(db)

            elif choice == '3':
                showViews(db)

            elif choice == '4':
                print("Terminating the application")
                break
            
            else:
                print("Invalid choice. Please try again.")

    finally:
        if db is not None and db.is_connected():
            db.close()

if __name__ == "__main__":
    main()