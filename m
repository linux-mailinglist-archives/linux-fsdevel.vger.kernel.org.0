Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E5722C12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjFEQAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFEQAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:00:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88294;
        Mon,  5 Jun 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980846; x=1717516846;
  h=date:from:to:cc:subject:message-id;
  bh=1XMWJYaZIA+06520U05wDEJCcPWqKpSnIw3WPggaMuE=;
  b=NQvg/cGAzZikxr6Et/mX+yMMpp26zK42Nc4SqmJ2K/4vhyXq4bOimjio
   kUgFoRI6xzc4mY87OOazs/CKg67hKOtO7Xg1wCl37q3QumoZHe7WOohJ3
   HYVJlNoMj0ytRY9BM+++sW1SMav1ORq8qmUmq6VLekEcLXlf81a3usvGZ
   zCz0xLIlvmkKYngvIdslevksVjS4DEBIxpY5U8LnBri2fBXDxsesKdwJq
   HwHSZLHPOL3qpNQmE80uodrCZQspXuMGJVWsDvtWh7CZpmVEq7OerwcOu
   joyCJNT6eOvgfeW67ZnxvgMA/1mA86sndOapqlhRrpcO+cJThI88ZYyOr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422229224"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="422229224"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 09:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="702796973"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="702796973"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jun 2023 09:00:10 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6Ccs-0004GI-07;
        Mon, 05 Jun 2023 16:00:10 +0000
Date:   Mon, 05 Jun 2023 23:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        bpf@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-xfs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [linux-next:master] BUILD REGRESSION
 9ca10bfb8aa8fbf19ee22e702c8cf9b66ea73a54
