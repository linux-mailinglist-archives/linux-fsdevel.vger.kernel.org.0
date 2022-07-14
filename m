Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361B574116
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 03:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiGNB46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 21:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGNB45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:56:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF94186E7;
        Wed, 13 Jul 2022 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657763815; x=1689299815;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1dI46LC8EZvKaITJZeugXLHI1LUtI+XqdOG1yfoS3vY=;
  b=iBA5J2262w60MB+N6lVlOISDo3EYainoyZnKQ2iMkDjeem5qdyw/c5GF
   6VBvLyYf0+JnflMU+VS6np9CN8KAyzTgKUeO8EaqKBPeIAdrcaBpWoyLG
   6lIQLmkzDO/9ryVa63C9FadP9RKTCuLR1cKfTOk22lzEYu6f+xwvKro/O
   Hk/vjMDL1ygDUaOoEeiB+Qsxa7p52/wbckU1dPp2zHoh8Ov/lkVgRmdMI
   degWvv5EdXzMTt4W89gHC4WICCHTffybeFK1bsVPKjkXF3NtCwL8e1rDo
   lb50NEj8UJ/1pKzLKy0wKIkOmpsmqrCIzm6+H1a3rBrpWgNO2ia1jHNX6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="268422128"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="268422128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="653660088"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2022 18:56:51 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBo5y-00002E-BL;
        Thu, 14 Jul 2022 01:56:50 +0000
Date:   Thu, 14 Jul 2022 09:56:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ntfs3@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-can@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Message-ID: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4662b7adea50bb62e993a67f611f3be625d3df0d  Add linux-next specific files for 20220713

Error/Warning reports:

