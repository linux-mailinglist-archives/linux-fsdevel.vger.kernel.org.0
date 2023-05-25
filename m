Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032B711151
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjEYQt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjEYQtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 12:49:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CED189;
        Thu, 25 May 2023 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685033392; x=1716569392;
  h=date:from:to:cc:subject:message-id;
  bh=yAaFl8xaWXtUTN2/2tBMaSZCgNk9fLjATl65FL+t4Vs=;
  b=jByYn2Sf+DovNIpmPjXi0fd5pGHl7SDIohwyQNU6rquiC93fjJzbQe5t
   ijyJWXzJ7X5tzmnrXFnOx4SwwpNlQhJv6Nna6kPGq9uFMCFkUCO8YZ78k
   7MwdIhscaXCCQyRbRpc/SUNaR1x7549sNANex1DA8/wY9Cvx1tbZxH0zw
   jlzpWSA+s80VgQLf/tGEnUf/PgQTdRceVNHcgJ2DyGSwcZkfRfvoPd47Q
   jZ9tKLWwp40pmbXDUvyNY/NJ/G0CwU022dyN5EcSb1C8zqWPimUHpR0pT
   KwhgAM41EvMFEnjU65qvDTtHPrbEHuJMWGTgO9bdct1XCmghK31NulI/6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352794729"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="352794729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 09:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="737848703"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="737848703"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2023 09:49:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2E9s-000Fr3-2A;
        Thu, 25 May 2023 16:49:48 +0000
Date:   Fri, 26 May 2023 00:49:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 6a3d37b4d885129561e1cef361216f00472f7d2e
Message-ID: <20230525164911.Tn0rP%lkp@intel.com>
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
branch HEAD: 6a3d37b4d885129561e1cef361216f00472f7d2e  Add linux-next specific files for 20230525

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305241902.UvHtMoxa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305251508.qSwAS1hL-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305251510.U0R2as7k-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "amdgpu_show_fdinfo" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
drivers/gpu/drm/i915/display/intel_display.c:6012:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
drivers/gpu/drm/i915/display/intel_display.c:6012:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
hppa-linux-ld: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o:(.rodata+0x2a8): undefined reference to `amdgpu_show_fdinfo'

Unverified Error/Warning (likely false positive, please contact us if interested):

fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible memory leak of 'cifs_sb'
fs/smb/client/cifssmb.c:4089 CIFSFindFirst() warn: missing error code? 'rc'
fs/smb/client/cifssmb.c:4216 CIFSFindNext() warn: missing error code? 'rc'
fs/smb/client/connect.c:2725 cifs_match_super() error: 'tlink' dereferencing possible ERR_PTR()
fs/smb/client/connect.c:2924 generic_ip_connect() error: we previously assumed 'socket' could be null (see line 2912)
fs/smb/client/smb2pdu.c:3729 SMB2_change_notify() error: we previously assumed 'plen' could be null (see line 3688)
fs/xfs/scrub/fscounters.c:459 xchk_fscounters() warn: ignoring unreachable code.
kernel/watchdog.c:40:19: sparse: sparse: symbol 'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
kernel/watchdog.c:41:19: sparse: sparse: symbol 'watchdog_softlockup_user_enabled' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r025-20230524
|   `-- ERROR:amdgpu_show_fdinfo-drivers-gpu-drm-amd-amdgpu-amdgpu.ko-undefined
|-- i386-randconfig-m021-20230524
|   `-- fs-xfs-scrub-fscounters.c-xchk_fscounters()-warn:ignoring-unreachable-code.
|-- i386-randconfig-s032-20230524
|   |-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_hardlockup_user_enabled-was-not-declared.-Should-it-be-static
|   `-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_softlockup_user_enabled-was-not-declared.-Should-it-be-static
|-- ia64-buildonly-randconfig-r005-20230524
|   `-- ERROR:amdgpu_show_fdinfo-drivers-gpu-drm-amd-amdgpu-amdgpu.ko-undefined
|-- ia64-randconfig-s031-20230524
|   |-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_hardlockup_user_enabled-was-not-declared.-Should-it-be-static
|   `-- kernel-watchdog.c:sparse:sparse:symbol-watchdog_softlockup_user_enabled-was-not-declared.-Should-it-be-static
|-- parisc-randconfig-r031-20230524
|   `-- hppa-linux-ld:drivers-gpu-drm-amd-amdgpu-amdgpu_drv.o:(.rodata):undefined-reference-to-amdgpu_show_fdinfo
`-- x86_64-randconfig-m001-20230524
    |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
    |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
    |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
    |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
    |-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
    `-- fs-smb-client-smb2pdu.c-SMB2_change_notify()-error:we-previously-assumed-plen-could-be-null-(see-line-)
clang_recent_errors
|-- i386-randconfig-i011-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-i014-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-i015-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:error:unannotated-fall-through-between-switch-labels-Werror-Wimplicit-fallthrough
|-- i386-randconfig-i075-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:warning:unannotated-fall-through-between-switch-labels
|-- i386-randconfig-i085-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-x066-20230524
|   `-- drivers-gpu-drm-i915-display-intel_display.c:error:unannotated-fall-through-between-switch-labels-Werror-Wimplicit-fallthrough
`-- x86_64-randconfig-x072-20230525
    `-- drivers-gpu-drm-i915-display-intel_display.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 725m

configs tested: 176
configs skipped: 10

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230524   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230524   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r032-20230524   gcc  
arc                  randconfig-r043-20230524   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                       aspeed_g4_defconfig   clang
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                  randconfig-r003-20230524   clang
arm                  randconfig-r015-20230524   gcc  
arm                  randconfig-r046-20230524   gcc  
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r005-20230524   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r002-20230524   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i075-20230524   clang
i386                 randconfig-i076-20230524   clang
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i084-20230524   clang
i386                 randconfig-i085-20230524   clang
i386                 randconfig-i086-20230524   clang
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i096-20230524   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r024-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r014-20230524   gcc  
m68k                           sun3_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r003-20230524   clang
mips                           ip28_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r016-20230524   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230524   gcc  
openrisc             randconfig-r036-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230524   gcc  
parisc               randconfig-r031-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     kmeter1_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r023-20230524   clang
powerpc              randconfig-r033-20230524   gcc  
powerpc                    socrates_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230524   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230524   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230524   clang
s390                 randconfig-r044-20230524   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r004-20230524   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230524   gcc  
sparc                randconfig-r012-20230524   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a011-20230524   clang
x86_64               randconfig-a012-20230524   clang
x86_64               randconfig-a013-20230524   clang
x86_64               randconfig-a014-20230524   clang
x86_64               randconfig-a015-20230524   clang
x86_64               randconfig-a016-20230524   clang
x86_64               randconfig-r013-20230524   clang
x86_64               randconfig-r035-20230524   gcc  
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x071-20230525   clang
x86_64               randconfig-x072-20230525   clang
x86_64               randconfig-x073-20230525   clang
x86_64               randconfig-x074-20230525   clang
x86_64               randconfig-x075-20230525   clang
x86_64               randconfig-x076-20230525   clang
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x091-20230525   gcc  
x86_64               randconfig-x092-20230525   gcc  
x86_64               randconfig-x093-20230525   gcc  
x86_64               randconfig-x094-20230525   gcc  
x86_64               randconfig-x095-20230525   gcc  
x86_64               randconfig-x096-20230525   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
