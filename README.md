# Campus Bulletin Board Mobile App with .NET Backend

## Introduction

This project is a Campus Bulletin Board mobile app designed to facilitate communication within a campus. The backend is powered by .NET and Docker, while the frontend is built with Flutter. This README provides instructions on how to set up, run, and deploy the project.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Backend Requirements**:
  - [.NET 6 SDK](https://dotnet.microsoft.com/download/dotnet/6.0)
  - [Docker](https://www.docker.com/products/docker-desktop)

- **App Requirements**:
  - [Flutter SDK](https://flutter.dev/docs/get-started/install)
  - [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter extension
## Setup

### Backend Setup

1. **Download the Backend Code**:
   Clone the repository containing the backend code.
   ```bash
   https://github.com/Amanuel94/campus-bulletin-board-api
   cd campus-bulletin-board-api-main
   ```

2. **Install Docker**:
   Follow the instructions on the [Docker website](https://www.docker.com/products/docker-desktop) to install Docker on your machine.

3. **Install MongoDB and RabbitMQ Images**:
   Pull the MongoDB and RabbitMQ Docker images.
   ```bash
   docker pull mongo
   docker pull rabbitmq
   ```

4. **Run Docker Compose**:
   Navigate to the backend root folder and run the following command to start the containers in detached mode.
   ```bash
   sudo docker-compose up -d
   ```

5. **Run the .NET Services**:
   Open a terminal and navigate to each service folder (UserService, ClassroomService, NoticeService) and run:
   ```bash
   dotnet run
   ```

### Frontend Setup

1. **Download the App Code**:
   Clone the repository containing the frontend code.
   ```bash
   cd campus-bulletin-board-main
   ```

2. **Install Flutter Dependencies**:
   Navigate to the frontend folder and install the required dependencies.
   ```bash
   flutter pub get
   ```

## Running the Project

### Running the Backend

1. Ensure Docker is running and the containers are up.
2. Run each of the .NET services:
   - Navigate to the Board.User.Service/src folder and run `dotnet run`
   - Navigate to the Board.ClassroomService/src folder and run `dotnet run`
   - Navigate to the Board.NoticeService/src folder and run `dotnet run`

### Running the App

1. Ensure you have an emulator or physical device connected.
2. Navigate to the frontend folder.
3. Run the Flutter application.
   ```bash
   flutter run
   ```
