FROM registry.access.redhat.com/ubi8/ubi-minimal
USER root
RUN echo -e "[centos8]" \
 "\nname = centos8" \
 "\nbaseurl = http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/" \
 "\nenabled = 1" \
 "\ngpgcheck = 0" > /etc/yum.repos.d/centos.repo
COPY nfs.sh /usr/local/bin/tackle-nfs
COPY export /etc/exports
RUN microdnf -y install \
  nfs-utils \
 && microdnf -y clean all
RUN mkdir -p /mnt/pv \
 && chmod 777 /mnt/pv \
 && modprobe nfs
ENTRYPOINT ["/usr/local/bin/tackle-nfs"]

LABEL name="konveyor/tackle2-nfs" \
      description="Konveyor Tackle - NFS" \
      help="For more information visit https://konveyor.io" \
      license="Apache License 2.0" \
      maintainers="jortel@redhat.com,slucidi@redhat.com" \
      summary="Konveyor Tackle - NFS" \
      url="https://quay.io/repository/konveyor/tackle2-nfs" \
      usage="podman run konveyor/tackle2-nfs:latest" \
      com.redhat.component="konveyor-tackle-nfs-container" \
      io.k8s.display-name="Tackle NFS" \
      io.k8s.description="Konveyor Tackle - NFS" \
      io.openshift.expose-services="" \
      io.openshift.tags="konveyor,tackle,nfs" \
      io.openshift.min-cpu="100m" \
      io.openshift.min-memory="350Mi"
