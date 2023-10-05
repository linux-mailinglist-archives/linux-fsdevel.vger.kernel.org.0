Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08ED7BAA40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJETgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJETgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:36:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F6DB;
        Thu,  5 Oct 2023 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696534579; x=1728070579;
  h=date:from:to:cc:subject:message-id;
  bh=O7t8WCFgng//NcKf5qtV6wBZy0Py6B/isH81y3b1+j8=;
  b=W9LMPOSaosNY/RGHckvjLckUR0bDZfBrhGsQJUwCmduuavsEucbhX34c
   SeymF+jOd2qy/m2JmeCt12uolBccso85pCk/fALioRgNuTAaFZQMH+YOT
   FFhSJPLcys7n7iBFQRjIxRMPN9xzXuHfFjt5z7GnawATuThzC61vO1Wa6
   WtbkQ/VPuFpMvpXXi55C/NltwxaOCnJpsEmZSxhEJoRjkIjInVDho/+Of
   49bJvwAjrSw8r6BG1xe31d4cZRVEKMJwpaHxKkydJlSohH9/Ha17ChSI7
   5fJOn3Qw/BN+HihQ+ebIXHAbQiaHPSt3xDyeThXg31wJgsihNVtoaTzO+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2201542"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2201542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895571961"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895571961"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2023 12:34:44 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoU8q-000LpK-0U;
        Thu, 05 Oct 2023 19:36:12 +0000
Date:   Fri, 06 Oct 2023 03:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
        gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        kunit-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 7d730f1bf6f39ece2d9f3ae682f12e5b593d534d
Message-ID: <202310060305.T8zECtq5-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 7d730f1bf6f39ece2d9f3ae682f12e5b593d534d  Add linux-next specific files for 20231005

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309122047.cRi9yJrq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309221945.uwcQ56zg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310041744.d34gIv9V-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310042215.w9PG3Rqs-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310051547.40nm4Sif-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310052201.AnVbpgPr-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Documentation/gpu/amdgpu/thermal:43: ./drivers/gpu/drm/amd/pm/amdgpu_pm.c:988: WARNING: Unexpected indentation.
arch/x86/include/asm/string_32.h:150:25: warning: '__builtin_memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
drivers/cpufreq/sti-cpufreq.c:215:50: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'
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

