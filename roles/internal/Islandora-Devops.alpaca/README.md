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

Path to alpaca app jar file:
```
alpaca_jar_path: "/opt/alpaca/islandora-alpaca-app/build/libs/islandora-alpaca-app-2.0.0-all.jar"
```

Alpaca user:
```
alpaca_user: {{ ansible_user }}
```

Alpaca group:
```
alpaca_group: {{ ansible_user }}
```

Alpaca log level:
```
alpaca_log_level: INFO
```

Triplestore namespace:
```
triplestore_namespace: islandora
```

Base URL to triplestore:
```
alpaca_triplestore_base_url: http://localhost:8080/bigdata
```

Base URL to various microservice instances:
```
alpaca_milliner_base_url: http://localhost:8000/milliner
alpaca_houdini_base_url: http://localhost:8000/houdini
alpaca_homarus_base_url: http://localhost:8000/homarus
alpaca_fits_base_url: http://localhost:8000/crayfits
alpaca_hypercube_base_url: http://localhost:8000/hypercube
```

Maximum number of times to retry a message:
```
alpaca_error_maxRedeliveries: 5
```

ActiveMQ connection settings:
```
alpaca_jms_baseUrl: tcp://localhost:61616
alpaca_jms_username:
alpaca_jms_password:
alpaca_jms_connections: 10
```

Custom HTTP timeout settings in milliseconds (-1 to leave as default):
```
alpaca_request_configurer_enabled: false
alpaca_request_configurer_request_timeout: -1
alpaca_request_configurer_connection_timeout: -1
alpaca_request_configurer_socket_timeout: -1
```

### Fcrepo indexer variables

Enable fcrepo indexer:
```
alpaca_fcrepo_enabled: true
```

Base URL of Milliner:
```
alpaca_fcrepo_milliner_baseUrl: "{{ alpaca_milliner_base_url }}"
```

Various topic/queues to expect messages for:

Indexing a node:
```
alpaca_fcrepo_node: queue:islandora-indexing-fcrepo-content
```

Deleting a resource:
```
alpaca_fcrepo_node_delete: queue:islandora-indexing-fcrepo-delete
```

Indexing a media:
```
alpaca_fcrepo_media: queue:islandora-indexing-fcrepo-media
```

Indexing an external content resource:
```
alpaca_fcrepo_external: queue:islandora-indexing-fcrepo-external
```

Configure default and maximum concurrent processes (-1 to leave as default):
```
alpaca_fcrepo_concurrent_consumers: -1
alpaca_fcrepo_max_consumers: -1
```

### Drupal Triplestore indexer

Enable triplestore indexer:
```
alpaca_triplestore_enabled: true
```

URL to triplestore Sparql endpoint:
```
alpaca_triplestore_baseUrl: "{{ alpaca_triplestore_base_url }}/namespace/{{ triplestore_namespace }}/sparql"
```

Various topic/queues for:

Indexing an object:
```
alpaca_triplestore_input_stream: queue:islandora-indexing-triplestore-index
```

Deleting an object:
```
alpaca_triplestore_delete_stream: queue:islandora-indexing-triplestore-delete
```

Configure default and maximum concurrent processes (-1 to leave as default):
```
alpaca_triplestore_concurrent_consumers: -1
alpaca_triplestore_max_consumers: -1
```

### Derivative services

The derivative services will start as many routes as you configure with the `alpaca_derivative_connectors` array

For example:

```
alpaca_derivative_connectors:
  - name: ocr
    enabled: true
    in_stream: queue:islandora-connector-ocr
    service_url: "{{ alpaca_hypercube_base_url }}"
    concurrent-consumers: -1
    max-consumers: -1
```

Where each element has the following keys:

```
name: ocr
```
A unique simple name

```
enabled: true
```
Whether the service is enabled to not

```
in_stream: queue:islandora-connector-ocr
```
The topic/queue to expect messages on

```
service_url: "{{ alpaca_hypercube_base_url }}"
```
The microservice URL to call to

```
concurrent-consumers: -1
max-consumers: -1
```
Configure default and maximum concurrent processes (-1 to leave as default)


## Example Playbook

    - hosts: webservers
      roles:
        - { role: islandora.alpaca }

## License

MIT