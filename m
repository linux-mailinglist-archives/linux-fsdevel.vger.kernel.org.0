Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276F356C26C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jul 2022 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiGHW5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiGHW5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:57:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238C637195;
        Fri,  8 Jul 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657321035; x=1688857035;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zSJQnM+e4IqkMLxyF5Ke5VcTppb2jbkVgp/XWot8kvg=;
  b=Dw9Qb7aEjIHJGxmA5nJ4eTu2lz8ReutzjW+YdULt/YYQ1y9BwVIjgjtp
   dPfBSCLJ/E3h6kBqI41iXzSmNf1fNu+PagAqplr/ofq+B9kXb5vdNrXWr
   ew7lMSbnXTUMYUs6oGOhQ4QIZydIzXAjBfjx7xjHUGW7yQQ+5MflOF5bz
   Zpz3v/vKwN9jMK0iAVMSNbXA43p+fIrsRkgSxROCDAciDy0m2vxQVbLTm
   OFO2DblLIkPLenKHx6px4ITiwkTY2aI6KtdkLmpWcbExp9JdKF1q+/2VX
   A0GSN/wcZiWPHDi/48m75DmFqZv0AYrr9quLZfZy+m+DJxnqGxteSv060
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="281934413"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="281934413"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 15:57:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="569108012"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 15:57:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9wuN-000O1l-AH;
        Fri, 08 Jul 2022 22:57:11 +0000
Date:   Sat, 09 Jul 2022 06:56:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 f2528c29385819a84480cacef4886b049761e2c5
Message-ID: <62c8b635.u4zeP15EM8cJP9/D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: f2528c29385819a84480cacef4886b049761e2c5  Add linux-next specific files for 20220708

Error/Warning reports:

https://lore.kernel.org/llvm/202207082240.wYnREIVo-lkp@intel.com
https://lore.kernel.org/llvm/202207090100.acXdJ79H-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/base/power/domain.c:3068:17: error: no member named 'runtime_error' in 'struct dev_pm_info'
drivers/base/power/domain.c:3070:22: error: no member named 'disable_depth' in 'struct dev_pm_info'
drivers/base/power/domain.c:3072:22: error: no member named 'runtime_status' in 'struct dev_pm_info'
drivers/base/power/domain.c:603:13: error: use of undeclared identifier 'pm_wq'
drivers/base/power/domain.c:802:26: error: no member named 'ignore_children' in 'struct dev_pm_info'
drivers/base/power/domain_governor.c:85:18: error: no member named 'ignore_children' in 'struct dev_pm_info'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2720:6: warning: no previous prototype for function 'dc_reset_state' [-Wmissing-prototypes]
drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: no previous prototype for 'pci_read' [-Wmissing-prototypes]
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: no previous prototype for 'pci_write' [-Wmissing-prototypes]
drivers/vfio/vfio_iommu_type1.c:2141:35: warning: cast to smaller integer type 'enum iommu_cap' from 'void *' [-Wvoid-pointer-to-enum-cast]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/events/core.c:2114 init_hw_perf_events() warn: missing error code 'err'
arch/x86/kernel/cpu/rdrand.c:36 x86_init_rdrand() error: uninitialized symbol 'prev'.
drivers/firmware/arm_scmi/clock.c:394:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/firmware/arm_scmi/powercap.c:376:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_powertune.c:1214:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/bridge/ite-it66121.c:1398:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/infiniband/hw/irdma/hw.c:1484:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/md/dm-mpath.c:1681:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/dvb-frontends/mxl692.c:49:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/ov5647.c:636:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/st-mipid02.c:271:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/platform/qcom/venus/vdec.c:1505:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/platform/st/sti/delta/delta-v4l2.c:719:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/tuners/msi001.c:81:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/mfd/sec-core.c:429:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/mmc/host/sh_mmcif.c:1318:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/net/bonding/bond_main.c:4647:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
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
drivers/phy/mediatek/phy-mtk-dp.c:192:24: sparse: sparse: symbol 'mtk_dp_phy_driver' was not declared. Should it be static?
drivers/scsi/elx/efct/efct_unsol.c:297:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/scsi/elx/libefc/efc_domain.c:692:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/scsi/megaraid/megaraid_sas_fp.c:297:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/soc/mediatek/mtk-mutex.c:799:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
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
fs/ext4/mballoc.c:3612:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
fs/kernel_read_file.c:61 kernel_read_file() warn: impossible condition '(i_size > (((~0) >> 1))) => (s64min-s64max > s64max)'
fs/ubifs/recovery.c:1062:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
kernel/sched/core.c:2076:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/filemap.c:1354:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/page_alloc.c:1185:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/page_alloc.c:7748:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/slub.c:5434:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/bluetooth/hci_event.c:5926:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/qrtr/mhi.c:102:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
net/wireless/reg.c:205:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/lola/lola.c:178:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/pcxhr/pcxhr_core.c:134:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/pci/rme9652/hdsp.c:666:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/fsl/fsl_spdif.c:1508:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/sh/rcar/core.c:1602:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
sound/soc/sof/intel/mtl.c:547:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
{standard input}:2311: Error: expecting )

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
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
|   |-- drivers-gpu-drm-bridge-lontium-lt9211.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-bridge-sii902x.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
|   |-- drivers-gpu-drm-mcde-mcde_dsi.c:internal-compiler-error:in-arc_ifcvt-at-config-arc-arc.c
clang_recent_errors
|-- riscv-randconfig-c006-20220707
|   |-- drivers-base-power-domain.c:error:no-member-named-disable_depth-in-struct-dev_pm_info
|   |-- drivers-base-power-domain.c:error:no-member-named-ignore_children-in-struct-dev_pm_info
|   |-- drivers-base-power-domain.c:error:no-member-named-runtime_error-in-struct-dev_pm_info
|   |-- drivers-base-power-domain.c:error:no-member-named-runtime_status-in-struct-dev_pm_info
|   |-- drivers-base-power-domain.c:error:use-of-undeclared-identifier-pm_wq
|   `-- drivers-base-power-domain_governor.c:error:no-member-named-ignore_children-in-struct-dev_pm_info
|-- riscv-randconfig-r006-20220707
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:no-previous-prototype-for-function-dc_reset_state
|-- x86_64-randconfig-a001
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- x86_64-randconfig-a005
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
`-- x86_64-randconfig-a012
    `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void

elapsed time: 725m

configs tested: 52
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220707
riscv                randconfig-r042-20220707
s390                 randconfig-r044-20220707
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
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220707
hexagon              randconfig-r045-20220707

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
