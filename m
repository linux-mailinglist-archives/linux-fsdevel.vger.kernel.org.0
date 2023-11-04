Return-Path: <linux-fsdevel+bounces-1970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F07E0F2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5411F21A26
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220F15EBA;
	Sat,  4 Nov 2023 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOc9gq8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BC15AE1;
	Sat,  4 Nov 2023 11:40:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE8D47;
	Sat,  4 Nov 2023 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699098017; x=1730634017;
  h=date:from:to:cc:subject:message-id;
  bh=R5fbyZNoG92iMIcrIldYkP+kzevNvG+y24CP2QYUrd0=;
  b=BOc9gq8Bq0VItyFmGgi/e81BPRfVnnUlJRUiVOnehtRBSeXzc0yRDOj9
   M7fDLOs79S5NB7TlXcIChZcI3YC0GF0IBDomRb2BvM3NJ2AhT5GWXCV5l
   RfMzJRdLf4UFJ6XvwabBg87iHE3aYhE8qd8kpD7nqCsUMm8h/gOh8ivNd
   Zaocz7biY15C7tmTebEQZppW6kPP4GPSjbiLt5AMpcGBEjnW1g4Je0pCz
   U4QDBq3eNGDAh5yZt9WojT5a7YibzNMOGb/PNirVRaZ1iXN8YRyfqnPMu
   55l4qxeM9sfF2PAm/nvsk6uY9N6KpGTgmKD9G/PGEpD8IuCbEY1kmD0kV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="2042362"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="2042362"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="711769833"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="711769833"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2023 04:40:08 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzF0Y-0004CT-1g;
	Sat, 04 Nov 2023 11:40:06 +0000
Date: Sat, 04 Nov 2023 19:38:56 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 alsa-devel@alsa-project.org, apparmor@lists.ubuntu.com,
 coreteam@netfilter.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-bcachefs@vger.kernel.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [linux-next:master] BUILD REGRESSION
 e27090b1413ff236ca1aec26d6b022149115de2c
Message-ID: <202311041939.0TTy6fVA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e27090b1413ff236ca1aec26d6b022149115de2c  Add linux-next specific files for 20231103

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310261059.USL6VstF-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310262104.JQhDdU3I-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310272130.WYttKhJa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311011040.L1ncxDT3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311011659.fOMoFPWP-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311031313.UUxwfuQJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311031648.9xiTejVV-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311031714.Xwzfduzn-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311041515.Rg81QtyA-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

