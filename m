Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08386FCA94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjEIP5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjEIP5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 11:57:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACC30CF;
        Tue,  9 May 2023 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683647819; x=1715183819;
  h=date:from:to:cc:subject:message-id;
  bh=InfKsIyfWaKXcN1AHvUy/rhJqovrMzLl8YA4lURiOLI=;
  b=FgkPel4hp2udnn6DeytciW6/OmRvNMiUvEQZbMslDP2pGPCMf3OU5WLx
   X3rnfCa1dZgWalViNS1lkZoOCGp2IiMfUlVyheqR8E2tBqFqZJOKGv7Df
   H0STr4xdkwzs44Ruts7vdlypvdI/66ig5nuuxdoY28qIKa02is9cft2b9
   OCE1/6o0IY+9nPSCDGTSAW73uMPKuYbEjmNKj7mS3D4wm084YCf8n4LAD
   LWOClFAsOMZkt39qQlLOqBbXgpoVzBJydq25WXebCa11BS8lwxKRad0Ks
   Yu1trPbCn3wuiHlVZnN7DPTjTlS/iR3F88s+0XtJ8qSl5z49pVnxyl7B7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="353032799"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="353032799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 08:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1028857739"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="1028857739"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2023 08:56:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwPhw-0002GM-0I;
        Tue, 09 May 2023 15:56:56 +0000
Date:   Tue, 09 May 2023 23:56:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        acpica-devel@lists.linuxfoundation.org,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 47cba14ce6fc4f314bd814d07269d0c8de1e4ae6
Message-ID: <20230509155619.x9EA-%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 47cba14ce6fc4f314bd814d07269d0c8de1e4ae6  Add linux-next specific files for 20230509

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305070840.X0G3ofjl-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6395:21: warning: variable 'count' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:499:13: warning: variable 'j' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: unused variable 'golden_settings_gc_9_4_3' [-Wunused-const-variable]

Unverified Warning (likely false positive, please contact us if interested):

drivers/acpi/acpica/tbutils.c:181 acpi_tb_get_root_table_entry() error: uninitialized symbol 'address32'.
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:648:3-9: preceding lock on line 640
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:658 amdgpu_gfx_enable_kgq() warn: inconsistent returns '&kiq->ring_lock'.
fs/ext4/super.c:4724 ext4_check_feature_compatibility() warn: bitwise AND condition is false here
fs/xfs/scrub/fscounters.c:459 xchk_fscounters() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- alpha-randconfig-r003-20230508
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arc-allyesconfig
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_index-is-used-uninitialized
|   |-- drivers-base-regmap-regcache-maple.c:warning:lower_last-is-used-uninitialized
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- csky-buildonly-randconfig-r001-20230508
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-randconfig-m031-20230507
|   |-- drivers-acpi-acpica-tbutils.c-acpi_tb_get_root_table_entry()-error:uninitialized-symbol-address32-.
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c-amdgpu_gfx_enable_kgq()-warn:inconsistent-returns-kiq-ring_lock-.
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|   |-- fs-ext4-super.c-ext4_check_feature_compatibility()-warn:bitwise-AND-condition-is-false-here
|   `-- fs-xfs-scrub-fscounters.c-xchk_fscounters()-warn:ignoring-unreachable-code.
|-- ia64-randconfig-r012-20230508
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-randconfig-r024-20230508
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-randconfig-r034-20230507
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- ia64-randconfig-r036-20230508
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- parisc-buildonly-randconfig-r004-20230507
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- parisc-randconfig-r024-20230507
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- powerpc-randconfig-c44-20230509
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:preceding-lock-on-line
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- riscv-randconfig-r042-20230508
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-r044-20230508
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-s051-20230507
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
|-- s390-randconfig-s053-20230507
|   `-- mm-filemap.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
`-- x86_64-allyesconfig
    |-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c:warning:variable-count-set-but-not-used
    `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gfx.c:warning:variable-j-set-but-not-used
clang_recent_errors
|-- arm-randconfig-r046-20230508
|   `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golden_settings_gc_9_4_3
`-- s390-randconfig-r006-20230508
    `-- drivers-gpu-drm-amd-amdgpu-gfx_v9_4_3.c:warning:unused-variable-golden_settings_gc_9_4_3

elapsed time: 735m

configs tested: 144
configs skipped: 12

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230508   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230508   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r002-20230508   gcc  
arc                  randconfig-r022-20230508   gcc  
arc                  randconfig-r043-20230507   gcc  
arc                  randconfig-r043-20230508   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r003-20230507   clang
arm                  randconfig-r011-20230507   gcc  
arm                  randconfig-r026-20230508   clang
arm                  randconfig-r036-20230507   clang
arm                  randconfig-r046-20230507   gcc  
arm                  randconfig-r046-20230508   clang
arm                           sama5_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230508   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230508   clang
arm64                randconfig-r021-20230507   clang
csky         buildonly-randconfig-r001-20230508   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230508   gcc  
csky                 randconfig-r015-20230507   gcc  
hexagon      buildonly-randconfig-r006-20230508   clang
hexagon              randconfig-r014-20230508   clang
hexagon              randconfig-r015-20230508   clang
hexagon              randconfig-r026-20230507   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r041-20230508   clang
hexagon              randconfig-r045-20230507   clang
hexagon              randconfig-r045-20230508   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230508   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r021-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230507   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230508   gcc  
ia64                 randconfig-r024-20230508   gcc  
ia64                 randconfig-r034-20230507   gcc  
ia64                 randconfig-r036-20230508   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230507   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r013-20230507   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r016-20230508   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230507   gcc  
mips                 randconfig-r034-20230508   gcc  
mips                 randconfig-r035-20230507   clang
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r002-20230507   gcc  
openrisc             randconfig-r032-20230507   gcc  
parisc       buildonly-randconfig-r004-20230507   gcc  
parisc       buildonly-randconfig-r005-20230507   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                     kmeter1_defconfig   clang
powerpc              randconfig-r006-20230507   gcc  
powerpc              randconfig-r012-20230507   clang
powerpc              randconfig-r023-20230508   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r014-20230507   clang
riscv                randconfig-r042-20230507   clang
riscv                randconfig-r042-20230508   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230508   clang
s390                 randconfig-r006-20230508   clang
s390                 randconfig-r025-20230508   gcc  
s390                 randconfig-r044-20230507   clang
s390                 randconfig-r044-20230508   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230508   gcc  
sh                   randconfig-r016-20230507   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230508   gcc  
sparc64              randconfig-r001-20230507   gcc  
sparc64              randconfig-r033-20230507   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230508   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64               randconfig-r033-20230508   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
