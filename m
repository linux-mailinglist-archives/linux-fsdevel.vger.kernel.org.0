Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0E77EA81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbjHPUNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346081AbjHPUNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:13:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1B2110;
        Wed, 16 Aug 2023 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692216814; x=1723752814;
  h=date:from:to:cc:subject:message-id;
  bh=ZdzdQxsJjmQ8JIuGGBZstgJPExcyUMWs/7gsn+/nIGw=;
  b=GnKR0D+gJqzNnxJ6Vtny9Vjwe6F2UYSKRIaCqfWEjs68jTDeRAIyyNcg
   eaMO34p+wkRHXjU13L289lWhdimT/sKtCcLrd+8RmDicmVtMP2S91Ambq
   5h92Ww+Se5r2U+O1Id3AejreP8onvorlOiNuxV6qarN0rYJhfTVYInqwR
   FYqwLiiq/hmKroBckaSu7EPq9ARaH93/epzf3sT/ZXLpwUBPcvV1Zu/DH
   fqALBuQEJYPbmOEgA1oveZ4y6m34m/LimFtXgIEKwFjqRdDmry+TSLX51
   mZLJ6020I8QMNgXXkJr1Pe4K082piAUB8KZu6iS5R616mg0aQ587aApHO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458983593"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="458983593"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980851444"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="980851444"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 13:11:51 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWMru-0000Wn-0Z;
        Wed, 16 Aug 2023 20:11:50 +0000
