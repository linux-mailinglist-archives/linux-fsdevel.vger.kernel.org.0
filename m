Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285687C043E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjJJTPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:15:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93785AC;
        Tue, 10 Oct 2023 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696965310; x=1728501310;
  h=date:from:to:cc:subject:message-id;
  bh=3xtiwVkZvQPkX3kPathx7bVZ3F+3M09fD/+72Yn/Tg0=;
  b=KaG6CEfolqO5B1SMHwQGgftabGYAzxHMo/bT7EdprGhgLuC7x1XE656y
   uy565uzARhwHJspQwf+FqA1SzMeCZXxhYLKPY9595VnHtbXqiLXDEaY8F
   zL7KEbjwgqJDWe2GVymJ7uXtnCioblfje0+0DG0S0LUAYkMoreqa+H9E2
   tLd6cPUmabkzXrS9/Z9qrSvUECn1ClKTkCC6BHH3cV71LM+v7cntyhrDZ
   xMF1UwLBvtYojZXl0N/S0E+2A59S8ktcO9IXvxxV0jyT6sjGaS21sgL7i
   ipZguMfBPiSZrpOXLYrbhX0JmI0EQ6z4miJmGarV8t+QAZKyLOjan7LMd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6049519"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="6049519"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 12:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730217522"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="730217522"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2023 12:15:06 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqIC8-0000xy-0C;
        Tue, 10 Oct 2023 19:15:04 +0000
Date:   Wed, 11 Oct 2023 03:14:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
        kunit-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 c0a6edb636cba9c0d1db966a54d910a02e52e4be
Message-ID: <202310110317.qBxdkqdN-lkp@intel.com>
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
branch HEAD: c0a6edb636cba9c0d1db966a54d910a02e52e4be  Add linux-next specific files for 20231010

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309122047.cRi9yJrq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309160053.sFDnNiu4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309202345.yPRVHW8Q-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310051547.40nm4Sif-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310100409.LrBAYpmk-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'
fs/bcachefs/bcachefs_format.h:215:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
fs/bcachefs/bcachefs_format.h:217:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
fs/bcachefs/btree_key_cache.c:113:7: warning: result of comparison of constant 9223372036854775807 with expression of type 'u32' (aka 'unsigned int') is always true [-Wtautological-constant-out-of-range-compare]
include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/bpf/helpers.c:1909:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1945:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2480:18: warning: no previous declaration for 'bpf_throw' [-Wmissing-declarations]
lib/kunit/kunit-test.c:565:25: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/kvm/x86.c:9016 x86_emulate_instruction() warn: missing error code? 'r'
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:538:25-29: ERROR: aconnector is NULL but dereferenced.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- csky-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-randconfig-051-20231010
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-001-20231010
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- m68k-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- m68k-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- microblaze-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-loongson3_defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- openrisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc-randconfig-003-20231010
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- x86_64-randconfig-011-20231010
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- x86_64-randconfig-013-20231010
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- x86_64-randconfig-104-20231010
|   `-- drivers-gpu-drm-amd-display-amdgpu_dm-amdgpu_dm_helpers.c:ERROR:aconnector-is-NULL-but-dereferenced.
`-- x86_64-randconfig-161-20231010
    |-- arch-x86-kvm-x86.c-x86_emulate_instruction()-warn:missing-error-code-r
    `-- mm-gup.c-pin_user_pages_fd()-warn:unsigned-start-is-never-less-than-zero.
clang_recent_errors
`-- arm64-allyesconfig
    |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
    |-- fs-bcachefs-btree_key_cache.c:warning:result-of-comparison-of-constant-with-expression-of-type-u32-(aka-unsigned-int-)-is-always-true
    `-- lib-kunit-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type

elapsed time: 773m

configs tested: 118
configs skipped: 2

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231010   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20231010   gcc  
i386                  randconfig-012-20231010   gcc  
i386                  randconfig-013-20231010   gcc  
i386                  randconfig-014-20231010   gcc  
i386                  randconfig-015-20231010   gcc  
i386                  randconfig-016-20231010   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231010   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-011-20231010   gcc  
x86_64                randconfig-012-20231010   gcc  
x86_64                randconfig-013-20231010   gcc  
x86_64                randconfig-076-20231010   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
