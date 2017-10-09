# ======================== Elasticsearch Configuration =========================
#
# NOTE: Elasticsearch comes with reasonable defaults for most settings.
#       Before you set out to tweak and tune the configuration, make sure you
#       understand what are you trying to accomplish and the consequences.
#
# The primary way of configuring a node is via this file. This template lists
# the most important settings you may want to configure for a production cluster.
#
# Please see the documentation for further information on configuration options:
# <http://www.elastic.co/guide/en/elasticsearch/reference/current/setup-configuration.html>
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#
{% if es_cluster_name is defined %}
cluster.name: {{ es_cluster_name }}
{% endif %}
# cluster.name: my-application
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
{% if ansible_nodename is defined %}
node.name: {{ ansible_nodename }}
{% endif %}
# node.name: node-1
#
# Add custom attributes to the node:
#
{% if es_node_rack is defined %}
{% if es_version|version_compare("5.0.0",'<') %}
node.rack: {{ es_node_rack }}
# node.rack: r1
{% else %}
node.attr.rack: {{ es_node_rack }}
# node.attr.rack: r1
{% endif %}
{% endif %}
{% if es_node_master is defined %}
node.master: {{ es_node_master }}
{% endif %}
{% if es_node_data is defined %}
node.data: {{ es_node_data }}
{% endif %}
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
{% if es_path_data is defined %}
path.data: {{ es_path_data }}
{% endif %}
# path.data: /path/to/data
#
# Path to log files:
#
{% if es_path_logs is defined %}
path.logs: {{ es_path_logs }}
{% endif %}
# path.logs: /path/to/logs
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
# bootstrap.memory_lock: true
## Ici pour garder la compatibilité avec les versions inferieures à 2.4 ###
## paramètre forcé à true car c'est les préconisations ES ##
## https://www.elastic.co/guide/en/elasticsearch/reference/2.4/setup-configuration.html
{% if es_old_lock_memory == 0 %}
bootstrap.memory_lock: true
{% else %}
bootstrap.mlockall: true
{% endif %}

# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
{% if es_localhost_only == 1 %}
network.host: 127.0.0.1
{% else %}
network.host: 0.0.0.0
{% endif %}
# network.host: 192.168.0.1
#
# Set a custom port for HTTP:
#
{% if es_http_port is defined %}
http.port: {{ es_http_port }}
{% endif %}
# http.port: 9200
#
{% if es_transport_tcp_port is defined %}
transport.tcp.port: {{ es_transport_tcp_port }}
{% endif %}

# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-network.html>
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when new node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
# discovery.zen.ping.unicast.hosts: ["host1", "host2"]
{% if es_transport_tcp_port is defined %}
discovery.zen.ping.unicast.hosts: [{% for host in es_unicast_hostlist %}"{{ host }}:{{ es_transport_tcp_port }}"{%- if not loop.last %}, {% endif -%}{% endfor %}]
{% else %}
discovery.zen.ping.unicast.hosts: [{% for host in es_unicast_hostlist %}"{{ host }}"{%- if not loop.last %}, {% endif -%}{% endfor %}]
{% endif %}
#
# Prevent the "split brain" by configuring the majority of nodes (total number of nodes / 2 + 1):
#
{% if es_discovery_zen_minimum_master_nodes is defined %}
discovery.zen.minimum_master_nodes: {{ es_discovery_zen_minimum_master_nodes }}
{% endif %}
# discovery.zen.minimum_master_nodes: 3
#
# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery.html>
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
#
{% if es_gateway_recover_after_nodes is defined %}
gateway.recover_after_nodes: {{ es_gateway_recover_after_nodes }}
{% endif %}
# gateway.recover_after_nodes: 3
#

{% if es_gateway_expected_nodes is defined %}
gateway.expected_nodes: {{ es_gateway_expected_nodes }}
{% endif %}

{% if es_gateway_expected_master_nodes is defined %}
gateway.expected_master_nodes: {{ es_gateway_expected_master_nodes }}
{% endif %}

{% if es_gateway_expected_data_nodes is defined %}
gateway.expected_data_nodes: {{ es_gateway_expected_data_nodes }}
{% endif %}

{% if es_gateway_recover_after_time is defined %}
gateway.recover_after_time: {{ es_gateway_recover_after_time }}
{% endif %}


# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/current/modules-gateway.html>
#
# ---------------------------------- Various -----------------------------------
#
# Disable starting multiple nodes on a single system:
#
{% if es_node_max_local_storage_nodes is defined %}
node.max_local_storage_nodes: {{ es_node_max_local_storage_nodes }}
{% endif %}
# node.max_local_storage_nodes: 1
#
# Require explicit names when deleting indices:
#
{% if es_action_destructive_requires_name is defined %}
action.destructive_requires_name: {{ es_action_destructive_requires_name }}
{% endif %}
# action.destructive_requires_name: true
# ------------------------------ Index Settings --------------------------------
#
### WARNING Elasticsearch comes with good defaults. Don’t twiddle these knobs until you understand what they do and why you should change them. ##
### SOURCE : https://www.elastic.co/guide/en/elasticsearch/guide/current/_index_settings.html
# Number of index replicas
#
{% if es_index_replicas_number is defined %}
index.number_of_replicas: {{ es_index_replicas_number }}
{% endif %}
#
# Number of index shards
#
{% if es_index_shards_number is defined %}
index.number_of_shards: {{ es_index_shards_number }}
{% endif %}
#
## Merge ##
# https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-merge.html
{% if es_index_merge_scheduler_max_thread_count is defined %}
index.merge.scheduler.max_thread_count: {{ es_index_merge_scheduler_max_thread_count }}
{% endif %}

## Translog ##
# https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-translog.html

{% if es_index_translog_flush_threshold_size is defined %}
index.translog.flush_threshold_size: {{ es_index_translog_flush_threshold_size }}
{% endif %}

## Store ##
# https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-store.html
{% if es_index_store_type is defined %}
index.store.type: {{ es_index_store_type }}
{% endif %}

## fielddata-size ##
# Can be set to a percentage of the heap size, or a concrete value like 5gb
# https://www.elastic.co/guide/en/elasticsearch/guide/2.x/_limiting_memory_usage.html
{% if es_indices_fielddata_cache_size is defined %}
indices.fielddata.cache.size: {{ es_indices_fielddata_cache_size }}
{% endif %}

## indexing perf ##
## The default is 20 MB/s, which is a good setting for spinning disks.
## If you have SSDs, you might consider increasing this to 100–200 MB/s ##
## https://www.elastic.co/guide/en/elasticsearch/guide/current/indexing-performance.html
{% if es_indices_store_throttle_max_bytes_per_sec is defined %}
indices.store.throttle.max_bytes_per_sec: {{ es_indices_store_throttle_max_bytes_per_sec }}
{% endif %}


# ------------------------------ OTHERS --------------------------------
## threadpool ##
# https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-threadpool.html
{% if es_threadpool_bulk_queue_size is defined %}
threadpool.bulk.queue_size: {{ es_threadpool_bulk_queue_size }}
{% endif %}