Unverified Error/Warning (likely false positive, please contact us if interested):

Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:
arch/x86/kvm/x86.c:8891 x86_emulate_instruction() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c:209 amdgpu_mca_smu_get_mca_entry() warn: variable dereferenced before check 'mca_funcs' (see line 200)
drivers/gpu/drm/i915/display/intel_psr.c:3185 i915_psr_sink_status_show() error: uninitialized symbol 'error_status'.
drivers/gpu/drm/i915/display/intel_tc.c:327 mtl_tc_port_get_max_lane_count() error: uninitialized symbol 'pin_mask'.
fs/exfat/namei.c:393 exfat_find_empty_entry() error: uninitialized symbol 'last_clu'.
fs/ntfs3/bitmap.c:663 wnd_init() warn: Please consider using kvcalloc instead of kvmalloc_array
fs/ntfs3/super.c:466:23: sparse: sparse: unknown escape sequence: '\%'
lib/kunit/executor_test.c:39 parse_filter_test() error: double free of 'filter.suite_glob'
lib/kunit/executor_test.c:40 parse_filter_test() error: double free of 'filter.test_glob'
scripts/mod/modpost.c:1437:14: warning: passing 'typeof (rela->r_offset) *' (aka 'const unsigned long *') to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
scripts/mod/modpost.c:1440:11: warning: passing 'typeof (rela->r_addend) *' (aka 'const long *') to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
scripts/mod/modpost.c:1472:14: warning: passing 'typeof (rel->r_offset) *' (aka 'const unsigned long *') to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
{standard input}:1127: Error: unknown .loc sub-directive `is_stm'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
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
|-- i386-buildonly-randconfig-004-20231005
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-writing-bytes-into-a-region-of-size-overflows-the-destination
|-- i386-randconfig-003-20231005
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- i386-randconfig-005-20231005
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- i386-randconfig-061-20231005
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
|-- i386-randconfig-062-20231005
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
|-- i386-randconfig-063-20231005
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
|-- i386-randconfig-s002-20211104
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-001-20231005
|   `-- Documentation-devicetree-bindings-mfd-qcom-pm8xxx.yaml:
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
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allyesconfig
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
|-- sh-randconfig-r015-20230501
|   `-- standard-input:Error:unknown-.loc-sub-directive-is_stm
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
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
|-- x86_64-randconfig-103-20231005
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
`-- x86_64-randconfig-161-20231005
    |-- arch-x86-kvm-x86.c-x86_emulate_instruction()-warn:missing-error-code-r
    |-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
    |-- drivers-gpu-drm-amd-amdgpu-amdgpu_mca.c-amdgpu_mca_smu_get_mca_entry()-warn:variable-dereferenced-before-check-mca_funcs-(see-line-)
    |-- drivers-gpu-drm-i915-display-intel_dsb.c-_intel_dsb_commit()-warn:always-true-condition-(dewake_scanline-)-(-u32max-)
    |-- drivers-gpu-drm-i915-display-intel_psr.c-i915_psr_sink_status_show()-error:uninitialized-symbol-error_status-.
    |-- drivers-gpu-drm-i915-display-intel_tc.c-mtl_tc_port_get_max_lane_count()-error:uninitialized-symbol-pin_mask-.
    |-- fs-exfat-namei.c-exfat_find_empty_entry()-error:uninitialized-symbol-last_clu-.
    |-- fs-ntfs3-bitmap.c-wnd_init()-warn:Please-consider-using-kvcalloc-instead-of-kvmalloc_array
    |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
    |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
    |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
    |-- lib-kunit-executor_test.c-parse_filter_test()-error:double-free-of-filter.suite_glob
    `-- lib-kunit-executor_test.c-parse_filter_test()-error:double-free-of-filter.test_glob
clang_recent_errors
`-- s390-alldefconfig
    |-- scripts-mod-modpost.c:warning:passing-typeof-(rel-r_offset)-(aka-const-unsigned-long-)-to-parameter-of-type-void-discards-qualifiers
    |-- scripts-mod-modpost.c:warning:passing-typeof-(rela-r_addend)-(aka-const-long-)-to-parameter-of-type-void-discards-qualifiers
    `-- scripts-mod-modpost.c:warning:passing-typeof-(rela-r_offset)-(aka-const-unsigned-long-)-to-parameter-of-type-void-discards-qualifiers

elapsed time: 875m

configs tested: 120
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231005   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20231005   gcc  
arm                         vf610m4_defconfig   gcc  
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
i386         buildonly-randconfig-001-20231005   gcc  
i386         buildonly-randconfig-002-20231005   gcc  
i386         buildonly-randconfig-003-20231005   gcc  
i386         buildonly-randconfig-004-20231005   gcc  
i386         buildonly-randconfig-005-20231005   gcc  
i386         buildonly-randconfig-006-20231005   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231005   gcc  
i386                  randconfig-002-20231005   gcc  
i386                  randconfig-003-20231005   gcc  
i386                  randconfig-004-20231005   gcc  
i386                  randconfig-005-20231005   gcc  
i386                  randconfig-006-20231005   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231005   gcc  
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
mips                           ip28_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
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
x86_64                randconfig-001-20231005   gcc  
x86_64                randconfig-002-20231005   gcc  
x86_64                randconfig-003-20231005   gcc  
x86_64                randconfig-004-20231005   gcc  
x86_64                randconfig-005-20231005   gcc  
x86_64                randconfig-006-20231005   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
