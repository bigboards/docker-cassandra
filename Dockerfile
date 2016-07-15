FROM bigboards/java-8-__arch__

MAINTAINER bigboards (hello@bigboards.io)

ENV CASSANDRA_VERSION 3.7.0
ENV CASSANDRA_PREFIX /opt/cassandra
ENV CASSANDRA_HOME /opt/cassandra
ENV CASSANDRA_CONF_DIR /opt/cassandra/conf

# explicitly set user/group IDs
RUN groupadd -r cassandra --gid=998 && useradd -r -g cassandra --uid=998 cassandra

# hadoop
RUN set -x \
    && curl -s http://www-us.apache.org/dist/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz | tar -xz -C /opt \
    && ln -s /opt/apache-cassandra-3.7 /opt/apache-cassandra \
    && ln -s /opt/apache-cassandra-3.7 /opt/cassandra

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160
#CMD ["cassandra", "-f"]
CMD ["/bin/bash"]
