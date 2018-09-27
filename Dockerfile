FROM openjdk:8

ARG server_zip=https://github.com/JanusGraph/janusgraph/releases/download/v0.3.0/janusgraph-0.3.0-hadoop2.zip

RUN apt-get update -y && apt-get install -y zip && \
    wget -nv -O /var/`basename ${server_zip}` ${server_zip} && \
    server_base=`basename ${server_zip} .zip` && \
    unzip -q /var/${server_base}.zip -d /var && \
    rm /var/${server_base}.zip && \
    ln -s /var/${server_base} /var/janusgraph && \
    groupadd -g 999 janusgraph && \
    useradd -r -u 999 -g janusgraph janusgraph && \
    chown -R janusgraph:janusgraph /var/${server_base} && \
    chmod 755 /var/${server_base} && \
    chown -R janusgraph:janusgraph /var/janusgraph && \
    chmod 755 /var/janusgraph

USER janusgraph

WORKDIR /var/janusgraph