https://lore.kernel.org/linux-doc/202207021352.PpKTUY8V-lkp@intel.com
https://lore.kernel.org/linux-doc/202207031437.qIh6LFcx-lkp@intel.com
https://lore.kernel.org/linux-doc/202207051821.3f0eRIsL-lkp@intel.com
https://lore.kernel.org/linux-doc/202207140742.GTPk4U8i-lkp@intel.com
https://lore.kernel.org/linux-mm/202206292052.LsFui3zO-lkp@intel.com
https://lore.kernel.org/linux-mm/202207140042.cK3tlk6j-lkp@intel.com
https://lore.kernel.org/llvm/202207090100.acXdJ79H-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING: Unexpected indentation.
Documentation/PCI/endpoint/pci-vntb-howto.rst:131: WARNING: Title underline too short.
Documentation/filesystems/netfs_library.rst:384: WARNING: Inline emphasis start-string without end-string.
Documentation/filesystems/netfs_library:609: fs/netfs/buffered_read.c:318: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/kvm/api.rst:8256: WARNING: Title underline too short.
Documentation/virt/kvm/api.rst:8263: WARNING: Unexpected indentation.
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2837:6: warning: no previous prototype for function 'dc_reset_state' [-Wmissing-prototypes]
drivers/mmc/host/sdhci-of-aspeed-test.c:10: undefined reference to `kunit_binary_assert_format'
drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: no previous prototype for 'pci_read' [-Wmissing-prototypes]
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: no previous prototype for 'pci_write' [-Wmissing-prototypes]
drivers/vfio/vfio_iommu_type1.c:2141:35: warning: cast to smaller integer type 'enum iommu_cap' from 'void *' [-Wvoid-pointer-to-enum-cast]
fs/ntfs/attrib.c:705:18: warning: Either the condition '!al' is redundant or there is pointer arithmetic with NULL pointer. [nullPointerArithmeticRedundantCheck]
fs/ntfs/layout.h:126:43: warning: Parameter 'p' can be declared with const [constParameter]
fs/ntfs/ntfs.h:144:3: warning: Assignment of function parameter has no effect outside the function. [uselessAssignmentArg]
fs/super.c:1310:57: warning: Parameter 'data' can be declared with const [constParameter]
fs/super.c:750:52: warning: Parameter 'bdev' can be declared with const [constParameter]
ipc/shm.c:158:0: warning: failed to expand 'ipc_init_proc_interface', it is invalid to use a preprocessor directive as macro parameter [preprocessorErrorDirective]
kernel/bpf/task_iter.c:152:11: warning: Redundant initialization for 'curr_fd'. The initialized value is overwritten before it is read. [redundantInitialization]
kernel/bpf/task_iter.c:498:59: warning: Parameter 'v' can be declared with const [constParameter]
kernel/fork.c:3256:42: warning: Parameter 'table' can be declared with const [constParameter]
kernel/fork.c:942:33: warning: Parameter 'src' can be declared with const [constParameter]
kernel/sched/fair.c:5081:25: warning: Uninitialized variables: cfs_rq.load, cfs_rq.nr_running, cfs_rq.h_nr_running, cfs_rq.idle_nr_running, cfs_rq.idle_h_nr_running, cfs_rq.exec_clock, cfs_rq.min_vruntime, cfs_rq.min_vruntime_copy, cfs_rq.tasks_timeline, cfs_rq.curr, cfs_rq.next, cfs_rq.last, cfs_rq.skip [uninitvar]
kernel/sched/fair.c:6967:7: warning: Local variable 'min_vruntime' shadows outer function [shadowFunction]
lib/maple_tree.c:1522:52: warning: Parameter 'gaps' can be declared with const [constParameter]
lib/maple_tree.c:1871:21: warning: Array index 'split' is used before limits check. [arrayIndexThenCheck]
lib/maple_tree.c:2033:55: warning: Parameter 'mas' can be declared with const [constParameter]
lib/maple_tree.c:2426:8: warning: Redundant initialization for 'r_tmp'. The initialized value is overwritten before it is read. [redundantInitialization]
lib/maple_tree.c:2427:8: warning: Redundant initialization for 'l_tmp'. The initialized value is overwritten before it is read. [redundantInitialization]
lib/maple_tree.c:3160:22: warning: Found suspicious operator ',' [constStatement]
lib/maple_tree.c:3208:11: warning: Size of pointer 'pivs' used instead of size of its data. [pointerSize]
lib/maple_tree.c:326:2: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
lib/maple_tree.c:4266:15: warning: The if condition is the same as the previous if condition [duplicateCondition]
lib/maple_tree.c:4302:23: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
lib/maple_tree.c:694:59: warning: Parameter 'pivots' can be declared with const [constParameter]
lib/test_printf.c:415:11: warning: Local variable 'addr' shadows outer function [shadowFunction]
mm/highmem.c:737:13: warning: Uninitialized variable: pam->page [uninitvar]
mm/migrate.c:355:53: warning: Parameter 'mapping' can be declared with const [constParameter]
mm/migrate.c:875:7: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]
mm/mlock.c:230:20: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
mm/slab.c:1635:24: warning: Uninitialized variables: slab.__page_flags, slab.__unused_1, slab.freelist, slab.units, slab.__unused_2, slab.__page_refcount [uninitvar]
mm/slab.c:3289:7: warning: Redundant assignment of 'objp' to itself. [selfAssignment]
mm/slab.c:3509:8: warning: Redundant assignment of 'p[i]' to itself. [selfAssignment]
mm/slab.c:405:9: warning: Local variable 'slab_size' shadows outer function [shadowFunction]
mm/vmstat.c:1409:53: warning: Parameter 'pos' can be declared with const [constParameter]
mm/vmstat.c:1650:68: warning: Parameter 'zone' can be declared with const [constParameter]
mm/zsmalloc.c:2019:15: warning: Uninitialized variables: zspage.huge, zspage.fullness, zspage.class, zspage.isolated, zspage.magic, zspage.inuse, zspage.freeobj, zspage.first_page, zspage.lock [uninitvar]
mm/zsmalloc.c:2060:16: warning: Local variable 'obj_allocated' shadows outer function [shadowFunction]
or1k-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.c:10: undefined reference to `kunit_binary_assert_format'
or1k-linux-ld: drivers/mmc/host/sdhci-of-aspeed-test.c:10: undefined reference to `kunit_do_failed_assertion'

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/kernel/cpu/rdrand.c:36 x86_init_rdrand() error: uninitialized symbol 'prev'.
drivers/firmware/arm_scmi/clock.c:394:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/firmware/arm_scmi/powercap.c:376:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_powertune.c:1214:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/bridge/ite-it66121.c:1398:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/tests/drm_buddy_test.c:197:26-31: ERROR: invalid reference to the index variable of the iterator on line 152
drivers/infiniband/hw/irdma/hw.c:1484:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/md/dm-mpath.c:1681:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/dvb-frontends/mxl692.c:49:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/ov5647.c:636:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/st-mipid02.c:295:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/platform/qcom/venus/vdec.c:1505:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/platform/st/sti/delta/delta-v4l2.c:719:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/tuners/msi001.c:81:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/mfd/sec-core.c:429:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/mmc/host/sh_mmcif.c:1318:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/bonding/bond_main.c:4647:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void *
drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void [noderef] __rcu *
drivers/net/can/slcan/slcan-core.c:601:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
drivers/net/dsa/microchip/ksz9477.c:501:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1388:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/faraday/ftgmac100.c:854:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/hisilicon/hns/hnae.c:436:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/intel/i40e/i40e_main.c:9347:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/intel/ice/ice_base.c:1003:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/intel/ice/ice_dcb_lib.c:520:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/intel/ice/ice_vlan_mode.c:379:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/intel/igb/e1000_phy.c:1185:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/microchip/encx24j600.c:827:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/microchip/lan743x_main.c:1238:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/smsc/smsc9420.c:451:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/ethernet/vertexcom/mse102x.c:422:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/phy/dp83640.c:890:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/usb/cdc_ncm.c:195:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/usb/rtl8150.c:176:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/parport/ieee1284_ops.c:615:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/scsi/elx/efct/efct_unsol.c:297:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/scsi/elx/libefc/efc_domain.c:692:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/scsi/megaraid/megaraid_sas_fp.c:297:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/soc/mediatek/mtk-mutex.c:793:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/staging/media/zoran/zr36016.c:430:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/staging/media/zoran/zr36050.c:829:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/staging/media/zoran/zr36060.c:869:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/target/iscsi/iscsi_target.c:2348:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/target/target_core_device.c:1013:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/thunderbolt/tmu.c:758:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/thunderbolt/tunnel.c:1264:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/tty/serial/atmel_serial.c:1442:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/usb/host/uhci-q.c:1367:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/usb/serial/digi_acceleport.c:1167:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/video/backlight/qcom-wled.c:871:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
fs/ext4/mballoc.c:3618:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
fs/kernel_read_file.c:61 kernel_read_file() warn: impossible condition '(i_size > (((~0) >> 1))) => (s64min-s64max > s64max)'
fs/ubifs/recovery.c:1062:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
include/linux/bits.h:9:41: warning: shift by negative count ('-1') [-Wanalyzer-shift-count-negative]
mm/filemap.c:1354:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/khugepaged.c:2410 madvise_collapse() warn: possible memory leak of 'cc'
mm/madvise.c:1174:66: warning: Parameter 'task' can be declared with const [constParameter]
mm/page_alloc.c:1181:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/page_alloc.c:7744:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/slub.c:5434:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/bluetooth/hci_event.c:5926:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/qrtr/mhi.c:102:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/wireless/reg.c:205:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/lola/lola.c:178:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/pcxhr/pcxhr_core.c:134:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/rme9652/hdsp.c:666:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/fsl/fsl_spdif.c:1508:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/sh/rcar/core.c:1602:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/sof/intel/mtl.c:553:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
{standard input}:2311: Error: expecting )

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-pci-endpoint-functions-pci-epf-vntb.c:warning:no-previous-prototype-for-pci_read
|   `-- drivers-pci-endpoint-functions-pci-epf-vntb.c:warning:no-previous-prototype-for-pci_write
|-- alpha-randconfig-r004-20220712
|   |-- drivers-pci-endpoint-functions-pci-epf-vntb.c:warning:no-previous-prototype-for-pci_read
|   `-- drivers-pci-endpoint-functions-pci-epf-vntb.c:warning:no-previous-prototype-for-pci_write
|-- arc-allyesconfig
|   |-- block-partitions-efi.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- block-sed-opal.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- crypto-asymmetric_keys-pkcs7_verify.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-ata-libata-core.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-ata-libata-eh.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-ata-sata_dwc_460ex.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-base-power-runtime.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-block-rbd.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-bluetooth-hci_ll.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-bluetooth-hci_qca.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-cdrom-cdrom.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-char-ipmi-ipmi_ssif.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-char-pcmcia-cm4000_cs.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-char-random.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-char-tpm-tpm_tis_core.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-clk-bcm-clk-iproc-armpll.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-clk-clk-bd718x7.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-clk-clk-lochnagar.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-crypto-ccree-cc_request_mgr.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-crypto-qce-sha.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-crypto-qce-skcipher.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-cxl-core-hdm.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-cxl-core-pci.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-dma-buf-dma-buf.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-firmware-arm_scmi-bus.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-firmware-arm_scmi-clock.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-firmware-arm_scmi-powercap.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-firmware-arm_scmi-sensors.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-firmware-arm_scmi-voltage.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-fpga-dfl-fme-mgr.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gnss-usb.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_debug.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce110-dce110_resource.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dce112-dce112_resource.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-hwmgr-smu7_hwmgr.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-hwmgr-smu8_hwmgr.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-hwmgr-vega10_powertune.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-powerplay-smumgr-smu7_smumgr.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-..-pm-swsmu-smu13-smu_v13_0.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_ttm.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-bridge-cadence-cdns-mhdp8546-hdcp.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-bridge-ite-it66121.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
clang_recent_errors
|-- arm-randconfig-r024-20220712
|   `-- drivers-gpu-drm-tests-drm_mm_test.c:warning:stack-frame-size-()-exceeds-limit-()-in-__igt_reserve
|-- s390-randconfig-r044-20220713
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:no-previous-prototype-for-function-dc_reset_state
|-- x86_64-randconfig-a001
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- x86_64-randconfig-a005
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- x86_64-randconfig-a012
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
`-- x86_64-randconfig-k001
    `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void

