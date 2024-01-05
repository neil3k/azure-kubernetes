# Microsoft Azure Virtual Network Module

## Purpose
This module provides support for the creation of a Azure standard Kubernetes cluster with an Istio service mesh.

## Description
This module is used for creating a kubernetes cluster in Azure,

## Usage Instructions
Built for use alongside other modules.

## Preconditions and Assumptions

None

## Requirements

No Requirements

## Providers


| Name       | Version |
|------------|---------|
| azurerm    | 3.86.0  |
| kubernetes | 2.25.0  |
| helm       | 2.12.0  |



## Resources

| Name                                             | Type     |
|--------------------------------------------------|----------|
| azurerm_resource_group                           | resource |
| azurerm_kubernetes_cluster                       | resource |
| helm_release                                     | resource |
| kubernetes_namespace                             | resource |


## Inputs

| Name                | Description | Type   | Default | Required |
|---------------------|-------------|--------|---------|----------|
| location            | n/a         | string | n/a     | yes      |
| resource_group_name | n/a         | string | n/a     | yes      |
| istio_version       | n/a         | string | n/a     | yes      |

## Outputs

| Name                  | Description |
|-----------------------|-------------|
| Kubernetes_cluster_id | n/a         |

