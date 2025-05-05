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
    except Error as e:
        print("Error when connecting to the MySQL database", e)
        return None
    
def showStoredProcesses():
    print("implemented stored processes")

def showTrigers():
    print("implement triggers")

def showViews():
    print("implement views")

if __name__ == "__main__":
    main()

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
                
                main_choice = input("Enter your choice: ")

                if main_choice == '1':
                    print("implement stored processes")

                elif main_choice == '2':
                    print("implement triggers")

                elif main_choice == '3':
                    print("implement views")

                elif main_choice == '4':
                    print("Terminating the application")
                    break
                
                else:
                    print("Invalid choice. Please try again.")

        finally:
            if db is not None and db.is_connected():
                db.close()