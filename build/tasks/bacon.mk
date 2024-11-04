# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# SIGMA OTA update package

SIGMA_TARGET_PACKAGE := $(PRODUCT_OUT)/$(LINEAGE_VERSION).zip
SIGMA_TARGET_CHANGELOG := $(PRODUCT_OUT)/$(LINEAGE_VERSION)-Changelog.txt
ECHO_BLUE := \e[34m
ECHO_GREEN := \e[32m
ECHO_ENDCOLOR := \e[0m

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bacon
bacon: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv -f $(INTERNAL_OTA_PACKAGE_TARGET) $(SIGMA_TARGET_PACKAGE)
	$(hide) $(SHA256) $(SIGMA_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(SIGMA_TARGET_PACKAGE).sha256sum
	$(hide) ./vendor/lineage/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) $(LINEAGE_VERSION).zip
	$(hide) cp Changelog.txt $(SIGMA_TARGET_CHANGELOG)
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)
	$(hide) ./vendor/lineage/tools/ascii_output.sh
	@echo -e "$(ECHO_GREEN)===================================================================${ECHO_ENDCOLOR}"
	@echo -e " ${ECHO_BLUE}OTA Package Complete:${ECHO_ENDCOLOR} $(SIGMA_TARGET_PACKAGE)"
	@echo -e " ${ECHO_BLUE}OTA Changelog:${ECHO_ENDCOLOR} $(SIGMA_TARGET_CHANGELOG)"
	@echo -e "${ECHO_GREEN}===================================================================${ECHO_ENDCOLOR}"
	@echo ""