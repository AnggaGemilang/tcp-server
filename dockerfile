# Use base image (Ubuntu 22.04) as BUILD STAGE
FROM ubuntu:22.04 as build

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    ca-certificates \
    wget \
    tar \
    curl \
    zip \
    pkg-config \
    autoconf \
    python3 \
    flex \
    bison \
    git \
    build-essential \
    cmake \
    ninja-build \
    g++ \
    gcc \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy OpenDDS
RUN wget https://docs.len-iot.id/s/9jykng8dNBA6STM/download/OpenDDS-3.26.1.zip && \
    unzip OpenDDS-3.26.1.zip && mv OpenDDS-3.26.1 opendds && mv opendds /home/

# Install vcpkg packages
RUN ./vcpkg/vcpkg install boost-asio

# Copy files from local directory to container
COPY ./src /home/project/src
COPY ./docker/CMakeLists.txt /home/project/CMakeLists.txt

# Build project
RUN cmake --no-warn-unused-cli \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_TOOLCHAIN_FILE:STRING=/home/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
    -DCMAKE_C_COMPILER:FILEPATH=/usr/bin/gcc \
    -DCMAKE_CXX_COMPILER:FILEPATH=/usr/bin/g++ \
    "-S/home/project" "-B/home/project/build" -G "Unix Makefiles" \
    && cmake --build "/home/project/build" --config Release --target all -j 18 --

# Start a new stage, this stage will run programs from the build stage
FROM ubuntu:22.04

# Define working directory from container
WORKDIR /home/project/build

# Copy files from the build stage
COPY --from=build /home/project/build /home/project/build
COPY --from=build /home/project/rtps.ini /home/project/rtps.ini

# Set exposed ports
EXPOSE 5100

# Run the app
ENTRYPOINT ["./waw-server-tcp"]
