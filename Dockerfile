FROM ubuntu:24.10 AS build-qt

# Set non-interactive installs for apt.
ENV DEBIAN_FRONTEND=noninteractive

# Set bash as default shell.
SHELL [ "bash", "-c" ]

# Install dependencies.
RUN apt update \
    && apt satisfy -y "cmake (>= 3.21.1), perl (>= 5.14)" \
    && apt install -y \
    git \
    ninja-build \
    gcc \
    g++ \
    python3-dev \
    libfontconfig1-dev \
    libgl-dev \
    && apt autoremove \
    && apt clean

# Get QT6 source code.
RUN git clone https://code.qt.io/qt/qt5.git ~/qt-src \
    && cd ~/qt-src \
    && git switch 6.8 \
    && mkdir ~/{qt-build,qt-bin} \
    && cd ~/qt-build \
    && ~/qt-src/configure -prefix ~/qt-bin -skip qtwebengine,qtsensors -init-submodules

# Build QT6 binaries/libraries.
RUN cd ~/qt-build \
    && cmake --build . --parallel $(nproc) \
    && cmake --install .

# Get MuseScore source code.
RUN git clone https://github.com/codeblessing/MuseScore.git ~/ms-src

WORKDIR /root/ms-src
