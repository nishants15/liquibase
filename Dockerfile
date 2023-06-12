FROM jenkins/jenkins:latest

USER root

# Install Liquibase
ENV LIQUIBASE_VERSION=4.12.0
ENV LIQUIBASE_URL=https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip
RUN curl -L -o liquibase.zip ${LIQUIBASE_URL} && \
    unzip liquibase.zip && \
    rm liquibase.zip && \
    chmod +x liquibase && \
    mv liquibase /usr/local/bin/

# Install Snowflake JDBC driver
ENV SNOWFLAKE_JDBC_VERSION=3.15.1
ENV SNOWFLAKE_JDBC_URL=https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar
RUN curl -L -o snowflake-jdbc.jar ${SNOWFLAKE_JDBC_URL} && \
    mv snowflake-jdbc.jar /usr/local/bin/

USER jenkins
