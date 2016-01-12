maxdb Cookbook
==================

This cookbook provides recipes for installing SAP MAXDB Server Tested with Vagrant & AWS Provider
For more information, other SAP Cookbooks, questions and feedback please go to: http://sapcc.github.io/sap-cookbook-docs/

This cookbook
- creates a volume for the data
- installs the MaxDB binaries
- creates a default database instance
- starts the MaxDB including x-server
 

Requirements
------------
#### Installation binary
The installation bin is taken from service market of sap, you should login and take it from there
link: https://support.sap.com/software/databases.html 

#### Platform
* AWS Image - Suse SLES 11 SP3 (checked on this AMI: ami-f1f5acc1 from region: us-west-2)
* approx. 80GB in the rootfs directory 
* AWS EC2 Instance Type: m4.large (Minimum requirements - tested on this type)


#### Dependencies (recepies) 
Please ensure that you have accessibility to the following:
- ark 
- lvm




### Attributes

All attributes have sane default values (See `attributes/default.rb`). You can install any supported component in this cookbook, without overriding any attributes. In case you need to override an attribute(s), use either a role or a wrapper cookbook. See examples in the examples section.


#### maxdb::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['maxdb']['tmpDir']</tt></td>
    <td>String</td>
    <td>tmp dir to put zip files and setup scripts</td>
    <td><tt>/tmp</tt></td>
  </tr>
  <tr>
    <td><tt>['maxdb']['sapdbDir']</tt></td>
    <td>String</td>
    <td>base directory for installation</td>
    <td><tt>/sapdb</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['programDir']</tt></td>
     <td>String</td>
     <td>global programs directory</td>
     <td><tt>/sapdb/programs</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['SID']</tt></td>
     <td>String</td>
     <td>instance id</td>
     <td><tt>SID</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['volDataDir']</tt></td>
     <td>String</td>
     <td>path to the data volume</td>
     <td><tt>/sapdb/['maxdb']['SID']/sapdata1</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['volLogDir']</tt></td>
     <td>String</td>
     <td>path to the log volume</td>
     <td><tt>/sapdb/['maxdb']['SID']/saplog1</tt></td>
  </tr>
</table>

#### maxdb::installdb
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['maxdb']['repoUrl']</tt></td>
    <td>String</td>
    <td>Repository url pointing to the maxdb installation files</td>
    <td><tt>http://example-server.org:8080/location-of-binary/</tt></td>
  </tr>
  <tr>
    <td><tt>['maxdb']['version']</tt></td>
    <td>String</td>
    <td>MaxDB version</td>
    <td><tt>7.8</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['globalDataDir']</tt></td>
     <td>String</td>
     <td>global data directory</td>
     <td><tt>/sapdb/data</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['instDbDir']</tt></td>
     <td>String</td>
     <td>instance data directory</td>
     <td><tt>/sapdb/<SID>/db</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['zipFile']</tt></td>
     <td>String</td>
     <td>Name of the installation zip file</td>
     <td><tt>filename.tgz</tt></td>
  </tr>
</table>

