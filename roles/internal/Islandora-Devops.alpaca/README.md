# Ansible Role: Alpaca

An Ansible role that installs [Alpaca](https://github.com/Islandora-CLAW/Alpaca) in a Tomcat 8 servlet container on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

Install from source or from maven:
```
alpaca_from_source: no
```

Which version to install:
```
alpaca_version: main
```

Where to clone Alpaca to:
```
alpaca_clone_directory: /opt/alpaca
```

Karaf repo:
```
alpaca_karaf_repos:
  - mvn:ca.islandora.alpaca/islandora-karaf/LATEST/xml/features
```

Which features to install:
```
alpaca_features:
  - islandora-http-client
  - islandora-connector-broadcast
  - islandora-indexing-triplestore
  - islandora-indexing-fcrepo
```

Where Karaf is:
```
alpaca_karaf_dir: /opt/karaf
```

Where the Karaf configuration files are:
```
alpaca_karaf_etc_dir: "{{ alpaca_karaf_dir }}/etc"
```

Karaf user:
```
alpaca_karaf_user: karaf
```

Local path for maven repository:
```
alpaca_local_mvn_path: /opt/maven/repo
```

Configuration settings:
```
alpaca_settings:
  - pid: ca.islandora.alpaca.connector.broadcast
    settings:
      input.stream: activemq:queue:islandora-connector-broadcast
  - pid: ca.islandora.alpaca.indexing.triplestore
    settings:
      error.maxRedeliveries: 10
      input.stream: activemq:queue:islandora-indexing-triplestore
      triplestore.baseUrl: http://localhost:8080/bigdata/namespace/kb/sparql
```

## Dependencies

* Apache Karaf
  
## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.alpaca }

## License

MIT