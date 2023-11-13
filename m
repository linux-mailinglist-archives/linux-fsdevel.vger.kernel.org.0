Return-Path: <linux-fsdevel+bounces-2792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF77E9DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5E81C209AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633B20B22;
	Mon, 13 Nov 2023 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaYwurpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756C208A2;
	Mon, 13 Nov 2023 13:47:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC3D4E;
	Mon, 13 Nov 2023 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699883246; x=1731419246;
  h=date:from:to:cc:subject:message-id;
  bh=iVxELy8r9rPpxKQ0br6LUk9UBe2x5laec32TwJ4lrUU=;
  b=CaYwurpWnwd4znObBJLbAxdlQUjNSVILhKug0vMh3BWk4E0y32dz+uPb
   kokhdB6cZ3QmYqCtQhO+wR9rF+4IMwaSQuF1ZVVnY5nR2fUAkSPBpQ6U5
   lWuFRhrbe+5eYHGRuLv8UuXA/9S5bVzs/9XFd/+5Hbkq4BR+W74SSVJlP
   WlPXKWDrxRkmq441HiNknEL/3DMEbh9hYI5lqLNUmymNCuhqh9MSzWo9p
   aU94pDN/XckxJkZKqH6EY70nEblDZFDJBkGcV9vJH5uo8mC+MkX0dwgt2
   wAvkUFOlE8EPrgogPiY1c1N+X5j4ayxGvhdAKxyKjMp3cxhK6SV/rjx0g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3519593"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3519593"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="740771425"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740771425"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2023 05:47:13 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r2XHT-000C9p-1P;
	Mon, 13 Nov 2023 13:47:11 +0000
Date: Mon, 13 Nov 2023 21:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 alsa-devel@alsa-project.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, coreteam@netfilter.org,
 dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 d173336e238b0f7f5b7eddfa641d7c25c24bb86a
