Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69687B3E6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjI3FZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjI3FZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:25:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7917B9;
        Fri, 29 Sep 2023 22:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696051545; x=1727587545;
  h=date:from:to:cc:subject:message-id;
  bh=ikTuE2ISJ5c7tnVrMfL47uksRUpDiXItJyB89nyxGAo=;
  b=LACvjXOEH9i5Qk2u6AgjdLiaC62KA8JrxmjVlDX4rsSuSSZzGCKNah0S
   bZ4uSZQ0ORwO26Q5L2MkRIT73KbeLziqSu5TkSW/+2lGpfrXnKs7xh9wJ
   BG+6Lea9XBabkwMDRwffHQawMqz/0pfbbPIvTd/4wa4nWnRPvSvn0apBx
   7uJdigwxgSxyBD0q4h6ri99j+ASocUGHPPfaLw1NPLurcvKLDzVQXPC4T
   gw8CDJCI2OjoUFcDej3jyhk6YyWe/kTOcmJwrbk7FGc9JqjfGRL1ZB7TG
   7Nlpqwwdry/Y1r/RtHDzbF6hK346tsWUtHQeT5Fb5IaSCTqzxG9D0RZa3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379706805"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="379706805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 22:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="726782987"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="726782987"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Sep 2023 22:25:40 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmSTy-0003k4-0R;
        Sat, 30 Sep 2023 05:25:38 +0000
Date:   Sat, 30 Sep 2023 13:25:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, patches@opensource.cirrus.com
Subject: [linux-next:master] BUILD REGRESSION
 df964ce9ef9fea10cf131bf6bad8658fde7956f6
