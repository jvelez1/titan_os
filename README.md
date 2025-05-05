# **Setup Instructions**

### **Prerequisites**
1. **Ruby**: Ensure you have Ruby installed (version ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin23]).
2. **Rails**: Install Rails (`gem install rails`).
3. **PostgreSQL**: Install PostgreSQL (version 9.3 or higher).

---

### **Steps to Run the Application**

#### **1. Clone the Repository**
```bash
git clone https://github.com/jvelez1/titan_os
cd titan_os
```

#### **2. Install Dependencies**
Run the following command to install all required gems:
```bash
bundle install
```

#### **3. Configure the Database**
Ensure PostgreSQL is running and accessible. Update the environment variables or modify the `config/database.yml` file to match your PostgreSQL setup.

The default configuration uses the following environment variables:
- `TITAN_OS_DB_HOST` (default: `localhost`)
- `TITAN_OS_DB_PORT` (default: `5432`)
- `TITAN_OS_DB_USER` (default: `postgres`)
- `TITAN_OS_DB_PASSWORD` (default: `postgres`)
- `TITAN_OS_DB_NAME` (default: `titan_os_development`)

If you are using the default configuration, ensure that:
- A PostgreSQL user `postgres` exists with the password `postgres`.

To create the database, run:
```bash
rails db:create
```

#### **4. Run Database Migrations**
Run the following command to apply database migrations:
```bash
rails db:migrate
```

#### **5. Seed the Database**
Important step for testing the api
```bash
rails db:seed
```

#### **6. Start the Rails Server**
Run the following command to start the Rails server:
```bash
rails server
```

The application will be available at `http://localhost:3000`.

---

### **Running Tests**
Ensure the test database is set up by running:
```bash
rails db:test:prepare
```

To run the test suite, use the following command:
```bash
rspec
```

# Titan OS API Documentation

This README provides an overview of the available endpoints in the Titan OS application, along with their payloads and expected responses.

---

## **Endpoints**

### **Contents**

#### **1. List Contents**
- **Endpoint**: `GET /contents`
- **Description**: Fetches a list of contents based on the provided parameters.
- **Request Parameters**:
  - `country` (required): The country code (e.g., `es`, `gb`).
  - `type` (optional): The type of content (e.g., `movie`, `tv_show`, `episode`, `season`)
  - `query` (optional): A search query string.
- **Example Request**:
  ```bash
  GET /contents?country=US&type=movie&query=2001
  ```
- **Response**:
  ```json
  [
    {
      "id": 1,
      "title": "Action Movie 1",
      "type": "Movie",
      "year": "2001",
      "duration_in_seconds": 10500
    },
    {
      "id": 2,
      "title": "Action Movie 2",
      "type": "Movie",
      "year": "1993",
      "duration_in_seconds": 40000
    }
  ]
  ```

#### **2. Get Content Details**
- **Endpoint**: `GET /contents/:id`
- **Description**: Fetches details of a specific content by its ID.
- **Request Parameters**: None.
- **Example Request**:
  ```bash
  GET /contents/1
  ```
- **Response**:
  ```json
  {
     "id":22,
     "type":"ChannelProgram",
     "title":"SpongeBob",
     "year":null,
     "duration_in_seconds":null,
     "content_schedules":[
        {
           "start_time":"2024-03-11T08:00:00.000Z",
           "end_time":"2024-03-11T09:00:00.000Z"
        },
        {
           "start_time":"2024-03-11T09:00:00.000Z",
           "end_time":"2024-03-11T10:00:00.000Z"
        }
     ]
  }
  ```

---

### **Favorites**

#### **1. List Favorite Channel Programs**
- **Endpoint**: `GET /users/:user_id/favorites/channel_programs`
- **Description**: Fetches a list of the user's favorite channel programs, ordered by the time watched in descending order.
- **Request Parameters**: None.
- **Example Request**:
  ```bash
  GET /users/123/favorites/channel_programs
  ```
- **Response**:
  ```json
  [
     {
        "id":2,
        "time_watched_in_seconds":54555,
        "content":{
           "id":22,
           "type":"ChannelProgram",
           "title":"SpongeBob",
           "year":null,
           "duration_in_seconds":null
        }
     },
     {
        "id":1,
        "time_watched_in_seconds":3600,
        "content":{
           "id":25,
           "type":"ChannelProgram",
           "title":"News 24hr",
           "year":null,
           "duration_in_seconds":null
        }
     }
  ]
  ```

#### **2. List Favorite Apps**
- **Endpoint**: `GET /users/:user_id/favorites/apps`
- **Description**: Fetches a list of the user's favorite apps, ordered by their position.
- **Request Parameters**: None.
- **Example Request**:
  ```bash
  GET /users/123/favorites/apps
  ```
- **Response**:
  ```json
  [
     {
        "id":1,
        "position":1,
        "streaming_app":{
           "id":1,
           "name":"netflix"
        }
     },
     {
        "id":2,
        "position":2,
        "streaming_app":{
           "id":2,
           "name":"prime_video"
        }
     }
  ]
  ```

#### **3. Set Favorite App**
- **Endpoint**: `POST /users/:user_id/favorite_app`
- **Description**: Sets a streaming app as a favorite for the user.
- **Request Payload**:
  - `streaming_app_id` (required): The ID of the streaming app to be set as a favorite.
  - `position` (optional): The position of the app in the favorites list.
- **Example Request**:
  ```bash
  POST /users/123/favorite_app
  Content-Type: application/json

  {
    "streaming_app_id": 201,
    "position": 1
  }
  ```
- **Response**:
  ```json
  {
    "message": "Favorite app set successfully"
  }
  ```

## **Error Handling**

### **Common Errors**
- **404 Not Found**: Returned when a resource is not found.
  ```json
  {
    "error": "Record not found"
  }
  ```
- **422 Unprocessable Entity**: Returned when validation fails.
  ```json
  {
    "error": "Position must be greater than 0"
  }
  ```
- **500 Internal Server Error**: Returned when an unexpected error occurs.
  ```json
  {
    "error": "Internal server error"
  }
  ```