Message-ID: <202311132145.dmvawNds-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: d173336e238b0f7f5b7eddfa641d7c25c24bb86a  Add linux-next specific files for 20231113

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310261059.USL6VstF-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310272130.WYttKhJa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310301338.pB7KCZxs-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311011040.L1ncxDT3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311011659.fOMoFPWP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
drivers/gpu/drm/mediatek/mtk_disp_gamma.c:121:6: warning: variable 'cfg_val' set but not used [-Wunused-but-set-variable]
fs/bcachefs/disk_groups.c:583:6: warning: no previous prototype for 'bch2_target_to_text_sb' [-Wmissing-prototypes]
fs/bcachefs/disk_groups.c:583:6: warning: no previous prototype for function 'bch2_target_to_text_sb' [-Wmissing-prototypes]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/riscv/kernel/smpboot.c: asm/cpufeature.h is included more than once.
arch/x86/kernel/cpu/cacheinfo.c:341:24: sparse: sparse: too long token expansion
block/bdev.c:832 bdev_open_by_dev() warn: possible memory leak of 'handle'
drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: warning: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- arc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arc-randconfig-001-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arc-randconfig-002-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arm-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-allnoconfig
|   `-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|-- arm-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm-defconfig
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- arm-randconfig-001-20231113
|   |-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- arm-randconfig-002-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   `-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|-- arm-randconfig-003-20231113
|   |-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- arm-randconfig-004-20231113
|   |-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- arm-stm32_defconfig
|   `-- arch-arm-kernel-process.c:warning:variable-buf-set-but-not-used
|-- arm64-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- arm64-defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- arm64-randconfig-001-20231113
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
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
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- arm64-randconfig-002-20231113
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|   `-- sound-firewire-dice-dice.c:warning:)-at-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- arm64-randconfig-003-20231113
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- arm64-randconfig-004-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- csky-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- csky-allyesconfig
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|-- i386-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- i386-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- i386-buildonly-randconfig-001-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-net-ppp-pppoe.c:warning:variable-pde-set-but-not-used
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-buildonly-randconfig-002-20231113
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-003-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-net-ppp-pppoe.c:warning:variable-pde-set-but-not-used
|   |-- drivers-net-wireless-intersil-hostap-hostap_ap.c:warning:ap_control_proc_seqops-defined-but-not-used
|   |-- drivers-net-wireless-intersil-hostap-hostap_ap.c:warning:prism2_ap_proc_seqops-defined-but-not-used
|   |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_bss_list_proc_seqops-defined-but-not-used
|   |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_scan_results_proc_seqops-defined-but-not-used
|   |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_wds_proc_seqops-defined-but-not-used
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-buildonly-randconfig-004-20231113
|   `-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|-- i386-buildonly-randconfig-005-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-buildonly-randconfig-006-20231113
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   `-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|-- i386-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- i386-randconfig-001-20231113
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-002-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-003-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   `-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|-- i386-randconfig-004-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- i386-randconfig-005-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-006-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-011-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   `-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|-- i386-randconfig-014-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-015-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   `-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|-- i386-randconfig-016-20231113
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-061-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- i386-randconfig-062-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-063-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-mtd-nand-raw-nand_legacy.c:sparse:sparse:cast-from-restricted-__le16
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-noderef-__rcu-f-got-struct-file-f
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-assigned-file
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- i386-randconfig-141-20231113
|   |-- block-bdev.c-bdev_open_by_dev()-warn:possible-memory-leak-of-handle
|   |-- crypto-tcrypt.c-do_test()-warn:Function-too-hairy.-No-more-merges.
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-hwmon-sht3x.c-update_interval_write()-error:uninitialized-symbol-ret-.
|   |-- drivers-hwtracing-stm-core.c-stm_register_device()-error:double-free-of-stm
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-bkey_methods.c-__bch2_bkey_compat()-warn:for-statement-not-indented
|   |-- fs-bcachefs-btree_update.c-bch2_trans_update_by_path()-error:uninitialized-symbol-cmp-.
|   |-- fs-bcachefs-btree_write_buffer.c-__bch2_btree_write_buffer_flush()-error:we-previously-assumed-iter.path-could-be-null-(see-line-)
|   |-- fs-bcachefs-buckets.c-bch2_trans_fs_usage_apply()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   |-- fs-bcachefs-chardev.c-bch2_ioctl_fs_usage()-warn:check-for-integer-overflow-replica_entries_bytes
|   |-- fs-bcachefs-compress.c-__bounce_alloc()-warn:possible-memory-leak-of-b
|   |-- fs-bcachefs-ec.c-bch2_ec_stripe_head_get()-error:we-previously-assumed-h-s-could-be-null-(see-line-)
|   |-- fs-bcachefs-fs-io-buffered.c-__bch2_writepage()-error:we-previously-assumed-w-io-could-be-null-(see-line-)
|   |-- fs-bcachefs-journal_io.c-journal_entry_add()-warn:missing-error-code-ret
|   |-- fs-bcachefs-movinggc.c-bch2_copygc()-error:f-dereferencing-possible-ERR_PTR()
|   |-- fs-bcachefs-reflink.c-bch2_reflink_p_merge()-warn:ignoring-unreachable-code.
|   |-- fs-bcachefs-six.c-__do_six_trylock()-error:uninitialized-symbol-old-.
|   |-- fs-bcachefs-super.c-__bch2_fs_read_write()-warn:missing-unwind-goto
|   |-- kernel-sched-fair.c-find_energy_efficient_cpu()-error:uninitialized-symbol-best_energy_cpu-.
|   |-- kernel-sched-fair.c-select_idle_sibling()-error:uninitialized-symbol-util_max-.
|   |-- kernel-sched-fair.c-select_idle_sibling()-error:uninitialized-symbol-util_min-.
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|-- loongarch-allmodconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-allnoconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|-- loongarch-allyesconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-defconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- loongarch-randconfig-001-20231113
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- loongarch-randconfig-002-20231113
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_kvm_defines
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- m68k-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|-- m68k-defconfig
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- m68k-q40_defconfig
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- arch-mips-kernel-ftrace.c:warning:no-previous-prototype-for-prepare_ftrace_return
|   |-- arch-mips-kernel-machine_kexec.c:warning:no-previous-prototype-for-machine_shutdown
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- mips-allyesconfig
|   |-- arch-mips-kernel-ftrace.c:warning:no-previous-prototype-for-prepare_ftrace_return
|   |-- arch-mips-kernel-machine_kexec.c:warning:no-previous-prototype-for-machine_shutdown
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- mips-decstation_64_defconfig
|   |-- arch-mips-dec-prom-identify.c:warning:variable-dec_cpunum-set-but-not-used
|   |-- arch-mips-dec-prom-identify.c:warning:variable-dec_firmrev-set-but-not-used
|   |-- arch-mips-dec-prom-init.c:warning:no-previous-prototype-for-which_prom
|   |-- arch-mips-dec-reset.c:warning:no-previous-prototype-for-dec_machine_restart
|   |-- arch-mips-kernel-cevt-ds1287.c:warning:no-previous-prototype-for-ds1287_clockevent_init
|   |-- drivers-tc-tc-driver.c:warning:Excess-function-parameter-drv-description-in-tc_unregister_driver
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- nios2-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- nios2-randconfig-001-20231113
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- nios2-randconfig-002-20231113
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- openrisc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- openrisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- parisc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- parisc-randconfig-001-20231113
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-spi-spi-s3c64xx.c:warning:s3c64xx_spi_dt_match-defined-but-not-used
|   |-- drivers-spi-spi-st-ssc4.c:warning:stm_spi_match-defined-but-not-used
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- parisc-randconfig-002-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
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
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   `-- net-ipv4-ipconfig.c:warning:variable-start_jiffies-set-but-not-used
|-- powerpc-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- powerpc-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- powerpc-randconfig-002-20231113
|   |-- arch-powerpc-platforms-powermac-smp.c:warning:no-previous-prototype-for-smp_psurge_give_timebase
|   |-- arch-powerpc-sysdev-cpm2_pic.c:warning:variable-i-set-but-not-used
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-video-fbdev-fsl-diu-fb.c:warning:Function-parameter-or-member-bits_per_pixel-not-described-in-fsl_diu_get_pixel_format
|   |-- drivers-video-fbdev-fsl-diu-fb.c:warning:Function-parameter-or-member-mfb-not-described-in-fsl_diu_data
|   |-- drivers-video-fbdev-fsl-diu-fb.c:warning:variable-hw-set-but-not-used
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   `-- sound-soc-fsl-mpc5200_psc_ac97.c:warning:cannot-understand-function-prototype:const-struct-snd_soc_dai_ops-psc_ac97_analog_ops
|-- powerpc-stx_gp3_defconfig
|   `-- arch-powerpc-sysdev-cpm2_pic.c:warning:variable-i-set-but-not-used
|-- powerpc64-randconfig-001-20231113
|   |-- arch-powerpc-kernel-traps.c:warning:no-previous-prototype-for-is_valid_bugaddr
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
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
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- powerpc64-randconfig-003-20231113
|   |-- arch-powerpc-kernel-traps.c:warning:no-previous-prototype-for-is_valid_bugaddr
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- riscv-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- riscv-randconfig-001-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- riscv-randconfig-002-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- riscv-rv32_defconfig
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-debug_defconfig
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-defconfig
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- s390-randconfig-001-20231113
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- net-netfilter-xt_hashlimit.c:warning:variable-ops-set-but-not-used
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- s390-randconfig-002-20231113
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sh-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|-- sh-randconfig-002-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-allnoconfig
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-allyesconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   `-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|-- sparc-randconfig-001-20231113
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   |-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc-randconfig-002-20231113
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- kernel-dma.c:warning:no-previous-prototype-for-free_dma
|   |-- kernel-dma.c:warning:no-previous-prototype-for-request_dma
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:error:variable-strtab-set-but-not-used
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- sparc64-randconfig-001-20231113
|   |-- drivers-input-touchscreen-wdt87xx_i2c.c:warning:wdt87xx_acpi_id-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- um-randconfig-001-20231113
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- um-randconfig-002-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   `-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|-- x86_64-allnoconfig
|   |-- Warning:Documentation-devicetree-bindings-power-wakeup-source.txt-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-input-qcom-pm8xxx-keypad.txt
|   |-- Warning:MAINTAINERS-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-iio-imu-bosch-bma400.yaml
|   |-- arch-riscv-include-asm-insn-def.h:asm-gpr-num.h-is-included-more-than-once.
|   |-- arch-riscv-kernel-smpboot.c:asm-cpufeature.h-is-included-more-than-once.
|   |-- drivers-pinctrl-qcom-pinctrl-lpass-lpi.c:linux-seq_file.h-is-included-more-than-once.
|   |-- include-linux-gpio-consumer.h:linux-err.h-is-included-more-than-once.
|   |-- include-linux-gpio-driver.h:asm-bug.h-is-included-more-than-once.
|   |-- include-linux-gpio-driver.h:linux-err.h-is-included-more-than-once.
|   `-- kernel-bpf-bpf_struct_ops.c:bpf_struct_ops_types.h-is-included-more-than-once.
|-- x86_64-allyesconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-firmware-broadcom-bcm47xx_sprom.c:warning:snprintf-output-may-be-truncated-before-the-last-format-character
|   |-- drivers-input-touchscreen-stmpe-ts.c:warning:stmpe_ts_ids-defined-but-not-used
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|-- x86_64-buildonly-randconfig-002-20231113
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-buildonly-randconfig-003-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|-- x86_64-defconfig
|   `-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|-- x86_64-randconfig-001-20231113
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
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
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- x86_64-randconfig-002-20231113
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-003-20231113
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-004-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-randconfig-005-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   `-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|-- x86_64-randconfig-006-20231113
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
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
|   `-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|-- x86_64-randconfig-014-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
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
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-016-20231113
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
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
|   `-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|-- x86_64-randconfig-071-20231113
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
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
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-121-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-122-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-leds-leds-pca955x.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   `-- sound-firewire-dice-dice.c:warning:)-at-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-123-20231113
|   |-- arch-x86-kernel-cpu-cacheinfo.c:sparse:sparse:too-long-token-expansion
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-in-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-olen-not-described-in-sw842_compress
|   |-- lib-842_compress.c:warning:Function-parameter-or-member-wmem-not-described-in-sw842_compress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-ilen-not-described-in-sw842_decompress
|   |-- lib-842_decompress.c:warning:Function-parameter-or-member-out-not-described-in-sw842_decompress
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-ida_dump
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-randconfig-161-20231113
|   |-- block-bdev.c-bdev_open_by_dev()-warn:possible-memory-leak-of-handle
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-char-tpm-tpm_tis_spi_main.c-tpm_tis_spi_transfer_half()-error:uninitialized-symbol-ret-.
|   |-- drivers-gpu-drm-scheduler-sched_main.c-drm_sched_init()-warn:Please-consider-using-kcalloc-instead-of-kmalloc_array
|   |-- drivers-gpu-drm-scheduler-sched_main.c-drm_sched_select_entity()-error:uninitialized-symbol-entity-.
|   |-- drivers-hwtracing-stm-core.c-stm_register_device()-error:double-free-of-stm
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   `-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|-- x86_64-rhel-8.3
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
|   |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
|   |-- net-8021q-vlan.c:warning:i-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size-between-and
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
`-- xtensa-randconfig-001-20231113
    |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
    |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
    |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
    |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
    |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
    |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
    |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
    |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
    |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
    |-- drivers-net-wireless-intersil-hostap-hostap_ap.c:warning:ap_control_proc_seqops-defined-but-not-used
    |-- drivers-net-wireless-intersil-hostap-hostap_ap.c:warning:prism2_ap_proc_seqops-defined-but-not-used
    |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_bss_list_proc_seqops-defined-but-not-used
    |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_scan_results_proc_seqops-defined-but-not-used
    |-- drivers-net-wireless-intersil-hostap-hostap_proc.c:warning:prism2_wds_proc_seqops-defined-but-not-used
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
    `-- net-netfilter-xt_hashlimit.c:warning:variable-ops-set-but-not-used
clang_recent_errors
|-- arm64-allmodconfig
|   |-- block-partitions-aix.c:warning:Function-parameter-or-member-state-not-described-in-read_lba
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-file-not-described-in-binder_task_work_cb
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-length-not-described-in-binder_sg_copy
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-offset-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-skip_size-not-described-in-binder_ptr_fixup
|   |-- drivers-android-binder.c:warning:Function-parameter-or-member-thread-not-described-in-binder_free_buf
|   |-- drivers-android-binder_alloc.c:warning:Function-parameter-or-member-lru-not-described-in-binder_alloc_free_page
|   |-- drivers-clocksource-timer-ti-32k.c:warning:expecting-prototype-for-timer().-Prototype-was-for-OMAP2_32KSYNCNT_REV_OFF()-instead
|   |-- drivers-gpu-drm-mediatek-mtk_disp_gamma.c:warning:variable-cfg_val-set-but-not-used
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-host-not-described-in-memstick_remove_host
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-mrq-not-described-in-memstick_init_req
|   |-- drivers-memstick-core-memstick.c:warning:Function-parameter-or-member-tpc-not-described-in-memstick_init_req
|   |-- drivers-mtd-nand-raw-lpc32xx_mlc.c:warning:cast-from-irqreturn_t-(-)(int-struct-lpc32xx_nand_host-)-(aka-enum-irqreturn-(-)(int-struct-lpc32xx_nand_host-)-)-to-irq_handler_t-(aka-enum-irqreturn-(-)(in
|   |-- drivers-pci-controller-dwc-pcie-rcar-gen4.c:warning:cast-to-smaller-integer-type-enum-dw_pcie_device_mode-from-const-void
|   |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
|   |-- fs-bcachefs-disk_groups.c:warning:no-previous-prototype-for-function-bch2_target_to_text_sb
|   |-- fs-gfs2-glops.c:warning:Function-parameter-or-member-gl-not-described-in-inode_go_instantiate
|   |-- kernel-gcov-clang.c:warning:Excess-function-parameter-dest-description-in-gcov_info_add
|   |-- kernel-gcov-clang.c:warning:Excess-function-parameter-source-description-in-gcov_info_add
|   |-- kernel-gcov-clang.c:warning:Function-parameter-or-member-dst-not-described-in-gcov_info_add
|   |-- kernel-gcov-clang.c:warning:Function-parameter-or-member-src-not-described-in-gcov_info_add
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
|   |-- lib-test_ida.c:warning:no-previous-prototype-for-function-ida_dump
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
|   |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt
|   `-- sound-core-seq-seq_midi.c:warning:cast-from-int-(-)(struct-snd_rawmidi_substream-const-char-int)-to-snd_seq_dump_func_t-(aka-int-(-)(void-void-int)-)-converts-to-incompatible-function-type
`-- x86_64-rhel-8.3-rust
    |-- drivers-usb-host-xhci.c:warning:Function-parameter-or-member-desc-not-described-in-xhci_get_endpoint_index
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-buf-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-len-not-described-in-ftrace_set_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_filter
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_global_notrace
    |-- kernel-trace-ftrace.c:warning:Function-parameter-or-member-reset-not-described-in-ftrace_set_notrace
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-level-not-described-in-apparmor_socket_getsockopt
    |-- security-apparmor-lsm.c:warning:Function-parameter-or-member-optname-not-described-in-apparmor_socket_getsockopt
    `-- security-apparmor-lsm.c:warning:Function-parameter-or-member-sock-not-described-in-apparmor_socket_setsockopt

