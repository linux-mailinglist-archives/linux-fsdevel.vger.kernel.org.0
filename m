Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE717B8AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbjJDSjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbjJDSjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:39:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D2BF;
        Wed,  4 Oct 2023 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444742; x=1727980742;
  h=date:from:to:cc:subject:message-id;
  bh=gnRpsP+7CnP0yiRI2VNQVjPOHCBbxw61Jj5irU9iDk8=;
  b=GEFx+XlN76vrp/AaGYwaGjI2CvVCbN5B+CLUheOcogngJWs/B88wDcsV
   2/uOdE7MCJGR92AZGR2/j7T3I27gIu2NUOuqKUMKfZSp8bIChNsKadWEP
   /VQqGKvw7wmSvomuR3EIKi8b1OWg4ZFM7fYTCMPeke6zig7c0IxRTnzJk
   Q8ojkd4euXFM24iexcMyV4W6IalJ61ATXEmhXWWbiD6RQg6mxWTRYJVg1
   fR+xhuwQUu6/2ZChnbBuYVeQWpBEvtsgmw+jV5HUofkkIBRMDxoXCfQxV
   e0wonFke+pv9+mhj3cC2TWlg9ANn3ODlwLyANZoqFCdY0iQArL3wpsZfQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383169018"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383169018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780909668"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="780909668"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2023 11:38:57 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qo6lq-000KVR-39;
        Wed, 04 Oct 2023 18:38:54 +0000
Date:   Thu, 05 Oct 2023 02:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        alsa-devel@alsa-project.org, bpf@vger.kernel.org,
        gfs2@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 33b64befb1a28bca3f5a9ed9807d2f87e976c63a
