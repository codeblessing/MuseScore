FROM ubuntu:24.10 as dev

# Install required tools and dependencies.
RUN \
apt update && \
apt install \
git \
cmake \
g++ \
libasound2-dev \
libfreetype6 \
libfreetype6-dev \
libsndfile1-dev \
libssl-dev \
libportmidi-dev \
libpulse-dev \
portaudio19-dev \
libgl1-mesa-dev \
libxkbcommon-dev \
libsndfile1-dev \
# Qt libraries & tools
qt6-base-dev \
qt6-base-private-dev \
qt6-declarative-dev  \
qt6-l10n-tools \
qt6-scxml-dev  \
qt6-tools-dev  \
qt6-tools-dev-tools \
qml6-module-qtqml-statemachine  \
libqt6core5compat6-dev  \
libqt6networkauth6-dev  \
libqt6statemachine6  \
libqt6svg6-dev  \
linguist-qt6 && \
apt upgrade && \
apt autoremove && \
apt clean

RUN mkdir /development

COPY . /development

WORKDIR /development

RUN ./build.cmake