elapsed time: 741m

configs tested: 158
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231113   gcc  
arc                   randconfig-002-20231113   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231113   gcc  
arm                   randconfig-002-20231113   gcc  
arm                   randconfig-003-20231113   gcc  
arm                   randconfig-004-20231113   gcc  
arm                        spear3xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allmodconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231113   gcc  
arm64                 randconfig-002-20231113   gcc  
arm64                 randconfig-003-20231113   gcc  
arm64                 randconfig-004-20231113   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231113   gcc  
i386         buildonly-randconfig-002-20231113   gcc  
i386         buildonly-randconfig-003-20231113   gcc  
i386         buildonly-randconfig-004-20231113   gcc  
i386         buildonly-randconfig-005-20231113   gcc  
i386         buildonly-randconfig-006-20231113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231113   gcc  
i386                  randconfig-002-20231113   gcc  
i386                  randconfig-003-20231113   gcc  
i386                  randconfig-004-20231113   gcc  
i386                  randconfig-005-20231113   gcc  
i386                  randconfig-006-20231113   gcc  
i386                  randconfig-011-20231113   gcc  
i386                  randconfig-014-20231113   gcc  
i386                  randconfig-015-20231113   gcc  
i386                  randconfig-016-20231113   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231113   gcc  
loongarch             randconfig-002-20231113   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231113   gcc  
nios2                 randconfig-002-20231113   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231113   gcc  
parisc                randconfig-002-20231113   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc               randconfig-002-20231113   gcc  
powerpc               randconfig-003-20231113   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231113   gcc  
powerpc64             randconfig-003-20231113   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231113   gcc  
riscv                 randconfig-002-20231113   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231113   gcc  
s390                  randconfig-002-20231113   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-002-20231113   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231113   gcc  
sparc                 randconfig-002-20231113   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231113   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231113   gcc  
um                    randconfig-002-20231113   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-002-20231113   gcc  
x86_64       buildonly-randconfig-003-20231113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231113   gcc  
x86_64                randconfig-002-20231113   gcc  
x86_64                randconfig-003-20231113   gcc  
x86_64                randconfig-004-20231113   gcc  
x86_64                randconfig-005-20231113   gcc  
x86_64                randconfig-006-20231113   gcc  
x86_64                randconfig-014-20231113   gcc  
x86_64                randconfig-016-20231113   gcc  
x86_64                randconfig-071-20231113   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

