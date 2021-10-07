# Ansible Role: Blazegraph [![Build Status](https://travis-ci.org/Islandora-Devops/ansible-role-blazegraph.svg?branch=main)](https://travis-ci.org/Islandora-Devops/ansible-role-blazegraph)

An Ansible role that installs [Blazegraph](https://www.blazegraph.com/) in a Karaf container on:

* Centos/RHEL 7.x
* Ubuntu Xenial

## Role Variables

Available variables are listed below, along with default values:

```
# Blazegraph version
blazegraph_version: 2.1.4
# User to install with
blazegraph_user: tomcat
# Where to install to
blazegraph_home_dir: /opt/blazegraph
# Servlet container home directory
blazegraph_tomcat_home: /var/lib/tomcat9
# Path to install the WAR to
blazegraph_war_path: "{{ blazegraph_tomcat_home }}/webapps/bigdata.war"
# Log4J template file
blazegraph_log4j_template: log4j.properties
# Log directory
blazegraph_log_dir: /var/log/tomcat9/blazegraph
# Path to install the log4k settings to
blazegraph_log4j_path: "{{ blazegraph_tomcat_home }}/webapps/bigdata/WEB-INF/classes/log4j.properties"
```

There are additional configuration options available and documented in [defaults/main.yml](defaults/main.yml)

## Dependencies

This expects an Apache Tomcat container to install into. 

This role should also handle a notification "restart tomcat9". 

We recommend the following:
* Islandora-Devops.tomcat9
     * [Github](https://github.com/Islandora-Devops/ansible-role-tomcat9)
     * [Galaxy](https://galaxy.ansible.com/Islandora-Devops/tomcat9/)
  
In order for blazegraph to find its configuration files you have two options: 
* Specify it in the blazegraph web.xml file:
  * This can be done automatically the role be specifying `blazegraph_webxml_template: yes` (default)
* Set the blazegraph options in your `JAVA_OPTS` environment variable. How to do this depends on the role. An example using Islandora-Devops.tomcat9 can be found [here](tests/java_opts.yml).

## Example Playbook

There are two examples depending how the configuration infomration is passed to blazegraph: 
* [Using JAVA_OPTS](tests/java_opts.yml)
* [Using web.xml](tests/web_xml.yml)

## License

MIT
