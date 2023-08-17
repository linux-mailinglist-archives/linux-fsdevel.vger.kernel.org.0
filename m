Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88777FD42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354080AbjHQRvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353791AbjHQRvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:51:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C0AFD;
        Thu, 17 Aug 2023 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692294701; x=1723830701;
  h=date:from:to:cc:subject:message-id;
  bh=Qq6Pp/ieMedj/qD4CWVQWeanO2Fn6fVRWp5sEpfAHiU=;
  b=ecOM5MQx0TMnPv+NBBZr3FlEpbmowx9UKACWWgzxmNezRPnqwOEMBFHV
   YrH5Sou9RS30iBs25zjMOXx8Ui0XHcB1I/ZmD9GpVC11m7fz8FZ/J7hGr
   TLBE0JmZRcPGNOzPe4IfTSMRkRSZShuwV5CRCkWQyy3aN5mBdAbVRLKtA
   NM/HjERq8yvKvr6OZcTxH3saIEz7Rem8iTfVtGAppnHIA1Ys1C3piekaR
   LlnMoIQN5vL3lgrZ2pf4TYpb39vwIye/nluoFj6XvZXMFWKqX+ExN20iA
   js130+NoWixM+UIn9++SCtrlcyCZuft6JoIxa2Uo5bYw5ycsOlcbQCt50
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403867192"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403867192"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065371695"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065371695"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 10:51:36 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWh9j-0001MT-1X;
        Thu, 17 Aug 2023 17:51:35 +0000
Date:   Fri, 18 Aug 2023 01:51:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-crypto@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-spi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 47762f08697484cf0c2f2904b8c52375ed26c8cb
Message-ID: <202308180122.V8WHsGaW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 47762f08697484cf0c2f2904b8c52375ed26c8cb  Add linux-next specific files for 20230817

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
https://lore.kernel.org/oe-kbuild-all/202308170544.f6zj62AL-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171406.uWe0yyv9-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171521.DFEZZNuE-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171555.5mSXBst8-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171620.m4MNACWz-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171742.AncabIG1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308171801.P2Rd8yeL-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308172148.PPKMOAI8-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308172348.1BthulLk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308180127.VD7YRPGa-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'product_name' not found
./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'serial_number' not found
Documentation/gpu/rfc/i915_scheduler.rst:138: WARNING: Unknown directive type "c:namespace-push".
Documentation/gpu/rfc/i915_scheduler.rst:143: WARNING: Unknown directive type "c:namespace-pop".
ERROR: modpost: "bdev_mark_dead" [drivers/s390/block/dasd_mod.ko] undefined!
Warning: kernel/Kconfig.kexec references a file that doesn't exist: file:Documentation/s390/zfcpdump.rst
arch/csky/include/asm/ptrace.h:100:11: error: expected ';' before 'void'
arch/csky/include/asm/ptrace.h:99:11: error: expected ';' before 'int'
arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
arch/loongarch/kernel/asm-offsets.c:172:6: warning: no previous prototype for 'output_thread_lbt_defines' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:516: warning: Function parameter or member 'xcc_id' not described in 'amdgpu_mm_wreg_mmio_rlc'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:576: warning: Function parameter or member 'xcc_id' not described in 'amdgpu_mm_wreg_mmio_rlc'
drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Excess function parameter 'db_index' description in 'amdgpu_doorbell_index_on_bar'
drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Function parameter or member 'doorbell_index' not described in 'amdgpu_doorbell_index_on_bar'
drivers/gpu/drm/drm_gpuva_mgr.c:1079:32: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/drm_gpuva_mgr.c:1079:39: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for drm_kunit_helper_context_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead
drivers/infiniband/hw/irdma/verbs.c:584: warning: Function parameter or member 'udata' not described in 'irdma_setup_umode_qp'
drivers/infiniband/hw/irdma/verbs.c:586: warning: Function parameter or member 'udata' not described in 'irdma_setup_umode_qp'
drivers/media/pci/intel/ivsc/mei_csi.c:342:10: error: call to undeclared function 'v4l2_subdev_get_try_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/media/pci/intel/ivsc/mei_csi.c:342:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct v4l2_mbus_framefmt *' [-Wint-conversion]
drivers/media/pci/intel/ivsc/mei_csi.c:360:14: error: incompatible integer to pointer conversion assigning to 'struct v4l2_mbus_framefmt *' from 'int' [-Wint-conversion]
drivers/pinctrl/pinctrl-cy8c95x0.c:168: warning: Function parameter or member 'gpio_reset' not described in 'cy8c95x0_pinctrl'
drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member 'remote_flow_restricted' not described in 'rpmsg_eptdev'
drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member 'remote_flow_updated' not described in 'rpmsg_eptdev'
drivers/video/backlight/lp855x_bl.c:252:11: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
fs/fuse/dir.c:353:6: warning: no previous declaration for 'fuse_valid_size' [-Wmissing-declarations]
include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
kernel/bpf/map_iter.c:200:17: warning: no previous declaration for 'bpf_map_sum_elem_count' [-Wmissing-declarations]
kernel/seccomp.c:151: warning: Function parameter or member 'requests' not described in 'notification'
kernel/seccomp.c:154: warning: Function parameter or member 'requests' not described in 'notification'
lib/kunit/attributes.c:41: warning: Function parameter or member 'attr_default' not described in 'kunit_attr'
lib/kunit/attributes.c:41: warning: Function parameter or member 'print' not described in 'kunit_attr'
net/bpf/test_run.c:559:15: warning: no previous declaration for 'bpf_fentry_test_sinfo' [-Wmissing-declarations]
net/bpf/test_run.c:569:17: warning: no previous declaration for 'bpf_modify_return_test2' [-Wmissing-declarations]

