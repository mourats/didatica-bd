from users_crud import display_all_users, add_new_user,search_users,update_user,delete_user,create_table_user,close_connection

while(True):
    title = "Users management - Create, Read, Update & Delete"

    print('-' * len(title))
    print(title)
    print('-' * len(title))
    print('')
    print('Select the action that you need to perform')
    print('')
    print('0. Create table users')
    print('1. Display all users')
    print('2. Add new user')
    print('3. Search users')
    print('4. Update user')
    print('5. Delete user')
    print('6. Exit\n')
    choice = input("Enter your selection number: ")
    print('')

    if choice == 0:
        create_table_user()

    elif choice == 1:
        display_all_users()

    elif choice == 2:
        username = input("Username: ")
        email = input("Email: ")
        password = input("Password: ")

        user = (username,email,password)

        add_new_user(user)

    elif choice == 3:
        query = input("Enter your search term: ")

        search_users(query)
    elif choice == 4:
        user_id = input("Enter the user id: ")
        username = input("Username: ")
        email = input("Email: ")
        password = input("Password: ")

        user = (username,email,password,user_id)

        update_user(user)
    elif choice == 5:
        user_id = input("Enter the user id: ")

        delete_user(user_id)
    elif choice == 6:
        close_connection()
        exit()
    else:
        print("Invalid Selection. Please select a number that is between 0 and 6")