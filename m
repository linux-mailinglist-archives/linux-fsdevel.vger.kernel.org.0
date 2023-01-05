Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3865F082
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjAEPvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjAEPuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:50:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AB5E09D;
        Thu,  5 Jan 2023 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672933822; x=1704469822;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RJatMYrbPfEvNurBxtLaBiUJD4LCEtP8VKvLxxz/leM=;
  b=kd+ndZ8K31PGe55ZJiqMQis4fsu+hv8Rm63LgYwx5JxFW9JsIhuqBdsU
   mUV2x5Jscn5rE5BjY3vePPgkoaYaz56cKPdGNYKuP4sRZal5LafympAro
   8Gry/cIEmHQZK8kFSjgyEQ42SvcWVmih9WIPeRz6HicpQ4F1I/efKWDRx
   U45aDrwzVvms7bgxa2YiAQr+44rJrMnUZkrcIw/U/OHnSaeDDlumeK9xR
   xF9qVk4Ey39D7v53nkXypFoSQTGoSghKWaH2M4l5pQOsbTY2PPWg3RgHE
   XmHRJBeyW+Me1s/I7vsi4I/4qv26uDvkN2g3YnTaRbi8io+T7QP+eHsKt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="310026053"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="310026053"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="633190458"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="633190458"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2023 07:50:18 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDSVV-0001zD-1E;
        Thu, 05 Jan 2023 15:50:17 +0000
Date:   Thu, 05 Jan 2023 23:49:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     loongarch@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 cc3c08b41a9c9402ead726ec6deb1217081d0d8b
Message-ID: <63b6f194.O4eKwdyFWFrII4HE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: cc3c08b41a9c9402ead726ec6deb1217081d0d8b  Add linux-next specific files for 20230105

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202212090509.NjAl9tbo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202212170128.DFuMhkwh-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Documentation/gpu/drm-internals:179: ./include/drm/drm_file.h:411: WARNING: undefined label: drm_accel_node (if the link has no caption the label must precede a section header)
Warning: tools/power/cpupower/man/cpupower-powercap-info.1 references a file that doesn't exist: Documentation/power/powercap/powercap.txt
aarch64-linux-ld: ID map text too big or misaligned
arch/loongarch/kernel/asm-offsets.c:265:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
drivers/gpu/drm/ttm/ttm_bo_util.c:364:32: error: implicit declaration of function 'vmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/ttm/ttm_bo_util.c:429:17: error: implicit declaration of function 'vunmap'; did you mean 'kunmap'? [-Werror=implicit-function-declaration]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/block/null_blk/zoned.c:769 zone_cond_store() warn: potential spectre issue 'dev->zones' [w] (local cap)
drivers/clk/qcom/camcc-sm6350.c:1745:15: sparse: sparse: symbol 'camcc_sm6350_hws' was not declared. Should it be static?
fs/udf/file.c:177 udf_file_write_iter() warn: inconsistent returns '&iinfo->i_data_sem'.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- aarch64-linux-ld:ID-map-text-too-big-or-misaligned
|-- loongarch-allyesconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_pbe_defines
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vmap
|   `-- drivers-gpu-drm-ttm-ttm_bo_util.c:error:implicit-declaration-of-function-vunmap
|-- parisc-randconfig-m041-20230102
|   `-- fs-udf-file.c-udf_file_write_iter()-warn:inconsistent-returns-iinfo-i_data_sem-.
|-- riscv-randconfig-m031-20230105
|   |-- drivers-block-null_blk-zoned.c-zone_cond_store()-warn:potential-spectre-issue-dev-zones-w-(local-cap)
|   `-- drivers-regulator-tps65219-regulator.c-tps65219_regulator_probe()-warn:unsigned-rdev-is-never-less-than-zero.
|-- riscv-randconfig-s032-20230105
|   `-- drivers-clk-qcom-camcc-sm6350.c:sparse:sparse:symbol-camcc_sm6350_hws-was-not-declared.-Should-it-be-static
`-- x86_64-allnoconfig
    |-- Documentation-gpu-drm-internals:.-include-drm-drm_file.h:WARNING:undefined-label:drm_accel_node-(if-the-link-has-no-caption-the-label-must-precede-a-section-header)
    `-- Warning:tools-power-cpupower-man-cpupower-powercap-info.-references-a-file-that-doesn-t-exist:Documentation-power-powercap-powercap.txt
clang_recent_errors
`-- x86_64-rhel-8.3-rust
    `-- vmlinux.o:warning:objtool:___ksymtab_gpl-_RNvNtCsfATHBUcknU9_6kernel5print16call_printk_cont:data-relocation-to-ENDBR:_RNvNtCsfATHBUcknU9_6kernel5print16call_printk_cont

elapsed time: 726m

configs tested: 62
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
i386                          randconfig-a012
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                              defconfig
m68k                             allyesconfig
arc                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
alpha                               defconfig
arc                  randconfig-r043-20230105
s390                                defconfig
i386                          randconfig-a003
s390                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
s390                 randconfig-r044-20230105
i386                             allyesconfig
arm                                 defconfig
s390                             allyesconfig
riscv                randconfig-r042-20230105
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
arm                  randconfig-r046-20230105
i386                          randconfig-a002
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230105
i386                          randconfig-a004
hexagon              randconfig-r045-20230105
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
