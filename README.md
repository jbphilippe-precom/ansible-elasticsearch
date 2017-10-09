[![build status](https://gitrep.services.local/ansible-middlewares/ansible-elasticsearch/badges/develop/build.svg)](https://gitrep.services.local/ansible-middlewares/ansible-elasticsearch/commits/develop)
Role Name
=========

This role deploys ElasticSearch 5.X (5.4.0 verified)

Requirements
------------

	Ansible 2.x to deploy, (Ansible 2.1 recommended)
	Java is required, needs to be installed before
	Recommended : Java 8 update 73 or later (1.8.0_121 verified)
	Please install java in your PATH


Global Default Variables (to be overloaded)
-------------------------------------------
      Those variables can be overloaded, here you can see default's role values
      es_version: "5.4.0"
      es_apt_key: "http://mirror.services.local/pubkey/ael.scs.systeme.key"
      es_apt_repo: "deb http://mirror.services.local/elasticsearch_5.x/ stable main"
      es_vg_name: "vg_vroot"
      es_lv_name: "lv_elasticsearch"
      es_lvsize: "5G"
      ## IMPORTANT you need to overload this variable with the name of your hostgroup ##
      es_cluster_group: "all"
      es_prod_interface: "eth0"
      es_allowed_client_list_ip: ""
      es_config_template_file: "elasticsearch_yaml.tpl"
      es_default_config_template_file: "elasticsearch_default.tpl"
      es_systemd_template_file: "elasticsearch.service.systemd.tpl"
			es_jvm_options_template_file: "jvm_options.tpl"
      es_heap_size: "2G"
      es_max_locked_memory: "unlimited"
      es_firewall: yes
      es_lv_create: yes
      es_old_lock_memory: 0
      es_username: "elasticsearch"
      es_groupname: "elasticsearch"
      es_fs_type: "ext4"
      es_cluster_name: "elasticsearch"
      es_http_port: 9200
      es_transport_tcp_port: 9300
      es_pid_dir: "/var/run/elasticsearch/"
      es_data_dir: "/var/lib/elasticsearch/"
      es_log_dir: "/var/log/elasticsearch/"
      es_path_data: "{{ es_data_dir }}"
      es_path_logs: "{{ es_log_dir }}"

      ## xenial only do not use those variables under trusty ##
      es_service_name: "elasticsearch"
      es_conf_dir: "/etc/elasticsearch/"
      es_environment_filename: "elasticsearch"
      es_service_systemd_filename: "elasticsearch"
			es_jvm_options_file: "jvm.options"

Others Global variables
------------------------------
    Firewalling :
    es_firewall: yes
    es_allowed_client_list_ip:
      - "192.168.229.42"
    es_unicast_hostlist:
    - "192.168.229.97"
    - "192.168.229.98"
    - "192.168.229.102"


Templates system default variables
------------------------------------
Those variables can be defined if is it's needed


Nom de la variable   | Paramètre ElasticSearch surchargé   | Commentaire
-------------------- | ----------------------------------- | -----------
es_home_dir	         | ES_HOME	                           |
es_conf_dir	         | CONF_DIR	                           |
es_data_dir	         | DATA_DIR	                           |
es_log_dir	         | LOG_DIR	                           |
es_pid_dir	         | PID_DIR	                           |
es_heap_size	       | ES_HEAP_SIZE	                       |
es_heap_newsize	     | ES_HEAP_NEWSIZE	                   |
es_direct_size	     | ES_DIRECT_SIZE	                     |
es_java_opts	       | ES_JAVA_OPTS	                       |
es_gc_log_file	     | ES_GC_LOG_FILE	                     |
es_username	         | ES_USER	                           |
es_groupname	       | ES_GROUP	                           |
es_startup_stime	   | ES_STARTUP_SLEEP_TIME	             |
es_max_open_files	   | MAX_OPEN_FILES	                     |
es_max_locked_memory | MAX_LOCKED_MEMORY                   |
es_max_map_count	   | MAX_MAP_COUNT                       |



Templates elasticsearch configuration variables
------------------------------------------------
Those variables can be defined if is it's needed


Nom de la variable                          | Paramètre ElasticSearch surchargé         | Commentaire
------------------------------------------- | ----------------------------------------- | -----------
es_cluster_name	                            | cluster.name                              |
ansible_nodename	                          | node.name                                 |
es_node_rack	                              | node.attr.rack                            | Nom changé en 5.X
es_node_master	                            | node.master                               |
es_node_data	                              | node.data                                 |
es_path_data	                              | path.data                                 |
es_path_logs	                              | path.logs                                 |
es_old_lock_memory = 0                      | bootstrap.memory_lock (>=v2.4)            | Bien définir à 0 en 5.X
es_old_lock_memory = 1	                    | bootstrap.mlockall (<v2.4)                |
es_http_custom_port	                        | http.port                                 |
es_discovery_zen_minimum_master_nodes	      | discovery.zen.minimum_master_nodes        |
es_gateway_recover_after_nodes	            | gateway.recover_after_nodes               |
es_gateway_expected_nodes	                  | gateway.expected_nodes                    |
es_gateway_expected_master_nodes	          | gateway.expected_master_nodes             |
es_gateway_expected_data_nodes	            | gateway.expected_data_nodes               |
es_gateway_recover_after_time	              | gateway.recover_after_time                |
es_node_max_local_storage_nodes	            | node.max_local_storage_nodes              |
es_action_destructive_requires_name	        | action.destructive_requires_name          |
es_index_replicas_number	                  | index.number_of_replicas                  |
es_index_shards_number	                    | index.number_of_shards                    |
es_index_merge_scheduler_max_thread_count	  | index.merge.scheduler.max_thread_count    |
es_index_translog_flush_threshold_size	    | index.translog.flush_threshold_size       |
es_index_store_type	                        | index.store.type                          |
es_indices_fielddata_cache_size	            | indices.fielddata.cache.size              |
es_indices_store_throttle_max_bytes_per_sec	| indices.store.throttle.max_bytes_per_sec  |
es_threadpool_bulk_queue_size	              | threadpool.bulk.queue_size                |


Templates systemd variables
------------------------------------------------
Those variables can be defined if is it's needed


| Nom de la variable                          | Paramètre Systemd ElasticSearch surchargé | Commentaire |
| ------------------------------------------- | ----------------------------------------- | ----------- |
| es_home_dir	                                | Environment=ES_HOME	 	                    |             |
| es_conf_dir	                                | Environment=CONF_DIR	 	                  |             |
| es_data_dir	                                | Environment=DATA_DIR	 	                  |             |
| es_log_dir	                                | Environment=LOG_DIR	 	                    |             |
| es_pid_dir	                                | Environment=PID_DIR	 	                    |             |
| es_username	                                | User	 	                                  |             |
| es_groupname	                              | Group		                                  |             |


Dependencies
------------
None

Basic example Playbook v5.4.0
---------------------------				
				- hosts: gges01l
				  roles:
				    - { role: ansible-java }
				    - { role: ansible-elasticsearch }
				  vars:
				    java_version: 8
				    install_jdk: 1
				    install_jre: 0
				    install_openjdk: 0
				    es_version: "5.4.0"
				    es_apt_repo: "deb http://mirror.services.local/elasticsearch_5.x/ stable main"
				    es_localhost_only: 0
				    es_max_locked_memory: "unlimited"
				    es_cluster_group: "gges01l"
				    es_prod_interface: "eth1"
				    es_firewall: yes
				    es_allowed_client_list_ip:
				      - "192.168.229.XX"
				    es_unicast_hostlist:
				      - "192.168.229.XX"
				      - "192.168.229.YY"
				      - "192.168.229.ZZ"




Example Playbook v2.4.1 with many optionnals variables used (for example)
-------------------------------------------------------------------------
Hostname                  | IP
------------------------- | --------------
jlsxenial01l.btsys.local	| 192.168.229.97
jlsxenial02l.btsys.local	| 192.168.229.98
jlsxenial03l.btsys.local	| 192.168.229.102
jlstest01l.btsys.local.	  | 192.168.229.42


    - hosts: jlsxenial
      roles:
        - { role: ansible-java }
        - { role: ansible-elasticsearch }
      vars:
        java_version: 8
        install_jdk: 1
        install_jre: 0
        install_openjdk: 0
        es_version: "2.4.1"
        es_lv_create: yes
        es_lvsize: "2G"
        es_cluster_name: "moncluster"
        es_localhost_only: 0
        es_heap_size: "2G"
        es_max_locked_memory: "unlimited"
        ## HERE, es_cluster_group must be the group name you declared in your inventory file (like hosts param )##
        es_cluster_group: "jlsxenial"
        es_prod_interface: "eth1"
        es_firewall: yes
        es_allowed_client_list_ip:
          - "192.168.229.42"
        es_unicast_hostlist:
          - "192.168.229.97"
          - "192.168.229.98"
          - "192.168.229.102"
        es_index_translog_flush_threshold_size: "1GB"
        es_index_store_type: "mmapfs"
        es_indices_fielddata_cache_size: "40%"
        es_indices_store_throttle_max_bytes_per_sec: "100mb"
        es_discovery_zen_minimum_master_nodes: 2
        es_gateway_recover_after_nodes: 2
        es_gateway_expected_nodes: 3
        es_gateway_recover_after_time: "5m"
        es_threadpool_bulk_queue_size: 10000
        es_vm_vfs_cache_pressure: 50
        es_index_replicas_number: 2
        es_index_shards_number: 5


Example Playbook v1.7.5
---------------------------
Hostname                  | IP
------------------------- | --------------
jlsxenial01l.btsys.local	| 192.168.229.97
jlsxenial02l.btsys.local	| 192.168.229.98
jlsxenial03l.btsys.local	| 192.168.229.102
jlstest01l.btsys.local.	  | 192.168.229.42


    - hosts: jlsxenial
      roles:
        - { role: ansible-java }
        - { role: ansible-elasticsearch }
      vars:
        java_version: 8
        install_jdk: 1
        install_jre: 0
        install_openjdk: 0
        es_version: "1.7.5"
        es_apt_repo: "deb http://mirror.services.local/elasticsearch_1.7/ stable main"
        es_lv_create: yes
        es_lvsize: "2G"
        es_cluster_name: "moncluster"
        es_localhost_only: 0
        es_heap_size: "2G"
        es_max_locked_memory: "unlimited"
        ## HERE, es_cluster_group must be the group name you declared in your inventory file (like hosts param )##
        es_cluster_group: "jlsxenial"
        es_prod_interface: "eth1"
        es_firewall: yes
        es_allowed_client_list_ip:
          - "192.168.229.42"
        es_unicast_hostlist:
          - "192.168.229.97"
          - "192.168.229.98"
          - "192.168.229.102"
        es_old_lock_memory: 1


Example of host declaration
-----------------------------
	  [jlsxenial]
	  jlstrusty01l.btsys.local node.name=jlstrusty01l
	  jlstrusty02l.btsys.local node.name=jlstrusty02l
	  jlstrusty03l.btsys.local node.name=jlstrusty02l


Other example of host declaration
----------------------------------
    [jlsxenial]
    jlsxenial01l.btsys.local node.name=jlsxenial01l es_node_data=true es_node_master=false
    jlsxenial02l.btsys.local node.name=jlsxenial02l es_node_data=true es_node_master=true
    jlsxenial03l.btsys.local node.name=jlsxenial03l es_node_data=true es_node_master=true


Multi instances on same hosts
-------------------------------
      By allowing overloading of lot of variables, this role give you the possibility deploy multi ElasticSearch instances on same server (same version, Xenial only).
      To do that, for example to deploy 2 instances, you can deploy the first one with one playbook (with standard paths) and a second one with somes variables overloaded.
      Overloading example for the second playbook :
      es_cluster_name: "mysecondcluster"
      es_conf_dir: "/etc/elasticsearch2/"
      es_environment_filename: "elasticsearch2"
      es_service_systemd_filename: "elasticsearch2"
      es_pid_dir: "/var/run/elasticsearch2/"
      es_data_dir: "/var/lib/elasticsearch2/"
      es_log_dir: "/var/log/elasticsearch2/"
      es_service_name: "elasticsearch2"
      es_http_port: 19200
      es_transport_tcp_port: 19300


INSTALLATION
--------------
	ansible-playbook -k --ask-become-pass -i inventory --tag installation elasticsearch.yml

TEST
--------------
	ansible-playbook -k --ask-become-pass -i inventory --tag testing elasticsearch.yml

License
-------

BSD

TODO
-------

Author Information
------------------

JLS, GG

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
