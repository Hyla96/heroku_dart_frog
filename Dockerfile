# Official Dart image: https://hub.docker.com/_/dart
# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.17)
FROM dart:latest AS build

WORKDIR /app

# Copy entire repo from the build machine to the image.
COPY . .

# Resolve app dependencies.
RUN dart pub get
RUN dart pub global activate dart_frog_cli

# Build the app.
RUN export PATH="$PATH":"$HOME/.pub-cache/bin" && dart_frog build

# Compile the app to a native executable.
RUN dart compile exe ./build/bin/server.dart -o ./build/bin/server

# Start server.
CMD ["./build/bin/server"]
