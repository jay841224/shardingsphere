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

package io.shardingsphere.proxy.transport.mysql.constant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * New parameters bound flag.
 * @see <a href="https://dev.mysql.com/doc/internals/en/com-stmt-execute.html">COM_STMT_EXECUTE</a>
 *
 * @author zhangyonglun
 */
@RequiredArgsConstructor
@Getter
public enum NewParametersBoundFlag {
    
    PARAMETER_TYPE_EXIST(1),
    PARAMETER_TYPE_NOT_EXIST(0);
    
    private final int value;
    
    /**
     * Value of.
     * 
     * @param value value
     * @return new parameters bound flag
     */
    public static NewParametersBoundFlag valueOf(final int value) {
        for (NewParametersBoundFlag each : NewParametersBoundFlag.values()) {
            if (value == each.value) {
                return each;
            }
        }
        throw new IllegalArgumentException(String.format("Cannot find value '%s' in new parameters bound flag", value));
    }
}
