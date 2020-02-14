FROM centos:7.6.1810

ENV container docker

COPY sestatus /bin/

RUN chmod 700 /bin/sestatus

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install \
	--setopt=tsflags=nodocs \
	--disableplugin=fastestmirror \
	openssh-clients \
	openssh-server \
	openssl \
	sudo \
	initscripts

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
	chmod 0700 /root/.ssh


# Add the keys and set permissions
RUN cat /dev/zero | ssh-keygen -q -N "" && \
	chmod 600 /root/.ssh/id_rsa && \
	chmod 600 /root/.ssh/id_rsa.pub && \
	cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]