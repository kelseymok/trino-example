FROM ubuntu:18.04
RUN apt-get update && apt-get install -y wget default-jre

RUN wget https://repo1.maven.org/maven2/io/trino/trino-cli/364/trino-cli-364-executable.jar \
    && mv trino-cli-364-executable.jar /usr/local/bin/trino \
    && chmod +x /usr/local/bin/trino

#ENTRYPOINT ["trino"]
#ENTRYPOINT ["/bin/bash"]