Date:   Thu, 17 Aug 2023 04:11:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-wireless@vger.kernel.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 ef66bf8aeb91fd331cf8f5dca8f9d7bca9ab2849
Message-ID: <202308170404.3guzL22x-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: ef66bf8aeb91fd331cf8f5dca8f9d7bca9ab2849  Add linux-next specific files for 20230816

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307281049.40t8s0uv-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307301850.i9xFNWT6-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308111853.ISf5a6VC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308112307.TPmYbd3L-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308112326.AJAVWCOC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308162234.Y7j8JEIF-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308170007.OzhdwITj-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308170206.fZG3V1Gy-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308170227.ymiFlMbT-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING: Unknown directive type "c:namespace-push".
Documentation/gpu/rfc/i915_scheduler.rst:143: WARNING: Unknown directive type "c:namespace-pop".
Warning: kernel/Kconfig.kexec references a file that doesn't exist: file:Documentation/s390/zfcpdump.rst
arch/csky/include/asm/ptrace.h:100:11: error: expected ';' before 'void'
arch/csky/include/asm/ptrace.h:99:11: error: expected ';' before 'int'
arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
arch/loongarch/kernel/asm-offsets.c:172:6: warning: no previous prototype for 'output_thread_lbt_defines' [-Wmissing-prototypes]
drivers/gpu/drm/drm_gpuva_mgr.c:1079:32: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_gpuva_mgr.c:1079:39: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for drm_kunit_helper_context_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead
drivers/media/pci/intel/ivsc/mei_csi.c:342:10: error: call to undeclared function 'v4l2_subdev_get_try_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/media/pci/intel/ivsc/mei_csi.c:342:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct v4l2_mbus_framefmt *' [-Wint-conversion]
drivers/media/pci/intel/ivsc/mei_csi.c:360:14: error: incompatible integer to pointer conversion assigning to 'struct v4l2_mbus_framefmt *' from 'int' [-Wint-conversion]
drivers/video/backlight/lp855x_bl.c:252:11: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
fs/fuse/dir.c:353:6: warning: no previous declaration for 'fuse_valid_size' [-Wmissing-declarations]
include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
kernel/bpf/map_iter.c:201:17: warning: no previous declaration for 'bpf_map_sum_elem_count' [-Wmissing-declarations]
net/bpf/test_run.c:558:15: warning: no previous declaration for 'bpf_fentry_test_sinfo' [-Wmissing-declarations]
net/bpf/test_run.c:559:15: warning: no previous declaration for 'bpf_fentry_test_sinfo' [-Wmissing-declarations]
net/bpf/test_run.c:568:17: warning: no previous declaration for 'bpf_modify_return_test2' [-Wmissing-declarations]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/input/touchscreen/iqs7211.c:1761 iqs7211_parse_cycles() error: buffer overflow 'cycle_alloc[0]' 2 <= 41
drivers/mtd/nand/raw/qcom_nandc.c:2590 qcom_op_cmd_mapping() error: uninitialized symbol 'ret'.
drivers/mtd/nand/raw/qcom_nandc.c:3017 qcom_check_op() warn: was && intended here instead of ||?
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264 mlx5_devcom_send_event() warn: variable dereferenced before IS_ERR check 'devcom' (see line 259)
drivers/net/wireless/mediatek/mt76/mt792x_mac.c:362 mt792x_pm_power_save_work() warn: can 'dev->fw_assert' even be NULL?
drivers/pwm/pwm-atmel.c:479 atmel_pwm_enable_clk_if_on() warn: missing error code 'ret'
drivers/regulator/max77857-regulator.c:430:28: sparse: sparse: symbol 'max77857_id' was not declared. Should it be static?
drivers/rtc/rtc-pcf2127.c:1063 pcf2127_enable_ts() warn: missing error code? 'ret'
kernel/workqueue.c:325:40: sparse: sparse: duplicate [noderef]
kernel/workqueue.c:325:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
lib/crypto/mpi/mpi-inv.c:34:15: warning: variable 'k' set but not used [-Wunused-but-set-variable]
net/xdp/xsk.c:696 xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
{standard input}: Warning: end of file not at end of a line; newline inserted
{standard input}:927: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arc-axs101_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arc-randconfig-r005-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arc-randconfig-r013-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arc-randconfig-r043-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm-randconfig-r046-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm-randconfig-r093-20230816
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- arm-spear6xx_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm-tegra_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm-u8500_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- csky-randconfig-r003-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- csky-randconfig-r013-20230816
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-int
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-void
|   `-- arch-csky-include-asm-traps.h:error:expected-before-void
|-- csky-randconfig-r015-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- csky-randconfig-r026-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- csky-randconfig-r083-20230816
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-int
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-void
|   |-- arch-csky-include-asm-traps.h:error:expected-before-void
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- i386-buildonly-randconfig-r004-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- i386-debian-10.3
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i001-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i002-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i004-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i005-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i052-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|-- i386-randconfig-i054-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- fs-fuse-dir.c:warning:no-previous-declaration-for-fuse_valid_size
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|-- i386-randconfig-i061-20230816
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-randconfig-i063-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-randconfig-r081-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- loongarch-allmodconfig
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- loongarch-allnoconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|-- loongarch-defconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- include-linux-build_bug.h:error:bit-field-anonymous-width-not-an-integer-constant
|-- loongarch-randconfig-r014-20230816
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|-- loongarch-randconfig-r032-20230816
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|-- loongarch-randconfig-r035-20230816
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- m68k-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- m68k-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- nios2-randconfig-r012-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- nios2-randconfig-r062-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- parisc-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- parisc64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- powerpc-randconfig-r001-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- riscv-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- riscv-randconfig-r091-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- riscv-rv32_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- s390-randconfig-r063-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- sh-allmodconfig
|   |-- sh4-linux-gcc:internal-compiler-error:Segmentation-fault-signal-terminated-program-cc1
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:end-of-file-not-at-end-of-a-line-newline-inserted
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- sparc-randconfig-m031-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- sparc-randconfig-r052-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- sparc-randconfig-r092-20230816
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- um-randconfig-r072-20230816
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- um-randconfig-r082-20230816
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- x86_64-allnoconfig
|   |-- Documentation-gpu-rfc-i915_scheduler.rst:WARNING:Unknown-directive-type-c:namespace-pop-.
|   |-- Documentation-gpu-rfc-i915_scheduler.rst:WARNING:Unknown-directive-type-c:namespace-push-.
|   `-- Warning:kernel-Kconfig.kexec-references-a-file-that-doesn-t-exist:file:Documentation-s390-zfcpdump.rst
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-input-touchscreen-iqs7211.c-iqs7211_parse_cycles()-error:buffer-overflow-cycle_alloc
|   |-- drivers-mtd-nand-raw-qcom_nandc.c-qcom_check_op()-warn:was-intended-here-instead-of
|   |-- drivers-mtd-nand-raw-qcom_nandc.c-qcom_op_cmd_mapping()-error:uninitialized-symbol-ret-.
|   |-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_send_event()-warn:variable-dereferenced-before-IS_ERR-check-devcom-(see-line-)
|   |-- drivers-net-wireless-mediatek-mt76-mt792x_mac.c-mt792x_pm_power_save_work()-warn:can-dev-fw_assert-even-be-NULL
|   |-- drivers-pwm-pwm-atmel.c-atmel_pwm_enable_clk_if_on()-warn:missing-error-code-ret
|   |-- drivers-rtc-rtc-pcf2127.c-pcf2127_enable_ts()-warn:missing-error-code-ret
|   `-- net-xdp-xsk.c-xsk_build_skb()-error:skb-dereferencing-possible-ERR_PTR()
|-- x86_64-buildonly-randconfig-r002-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- x86_64-buildonly-randconfig-r003-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- x86_64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-r032-20230816
|   |-- fs-fuse-dir.c:warning:no-previous-declaration-for-fuse_valid_size
|   |-- kernel-bpf-map_iter.c:warning:no-previous-declaration-for-bpf_map_sum_elem_count
|   |-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_modify_return_test2
|-- x86_64-randconfig-x014-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x015-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x051-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x052-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x053-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x071-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x072-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x073-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x074-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x076-20230816
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- xtensa-randconfig-r001-20230816
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
`-- xtensa-randconfig-r005-20230816
    `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
clang_recent_errors
|-- arm-randconfig-r002-20230816
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- arm-randconfig-r003-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- arm-randconfig-r031-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- arm64-randconfig-r011-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- hexagon-randconfig-r041-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- hexagon-randconfig-r045-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- powerpc-pmac32_defconfig
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- riscv-randconfig-r042-20230816
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- s390-randconfig-r044-20230816
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-r015-20230816
|   `-- drivers-spi-spi-amd.o:warning:objtool:amd_spi_host_transfer()-falls-through-to-next-function-amd_spi_max_transfer_size()
|-- x86_64-randconfig-r025-20230816
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x001-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x002-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x003-20230816
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x004-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x005-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x006-20230816
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x074-20230817
|   |-- drivers-media-pci-intel-ivsc-mei_csi.c:error:call-to-undeclared-function-v4l2_subdev_get_try_format-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-media-pci-intel-ivsc-mei_csi.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-v4l2_mbus_framefmt-from-int
|   `-- drivers-media-pci-intel-ivsc-mei_csi.c:error:incompatible-integer-to-pointer-conversion-returning-int-from-a-function-with-result-type-struct-v4l2_mbus_framefmt
`-- x86_64-rhel-8.3-rust
    |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
    `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used

elapsed time: 731m

configs tested: 140
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r005-20230816   gcc  
arc                  randconfig-r013-20230816   gcc  
arc                  randconfig-r043-20230816   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r002-20230816   clang
arm                  randconfig-r003-20230816   clang
arm                  randconfig-r031-20230816   clang
arm                  randconfig-r046-20230816   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230816   gcc  
arm64                randconfig-r011-20230816   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230816   gcc  
csky                 randconfig-r015-20230816   gcc  
csky                 randconfig-r026-20230816   gcc  
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-r002-20230816   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230816   gcc  
loongarch            randconfig-r032-20230816   gcc  
loongarch            randconfig-r035-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r012-20230816   gcc  
m68k                 randconfig-r034-20230816   gcc  
microblaze           randconfig-r022-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230816   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r016-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r001-20230816   gcc  
powerpc              randconfig-r033-20230816   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230816   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r014-20230816   gcc  
sh                   randconfig-r021-20230816   gcc  
sh                           se7721_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230816   gcc  
sparc                randconfig-r024-20230816   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r036-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230816   clang
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r001-20230816   gcc  
xtensa               randconfig-r004-20230816   gcc  
xtensa               randconfig-r005-20230816   gcc  
xtensa               randconfig-r015-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