Message-ID: <202309301308.d22sJdaF-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: df964ce9ef9fea10cf131bf6bad8658fde7956f6  Add linux-next specific files for 20230929

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202309122047.cRi9yJrq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309130213.mSR7X2jZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309192154.NJNpFIy5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309192314.VBsjiIm5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212121.cul1pTRa-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309212339.hxhBu2F1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202309290750.bYBcf6Q2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: ice_dpll.c:(.text+0x1124): undefined reference to `ice_cgu_get_pin_type'
aarch64-linux-ld: ice_dpll.c:(.text+0x122c): undefined reference to `ice_cgu_get_pin_freq_supp'
aarch64-linux-ld: ice_dpll.c:(.text+0xaa0): undefined reference to `ice_cgu_get_pin_name'
aarch64-linux-ld: ice_dpll.c:(.text+0xab4): undefined reference to `ice_cgu_get_pin_type'
aarch64-linux-ld: ice_lib.c:(.text+0x6064): undefined reference to `ice_is_cgu_present'
aarch64-linux-ld: ice_lib.c:(.text+0x6070): undefined reference to `ice_is_clock_mux_present_e810t'
arc-elf-ld: xfrm_algo.c:(.text+0x46c): undefined reference to `crypto_has_aead'
arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1647:(.text+0x34a4): undefined reference to `ice_cgu_get_pin_type'
arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1666:(.text+0x3704): undefined reference to `ice_cgu_get_pin_freq_supp'
arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_lib.c:3998:(.text+0x166b0): undefined reference to `ice_is_cgu_present'
arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_lib.c:4000:(.text+0x16734): undefined reference to `ice_is_clock_mux_present_e810t'
drivers/cpufreq/sti-cpufreq.c:215:50: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3928: warning: Function parameter or member 'srf_updates' not described in 'could_mpcc_tree_change_for_active_pipes'
drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c:194:29: warning: variable 'tx_buf' set but not used [-Wunused-but-set-variable]
fs/bcachefs/bcachefs_format.h:215:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
fs/bcachefs/bcachefs_format.h:217:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
ice_dpll.c:(.text+0x1104): undefined reference to `ice_cgu_get_pin_name'
ice_dpll.c:(.text+0x15b4): undefined reference to `ice_get_cgu_state'
ice_dpll.c:(.text+0x1ea0): undefined reference to `ice_get_cgu_rclk_pin_info'
ice_dpll.c:(.text+0x2754): undefined reference to `ice_get_cgu_rclk_pin_info'
ice_dpll.c:(.text+0xa64): undefined reference to `ice_cgu_get_pin_freq_supp'
ice_dpll.c:(.text+0xe84): undefined reference to `ice_get_cgu_state'
ice_lib.c:(.text+0x604c): undefined reference to `ice_is_phy_rclk_present'
include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
kernel/bpf/helpers.c:1906:19: warning: no previous declaration for 'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1942:18: warning: no previous declaration for 'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2477:18: warning: no previous declaration for 'bpf_throw' [-Wmissing-declarations]
ld.lld: error: undefined symbol: crypto_has_aead
ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1647: undefined reference to `ice_cgu_get_pin_type'
riscv64-linux-ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1062:(.text+0x1236): undefined reference to `ice_get_cgu_state'
riscv64-linux-ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1667:(.text+0xdea): undefined reference to `ice_cgu_get_pin_name'
riscv64-linux-ld: drivers/net/ethernet/intel/ice/ice_dpll.c:1777:(.text+0x24aa): undefined reference to `ice_get_cgu_rclk_pin_info'
sound/pci/hda/cirrus_scodec_test.c:151:60: error: initializer element is not a compile-time constant
sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c:44:50: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 10 [-Wformat-truncation=]
xfrm_algo.c:(.text+0x46c): undefined reference to `crypto_has_aead'

Unverified Error/Warning (likely false positive, please contact us if interested):

Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml:
mm/shrinker.c:100:1-7: preceding lock on line 83
sound/pci/hda/cs35l41_hda.c:1559 cs35l41_hda_probe() warn: passing zero to 'dev_err_probe'
{standard input}:1247: Error: unknown pseudo-op: `.sho'
{standard input}:1468: Error: unknown .loc sub-directive `is_'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- arc-defconfig
|   |-- arc-elf-ld:xfrm_algo.c:(.text):undefined-reference-to-crypto_has_aead
|   `-- xfrm_algo.c:(.text):undefined-reference-to-crypto_has_aead
|-- arm-allmodconfig
|   |-- drivers-cpufreq-sti-cpufreq.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   `-- sound-soc-mediatek-mt2701-mt2701-afe-clock-ctrl.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-allyesconfig
|   |-- drivers-cpufreq-sti-cpufreq.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   `-- sound-soc-mediatek-mt2701-mt2701-afe-clock-ctrl.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm-randconfig-r012-20220815
|   |-- arm-linux-gnueabi-ld:drivers-net-ethernet-intel-ice-ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_freq_supp
|   |-- arm-linux-gnueabi-ld:drivers-net-ethernet-intel-ice-ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_type
|   |-- arm-linux-gnueabi-ld:drivers-net-ethernet-intel-ice-ice_lib.c:(.text):undefined-reference-to-ice_is_cgu_present
|   `-- arm-linux-gnueabi-ld:drivers-net-ethernet-intel-ice-ice_lib.c:(.text):undefined-reference-to-ice_is_clock_mux_present_e810t
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|   `-- sound-soc-mediatek-mt2701-mt2701-afe-clock-ctrl.c:warning:d-directive-output-may-be-truncated-writing-between-and-bytes-into-a-region-of-size
|-- arm64-randconfig-001-20230929
|   |-- aarch64-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_name
|   |-- aarch64-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_type
|   |-- aarch64-linux-ld:ice_lib.c:(.text):undefined-reference-to-ice_is_cgu_present
|   |-- aarch64-linux-ld:ice_lib.c:(.text):undefined-reference-to-ice_is_clock_mux_present_e810t
|   |-- ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_freq_supp
|   |-- ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_rclk_pin_info
|   |-- ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_state
|   `-- ice_lib.c:(.text):undefined-reference-to-ice_is_phy_rclk_present
|-- arm64-randconfig-002-20230927
|   |-- aarch64-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_freq_supp
|   |-- aarch64-linux-ld:ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_type
|   |-- ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_name
|   |-- ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_rclk_pin_info
|   `-- ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_state
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- csky-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- i386-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- i386-buildonly-randconfig-005-20230929
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- i386-randconfig-006-20230929
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_drop_impl
|   |-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_percpu_obj_new_impl
|   `-- kernel-bpf-helpers.c:warning:no-previous-declaration-for-bpf_throw
|-- i386-randconfig-a014-20211211
|   `-- ld:drivers-net-ethernet-intel-ice-ice_dpll.c:undefined-reference-to-ice_cgu_get_pin_type
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- loongarch-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- loongarch-randconfig-001-20230929
|   |-- Documentation-devicetree-bindings-mfd-qcom-pm8xxx.yaml:
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- loongarch-randconfig-002-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- m68k-allmodconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- m68k-allyesconfig
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- microblaze-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- powerpc-randconfig-001-20230929
|   |-- drivers-net-ethernet-intel-idpf-idpf_singleq_txrx.c:warning:variable-tx_buf-set-but-not-used
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- powerpc-randconfig-003-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- riscv-buildonly-randconfig-r001-20221205
|   |-- riscv64-linux-ld:drivers-net-ethernet-intel-ice-ice_dpll.c:(.text):undefined-reference-to-ice_cgu_get_pin_name
|   |-- riscv64-linux-ld:drivers-net-ethernet-intel-ice-ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_rclk_pin_info
|   `-- riscv64-linux-ld:drivers-net-ethernet-intel-ice-ice_dpll.c:(.text):undefined-reference-to-ice_get_cgu_state
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   |-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- sh-randconfig-r011-20230418
|   `-- standard-input:Error:unknown-pseudo-op:sho
|-- sh-randconfig-r032-20230410
|   `-- standard-input:Error:unknown-.loc-sub-directive-is_
|-- sparc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc-randconfig-001-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- sparc64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   |-- fs-bcachefs-bcachefs_format.h:warning:p-offset-in-struct-bkey-isn-t-aligned-to
|   `-- fs-bcachefs-bcachefs_format.h:warning:version-offset-in-struct-bkey-isn-t-aligned-to
|-- sparc64-randconfig-002-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|   `-- include-linux-fortify-string.h:warning:writing-bytes-into-a-region-of-size
|-- x86_64-buildonly-randconfig-005-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- x86_64-randconfig-015-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- x86_64-randconfig-071-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- x86_64-randconfig-076-20230929
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
|-- x86_64-randconfig-103-20230927
|   `-- mm-shrinker.c:preceding-lock-on-line
|-- x86_64-randconfig-161-20230929
|   `-- sound-pci-hda-cs35l41_hda.c-cs35l41_hda_probe()-warn:passing-zero-to-dev_err_probe
`-- xtensa-randconfig-002-20230929
    `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:Function-parameter-or-member-srf_updates-not-described-in-could_mpcc_tree_change_for_active_pipes
clang_recent_errors
|-- arm-ep93xx_defconfig
|   `-- ld.lld:error:undefined-symbol:crypto_has_aead
`-- hexagon-allmodconfig
    `-- sound-pci-hda-cirrus_scodec_test.c:error:initializer-element-is-not-a-compile-time-constant

