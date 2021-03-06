# ALWAYS BE FACTORING

A project to:

1. Learn Docker and Kubernetes
1. Contribute usefully to CADO-NFS upstream
1. Learn profiling and optimization techniques
1. Factor a large number or two!

## Code layout

Contents of each directory are:

* `build/`: a build container based on Debian;
* `gmp/`, `cado/`: build 3rd-party packages using the build environment;
* `build.sh`: a basic build script that build containers in the correct order.
* `deploy/`: k8s YAML files defining deployments and other k8s concepts;

## Future work

* `build`:
  * make the build container smaller;
  * try different C compilers;
  * target different architectures;
* `gmp`:
* `cado`:
	* subclass / tweak CADO-NFS server and client scripts to make them more
	  suitable for k8s;
  * make client pods self-terminate on HTTP 410;
  * deployment for running linear algebra;
  * turn off color in logs;
  * accept lost pods (lower task timeout? disable node autoscaling?);
  * create persistent disk as needed;
* `build.sh`:
  * replace script with a Makefile that builds exactly what is needed;
  * make a system of tags to use to manage deployments;
* `deploy`:
  * script creation of a cluster to run in;
  * accept N, cluster size and CPUs/node as parameters;
