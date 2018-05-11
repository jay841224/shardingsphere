/*
 * Copyright 2016-2018 shardingsphere.io.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * </p>
 */

package io.shardingsphere.jdbc.orchestration.api.util;

import io.shardingsphere.jdbc.orchestration.internal.OrchestrationMasterSlaveDataSource;
import io.shardingsphere.jdbc.orchestration.internal.OrchestrationShardingDataSource;

import javax.sql.DataSource;

/**
 * Orchestration datasource closeable util.
 *
 * @author caohao
 */
public final class OrchestrationDataSourceCloseableUtil {
    
    /**
     * Close quietly.
     * 
     * @param dataSource dataSource
     */
    public static void closeQuietly(final DataSource dataSource) {
        if (dataSource instanceof OrchestrationShardingDataSource) {
            ((OrchestrationShardingDataSource) dataSource).close();
        }
        if (dataSource instanceof OrchestrationMasterSlaveDataSource) {
            ((OrchestrationMasterSlaveDataSource) dataSource).close();
        }
    }
}