elapsed time: 1457m

configs tested: 134
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230929   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230929   gcc  
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
i386         buildonly-randconfig-001-20230929   gcc  
i386         buildonly-randconfig-002-20230929   gcc  
i386         buildonly-randconfig-003-20230929   gcc  
i386         buildonly-randconfig-004-20230929   gcc  
i386         buildonly-randconfig-005-20230929   gcc  
i386         buildonly-randconfig-006-20230929   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230929   gcc  
i386                  randconfig-002-20230929   gcc  
i386                  randconfig-003-20230929   gcc  
i386                  randconfig-004-20230929   gcc  
i386                  randconfig-005-20230929   gcc  
i386                  randconfig-006-20230929   gcc  
i386                  randconfig-011-20230929   gcc  
i386                  randconfig-012-20230929   gcc  
i386                  randconfig-013-20230929   gcc  
i386                  randconfig-014-20230929   gcc  
i386                  randconfig-015-20230929   gcc  
i386                  randconfig-016-20230929   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230929   gcc  
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
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230929   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230929   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230929   gcc  
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
x86_64       buildonly-randconfig-001-20230929   gcc  
x86_64       buildonly-randconfig-002-20230929   gcc  
x86_64       buildonly-randconfig-003-20230929   gcc  
x86_64       buildonly-randconfig-004-20230929   gcc  
x86_64       buildonly-randconfig-005-20230929   gcc  
x86_64       buildonly-randconfig-006-20230929   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230929   gcc  
x86_64                randconfig-002-20230929   gcc  
x86_64                randconfig-003-20230929   gcc  
x86_64                randconfig-004-20230929   gcc  
x86_64                randconfig-005-20230929   gcc  
x86_64                randconfig-006-20230929   gcc  
x86_64                randconfig-011-20230929   gcc  
x86_64                randconfig-012-20230929   gcc  
x86_64                randconfig-013-20230929   gcc  
x86_64                randconfig-014-20230929   gcc  
x86_64                randconfig-015-20230929   gcc  
x86_64                randconfig-016-20230929   gcc  
x86_64                randconfig-071-20230929   gcc  
x86_64                randconfig-072-20230929   gcc  
x86_64                randconfig-073-20230929   gcc  
x86_64                randconfig-074-20230929   gcc  
x86_64                randconfig-075-20230929   gcc  
x86_64                randconfig-076-20230929   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
