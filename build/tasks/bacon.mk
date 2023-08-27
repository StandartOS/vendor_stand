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
# StandartOS update package

STANDARTOS_TARGET_PACKAGE := $(PRODUCT_OUT)/$(STANDARTOS_VERSION).zip
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(STANDARTOS_TARGET_PACKAGE)
	$(hide) $(SHA256) $(STANDARTOS_TARGET_PACKAGE) | cut -d ' ' -f1 > $(STANDARTOS_TARGET_PACKAGE).sha256sum
	@echo "Done"
	@echo -e "\t ===============================-Package complete-========================================="
	@echo -e "\t Zip: $(STANDARTOS_TARGET_PACKAGE)" >&2
	@echo -e "\t Size: `du -sh $(STANDARTOS_TARGET_PACKAGE) | awk '{print $$1}' `"
	@echo -e "sha256:" $(shell cat $(STANDARTOS_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1)
	@echo -e "\t =========================================================================================="