/bin/bash: line 1: 54552 Segmentation fault      LLVM_OBJCOPY="loongarch64-linux-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/cxl/core/cxl_core.ko
Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
arch/riscv/kernel/cpufeature.c:562:6: error: conflicting types for 'check_unaligned_access'; have 'void(int)'
arch/riscv/kernel/smpboot.c:251:32: warning: passing argument 1 of 'check_unaligned_access' makes pointer from integer without a cast [-Wint-conversion]
fs/bcachefs/disk_groups.c:583:6: warning: no previous prototype for 'bch2_target_to_text_sb' [-Wmissing-prototypes]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/riscv/kernel/smpboot.c: asm/cpufeature.h is included more than once.
arch/x86/kernel/cpu/cacheinfo.c:341:24: sparse: sparse: too long token expansion
drivers/firmware/sysfb_simplefb.c:60:34: sparse: sparse: too long token expansion
drivers/media/pci/solo6x10/solo6x10-core.c:362:24: sparse: sparse: too long token expansion
drivers/media/pci/solo6x10/solo6x10-enc.c:245:18: sparse: sparse: too long token expansion
drivers/media/pci/solo6x10/solo6x10-p2m.c:309:13: sparse: sparse: too long token expansion
drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c:468:30: sparse: sparse: too long token expansion
security/safesetid/lsm.c:265:21: sparse: sparse: symbol 'safesetid_lsmid' was not declared. Should it be static?
security/yama/yama_lsm.c:425:21: sparse: sparse: symbol 'yama_lsmid' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- alpha-defconfig
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- alpha-randconfig-r016-20221212
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- arc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arc-randconfig-001-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|-- arc-randconfig-002-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arm-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-defconfig
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- arm-randconfig-001-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-002-20231103
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm-randconfig-003-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arm-randconfig-004-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- arm-randconfig-r034-20220611
|   `-- bin-bash:line:Segmentation-fault-scripts-mod-modpost-M-m-w-N-W-o-Module.symvers-n-T-modules.order-vmlinux.o
|-- arm64-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm64-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm64-defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-randconfig-001-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   `-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|-- arm64-randconfig-002-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- arm64-randconfig-003-20231103
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arm64-randconfig-004-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- csky-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- csky-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- csky-randconfig-001-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- csky-randconfig-002-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-buildonly-randconfig-001-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-002-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-003-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-004-20231103
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-spi-spi-s3c64xx.c:warning:s3c64xx_spi_dt_match-defined-but-not-used
|   |-- drivers-spi-spi-st-ssc4.c:warning:stm_spi_match-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-005-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   `-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|-- i386-buildonly-randconfig-006-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-debian-10.3
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- i386-randconfig-001-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-002-20231103
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-004-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-005-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   `-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|-- i386-randconfig-006-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-011-20231103
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-012-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-013-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-014-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-015-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-016-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-061-20231102
|   `-- fs-bcachefs-sb-members.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__le64-usertype-errors_reset_time-got-signed-long-long
|-- i386-randconfig-061-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-firmware-sysfb_simplefb.c:sparse:sparse:too-long-token-expansion
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   `-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|-- i386-randconfig-062-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-firmware-sysfb_simplefb.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-media-pci-solo6x10-solo6x10-core.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-media-pci-solo6x10-solo6x10-enc.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-media-pci-solo6x10-solo6x10-p2m.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-media-pci-solo6x10-solo6x10-v4l2-enc.c:sparse:sparse:too-long-token-expansion
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- security-apparmor-domain.c:sparse:sparse:symbol-stack_msg-was-not-declared.-Should-it-be-static
|   |-- security-apparmor-lsm.c:sparse:sparse:symbol-nulldfa-was-not-declared.-Should-it-be-static
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-randconfig-063-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-firmware-sysfb_simplefb.c:sparse:sparse:too-long-token-expansion
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-141-20231103
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c-axi_chan_resume()-warn:inconsistent-indenting
|   |-- drivers-dma-dw-axi-dmac-dw-axi-dmac-platform.c-dma_chan_pause()-warn:inconsistent-indenting
|   |-- drivers-gpu-drm-scheduler-sched_main.c-drm_sched_init()-warn:Please-consider-using-kcalloc-instead-of-kmalloc_array
|   |-- drivers-gpu-drm-scheduler-sched_main.c-drm_sched_select_entity()-error:uninitialized-symbol-entity-.
|   |-- drivers-hwmon-sht3x.c-update_interval_write()-error:uninitialized-symbol-ret-.
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|-- loongarch-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-buildonly-randconfig-r001-20220908
|   `-- bin-bash:line:Segmentation-fault-LLVM_OBJCOPY-loongarch64-linux-objcopy-pahole-J-btf_gen_floats-j-lang_exclude-rust-skip_encoding_btf_inconsistent_proto-btf_gen_optimized-btf_base-vmlinux-drivers-cxl-
|-- loongarch-defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-randconfig-001-20231103
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- loongarch-randconfig-002-20231103
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- m68k-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- m68k-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- m68k-defconfig
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- m68k-hp300_defconfig
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- microblaze-allmodconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- microblaze-allnoconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   `-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|-- microblaze-allyesconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- microblaze-defconfig
|   |-- arch-microblaze-kernel-traps.c:warning:no-previous-prototype-for-trap_init
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-fp-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-loglvl-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-pc-not-described-in-unwind_trap
|   |-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-task-not-described-in-unwind_trap
|   `-- arch-microblaze-kernel-unwind.c:warning:Function-parameter-or-member-trace-not-described-in-unwind_trap
|-- mips-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- mips-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- mips-buildonly-randconfig-r002-20211019
|   `-- arch-mips-kernel-signal.c:error:struct-sigcontext-has-no-member-named-sc_acx
|-- mips-randconfig-r022-20230503
|   |-- arch-mips-kernel-cps-vec-ns16550.S:Error:invalid-operands-dmfc0
|   `-- arch-mips-kernel-cps-vec-ns16550.S:Error:invalid-operands-mfc0
|-- nios2-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-randconfig-001-20231103
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- nios2-randconfig-002-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- openrisc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- openrisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-randconfig-001-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- parisc-randconfig-002-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- powerpc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- powerpc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- powerpc-cell_defconfig
|   |-- arch-powerpc-kernel-rtas_pci.c:error:no-previous-prototype-for-rtas_read_config
|   `-- arch-powerpc-kernel-rtas_pci.c:error:no-previous-prototype-for-rtas_write_config
|-- powerpc-randconfig-001-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- powerpc-randconfig-002-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- powerpc-randconfig-003-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc-randconfig-c004-20221209
|   |-- crypto-async_tx-async_memcpy.c:(.text):undefined-reference-to-ppc440spe_async_tx_find_best_channel
|   |-- crypto-async_tx-async_pq.c:(.text):undefined-reference-to-ppc440spe_async_tx_find_best_channel
|   `-- crypto-async_tx-async_xor.c:(.text):undefined-reference-to-ppc440spe_async_tx_find_best_channel
|-- powerpc64-randconfig-001-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- powerpc64-randconfig-002-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- powerpc64-randconfig-003-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- riscv-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-allyesconfig
|   |-- arch-riscv-kernel-smpboot.c:warning:passing-argument-of-check_unaligned_access-makes-pointer-from-integer-without-a-cast
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-defconfig
|   |-- arch-riscv-kernel-smpboot.c:warning:passing-argument-of-check_unaligned_access-makes-pointer-from-integer-without-a-cast
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-randconfig-001-20231103
|   |-- drivers-net-ppp-pppoe.c:warning:variable-pde-set-but-not-used
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- sound-firewire-dice-dice.c:warning:)-at-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- riscv-randconfig-002-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- riscv-randconfig-r052-20230821
|   `-- arch-riscv-kernel-cpufeature.c:error:conflicting-types-for-check_unaligned_access-have-void(int)
|-- riscv-rv32_defconfig
|   |-- arch-riscv-kernel-smpboot.c:warning:passing-argument-of-check_unaligned_access-makes-pointer-from-integer-without-a-cast
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-defconfig
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-randconfig-001-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- net-ipv4-ipconfig.c:warning:variable-start_jiffies-set-but-not-used
|   `-- net-netfilter-xt_hashlimit.c:warning:variable-ops-set-but-not-used
|-- s390-randconfig-002-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- sh-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sh-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sh-randconfig-001-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- sh-randconfig-002-20231103
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|   |-- standard-input:Warning:overflow-in-branch-to-.L63-converted-into-longer-instruction-sequence
|   `-- standard-input:Warning:overflow-in-branch-to-.L72-converted-into-longer-instruction-sequence
|-- sh-randconfig-r015-20220514
|   `-- standard-input:Error:unknown-pseudo-op:cfi_rest
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-allnoconfig
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-allyesconfig
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-randconfig-001-20231103
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   |-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- sparc-randconfig-002-20231103
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   |-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-001-20231103
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-pci_sun4v.c:error:no-previous-prototype-for-dma_4v_iotsb_bind
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-002-20231103
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-alloc_tag_store
|   |-- arch-sparc-kernel-adi_64.c:error:no-previous-prototype-for-find_tag_store
|   |-- arch-sparc-kernel-traps_64.c:error:no-previous-prototype-for-trap_init
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- um-randconfig-001-20231103
|   `-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|-- um-randconfig-002-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-allnoconfig
|   |-- Warning:Documentation-devicetree-bindings-power-wakeup-source.txt-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-input-qcom-pm8xxx-keypad.txt
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-iio-imu-bosch-bma400.yaml
|   `-- arch-riscv-kernel-smpboot.c:asm-cpufeature.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-buildonly-randconfig-002-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-buildonly-randconfig-004-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-buildonly-randconfig-006-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- x86_64-randconfig-001-20231103
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-randconfig-002-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-004-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- x86_64-randconfig-005-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-006-20231103
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- x86_64-randconfig-011-20231103
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-012-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-013-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-014-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-randconfig-016-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-071-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-randconfig-073-20231103
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-074-20231103
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-randconfig-075-20231103
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- x86_64-randconfig-076-20231103
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-randconfig-121-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-122-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-safesetid-lsm.c:sparse:sparse:symbol-safesetid_lsmid-was-not-declared.-Should-it-be-static
|   `-- security-yama-yama_lsm.c:sparse:sparse:symbol-yama_lsmid-was-not-declared.-Should-it-be-static
|-- x86_64-randconfig-123-20231104
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-firmware-sysfb_simplefb.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- x86_64-rhel-8.3
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- xtensa-randconfig-001-20231103
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- fs-afs-dir.c:error:no-return-statement-in-function-returning-non-void
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
`-- xtensa-randconfig-002-20231103
    |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
    |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
    |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
    |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
    `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