Unverified Error/Warning (likely false positive, please contact us if interested):

kernel/workqueue.c:325:40: sparse: sparse: duplicate [noderef]
kernel/workqueue.c:325:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
lib/crypto/mpi/mpi-inv.c:34:15: warning: variable 'k' set but not used [-Wunused-but-set-variable]
sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
{standard input}: Warning: end of file not at end of a line; newline inserted
{standard input}:927: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- alpha-randconfig-r001-20230817
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- alpha-randconfig-r002-20230817
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arc-randconfig-r013-20230817
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|-- arc-randconfig-r043-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arm-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm-randconfig-r005-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- arm64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- arm64-randconfig-r023-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- arm64-randconfig-r092-20230817
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- csky-defconfig
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-int
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-void
|   `-- arch-csky-include-asm-traps.h:error:expected-before-void
|-- csky-randconfig-r034-20230817
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- csky-randconfig-r061-20230817
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-int
|   |-- arch-csky-include-asm-ptrace.h:error:expected-before-void
|   |-- arch-csky-include-asm-traps.h:error:expected-before-void
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- i386-debian-10.3
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i011-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i013-20230817
|   |-- kernel-bpf-map_iter.c:warning:no-previous-declaration-for-bpf_map_sum_elem_count
|   |-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_modify_return_test2
|-- i386-randconfig-i015-20230817
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   `-- fs-fuse-dir.c:warning:no-previous-declaration-for-fuse_valid_size
|-- i386-randconfig-i016-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- i386-randconfig-i051-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- i386-randconfig-i052-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i053-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- i386-randconfig-i054-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- i386-randconfig-i061-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-randconfig-i062-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_restricted-not-described-in-rpmsg_eptdev
|   |-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_updated-not-described-in-rpmsg_eptdev
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-randconfig-i063-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   |-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- i386-randconfig-m021-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- loongarch-allmodconfig
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- loongarch-allnoconfig
|   `-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|-- loongarch-defconfig
|   |-- arch-loongarch-kernel-asm-offsets.c:warning:no-previous-prototype-for-output_thread_lbt_defines
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- include-linux-build_bug.h:error:bit-field-anonymous-width-not-an-integer-constant
|-- m68k-allmodconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- m68k-allyesconfig
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- m68k-amiga_defconfig
|   `-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|-- m68k-randconfig-r031-20230817
|   |-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_restricted-not-described-in-rpmsg_eptdev
|   `-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_updated-not-described-in-rpmsg_eptdev
|-- microblaze-randconfig-r006-20230817
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- microblaze-randconfig-r032-20230817
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   |-- lib-kunit-attributes.c:warning:Function-parameter-or-member-attr_default-not-described-in-kunit_attr
|   `-- lib-kunit-attributes.c:warning:Function-parameter-or-member-print-not-described-in-kunit_attr
|-- mips-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- mips-randconfig-r053-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- nios2-randconfig-r003-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|-- openrisc-randconfig-m041-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- openrisc-randconfig-r021-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- parisc-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- parisc-randconfig-r016-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- parisc-randconfig-r031-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- parisc-randconfig-r033-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- parisc64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- powerpc-randconfig-r015-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- powerpc-randconfig-r064-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- riscv-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- riscv-randconfig-r012-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- riscv-randconfig-r013-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- riscv-randconfig-r042-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- riscv-randconfig-r072-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- riscv-randconfig-r093-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|   |-- kernel-workqueue.c:sparse:sparse:duplicate-noderef
|   `-- kernel-workqueue.c:sparse:sparse:multiple-address-spaces-given:__percpu-__rcu
|-- riscv-rv32_defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- s390-randconfig-r044-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- sh-allmodconfig
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   |-- sh4-linux-gcc:internal-compiler-error:Segmentation-fault-signal-terminated-program-cc1
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:end-of-file-not-at-end-of-a-line-newline-inserted
|-- sparc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- sparc-randconfig-r032-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- um-i386_defconfig
|   `-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|-- x86_64-allnoconfig
|   |-- Documentation-gpu-rfc-i915_scheduler.rst:WARNING:Unknown-directive-type-c:namespace-pop-.
|   |-- Documentation-gpu-rfc-i915_scheduler.rst:WARNING:Unknown-directive-type-c:namespace-push-.
|   |-- Warning:kernel-Kconfig.kexec-references-a-file-that-doesn-t-exist:file:Documentation-s390-zfcpdump.rst
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:product_name-not-found
|   `-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:serial_number-not-found
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-infiniband-hw-irdma-verbs.c:warning:Function-parameter-or-member-udata-not-described-in-irdma_setup_umode_qp
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-defconfig
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-m001-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- fs-fuse-dir.c:warning:no-previous-declaration-for-fuse_valid_size
|   |-- kernel-bpf-map_iter.c:warning:no-previous-declaration-for-bpf_map_sum_elem_count
|   |-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_modify_return_test2
|-- x86_64-randconfig-r014-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-r022-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-x001-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-x002-20230817
|   `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|-- x86_64-randconfig-x003-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- fs-fuse-dir.c:warning:no-previous-declaration-for-fuse_valid_size
|   |-- kernel-bpf-map_iter.c:warning:no-previous-declaration-for-bpf_map_sum_elem_count
|   |-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_fentry_test_sinfo
|   `-- net-bpf-test_run.c:warning:no-previous-declaration-for-bpf_modify_return_test2
|-- x86_64-randconfig-x004-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_device.c:warning:Function-parameter-or-member-xcc_id-not-described-in-amdgpu_mm_wreg_mmio_rlc
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-x006-20230817
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-x051-20230817
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   `-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|-- x86_64-randconfig-x052-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   `-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|-- x86_64-randconfig-x053-20230817
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   `-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
|-- x86_64-randconfig-x054-20230817
|   |-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
|   |-- drivers-pinctrl-pinctrl-cy8c95x0.c:warning:Function-parameter-or-member-gpio_reset-not-described-in-cy8c95x0_pinctrl
|   `-- kernel-seccomp.c:warning:Function-parameter-or-member-requests-not-described-in-notification
`-- x86_64-rhel-8.3
    `-- drivers-gpu-drm-drm_gpuva_mgr.c:warning:variable-prev-set-but-not-used
clang_recent_errors
|-- arm-randconfig-r046-20230817
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- hexagon-randconfig-r041-20230817
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- hexagon-randconfig-r045-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-buildonly-randconfig-r004-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-buildonly-randconfig-r005-20230817
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-buildonly-randconfig-r006-20230817
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i001-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i002-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i003-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i004-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i005-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- i386-randconfig-i006-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- riscv-randconfig-r036-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Excess-function-parameter-db_index-description-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Function-parameter-or-member-doorbell_index-not-described-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_restricted-not-described-in-rpmsg_eptdev
|   `-- drivers-rpmsg-rpmsg_char.c:warning:Function-parameter-or-member-remote_flow_updated-not-described-in-rpmsg_eptdev
|-- s390-randconfig-r004-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- s390-randconfig-r006-20230817
|   `-- ERROR:bdev_mark_dead-drivers-s390-block-dasd_mod.ko-undefined
|-- um-randconfig-r011-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- um-randconfig-r024-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-buildonly-randconfig-r001-20230817
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-buildonly-randconfig-r002-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Excess-function-parameter-db_index-description-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Function-parameter-or-member-doorbell_index-not-described-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-gpu-drm-tests-drm_kunit_helpers.c:warning:expecting-prototype-for-drm_kunit_helper_context_alloc().-Prototype-was-for-drm_kunit_helper_acquire_ctx_alloc()-instead
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-buildonly-randconfig-r003-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-r025-20230816
|   `-- drivers-spi-spi-amd.o:warning:objtool:.text.amd_spi_host_transfer:unexpected-end-of-section
|-- x86_64-randconfig-x011-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x012-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x013-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x014-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x015-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Excess-function-parameter-db_index-description-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Function-parameter-or-member-doorbell_index-not-described-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x016-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x071-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x072-20230817
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x073-20230817
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Excess-function-parameter-db_index-description-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_doorbell_mgr.c:warning:Function-parameter-or-member-doorbell_index-not-described-in-amdgpu_doorbell_index_on_bar
|   |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x074-20230817
|   |-- drivers-media-pci-intel-ivsc-mei_csi.c:error:call-to-undeclared-function-v4l2_subdev_get_try_format-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-media-pci-intel-ivsc-mei_csi.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-v4l2_mbus_framefmt-from-int
|   |-- drivers-media-pci-intel-ivsc-mei_csi.c:error:incompatible-integer-to-pointer-conversion-returning-int-from-a-function-with-result-type-struct-v4l2_mbus_framefmt
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x075-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
|-- x86_64-randconfig-x076-20230817
|   `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used
`-- x86_64-rhel-8.3-rust
    |-- drivers-video-backlight-lp855x_bl.c:warning:variable-ret-is-used-uninitialized-whenever-if-condition-is-false
    `-- lib-crypto-mpi-mpi-inv.c:warning:variable-k-set-but-not-used

elapsed time: 730m

configs tested: 113
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230817   gcc  
alpha                randconfig-r002-20230817   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230817   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                  randconfig-r005-20230817   gcc  
arm                  randconfig-r046-20230817   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230817   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230817   clang
hexagon              randconfig-r045-20230817   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i011-20230817   gcc  
i386                 randconfig-i012-20230817   gcc  
i386                 randconfig-i013-20230817   gcc  
i386                 randconfig-i014-20230817   gcc  
i386                 randconfig-i015-20230817   gcc  
i386                 randconfig-i016-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r006-20230817   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                 randconfig-r034-20230817   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230817   gcc  
openrisc             randconfig-r021-20230817   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230817   gcc  
parisc               randconfig-r031-20230817   gcc  
parisc               randconfig-r033-20230817   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-r015-20230817   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230817   gcc  
riscv                randconfig-r013-20230817   gcc  
riscv                randconfig-r042-20230817   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230817   clang
s390                 randconfig-r044-20230817   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230817   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230817   clang
um                   randconfig-r024-20230817   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r014-20230817   gcc  
x86_64               randconfig-r022-20230817   gcc  
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x011-20230817   clang
x86_64               randconfig-x012-20230817   clang
x86_64               randconfig-x013-20230817   clang
x86_64               randconfig-x014-20230817   clang
x86_64               randconfig-x015-20230817   clang
x86_64               randconfig-x016-20230817   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
