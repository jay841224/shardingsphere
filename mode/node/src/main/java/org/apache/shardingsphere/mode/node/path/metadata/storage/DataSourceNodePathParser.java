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

package org.apache.shardingsphere.mode.node.path.metadata.storage;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.apache.shardingsphere.mode.node.path.NewNodePathGenerator;
import org.apache.shardingsphere.mode.node.path.NodePathPattern;

import java.util.regex.Pattern;

/**
 * Data source node path parser.
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class DataSourceNodePathParser {
    
    private static final Pattern PATTERN = Pattern.compile(NewNodePathGenerator.generatePath(new StorageUnitNodePath(NodePathPattern.IDENTIFIER, null), true) + "?", Pattern.CASE_INSENSITIVE);
    
    /**
     * Is data source path.
     *
     * @param path path
     * @return is data source path or not
     */
    public static boolean isDataSourcePath(final String path) {
        return PATTERN.matcher(path).find();
    }
}