Message-ID: <202310050242.IY1kedcV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 33b64befb1a28bca3f5a9ed9807d2f87e976c63a  Add linux-next specific files for 20231004

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309122047.cRi9yJrq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309221945.uwcQ56zg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310041744.d34gIv9V-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310042215.w9PG3Rqs-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310042342.Bv7kezcd-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Documentation/gpu/amdgpu/thermal:43: ./drivers/gpu/drm/amd/pm/amdgpu_pm.c:988: WARNING: Unexpected indentation.
drivers/cpufreq/sti-cpufreq.c:215:50: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
drivers/net/ethernet/intel/ice/ice_dpll.c:1066: undefined reference to `ice_get_cgu_state'
drivers/net/ethernet/intel/ice/ice_dpll.c:1666: undefined reference to `ice_cgu_get_pin_freq_supp'
drivers/net/ethernet/intel/ice/ice_dpll.c:1802: undefined reference to `ice_get_cgu_rclk_pin_info'
drivers/net/ethernet/intel/ice/ice_lib.c:3979: undefined reference to `ice_is_phy_rclk_present'
fs/bcachefs/bcachefs_format.h:215:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
fs/bcachefs/bcachefs_format.h:217:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
fs/gfs2/inode.c:1876:14: sparse:    struct gfs2_glock *
fs/gfs2/inode.c:1876:14: sparse:    struct gfs2_glock [noderef] __rcu *
fs/gfs2/super.c:1543:17: sparse:    struct gfs2_glock *
fs/gfs2/super.c:1543:17: sparse:    struct gfs2_glock [noderef] __rcu *
include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/bpf/helpers.c:1906:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1942:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2477:18: warning: no previous declaration for 'bpf_throw' [-Wmissing-declarations]
ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1646: undefined reference to `ice_cgu_get_pin_name'
ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1647: undefined reference to `ice_cgu_get_pin_type'
ld: drivers/net/ethernet/intel/ice/ice_lib.c:3984: undefined reference to `ice_is_cgu_present'
ld: drivers/net/ethernet/intel/ice/ice_lib.c:3986: undefined reference to `ice_is_clock_mux_present_e810t'
loongarch64-linux-ld: ice_dpll.c:(.text+0xb78): undefined reference to `ice_cgu_get_pin_type'
s390-linux-ld: ice_dpll.c:(.text+0xa4c): undefined reference to `ice_cgu_get_pin_type'
s390-linux-ld: ice_dpll.c:(.text+0xaf0): undefined reference to `ice_cgu_get_pin_freq_supp'
s390-linux-ld: ice_lib.c:(.text+0x4c7a): undefined reference to `ice_is_cgu_present'
s390-linux-ld: ice_lib.c:(.text+0x4c96): undefined reference to `ice_is_clock_mux_present_e810t'
sound/pci/hda/cirrus_scodec_test.c:151:60: error: initializer element is not a compile-time constant

Unverified Error/Warning (likely false positive, please contact us if interested):

Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:
fs/ntfs3/bitmap.c:662 wnd_init() warn: Please consider using kvcalloc instead of kvmalloc_array
fs/ntfs3/super.c:466:23: sparse: sparse: unknown escape sequence: '\%'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arm-allmodconfig
|   `-- drivers-cpufreq-sti-cpufreq.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   `-- drivers-cpufreq-sti-cpufreq.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm64-allmodconfig
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- arm64-allyesconfig
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- i386-randconfig-006-20231004
|   |-- drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_cgu_get_pin_freq_supp
|   |-- drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_get_cgu_rclk_pin_info
|   |-- drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_get_cgu_state
|   |-- drivers-net-ethernet-intel-ice-ice_lib.c:undefined-reference-to-ice_is_phy_rclk_present
|   |-- ld:drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_cgu_get_pin_name
|   |-- ld:drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_cgu_get_pin_type
|   |-- ld:drivers-net-ethernet-intel-ice-ice_lib.c:undefined-reference-to-ice_is_cgu_present
|   `-- ld:drivers-net-ethernet-intel-ice-ice_lib.c:undefined-reference-to-ice_is_clock_mux_present_e810t
|-- i386-randconfig-061-20231004
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-atomic_t-usertype-v-got-struct-atomic_t-noderef-__rcu
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file-got-struct-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file_reloaded-got-struct-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file_reloaded
|   |-- fs-gfs2-inode.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-gfs2-inode.c:sparse:struct-gfs2_glock
|   |-- fs-gfs2-inode.c:sparse:struct-gfs2_glock-noderef-__rcu
|   |-- fs-gfs2-super.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-gfs2-super.c:sparse:struct-gfs2_glock
|   |-- fs-gfs2-super.c:sparse:struct-gfs2_glock-noderef-__rcu
|   `-- fs-ntfs3-super.c:sparse:sparse:unknown-escape-sequence:
|-- i386-randconfig-062-20231004
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-atomic_t-usertype-v-got-struct-atomic_t-noderef-__rcu
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file-got-struct-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file_reloaded-got-struct-file
|   `-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file_reloaded
|-- i386-randconfig-063-20231004
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-atomic_t-usertype-v-got-struct-atomic_t-noderef-__rcu
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file-got-struct-file
|   |-- fs-file.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-struct-file-noderef-__rcu-file_reloaded-got-struct-file
|   `-- fs-file.c:sparse:sparse:incorrect-type-in-return-expression-(different-address-spaces)-expected-struct-file-got-struct-file-noderef-__rcu-file_reloaded
|-- loongarch-randconfig-001-20231004
|   `-- Documentation-devicetree-bindings-mfd-qcom-pm8xxx.yaml:
|-- loongarch-randconfig-r001-20230813
|   `-- loongarch64-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_type
|-- m68k-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- m68k-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc64-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- powerpc-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-randconfig-r033-20220907
|   |-- s390-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_freq_supp
|   |-- s390-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_type
|   |-- s390-linux-ld:ice_lib.c:(.text):undefined-reference-to-ice_is_cgu_present
|   `-- s390-linux-ld:ice_lib.c:(.text):undefined-reference-to-ice_is_clock_mux_present_e810t
|-- sparc-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- x86_64-allnoconfig
|   `-- Documentation-gpu-amdgpu-thermal:.-drivers-gpu-drm-amd-pm-amdgpu_pm.c:WARNING:Unexpected-indentation.
|-- x86_64-allyesconfig
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- x86_64-randconfig-002-20231004
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
`-- x86_64-randconfig-161-20231003
    `-- fs-ntfs3-bitmap.c-wnd_init()-warn:Please-consider-using-kvcalloc-instead-of-kvmalloc_array
clang_recent_errors
|-- hexagon-randconfig-r003-20221116
|   `-- bin-bash:line:Segmentation-fault-LLVM_OBJCOPY-llvm-objcopy-pahole-J-btf_gen_floats-j-lang_exclude-rust-skip_encoding_btf_inconsistent_proto-btf_gen_optimized-btf_base-vmlinux-drivers-power-supply-bq25
`-- hexagon-randconfig-r036-20230213
    `-- sound-pci-hda-cirrus_scodec_test.c:error:initializer-element-is-not-a-compile-time-constant

elapsed time: 720m

configs tested: 119
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231004   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20231004   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231004   gcc  
i386         buildonly-randconfig-002-20231004   gcc  
i386         buildonly-randconfig-003-20231004   gcc  
i386         buildonly-randconfig-004-20231004   gcc  
i386         buildonly-randconfig-005-20231004   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231004   gcc  
i386                  randconfig-002-20231004   gcc  
i386                  randconfig-003-20231004   gcc  
i386                  randconfig-004-20231004   gcc  
i386                  randconfig-005-20231004   gcc  
i386                  randconfig-006-20231004   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231004   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                       rbtx49xx_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                      walnut_defconfig   clang
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
sh                     magicpanelr2_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231004   gcc  
x86_64                randconfig-002-20231004   gcc  
x86_64                randconfig-003-20231004   gcc  
x86_64                randconfig-004-20231004   gcc  
x86_64                randconfig-005-20231004   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
