#!/bin/bash
# Copyright (c) 2022 Huawei Device Co., Ltd.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

logdir=${1:-.}

if tar tf "${logdir}" &>/dev/null; then
    mkdir "${logdir}.d"
    tar xf "${logdir}" -C "${logdir}.d"
    logdir="${logdir}.d"
fi

for f in $(find "${logdir}" -name 'asan.log.*'); do
    ./symbolize.sh < "$f" > "$f".resolved
done