elapsed time: 723m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
nios2                         3c120_defconfig
arm64                            alldefconfig
powerpc                      makalu_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
arm                            lart_defconfig
arm                            hisi_defconfig
sh                          urquell_defconfig
microblaze                      mmu_defconfig
sparc                               defconfig
sh                          r7780mp_defconfig
m68k                           virt_defconfig
arc                              alldefconfig
sh                           se7721_defconfig
mips                            gpr_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc32_defconfig
csky                                defconfig
x86_64                                  kexec
sparc                            allyesconfig
xtensa                           allyesconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
i386                              debian-10.3
arm                  randconfig-c002-20220712
x86_64                        randconfig-c001
ia64                             allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220712
riscv                randconfig-r042-20220712
s390                 randconfig-r044-20220712
arc                  randconfig-r043-20220713
x86_64                        randconfig-a002
x86_64                        randconfig-a004
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                     akebono_defconfig
mips                           ip27_defconfig
riscv                            alldefconfig
arm                       imx_v4_v5_defconfig
arm                        mvebu_v5_defconfig
mips                          ath79_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220712
hexagon              randconfig-r045-20220712
hexagon              randconfig-r045-20220713
riscv                randconfig-r042-20220713
hexagon              randconfig-r041-20220713
s390                 randconfig-r044-20220713
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
