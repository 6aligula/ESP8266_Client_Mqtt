# Imagen para compilar el firmware ESP8266 (no sube a la placa: Docker en Mac no ve el USB)
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates python3 \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/usr/local/bin sh -s 1.1.1 \
 && arduino-cli config init \
 && arduino-cli config add board_manager.additional_urls https://arduino.esp8266.com/stable/package_esp8266com_index.json \
 && arduino-cli core update-index \
 && arduino-cli core install esp8266:esp8266@3.1.2 \
 && arduino-cli lib install PubSubClient@2.8.0
WORKDIR /sketch/ESP8266_Client_Mqtt
CMD ["arduino-cli", "compile", "-b", "esp8266:esp8266:generic", "--output-dir", "build", "."]
