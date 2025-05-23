/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

grammar DALStatement;

import DMLStatement;

use
    : USE databaseName
    ;

help
    : HELP textOrIdentifier
    ;

explain
    : (DESC | DESCRIBE | EXPLAIN)
    (tableName (columnRef | textString)?
    | explainType? (explainableStatement | FOR CONNECTION connectionId)
    | ANALYZE (FORMAT EQ_ TREE)? (select | delete | update | insert))
    ;

fromDatabase
    : (FROM | IN) databaseName
    ;

fromTable
    : (FROM | IN) tableName
    ;

showLike
    : LIKE stringLiterals
    ;

showWhereClause
    : WHERE expr
    ;

showFilter
    : showLike | showWhereClause
    ;

showProfileType
    : ALL | BLOCK IO | CONTEXT SWITCHES | CPU | IPC | MEMORY | PAGE FAULTS | SOURCE | SWAPS
    ;

setVariable
    : SET optionValueList
    ;

optionValueList
    : optionValueNoOptionType (COMMA_ optionValue)*
    | optionType (internalVariableName EQ_ setExprOrDefault) (COMMA_ optionValue)*
    ;

optionValueNoOptionType
    : internalVariableName equal setExprOrDefault
    | userVariable equal expr
    | setSystemVariable equal setExprOrDefault
    | NAMES (equal expr | charsetName collateClause? | DEFAULT)
    ;

equal
    : EQ_ | ASSIGNMENT_
    ;

optionValue
    : optionType internalVariableName EQ_ setExprOrDefault | optionValueNoOptionType
    ;

showBinaryLogs
    : SHOW (BINARY | MASTER) LOGS
    ;

showBinlogEvents
    : SHOW BINLOG EVENTS (IN logName)? (FROM NUMBER_)? limitClause?
    ;

showCharacterSet
    : SHOW CHARACTER SET showFilter?
    ;

showCollation
    : SHOW COLLATION showFilter?
    ;

showColumns
    : SHOW EXTENDED? FULL? (COLUMNS | FIELDS) fromTable fromDatabase? showFilter?
    ;

showCreateDatabase
    : SHOW CREATE (DATABASE | SCHEMA) ifNotExists? databaseName
    ;

showCreateEvent
    : SHOW CREATE EVENT eventName
    ;

showCreateFunction
    : SHOW CREATE FUNCTION functionName
    ;

showCreateProcedure
    : SHOW CREATE PROCEDURE procedureName
    ;

showCreateTable
    : SHOW CREATE TABLE tableName
    ;

showCreateTrigger
    : SHOW CREATE TRIGGER triggerName
    ;

showCreateUser
    : SHOW CREATE USER username
    ;

showCreateView
    : SHOW CREATE VIEW viewName
    ;

showDatabases
    : SHOW (DATABASES | SCHEMAS) showFilter?
    ;

showEngine
    : SHOW ENGINE engineRef (STATUS | MUTEX)
    ;

showEngines
    : SHOW STORAGE? ENGINES
    ;

showErrors
    : SHOW (COUNT LP_ ASTERISK_ RP_)? ERRORS limitClause?
    ;

showEvents
    : SHOW EVENTS fromDatabase? showFilter?
    ;

showFunctionCode
    : SHOW FUNCTION CODE functionName
    ;

showFunctionStatus
    : SHOW FUNCTION STATUS showFilter?
    ;

showGrants
    : SHOW GRANTS (FOR (username | roleName) (USING roleName (COMMA_ roleName)*)?)?
    ;

showIndex
    : SHOW EXTENDED? (INDEX | INDEXES | KEYS) fromTable fromDatabase? showWhereClause?
    ;

showMasterStatus
    : SHOW MASTER STATUS
    ;

showOpenTables
    : SHOW OPEN TABLES fromDatabase? showFilter?
    ;

showPlugins
    : SHOW PLUGINS
    ;

showPrivileges
    : SHOW PRIVILEGES
    ;

showProcedureCode
    : SHOW PROCEDURE CODE functionName
    ;

showProcedureStatus
    : SHOW PROCEDURE STATUS showFilter?
    ;

