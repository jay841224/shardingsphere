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

package org.apache.shardingsphere.infra.instance.metadata;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.apache.shardingsphere.infra.instance.ComputeNodeData;
import org.apache.shardingsphere.infra.instance.metadata.jdbc.JDBCInstanceMetaData;
import org.apache.shardingsphere.infra.instance.metadata.proxy.ProxyInstanceMetaData;

/**
 * Instance meta data factory.
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class InstanceMetaDataFactory {
    
    /**
     * Create instance meta data.
     *
     * @param instanceId instance ID
     * @param instanceType instance type
     * @param computeNodeData compute node data
     * @return created instance meta data
     */
    public static InstanceMetaData create(final String instanceId, final InstanceType instanceType, final ComputeNodeData computeNodeData) {
        return InstanceType.JDBC == instanceType
                ? new JDBCInstanceMetaData(instanceId, computeNodeData.getAttribute(), computeNodeData.getVersion(), computeNodeData.getDatabaseName())
                : new ProxyInstanceMetaData(instanceId, computeNodeData.getAttribute(), computeNodeData.getVersion());
    }
}
