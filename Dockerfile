FROM ruby:3.2
WORKDIR /app

# Install system dependencies for SQLite
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Create directory for database and ensure proper permissions
RUN mkdir -p db && chmod 755 db

# Create a volume for database persistence
VOLUME ["/app/db"]

EXPOSE 3001

# Use config.ru as the proper entry point for Rack applications
CMD ["rackup", "config.ru", "--host", "0.0.0.0", "--port", "3001"]