showProcesslist
    : SHOW FULL? PROCESSLIST
    ;

showProfile
    : SHOW PROFILE (showProfileType (COMMA_ showProfileType)*)? (FOR QUERY NUMBER_)? limitClause?
    ;

showProfiles
    : SHOW PROFILES
    ;

showRelaylogEvent
    : SHOW RELAYLOG EVENTS (IN logName)? (FROM NUMBER_)? limitClause? (FOR CHANNEL channelName)?
    ;

showReplicas
    : SHOW REPLICAS
    ;

showSlaveHosts
    : SHOW SLAVE HOSTS
    ;

showReplicaStatus
    : SHOW REPLICA STATUS (FOR CHANNEL channelName)?
    ;

showSlaveStatus
    : SHOW SLAVE STATUS (FOR CHANNEL channelName)?
    ;

showStatus
    : SHOW (GLOBAL | SESSION)? STATUS showFilter?
    ;

showTableStatus
    : SHOW TABLE STATUS fromDatabase? showFilter?
    ;

showTables
    : SHOW EXTENDED? FULL? TABLES fromDatabase? showFilter?
    ;

showTriggers
    : SHOW TRIGGERS fromDatabase? showFilter?
    ;

showVariables
    : SHOW (GLOBAL | SESSION)? VARIABLES showFilter?
    ;

showWarnings
    : SHOW (COUNT LP_ ASTERISK_ RP_)? WARNINGS limitClause?
    ;

showCharset
    : SHOW CHARSET
    ;

setCharacter
    : SET (CHARACTER SET | CHARSET) (charsetName | DEFAULT)
    ;

clone
    : CLONE cloneAction
    ;

cloneAction
    : LOCAL DATA DIRECTORY EQ_? cloneDir
    | INSTANCE FROM cloneInstance IDENTIFIED BY string_ (DATA DIRECTORY EQ_? cloneDir)? (REQUIRE NO? SSL)?
    ;

createLoadableFunction
    : CREATE AGGREGATE? FUNCTION functionName RETURNS (STRING | INTEGER | INT | REAL | DECIMAL | DEC) SONAME shardLibraryName
    ;

install
    : installComponent | installPlugin
    ;

uninstall
    :uninstallComponent | uninstallPlugin
    ;

installComponent
    : INSTALL COMPONENT componentName (COMMA_ componentName)*
    ;

installPlugin
    : INSTALL PLUGIN pluginName SONAME shardLibraryName
    ;

uninstallComponent
    : UNINSTALL COMPONENT componentName (COMMA_ componentName)*
    ;

uninstallPlugin
    : UNINSTALL PLUGIN pluginName
    ;

analyzeTable
    : ANALYZE (NO_WRITE_TO_BINLOG | LOCAL)? tableOrTables tableList histogram?
    ;

histogram
    : UPDATE HISTOGRAM ON columnNames (WITH NUMBER_ BUCKETS | USING DATA string_)?
    | DROP HISTOGRAM ON columnNames
    ;

checkTable
    : CHECK tableOrTables tableList checkTableOption?
    ;

checkTableOption
    : FOR UPGRADE | QUICK | FAST | MEDIUM | EXTENDED | CHANGED
    ;

checksumTable
    : CHECKSUM tableOrTables tableList (QUICK | EXTENDED)?
    ;

optimizeTable
    : OPTIMIZE (NO_WRITE_TO_BINLOG | LOCAL)? tableOrTables tableList
    ;

repairTable
    : REPAIR (NO_WRITE_TO_BINLOG | LOCAL)? tableOrTables tableList QUICK? EXTENDED? USE_FRM?
    ;

alterResourceGroup
    : ALTER RESOURCE GROUP groupName (VCPU EQ_? vcpuSpec (COMMA_ vcpuSpec)*)? (THREAD_PRIORITY EQ_? NUMBER_)?
    (ENABLE | DISABLE FORCE?)?
    ;

vcpuSpec
    : NUMBER_ | NUMBER_ MINUS_ NUMBER_
    ;

