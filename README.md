# fudo-app
fudo challenge

## Setup Instructions for Linux

This is a Ruby Rack application that can be run either locally or using Docker.

### Prerequisites

- Git (for cloning the repository)
- For local setup: Ruby 3.2+, Bundler
- For Docker setup: Docker and Docker Compose (optional)

### Case 1: Running Locally on Linux

1. **Install Ruby 3.2+ and dependencies:**
   ```bash
   # On Ubuntu/Debian
   sudo apt update
   sudo apt install ruby-dev build-essential sqlite3 libsqlite3-dev

   ```

2. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd fudo-app
   ```

3. **Install Ruby dependencies:**
   ```bash
   gem install bundler
   bundle install
   ```

4. **Start the application:**
   ```bash
   bundle exec rackup -p 3001
   ```

   The application will be available at: `http://localhost:3001`

### Case 2: Running with Docker on Linux

1. **Install Docker:**
   ```bash
   # On Ubuntu/Debian
   sudo apt update
   sudo apt install docker.io docker-compose
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -aG docker $USER
   
   # Log out and log back in for group changes to take effect
   ```

2. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd fudo-app
   ```

3. **Build and run with Docker:**
   ```bash
   # Build the Docker image
   docker build -t fudo-app .
   
   # Run the container
   docker run -d \
     --name fudo-app-container \
     -p 3001:3001 \
     -v $(pwd)/db:/app/db \
     fudo-app
   ```

   **Alternative: Using docker-compose (if you have a docker-compose.yml):**
   ```bash
   docker-compose up -d
   ```

4. **Check if the container is running:**
   ```bash
   docker ps
   ```

   The application will be available at: `http://localhost:3001`

### Useful Docker Commands

- **View logs:** `docker logs fudo-app-container`
- **Stop container:** `docker stop fudo-app-container`
- **Start container:** `docker start fudo-app-container`
- **Remove container:** `docker rm fudo-app-container`
- **Enter container shell:** `docker exec -it fudo-app-container /bin/bash`

### Troubleshooting

- **Port already in use:** Change the port by modifying the `-p` flag (e.g., `-p 3002:3001`)
- **Permission issues:** Ensure your user is in the docker group or use `sudo` with Docker commands
- **Database persistence:** The database is stored in the `db/` directory and persisted using Docker volumes