#### maxdb::dbsettings
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['maxdb']['scriptName']</tt></td>
    <td>String</td>
    <td>Name of the MaxDB setup script to be found in the templates</td>
    <td><tt>createdb</tt></td>
  </tr>
  <tr>
    <td><tt>['maxdb']['dbName']</tt></td>
    <td>String</td>
    <td>Name of the Database to be created</td>
    <td><tt>DEFAULT</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbmOperator']['name']</tt></td>
     <td>String</td>
     <td>name of the DBM operator</td>
     <td><tt>dbm</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbmOperator']['password']</tt></td>
     <td>String</td>
     <td>password of the DBM operator</td>
     <td><tt>dbm</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['name']</tt></td>
     <td>String</td>
     <td>name of the DB User</td>
     <td><tt>DBADMIN</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['password']</tt></td>
     <td>String</td>
     <td>password of the DB User</td>
     <td><tt>admin</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['xuser']</tt></td>
     <td>String</td>
     <td>key of the DB User in the XUSERS list (of root)</td>
     <td><tt>dba</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['sessionTimeout']</tt></td>
     <td>String</td>
     <td>DB parameter sessionTimeout</td>
     <td><tt>0 (unlimited Sessions)</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['CacheMemorySize']</tt></td>
     <td>String</td>
     <td>DB parameter CacheMemorySize</td>
     <td><tt>1000</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['MaxDataVolumes']</tt></td>
     <td>String</td>
     <td>DB parameter MaxDataVolumes</td>
     <td><tt>64</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['MaxUserTasks']</tt></td>
     <td>String</td>
     <td>DB parameter MaxUserTasks</td>
     <td><tt>120</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['DefaultCodePage']</tt></td>
     <td>String</td>
     <td>DB parameter DefaultCodePage</td>
     <td><tt>UNICODE</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['autoUpdateStatistics']</tt></td>
     <td>String</td>
     <td>DB parameter autoUpdateStatistics</td>
     <td><tt>ON</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['autoExtend']</tt></td>
     <td>String</td>
     <td>DB parameter autoExtend</td>
     <td><tt>ON</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['autoExtendPercentage']</tt></td>
     <td>String</td>
     <td>DB parameter autoExtend on percentage</td>
     <td><tt>90</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['logOverwrite']</tt></td>
     <td>String</td>
     <td>DB parameter logOverwrite</td>
     <td><tt>ON</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['maxSQLLocks']</tt></td>
     <td>String</td>
     <td>DB parameter MaxSQLLocks</td>
     <td><tt>900000</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['maxServerTasks']</tt></td>
     <td>String</td>
     <td>DB parameter MaxServerTasks</td>
     <td><tt>4096</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['joinTableBufferSize']</tt></td>
     <td>String</td>
     <td>DB parameter JoinTableBufferSize</td>
     <td><tt>16384</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['joinSearchLevel']</tt></td>
     <td>String</td>
     <td>DB parameter JoinSearchLevel</td>
     <td><tt>4</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['maxTransactions']</tt></td>
     <td>String</td>
     <td>DB parameter MaxTransactions</td>
     <td><tt>32767</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['maxCPUs']</tt></td>
     <td>String</td>
     <td>DB parameter MaxCPUs</td>
     <td><tt>3</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['maxLogVolumes']</tt></td>
     <td>String</td>
     <td>DB parameter MaxLogVolumes</td>
     <td><tt>4</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['autoRecreateBadIndex']</tt></td>
     <td>String</td>
     <td>DB parameter AutoRecreateBadIndex. Can be ALL, UNIQUE or OFF</td>
     <td><tt>ALL</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['db']['parameter']['autoLogBackup']</tt></td>
     <td>String</td>
     <td>DB parameter AutoLogBackup. Can be on or off (must be lower case). Do not turn on, when ['maxdb']['db']['parameter']['logOverwrite'] is activated.</td>
     <td><tt>off</tt></td>
  </tr>
</table>

#### maxdb::createdb
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['maxdb']['scriptName']</tt></td>
    <td>String</td>
    <td>Name of the MaxDB setup script to be found in the templates</td>
    <td><tt>createdb</tt></td>
  </tr>
  <tr>
    <td><tt>['maxdb']['dbName']</tt></td>
    <td>String</td>
    <td>Name of the Database to be created</td>
    <td><tt>DEFAULT</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbmOperator']['name']</tt></td>
     <td>String</td>
     <td>name of the DBM operator</td>
     <td><tt>dbm</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbmOperator']['password']</tt></td>
     <td>String</td>
     <td>password of the DBM operator</td>
     <td><tt>dbm</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['name']</tt></td>
     <td>String</td>
     <td>name of the DB User</td>
     <td><tt>DBADMIN</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['password']</tt></td>
     <td>String</td>
     <td>password of the DB User</td>
     <td><tt>admin</tt></td>
  </tr>
  <tr>
     <td><tt>['maxdb']['dbUser']['xuser']</tt></td>
     <td>String</td>
     <td>key of the DB User in the XUSERS list (of root)</td>
     <td><tt>dba</tt></td>
  </tr>
</table>

Usage
-----
#### maxdb::default

All-in-one to get a running DB.

First, create four volumes with device path '/dev/sapdb_pv_data, /dev/sapdb_pv_log, /dev/sapdb_pv_global, /dev/sapdb_pv_instance' and attach it to your node.
Then include `maxdb` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[maxdb]"
  ]
}
```

and set at least the following attributes:

[maxdb][SID]
[maxdb][dbName]
[maxdb][dbmOperator][password]
[maxdb][dbUser][password]


#### maxdb::lvm

creates several ext3 lvm volume groups 'sapdb_vg_instance', 'sapdb_vg_global', 'sapdb_vg_data', 'sapdb_vg_log' and corresponding volumes from devices '/dev/sapdb_pv_instance', '/dev/sapdb_pv_global', '/dev/sapdb_pv_data', '/dev/sapdb_pv_log' and mounts it to '[maxdb][volDataDir]' (and subsequent)


#### maxdb::installdb

Downloads the installation zip file (tgz) from moo-repo and runs 'sdbinst' with the specified parameters.


#### maxdb::createdb

Processes the 'createdb' template and puts it to '/tmp'. Then it runs 'dbmcli -i /tmp/createdb' to setup a database named [:maxdb][:dbName].


#### maxdb::dbsettings

Processes the 'dbsettings' template and puts it to '/tmp'. Then it runs 'dbmcli -i /tmp/dbsettings' to configure the database named [:maxdb][:dbName].


#### maxdb::startdb

Starts the x_server and the database


Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: SAP AG
Authors: Stefan Weidemüller-Schmidt (stefan.weidemueller-schmidt@sap.com), Haggai Philip Zaggury, Dirk Lehmann (dirk.lehmann@sap.com)