createResourceGroup
    : CREATE RESOURCE GROUP groupName TYPE EQ_ (SYSTEM | USER) (VCPU EQ_? vcpuSpec (COMMA_ vcpuSpec)*)?
    (THREAD_PRIORITY EQ_? numberLiterals)? (ENABLE | DISABLE)?
    ;

dropResourceGroup
    : DROP RESOURCE GROUP groupName FORCE?
    ;

setResourceGroup
    : SET RESOURCE GROUP groupName (FOR NUMBER_ (COMMA_ NUMBER_)*)?
    ;

binlog
    : BINLOG stringLiterals
    ;

cacheIndex
    : CACHE INDEX (cacheTableIndexList (COMMA_ cacheTableIndexList)* | tableName PARTITION LP_ partitionList RP_) IN (identifier | DEFAULT)
    ;

cacheTableIndexList
    : tableName ((INDEX | KEY) LP_ indexName (COMMA_ indexName)* RP_)?
    ;

partitionList
    : ALL | partitionName (COMMA_ partitionName)*
    ;

flush
    : FLUSH (NO_WRITE_TO_BINLOG | LOCAL)? (flushOption (COMMA_ flushOption)* | tablesOption)
    ;

flushOption
    : BINARY LOGS | ENGINE LOGS | ERROR LOGS | GENERAL LOGS | HOSTS | LOGS | PRIVILEGES | OPTIMIZER_COSTS
    | RELAY LOGS (FOR CHANNEL channelName)? | SLOW LOGS | STATUS | USER_RESOURCES
    ;

tablesOption
    : (TABLES | TABLE)
    | (TABLES | TABLE) tableName (COMMA_ tableName)*
    | (TABLES | TABLE) WITH READ LOCK
    | (TABLES | TABLE) tableName (COMMA_ tableName)* WITH READ LOCK
    | (TABLES | TABLE) tableName (COMMA_ tableName)* FOR EXPORT
    ;

kill
    : KILL (CONNECTION | QUERY)? AT_? IDENTIFIER_
    ;

loadIndexInfo
    : LOAD INDEX INTO CACHE loadTableIndexList (COMMA_ loadTableIndexList)*
    ;

loadTableIndexList
    : tableName (PARTITION LP_ partitionList RP_)? ((INDEX | KEY) LP_ indexName (COMMA_ indexName)* RP_)? (IGNORE LEAVES)?
    ;

resetStatement
    : RESET resetOption (COMMA_ resetOption)*
    | resetPersist
    ;

resetOption
    : MASTER (TO binaryLogFileIndexNumber)?
    | SLAVE ALL? channelOption?
    | REPLICA
    | QUERY CACHE
    ;

resetPersist
    : RESET PERSIST (ifExists? identifier)?
    ;

restart
    : RESTART
    ;

shutdown
    : SHUTDOWN
    ;

explainType
    : (FORMAT EQ_ formatName | EXTENDED | PARTITIONS)
    ;

explainableStatement
    : select | delete | insert | replace | update
    ;

formatName
    : TRADITIONAL | JSON | TREE
    ;

delimiter
    : DELIMITER delimiterName
    ;

show
    : showDatabases
    | showTables
    | showTableStatus
    | showBinaryLogs
    | showColumns
    | showIndex
    | showCreateDatabase
    | showCreateTable
    | showBinlogEvents
    | showCharacterSet
    | showCollation
    | showCreateEvent
    | showCreateFunction
    | showCreateProcedure
    | showCreateTrigger
    | showCreateUser
    | showCreateView
    | showEngine
    | showEngines
    | showCharset
    | showErrors
    | showEvents
    | showFunctionCode
    | showFunctionStatus
    | showGrants
    | showMasterStatus
    | showPlugins
    | showOpenTables
    | showPrivileges
    | showProcedureCode
    | showProcesslist
    | showProfile
    | showProcedureStatus
    | showProfiles
    | showSlaveHosts
    | showSlaveStatus
    | showRelaylogEvent
    | showStatus
    | showTriggers
    | showWarnings
    | showVariables
    | showReplicas
    | showReplicaStatus
    ;
