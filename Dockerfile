FROM jenkins/jenkins:latest

USER root

# Install Liquibase
RUN curl -L -o liquibase.tar.gz https://github.com/liquibase/liquibase/releases/download/v4.5.0/liquibase-4.5.0.tar.gz && \
    tar -xzf liquibase.tar.gz && \
    rm liquibase.tar.gz && \
    mkdir -p /opt/liquibase && \
    mv liquibase /opt/liquibase && \
    chmod +x /opt/liquibase/liquibase && \
    ln -s /opt/liquibase/liquibase /usr/local/bin/

# Install Snowflake JDBC driver
RUN mkdir -p /opt/liquibase/lib/ && \
    curl -L -o snowflake-jdbc.jar https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.13.1/snowflake-jdbc-3.13.1.jar && \
    mv snowflake-jdbc.jar /opt/liquibase/lib/

# Install Liquibase JDBC driver
RUN curl -L -o liquibase-jdbc.jar https://repo1.maven.org/maven2/org/liquibase/liquibase-core/4.5.0/liquibase-core-4.5.0.jar && \
    mv liquibase-jdbc.jar /opt/liquibase/lib/

# Add picocli dependency
RUN curl -L -o picocli.jar https://repo1.maven.org/maven2/info/picocli/picocli/4.6.1/picocli-4.6.1.jar && \
    mv picocli.jar /opt/liquibase/lib/

USER jenkins