clang_recent_errors
|-- powerpc-pmac32_defconfig
|   `-- sound-core-seq-seq_midi.c:warning:cast-from-int-(-)(struct-snd_rawmidi_substream-const-char-int)-to-snd_seq_dump_func_t-(aka-int-(-)(void-void-int)-)-converts-to-incompatible-function-type
`-- x86_64-rhel-8.3-rust
    |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt

elapsed time: 1933m

configs tested: 185
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231103   gcc  
arc                   randconfig-002-20231103   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231103   gcc  
arm                   randconfig-002-20231103   gcc  
arm                   randconfig-003-20231103   gcc  
arm                   randconfig-004-20231103   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231103   gcc  
arm64                 randconfig-002-20231103   gcc  
arm64                 randconfig-003-20231103   gcc  
arm64                 randconfig-004-20231103   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231103   gcc  
csky                  randconfig-002-20231103   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231103   gcc  
i386         buildonly-randconfig-002-20231103   gcc  
i386         buildonly-randconfig-003-20231103   gcc  
i386         buildonly-randconfig-004-20231103   gcc  
i386         buildonly-randconfig-005-20231103   gcc  
i386         buildonly-randconfig-006-20231103   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231103   gcc  
i386                  randconfig-002-20231103   gcc  
i386                  randconfig-003-20231103   gcc  
i386                  randconfig-004-20231103   gcc  
i386                  randconfig-005-20231103   gcc  
i386                  randconfig-006-20231103   gcc  
i386                  randconfig-011-20231103   gcc  
i386                  randconfig-012-20231103   gcc  
i386                  randconfig-013-20231103   gcc  
i386                  randconfig-014-20231103   gcc  
i386                  randconfig-015-20231103   gcc  
i386                  randconfig-016-20231103   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231103   gcc  
loongarch             randconfig-002-20231103   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1c_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231103   gcc  
nios2                 randconfig-002-20231103   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231103   gcc  
parisc                randconfig-002-20231103   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20231103   gcc  
powerpc               randconfig-002-20231103   gcc  
powerpc               randconfig-003-20231103   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20231103   gcc  
powerpc64             randconfig-002-20231103   gcc  
powerpc64             randconfig-003-20231103   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231103   gcc  
riscv                 randconfig-002-20231103   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231103   gcc  
s390                  randconfig-002-20231103   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231103   gcc  
sh                    randconfig-002-20231103   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231103   gcc  
sparc                 randconfig-002-20231103   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231103   gcc  
sparc64               randconfig-002-20231103   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231103   gcc  
um                    randconfig-002-20231103   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231103   gcc  
x86_64       buildonly-randconfig-002-20231103   gcc  
x86_64       buildonly-randconfig-003-20231103   gcc  
x86_64       buildonly-randconfig-004-20231103   gcc  
x86_64       buildonly-randconfig-005-20231103   gcc  
x86_64       buildonly-randconfig-006-20231103   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231103   gcc  
x86_64                randconfig-002-20231103   gcc  
x86_64                randconfig-003-20231103   gcc  
x86_64                randconfig-004-20231103   gcc  
x86_64                randconfig-005-20231103   gcc  
x86_64                randconfig-006-20231103   gcc  
x86_64                randconfig-011-20231103   gcc  
x86_64                randconfig-012-20231103   gcc  
x86_64                randconfig-013-20231103   gcc  
x86_64                randconfig-014-20231103   gcc  
x86_64                randconfig-015-20231103   gcc  
x86_64                randconfig-016-20231103   gcc  
x86_64                randconfig-071-20231103   gcc  
x86_64                randconfig-072-20231103   gcc  
x86_64                randconfig-073-20231103   gcc  
x86_64                randconfig-074-20231103   gcc  
x86_64                randconfig-075-20231103   gcc  
x86_64                randconfig-076-20231103   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20231103   gcc  
xtensa                randconfig-002-20231103   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

