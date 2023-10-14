Return-Path: <linux-fsdevel+bounces-355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A247C9344
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9505B20AE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D2569D;
	Sat, 14 Oct 2023 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAZVSNDp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C111877;
	Sat, 14 Oct 2023 07:36:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB0BF;
	Sat, 14 Oct 2023 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697268974; x=1728804974;
  h=date:from:to:cc:subject:message-id;
  bh=LcwfZEcYEf/f4tUcGzyWriVFV01q/faDVa9sxT4TF3Q=;
  b=RAZVSNDp7McP8Frnn4DyGKk4WXcenU4hKRpLMK3Ai1nVS8c+59q0SErr
   KTlo1qarck4YFtP5wo76Vrn4zxuifyGH4V+uTRtiRAx0W3aUY5M8o0chy
   QNsn3YkjDWs9FvNIGs0nTVK6lj9WnOFAGG6pxWMTYvd0O1QZmCc9g8zu2
   R0LyZOKJ6K0Uz36fxMhE7bwghfGXZfZf4RUfCePq1uW8l0e3OSsWEkC09
   3JzSY6y9bpcQRzzuikfD+Ydky4YD5aP2FR1BXn6BssW9aVt8wp+Bnq/4W
   xd6hMcxLklUaR25XaRtmZEfVRX/Fw5E2+fsYgK+O+FcY5rQDtqUCxcula
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="471540301"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="471540301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 00:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748618440"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="748618440"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2023 00:36:10 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qrZBv-0005pD-1M;
	Sat, 14 Oct 2023 07:36:07 +0000
Date: Sat, 14 Oct 2023 15:35:44 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-crypto@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-staging@lists.linux.dev, ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 e3b18f7200f45d66f7141136c25554ac1e82009b
Message-ID: <202310141529.B09neLqf-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: e3b18f7200f45d66f7141136c25554ac1e82009b  Add linux-next specific files for 20231013

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310051547.40nm4Sif-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310052201.AnVbpgPr-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310100409.LrBAYpmk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310132104.O9S9Fdpn-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310132128.grw00tS2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310140301.H2JW530r-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/fpga/altera-ps-spi.c:74:34: warning: unused variable 'of_ef_match' [-Wunused-const-variable]
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 150)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:206 dcn35_init_hw() error: we previously assumed 'res_pool->hubbub' could be null (see line 159)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:285 dcn35_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 136)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:977 dcn35_calc_blocks_to_gate() error: we previously assumed 'pipe_ctx->plane_res.hubp' could be null (see line 973)
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'
fs/bcachefs/extents.h:603:17: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/bpf/helpers.c:1909:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1945:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2480:18: warning: no previous declaration for 'bpf_throw' [-Wmissing-declarations]

Unverified Error/Warning (likely false positive, please contact us if interested):

crypto/lskcipher.c:639 lskcipher_alloc_instance_simple() warn: passing zero to 'ERR_PTR'
drivers/staging/octeon/ethernet.c:204:37: error: storage size of 'rx_status' isn't known
drivers/staging/octeon/ethernet.c:205:37: error: storage size of 'tx_status' isn't known
drivers/staging/octeon/ethernet.c:801:49: error: storage size of 'imode' isn't known
drivers/staging/octeon/ethernet.c:802:21: error: variable 'imode' has initializer but incomplete type
fs/ntfs3/bitmap.c:663 wnd_init() warn: Please consider using kvcalloc instead of kvmalloc_array

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arc-randconfig-002-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- arm64-randconfig-004-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- csky-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-randconfig-003-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- i386-randconfig-141-20230905
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_calc_blocks_to_gate()-error:we-previously-assumed-pipe_ctx-plane_res.hubp-could-be-null-(see-line-)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_calc_blocks_to_gate()-warn:always-true-condition-(pipe_ctx-plane_res.mpcc_inst-)-(-)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_init_hw()-error:we-previously-assumed-dc-clk_mgr-could-be-null-(see-line-)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_init_hw()-error:we-previously-assumed-res_pool-hubbub-could-be-null-(see-line-)
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_init_hw()-warn:inconsistent-indenting
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_hwseq.c-dcn35_init_hw()-warn:variable-dereferenced-before-check-res_pool-dccg-(see-line-)
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn35-dcn35_resource.c-dcn35_resource_construct()-warn:inconsistent-indenting
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-loongson3_defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-001-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- loongarch-randconfig-002-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- microblaze-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- mips-cavium_octeon_defconfig
|   |-- drivers-staging-octeon-ethernet.c:error:storage-size-of-imode-isn-t-known
|   |-- drivers-staging-octeon-ethernet.c:error:storage-size-of-rx_status-isn-t-known
|   |-- drivers-staging-octeon-ethernet.c:error:storage-size-of-tx_status-isn-t-known
|   `-- drivers-staging-octeon-ethernet.c:error:variable-imode-has-initializer-but-incomplete-type
|-- openrisc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- openrisc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- parisc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-randconfig-001-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc-randconfig-002-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc64-randconfig-001-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc64-randconfig-001-20231014
|   `-- fs-bcachefs-extents.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc64-randconfig-002-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- powerpc64-randconfig-003-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- s390-randconfig-002-20231013
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc64-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- sparc64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
|-- x86_64-randconfig-001-20231013
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- x86_64-randconfig-161-20231013
|   |-- crypto-lskcipher.c-lskcipher_alloc_instance_simple()-warn:passing-zero-to-ERR_PTR
|   |-- drivers-gpu-drm-i915-display-intel_dsb.c-_intel_dsb_commit()-warn:always-true-condition-(dewake_scanline-)-(-u32max-)
|   |-- fs-ntfs3-bitmap.c-wnd_init()-warn:Please-consider-using-kvcalloc-instead-of-kvmalloc_array
|   `-- mm-gup.c-pin_user_pages_fd()-warn:unsigned-start-is-never-less-than-zero.
`-- xtensa-randconfig-001-20231013
    `-- drivers-gpu-drm-amd-amdgpu-amdgpu_gmc.c:warning:Function-parameter-or-member-gart_placement-not-described-in-amdgpu_gmc_gart_location
clang_recent_errors
`-- hexagon-randconfig-r011-20211004
    `-- drivers-fpga-altera-ps-spi.c:warning:unused-variable-of_ef_match

elapsed time: 1460m

configs tested: 118
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231013   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231013   gcc  
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
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231013   gcc  
i386                  randconfig-002-20231013   gcc  
i386                  randconfig-003-20231013   gcc  
i386                  randconfig-004-20231013   gcc  
i386                  randconfig-005-20231013   gcc  
i386                  randconfig-006-20231013   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231013   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   clang
mips                      pic32mzda_defconfig   clang
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
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231013   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231013   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231013   gcc  
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
x86_64                randconfig-001-20231013   gcc  
x86_64                randconfig-002-20231013   gcc  
x86_64                randconfig-003-20231013   gcc  
x86_64                randconfig-004-20231013   gcc  
x86_64                randconfig-005-20231013   gcc  
x86_64                randconfig-006-20231013   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

