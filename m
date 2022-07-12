Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FE570F19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 02:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiGLAvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 20:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGLAvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:51:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F062871D;
        Mon, 11 Jul 2022 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657587111; x=1689123111;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2YM2bZyb0VOFo7GFMRdOkt0l75ZaAT31t5w71WN2ZRY=;
  b=GlYrtkdCaKP60z67XY8xGdcSyvM8nauMoMAoUgXSNs0v4BbFCg4coa9N
   P7GAwFJIV5utYzYANILDCpc9oNgUpvyGP9CLOz152HACzh9XtHgjm1Niw
   F4OK1p04/teZKUomtsJcxGSllkGnLuXRJxGjOunzzn7uHfJswu3/Me7Bx
   dsKFn/EpM9ZFAyyFq3xAlOXfu9HRRbsJdgaIx2TSOkdMJTJE7EGBqVIsh
   O/u4ZAW/i5ASp8lm25E0OujRIi3r4RpbcqL/uwPxnYg9/dIBPB+PW1zPx
   2KQU+7HvKdONj19a+i1gZito+faR6jRneTJmTiQXq6ycEJ2fvoGAdwwvJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284833422"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284833422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="595097809"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2022 17:51:48 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB47w-0001Rn-7E;
        Tue, 12 Jul 2022 00:51:48 +0000
Date:   Tue, 12 Jul 2022 08:50:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 4112a8699ae2eac797415b9be1d7901b3f79e772
Message-ID: <62ccc570.sr2tHsBP2xOVGIlG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4112a8699ae2eac797415b9be1d7901b3f79e772  Add linux-next specific files for 20220711

Error/Warning reports:

https://lore.kernel.org/llvm/202207090100.acXdJ79H-lkp@intel.com
https://lore.kernel.org/llvm/202207120340.ToDnrawY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2728:6: warning: no previous prototype for function 'dc_reset_state' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn314/irq_service_dcn314.c:41:20: warning: no previous prototype for 'to_dal_irq_source_dcn314' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn314/irq_service_dcn314.c:41:20: warning: no previous prototype for function 'to_dal_irq_source_dcn314' [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1210:55: warning: implicit conversion from 'enum <anonymous>' to 'enum dma_resv_usage' [-Wenum-conversion]
drivers/pci/endpoint/functions/pci-epf-vntb.c:975:5: warning: no previous prototype for 'pci_read' [-Wmissing-prototypes]
drivers/pci/endpoint/functions/pci-epf-vntb.c:984:5: warning: no previous prototype for 'pci_write' [-Wmissing-prototypes]
drivers/vfio/vfio_iommu_type1.c:2141:35: warning: cast to smaller integer type 'enum iommu_cap' from 'void *' [-Wvoid-pointer-to-enum-cast]
fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/x86/kernel/cpu/rdrand.c:36 x86_init_rdrand() error: uninitialized symbol 'prev'.
drivers/firmware/arm_scmi/clock.c:394:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/firmware/arm_scmi/powercap.c:376:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_powertune.c:1214:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/gpu/drm/bridge/ite-it66121.c:1398:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/infiniband/hw/irdma/hw.c:1484:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/md/dm-mpath.c:1681:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/md/dm-table.c:1601:21: warning: Value stored to 'ti' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
drivers/media/dvb-frontends/mxl692.c:49:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/ov5647.c:636:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
drivers/media/i2c/st-mipid02.c:295:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
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
fs/ext4/mballoc.c:3618:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
fs/kernel_read_file.c:61 kernel_read_file() warn: impossible condition '(i_size > (((~0) >> 1))) => (s64min-s64max > s64max)'
fs/ubifs/recovery.c:1062:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/filemap.c:1354:1: internal compiler error: in arc_ifcvt, at config/arc/arc.c:9637
mm/khugepaged.c:2409 madvise_collapse() warn: possible memory leak of 'cc'
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
|-- arm64-randconfig-r026-20220711
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:no-previous-prototype-for-function-dc_reset_state
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-irq-dcn314-irq_service_dcn314.c:warning:no-previous-prototype-for-function-to_dal_irq_source_dcn314
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- s390-randconfig-c005-20220710
|   `-- drivers-md-dm-table.c:warning:Value-stored-to-ti-during-its-initialization-is-never-read-clang-analyzer-deadcode.DeadStores
|-- x86_64-randconfig-a001
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- x86_64-randconfig-a005
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
|-- x86_64-randconfig-a006-20220627
|   `-- fs-xfs-scrub-repair.c:warning:variable-agno-set-but-not-used
|-- x86_64-randconfig-a012
|   `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void
`-- x86_64-randconfig-r022-20220711
    `-- drivers-vfio-vfio_iommu_type1.c:warning:cast-to-smaller-integer-type-enum-iommu_cap-from-void

elapsed time: 724m

configs tested: 63
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                      integrator_defconfig
sh                         ap325rxa_defconfig
sh                          r7785rp_defconfig
arm                         nhk8815_defconfig
mips                        vocore2_defconfig
arc                           tb10x_defconfig
powerpc                   currituck_defconfig
parisc                generic-32bit_defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220710
s390                 randconfig-r044-20220710
riscv                randconfig-r042-20220710
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                         s5pv210_defconfig
riscv                             allnoconfig
arm                         orion5x_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
