FROM centos:7.6.1810

ENV ISLANDORA_DISTRO="centos/7" \
    ANSIBLE_CONFIG=/root/playbook/ansible.cfg 

WORKDIR /root/playbook

RUN yum -y install epel-release && \
    yum -y install git openssl openssh-clients python-pip python-devel python

RUN pip install ansible==2.8.7

COPY entrypoint.sh /bin/

RUN chmod 700 /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh" ]
