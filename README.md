# iac-demo

## Folder Structure

./applications contains the manifests to be deployed by ArgoCD
./infrastructure contains the ansible & terraform to bootstrap and manage the infrastructure from k8s to baremetal
./gencharts contains the code to generate the helm charts for the applications
./infrastructure/bootstrap/tasks/run-it-all.yml runs all applicable playbooks to configure all 6 components -> router, switches, hosts

## Purpose

To demonstrate my skills with SRE & DevOps functionality as a snapshot in time as well as to abuse IaC as much as possible for all layers of this application stack. This is not intended to be a production ready solution, and is currently being developed and deployed to a baremetal locally hosted cluter housed on a 3d printed rack. If you're here looking for ideas, just use EKS and ignore all the below.

## Desired functionality

`Note: This section will be updated as the project progresses`

- [x] Ansible defined controller (Raspberry Pi)
  - [x] ProtecCLI/VyOS Network Infrastructure
  - [x] Unifi Controller
  - [ ] MaaS.io (metal as a service) - bonus points
  - [x] Load Balancer
  - [ ] Nexus Docker Image Caching
  - [ ] Jenkins CI/CD
- [x] ProxMox Physical Hypervisors
  - [x] Provisioned via Ansible
  - [x] Updated via Ansible
- [ ] Terraform defined supplemental infrastructure
- [ ] Terraform defined Kubernetes cluster
  - [ ] Deployed via Terraform
  - [ ] Updated via Terraform
- [ ] CDK8s defined supplemental infrastructure
  - [ ] Python Diagrams Implementation (bonus points)
  - [ ] Linkerd2 App Mesh
  - [ ] App Tracing
  - [ ] Prometheus
  - [ ] Grafana
  - [ ] ArgoCD
- [ ] CDK8s defined https://github.com/GoogleCloudPlatform/microservices-demo
  - [ ] Customized to be deployed and updated through CDK8s
- [ ] CDK8s defined monitoring
  - [ ] CDK8s defined Infrastructure Monitoring
  - [ ] CDK8s defined Application Monitoring
  - [ ] CDK8s defined Feature Monitoring
- [ ] CDK8s defined logging
  - [ ] CDK8s defined Infrastructure Logging
  - [ ] CDK8s defined Application Logging
- [ ] CDK8s defined alerting
  - [ ] CDK8s defined Feature Alerting & Excalation
    - [ ] Discord
    - [ ] PagerDuty (bonus points)
- [ ] Documentation on all the above

## Authors Notes

The scope above is excessive. The plan is not to complete every task, but to start with the critical parts and work down towards the QOL parts. The challenge I have presented to myself is both for design time management and to include minimal net-new tools to my belt. Anything labeled "bonus points" is one such net-new technology or cost consideration for something I don't have on hand. CDK8s is also a net-new technology to me at the time of this writing but is part of the design prompt I have given myself.
