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

# Install vcpkg package manager
WORKDIR /home
RUN git clone https://github.com/microsoft/vcpkg && \
    # VCPKG commit that install protobuf 3.21.12
    cd vcpkg && git checkout 8150939b69720adc475461978e07c2d2bf5fb76e && \
    cd .. && vcpkg/bootstrap-vcpkg.sh

# Install vcpkg packages
RUN ./vcpkg/vcpkg install boost-asio && \
    ./vcpkg/vcpkg install boost-thread

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

# Set exposed ports
EXPOSE 5100

# Run the app
ENTRYPOINT ["./server-tcp"]