Message-ID: <20230605155917.CRiQj%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 9ca10bfb8aa8fbf19ee22e702c8cf9b66ea73a54  Add linux-next specific files for 20230605

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202305070840.X0G3ofjl-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202305132244.DwzBUcUd-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306021936.OktTcMAT-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306051319.EihCQZPs-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306051812.1YdWyZca-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306051823.Gbzkjb7e-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus' undeclared (first use in this function)
arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration of function 'perf_pmu__scan'; did you mean 'perf_pmus__scan'? [-Werror=implicit-function-declaration]
arch/x86/tests/amd-ibs-via-core-pmu.c:50:17: error: assignment to 'struct perf_pmu *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration of function 'perf_pmu__find'; did you mean 'perf_pmus__find'? [-Werror=implicit-function-declaration]
drivers/bus/fsl-mc/fsl-mc-allocator.c:108:12: warning: variable 'mc_bus_dev' is uninitialized when used here [-Wuninitialized]
drivers/cpufreq/cpufreq-dt-platdev.c:104:34: warning: 'blocklist' defined but not used [-Wunused-const-variable=]
drivers/cpufreq/cpufreq-dt-platdev.c:17:34: warning: 'allowlist' defined but not used [-Wunused-const-variable=]
include/drm/drm_print.h:456:39: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:330:18: warning: no previous prototype for 'bpf_kfunc_call_test_offset' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:336:1: warning: no previous prototype for 'bpf_kfunc_call_memb_acquire' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:342:18: warning: no previous prototype for 'bpf_kfunc_call_memb1_release' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:394:18: warning: no previous prototype for 'bpf_kfunc_call_test_fail1' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:398:18: warning: no previous prototype for 'bpf_kfunc_call_test_fail2' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:402:18: warning: no previous prototype for 'bpf_kfunc_call_test_fail3' [-Wmissing-prototypes]
tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:410:18: warning: no previous prototype for 'bpf_kfunc_call_test_mem_len_fail1' [-Wmissing-prototypes]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/clk/qcom/gpucc-sm8550.c:37:22: sparse: sparse: decimal constant 2300000000 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
drivers/clk/qcom/videocc-sm8550.c:34:22: sparse: sparse: decimal constant 2300000000 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
drivers/usb/cdns3/cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead
drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c:217:30: sparse: sparse: incorrect type in argument 1 (different base types)
fs/btrfs/volumes.c:6407 btrfs_map_block() error: we previously assumed 'mirror_num_ret' could be null (see line 6245)
fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible memory leak of 'cifs_sb'
fs/smb/client/cifssmb.c:4089 CIFSFindFirst() warn: missing error code? 'rc'
fs/smb/client/cifssmb.c:4216 CIFSFindNext() warn: missing error code? 'rc'
fs/smb/client/connect.c:2725 cifs_match_super() error: 'tlink' dereferencing possible ERR_PTR()
fs/smb/client/connect.c:2924 generic_ip_connect() error: we previously assumed 'socket' could be null (see line 2912)
fs/xfs/scrub/fscounters.c:459 xchk_fscounters() warn: ignoring unreachable code.
kernel/events/uprobes.c:478 uprobe_write_opcode() warn: passing zero to 'PTR_ERR'
lib/kunit/test.c:336 __kunit_abort() warn: ignoring unreachable code.
{standard input}:1078: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- arc-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- arm-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- arm-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- arm-randconfig-c031-20230605
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- arm64-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- i386-allyesconfig
|   `-- include-drm-drm_print.h:error:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-randconfig-m021-20230605
|   |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
|   |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
|   |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
|   |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
|   |-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
|   |-- fs-xfs-scrub-fscounters.c-xchk_fscounters()-warn:ignoring-unreachable-code.
|   `-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
|-- i386-randconfig-s042-20230605
|   |-- drivers-cpufreq-cpufreq-dt-platdev.c:warning:allowlist-defined-but-not-used
|   `-- drivers-cpufreq-cpufreq-dt-platdev.c:warning:blocklist-defined-but-not-used
|-- m68k-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- m68k-randconfig-m041-20230605
|   `-- lib-kunit-test.c-__kunit_abort()-warn:ignoring-unreachable-code.
|-- m68k-randconfig-s043-20230605
|   |-- drivers-clk-qcom-gpucc-sm8550.c:sparse:sparse:decimal-constant-is-between-LONG_MAX-and-ULONG_MAX.-For-C99-that-means-long-long-C90-compilers-are-very-likely-to-produce-unsigned-long-(and-a-warning)-he
|   `-- drivers-clk-qcom-videocc-sm8550.c:sparse:sparse:decimal-constant-is-between-LONG_MAX-and-ULONG_MAX.-For-C99-that-means-long-long-C90-compilers-are-very-likely-to-produce-unsigned-long-(and-a-warning)-
|-- mips-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- mips-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- powerpc-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- powerpc-randconfig-s053-20230604
|   `-- drivers-usb-typec-tcpm-qcom-qcom_pmic_typec_pdphy.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-header-got-restricted-__le16-const-usertype-header
|-- riscv-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- s390-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- s390-randconfig-s052-20230604
|   |-- mm-filemap.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   `-- mm-kfence-core.c:sparse:sparse:cast-to-restricted-__le64
|-- sh-allmodconfig
|   `-- standard-input:Error:pcrel-too-far
|-- sparc-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- x86_64-randconfig-k001-20230605
|   |-- arch-x86-tests-amd-ibs-via-core-pmu.c:error:assignment-to-struct-perf_pmu-from-int-makes-pointer-from-integer-without-a-cast
|   |-- arch-x86-tests-amd-ibs-via-core-pmu.c:error:implicit-declaration-of-function-perf_pmu__find
|   |-- arch-x86-tests-amd-ibs-via-core-pmu.c:error:implicit-declaration-of-function-perf_pmu__scan
|   |-- arch-x86-tests-amd-ibs-via-core-pmu.c:error:pmus-undeclared-(first-use-in-this-function)
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_memb1_release
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_memb_acquire
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_test_fail1
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_test_fail2
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_test_fail3
|   |-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_test_mem_len_fail1
|   `-- tools-testing-selftests-bpf-bpf_testmod-bpf_testmod.c:warning:no-previous-prototype-for-bpf_kfunc_call_test_offset
`-- x86_64-randconfig-m001-20230605
    |-- fs-btrfs-volumes.c-btrfs_map_block()-error:we-previously-assumed-mirror_num_ret-could-be-null-(see-line-)
    `-- fs-xfs-scrub-fscounters.c-xchk_fscounters()-warn:ignoring-unreachable-code.
clang_recent_errors
`-- arm-randconfig-r046-20230605
    `-- drivers-bus-fsl-mc-fsl-mc-allocator.c:warning:variable-mc_bus_dev-is-uninitialized-when-used-here

elapsed time: 726m

configs tested: 162
configs skipped: 9

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230605   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r005-20230605   gcc  
arc                  randconfig-r012-20230605   gcc  
arc                  randconfig-r013-20230605   gcc  
arc                  randconfig-r043-20230605   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                  randconfig-r006-20230605   gcc  
arm                  randconfig-r036-20230605   gcc  
arm                  randconfig-r046-20230605   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230605   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230605   clang
arm64                randconfig-r014-20230605   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230605   gcc  
hexagon              randconfig-r002-20230605   clang
hexagon              randconfig-r011-20230605   clang
hexagon              randconfig-r034-20230605   clang
hexagon              randconfig-r041-20230605   clang
hexagon              randconfig-r045-20230605   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i066-20230605   clang
ia64                      gensparse_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230605   gcc  
microblaze           randconfig-r005-20230605   gcc  
microblaze           randconfig-r014-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r023-20230605   clang
mips                 randconfig-r035-20230605   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230605   gcc  
nios2                randconfig-r025-20230605   gcc  
nios2                randconfig-r031-20230605   gcc  
openrisc     buildonly-randconfig-r001-20230605   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r002-20230605   gcc  
openrisc             randconfig-r016-20230605   gcc  
openrisc             randconfig-r021-20230605   gcc  
openrisc             randconfig-r022-20230605   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230605   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc              randconfig-r011-20230605   gcc  
powerpc              randconfig-r015-20230605   gcc  
powerpc                     sequoia_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230605   clang
riscv                randconfig-r042-20230605   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230605   clang
s390                 randconfig-r004-20230605   clang
s390                 randconfig-r032-20230605   clang
s390                 randconfig-r044-20230605   gcc  
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   randconfig-r001-20230605   gcc  
sh                   randconfig-r012-20230605   gcc  
sh                   randconfig-r013-20230605   gcc  
sh                   randconfig-r031-20230605   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r026-20230605   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230605   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230605   clang
x86_64               randconfig-a002-20230605   clang
x86_64               randconfig-a003-20230605   clang
x86_64               randconfig-a004-20230605   clang
x86_64               randconfig-a005-20230605   clang
x86_64               randconfig-a006-20230605   clang
x86_64               randconfig-a011-20230605   gcc  
x86_64               randconfig-a012-20230605   gcc  
x86_64               randconfig-a013-20230605   gcc  
x86_64               randconfig-a014-20230605   gcc  
x86_64               randconfig-a015-20230605   gcc  
x86_64               randconfig-a016-20230605   gcc  
x86_64               randconfig-k001-20230605   gcc  
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x054-20230605   gcc  
x86_64               randconfig-x055-20230605   gcc  
x86_64               randconfig-x056-20230605   gcc  
x86_64               randconfig-x061-20230605   gcc  
x86_64               randconfig-x062-20230605   gcc  
x86_64               randconfig-x063-20230605   gcc  
x86_64               randconfig-x064-20230605   gcc  
x86_64               randconfig-x065-20230605   gcc  
x86_64               randconfig-x066-20230605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230605   gcc  
xtensa               randconfig-r003-20230605   gcc  
xtensa               randconfig-r004-20230605   gcc  
xtensa               randconfig-r015-20230605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
