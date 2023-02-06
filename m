Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97B68C38A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBFQpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 11:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBFQpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:45:35 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C71D93F;
        Mon,  6 Feb 2023 08:45:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so675638wmb.5;
        Mon, 06 Feb 2023 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PfShJRqSEdgsJ8yfKiHY69ifrXSnMoabB+x7/wEHmxo=;
        b=EI5fJy2l8WncKM4Gk48TGnHlqRSi1Szy1Lk2LBNXFmsIx1mVaugDkpr3fnMpQJwspi
         lVmVEG3kvpcoRu73rYzSZn/gaVTO0c14n4zxZwszie4mleATcp52vb2/r7hxslBi0N0x
         rkJPaoDRjj7z3doMdSyP0AU1Qu3ALFbN1F+jFV/fOWzxz9CMyJ60QaIcYdnUrd8u/DBA
         I0KIvtmzFnk2l2PPRbR+lq7TEopAIB2g6NE3wCCbst8UHAcDY/kaQPLiqEcFCXFFxr6Q
         acFBJ3oP8HH4Om1zdgV+yQ+dvN4RXaggBEvQn4svyVrxcT9S4hAxlu+IL7Ge1aoXUh6z
         hleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfShJRqSEdgsJ8yfKiHY69ifrXSnMoabB+x7/wEHmxo=;
        b=7H8G987oW1w6SjQqhO00G+yvitwlzhpc0IsATEM+pguqAeDhL23fyGrI3Nz5+Rg3X4
         gZnKpNhPQFCDE0lqqbGBbS1dZ4jU81gLSndShiHtHcxl1XshtxZaKvrsuNoMv9lhsux1
         J8Jbe1JLWZo9L1tMNnuypsEoSoB+BfY3a6iAcwV8fOcAOqgUsQUR4zOSeVpaS+Jo6im+
         +YPr/nAQadYUFtxUsACZPzfyBdggOnQjruL5ghXoDWkI8u0W7AnCU4MdDzEWmIRQQrdi
         6Cp47BpUDd3e/tiMeZaLDfrOEeFXZf0aQI83UmwXhM9U8AdacUDKh00upYV30hTQEpDa
         G0FA==
X-Gm-Message-State: AO0yUKVTSvZsRUIn+JxDNjzLVQV1QWDL0/f3sE2v4PqUgUjh6kdV/sHM
        ACVyGIGZPOgBFbC33IUHIVs=
X-Google-Smtp-Source: AK7set+A5b7IlozX+5yUzoK/OsIy2AMoIc9hpDJBRKkH8KPJL2yLbefBkIudXSbI2nDf1T9CRlI0Vg==
X-Received: by 2002:a05:600c:2e95:b0:3da:50b0:e96a with SMTP id p21-20020a05600c2e9500b003da50b0e96amr316110wmn.29.1675701929951;
        Mon, 06 Feb 2023 08:45:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b003dd1b00bd9asm12258885wmq.32.2023.02.06.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:45:29 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:45:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y+EupX1jX1c5BAHv@kadam>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JKBL4U+/qNXwMCeG"
Content-Disposition: inline
In-Reply-To: <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--JKBL4U+/qNXwMCeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 05:13:02PM +0100, Julia Lawall wrote:
> An analysis with Coccinelle may be highly prone to false positives if the
> issue is very interprocedural.  Maybe smatch would be better suited for
> this?

I have a very good Smatch check for sleeping with preempt disabled
which would have detected this bug.

Where my check falls down is when the call tree is quite long.
Especially if the call tree is very long and there is some kind of
a MAY_SLEEP flag which is set and then checked several functions calls
down the call tree.

The unfortunate thing is that there are lot of sleeping in atomic bugs
and they are quite complicated to analyze because the call trees are
long so I'm not up to date on reviewing the warnings...  You need the
cross function database to review these warnings.  The warning looks
like:

drivers/accel/habanalabs/common/context.c:112 hl_ctx_fini() warn: sleeping in atomic context

That code looks like:
   111                  if (hdev->in_debug)
   112                          hl_device_set_debug_mode(hdev, ctx, false);
   113  

hl_device_set_debug_mode() take a mutex.  Then you do
`smdb.py preempt hl_ctx_fini` and it prints out the call tree which
disables preemption.

cs_ioctl_unreserve_signals() <- disables preempt
-> hl_ctx_put()
   -> hl_ctx_do_release()
      -> hl_ctx_fini()

And so on.  The unreviewed list is going to have more bugs and the other
list is probably mostly false positives outside of the staging/
directory.

regards,
dan carpenter


--JKBL4U+/qNXwMCeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=errs-complete

arch/x86/kernel/apic/x2apic_uv_x.c:1230 uv_set_vga_state() warn: sleeping in atomic context
arch/x86/kernel/fpu/xstate.c:1476 fpstate_free() warn: sleeping in atomic context
arch/x86/kernel/kvm.c:157 kvm_async_pf_task_wait_schedule() warn: sleeping in atomic context
arch/x86/kernel/step.c:36 convert_ip_to_linear() warn: sleeping in atomic context
arch/x86/lib/insn-eval.c:634 get_desc() warn: sleeping in atomic context
arch/x86/mm/ioremap.c:471 iounmap() warn: sleeping in atomic context
arch/x86/mm/mmio-mod.c:318 mmiotrace_iounmap() warn: sleeping in atomic context
arch/x86/platform/uv/bios_uv.c:171 uv_bios_set_legacy_vga_target() warn: sleeping in atomic context
arch/x86/platform/uv/bios_uv.c:45 uv_bios_call() warn: sleeping in atomic context
arch/x86/xen/p2m.c:189 alloc_p2m_page() warn: sleeping in atomic context
block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context
block/blk-crypto-profile.c:54 blk_crypto_hw_enter() warn: sleeping in atomic context
block/blk-mq.c:166 blk_freeze_queue_start() warn: sleeping in atomic context
block/blk-mq.c:206 blk_freeze_queue() warn: sleeping in atomic context
block/blk-mq.c:216 blk_mq_freeze_queue() warn: sleeping in atomic context
block/blk-mq.c:2174 __blk_mq_run_hw_queue() warn: sleeping in atomic context
block/blk-mq.c:4083 blk_mq_destroy_queue() warn: sleeping in atomic context
block/blk-wbt.c:673 wbt_enable_default() warn: sleeping in atomic context
block/blk-wbt.c:843 wbt_init() warn: sleeping in atomic context
drivers/accel/habanalabs/common/context.c:112 hl_ctx_fini() warn: sleeping in atomic context
drivers/accel/habanalabs/common/context.c:141 hl_ctx_do_release() warn: sleeping in atomic context
drivers/accel/habanalabs/common/debugfs.c:272 vm_show() warn: sleeping in atomic context
drivers/accel/habanalabs/common/device.c:1071 hl_device_set_debug_mode() warn: sleeping in atomic context
drivers/accel/habanalabs/common/memory.c:1300 unmap_device_va() warn: sleeping in atomic context
drivers/accel/habanalabs/common/memory.c:2842 hl_vm_ctx_fini() warn: sleeping in atomic context
drivers/acpi/osl.c:927 acpi_debugger_write_log() warn: sleeping in atomic context
drivers/base/core.c:189 device_links_write_lock() warn: sleeping in atomic context
drivers/base/core.c:681 device_link_add() warn: sleeping in atomic context
drivers/base/firmware_loader/main.c:587 firmware_free_data() warn: sleeping in atomic context
drivers/base/firmware_loader/main.c:815 _request_firmware() warn: sleeping in atomic context
drivers/base/power/runtime.c:1137 __pm_runtime_suspend() warn: sleeping in atomic context
drivers/base/power/sysfs.c:779 wakeup_sysfs_add() warn: sleeping in atomic context
drivers/base/power/sysfs.c:789 wakeup_sysfs_remove() warn: sleeping in atomic context
drivers/base/power/wakeup.c:225 wakeup_source_register() warn: sleeping in atomic context
drivers/base/power/wakeup.c:348 device_wakeup_enable() warn: sleeping in atomic context
drivers/base/power/wakeup.c:91 wakeup_source_create() warn: sleeping in atomic context
drivers/base/regmap/regmap.c:1790 _regmap_raw_write_impl() warn: sleeping in atomic context
drivers/base/regmap/regmap.c:1855 _regmap_raw_write_impl() warn: sleeping in atomic context
drivers/block/aoe/aoedev.c:229 aoedev_downdev() warn: sleeping in atomic context
drivers/clk/clk.c:133 clk_prepare_lock() warn: sleeping in atomic context
drivers/clk/clk.c:404 clk_core_get() warn: sleeping in atomic context
drivers/clk/clk.c:5077 of_clk_get_hw_from_clkspec() warn: sleeping in atomic context
drivers/clk/clkdev.c:77 clk_find_hw() warn: sleeping in atomic context
drivers/crypto/hisilicon/sec/sec_algs.c:389 sec_send_request() warn: sleeping in atomic context
drivers/crypto/hisilicon/sec/sec_algs.c:494 sec_skcipher_alg_callback() warn: sleeping in atomic context
drivers/crypto/hisilicon/sec/sec_algs.c:506 sec_skcipher_alg_callback() warn: sleeping in atomic context
drivers/crypto/hisilicon/sec/sec_algs.c:824 sec_alg_skcipher_crypto() warn: sleeping in atomic context
drivers/crypto/hisilicon/sec/sec_drv.c:864 sec_queue_send() warn: sleeping in atomic context
drivers/dma/dmaengine.c:905 dma_release_channel() warn: sleeping in atomic context
drivers/gpio/gpio-aggregator.c:299 gpio_fwd_get_multiple() warn: sleeping in atomic context
drivers/gpio/gpio-aggregator.c:355 gpio_fwd_set_multiple() warn: sleeping in atomic context
drivers/gpio/gpio-it87.c:157 it87_gpio_request() warn: sleeping in atomic context
drivers/gpio/gpio-it87.c:202 it87_gpio_direction_in() warn: sleeping in atomic context
drivers/gpio/gpio-it87.c:245 it87_gpio_direction_out() warn: sleeping in atomic context
drivers/gpio/gpio-it87.c:82 superio_enter() warn: sleeping in atomic context
drivers/gpio/gpiolib.c:3263 gpiod_set_consumer_name() warn: sleeping in atomic context
drivers/gpio/gpiolib.c:3516 gpiod_get_value_cansleep() warn: sleeping in atomic context
drivers/gpio/gpiolib.c:3573 gpiod_get_array_value_cansleep() warn: sleeping in atomic context
drivers/gpio/gpiolib.c:3612 gpiod_set_value_cansleep() warn: sleeping in atomic context
drivers/gpio/gpiolib.c:3677 gpiod_set_array_value_cansleep() warn: sleeping in atomic context
drivers/gpio/gpiolib-devres.c:118 devm_gpiod_get_index() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/intel_gt_mcr.c:379 intel_gt_mcr_lock() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/intel_ring.c:216 wait_for_space() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/selftest_lrc.c:1721 garbage_reset() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c:660 ct_send() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c:784 intel_guc_ct_send() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2007 new_guc_id() warn: sleeping in atomic context
drivers/gpu/drm/i915/i915_request.c:1982 i915_request_wait_timeout() warn: sleeping in atomic context
drivers/gpu/drm/i915/i915_request.c:2117 i915_request_wait() warn: sleeping in atomic context
drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c:372 update_cursor() warn: sleeping in atomic context
drivers/gpu/drm/msm/msm_gem.c:495 msm_gem_get_and_pin_iova_range() warn: sleeping in atomic context
drivers/gpu/drm/msm/msm_gem.c:506 msm_gem_get_and_pin_iova() warn: sleeping in atomic context
drivers/gpu/drm/msm/msm_gem.h:185 msm_gem_lock() warn: sleeping in atomic context
drivers/gpu/drm/nouveau/nvif/object.c:149 nvif_object_mthd() warn: sleeping in atomic context
drivers/gpu/drm/nouveau/nvkm/core/subdev.c:200 nvkm_subdev_ref() warn: sleeping in atomic context
drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:516 vmw_host_printf() warn: sleeping in atomic context
drivers/hid/hid-core.c:1935 __hid_request() warn: sleeping in atomic context
drivers/hid/hid-core.c:2379 hid_hw_request() warn: sleeping in atomic context
drivers/infiniband/core/restrack.c:351 rdma_restrack_del() warn: sleeping in atomic context
drivers/infiniband/core/verbs.c:971 rdma_destroy_ah_user() warn: sleeping in atomic context
drivers/leds/leds-ns2.c:96 ns2_led_set_mode() warn: sleeping in atomic context
drivers/mailbox/mailbox.c:280 mbox_send_message() warn: sleeping in atomic context
drivers/media/pci/cx88/cx88-alsa.c:743 snd_cx88_switch_put() warn: sleeping in atomic context
drivers/media/v4l2-core/v4l2-ctrls-core.c:1396 find_ref_lock() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:102 ezx_pcap_read() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:117 ezx_pcap_set_bits() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:220 pcap_set_ts_bits() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:232 pcap_disable_adc() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:247 pcap_adc_trigger() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:252 pcap_adc_trigger() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:280 pcap_adc_irq() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:69 ezx_pcap_putget() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:86 ezx_pcap_write() warn: sleeping in atomic context
drivers/misc/sgi-gru/grukservices.c:262 gru_get_cpu_resources() warn: sleeping in atomic context
drivers/mmc/core/slot-gpio.c:69 mmc_gpio_get_ro() warn: sleeping in atomic context
drivers/mmc/host/sdhci.c:1304 sdhci_external_dma_release() warn: sleeping in atomic context
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:976 xgbe_napi_disable() warn: sleeping in atomic context
drivers/net/ethernet/amd/xgbe/xgbe-drv.c:982 xgbe_napi_disable() warn: sleeping in atomic context
drivers/net/ethernet/cadence/macb_main.c:5159 macb_suspend() warn: sleeping in atomic context
drivers/net/ethernet/cadence/macb_main.c:5171 macb_suspend() warn: sleeping in atomic context
drivers/net/ethernet/cadence/macb_main.c:5250 macb_resume() warn: sleeping in atomic context
drivers/net/ethernet/cavium/liquidio/octeon_device.c:704 octeon_allocate_device_mem() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c:200 t4vf_wr_mbox_core() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c:256 t4vf_wr_mbox_core() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c:218 alloc_ctrl_skb() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:330 ppm_destroy() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:338 cxgbi_ppm_release() warn: sleeping in atomic context
drivers/net/ethernet/davicom/dm9000.c:329 dm9000_phy_write() warn: sleeping in atomic context
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917 ixgbe_ipsec_vf_add_sa() warn: sleeping in atomic context
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1861 cmd_exec() warn: sleeping in atomic context
drivers/net/ethernet/netronome/nfp/flower/lag_conf.c:167 nfp_fl_lag_get_group_info() warn: sleeping in atomic context
drivers/net/ethernet/netronome/nfp/flower/lag_conf.c:211 nfp_flower_lag_get_info_from_netdev() warn: sleeping in atomic context
drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c:518 nfp_tun_write_neigh() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:1091 nv_disable_irq() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:1093 nv_disable_irq() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:1095 nv_disable_irq() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:4889 nv_set_loopback() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:4915 nv_set_loopback() warn: sleeping in atomic context
drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c:303 netxen_pcie_sem_lock() warn: sleeping in atomic context
drivers/net/ethernet/qlogic/qed/qed_mcp.c:200 qed_load_mcp_offsets() warn: sleeping in atomic context
drivers/net/ethernet/rocker/rocker_main.c:1080 rocker_cmd_exec() warn: sleeping in atomic context
drivers/net/ethernet/rocker/rocker_main.c:84 rocker_wait_event_timeout() warn: sleeping in atomic context
drivers/net/phy/mdio_bus.c:1053 mdiobus_read() warn: sleeping in atomic context
drivers/net/phy/mdio_bus.c:1076 mdiobus_c45_read() warn: sleeping in atomic context
drivers/net/phy/mdio_bus.c:1152 mdiobus_write() warn: sleeping in atomic context
drivers/net/phy/mdio_bus.c:1177 mdiobus_c45_write() warn: sleeping in atomic context
drivers/net/phy/phy.c:1027 phy_ethtool_ksettings_set() warn: sleeping in atomic context
drivers/net/phy/phy.c:330 phy_mii_ioctl() warn: sleeping in atomic context
drivers/net/phy/phy.c:334 phy_mii_ioctl() warn: sleeping in atomic context
drivers/net/phy/phy.c:386 phy_mii_ioctl() warn: sleeping in atomic context
drivers/net/phy/phy.c:388 phy_mii_ioctl() warn: sleeping in atomic context
drivers/net/wireless/ath/ath11k/peer.c:396 ath11k_peer_create() warn: sleeping in atomic context
drivers/net/wireless/broadcom/b43legacy/main.c:2832 b43legacy_op_bss_info_changed() warn: sleeping in atomic context
drivers/net/wireless/broadcom/b43legacy/main.c:590 b43legacy_synchronize_irq() warn: sleeping in atomic context
drivers/net/wireless/broadcom/b43legacy/radio.c:213 b43legacy_synth_pu_workaround() warn: sleeping in atomic context
drivers/net/wireless/broadcom/b43legacy/radio.c:604 b43legacy_calc_nrssi_slope() warn: sleeping in atomic context
drivers/net/wireless/broadcom/b43legacy/radio.c:780 b43legacy_calc_nrssi_slope() warn: sleeping in atomic context
drivers/net/wireless/intel/iwlegacy/common.c:1844 il_send_add_sta() warn: sleeping in atomic context
drivers/net/wireless/intersil/orinoco/fw.c:114 orinoco_dl_firmware() warn: sleeping in atomic context
drivers/net/wireless/intersil/orinoco/fw.c:224 symbol_dl_image() warn: sleeping in atomic context
drivers/net/wireless/intersil/orinoco/fw.c:339 orinoco_download() warn: sleeping in atomic context
drivers/net/wwan/t7xx/t7xx_state_monitor.c:416 t7xx_fsm_append_cmd() warn: sleeping in atomic context
drivers/nvme/host/core.c:4931 nvme_remove_admin_tag_set() warn: sleeping in atomic context
drivers/nvme/host/core.c:4993 nvme_remove_io_tag_set() warn: sleeping in atomic context
drivers/nvme/host/core.c:571 nvme_change_ctrl_state() warn: sleeping in atomic context
drivers/nvme/host/fc.c:2408 nvme_fc_ctrl_free() warn: sleeping in atomic context
drivers/nvme/host/multipath.c:146 nvme_kick_requeue_lists() warn: sleeping in atomic context
drivers/nvme/target/fc.c:495 nvmet_fc_xmt_disconnect_assoc() warn: sleeping in atomic context
drivers/pci/iov.c:888 sriov_restore_state() warn: sleeping in atomic context
drivers/pci/msi/msi.c:864 __pci_restore_msix_state() warn: sleeping in atomic context
drivers/pci/pci.c:5376 __pci_reset_function_locked() warn: sleeping in atomic context
drivers/pci/pci.c:855 pci_wait_for_pending() warn: sleeping in atomic context
drivers/pci/pcie/aspm.c:1094 pcie_aspm_powersave_config_link() warn: sleeping in atomic context
drivers/pci/probe.c:2360 pci_bus_wait_crs() warn: sleeping in atomic context
drivers/pcmcia/pcmcia_resource.c:168 pcmcia_access_config() warn: sleeping in atomic context
drivers/pcmcia/pcmcia_resource.c:208 pcmcia_write_config_byte() warn: sleeping in atomic context
drivers/phy/phy-core.c:404 phy_set_mode_ext() warn: sleeping in atomic context
drivers/platform/olpc/olpc-xo175-ec.c:363 olpc_xo175_ec_complete() warn: sleeping in atomic context
drivers/platform/olpc/olpc-xo175-ec.c:567 olpc_xo175_ec_cmd() warn: sleeping in atomic context
drivers/scsi/arcmsr/arcmsr_hba.c:409 arcmsr_hbaA_wait_msgint_ready() warn: sleeping in atomic context
drivers/scsi/arcmsr/arcmsr_hba.c:429 arcmsr_hbaB_wait_msgint_ready() warn: sleeping in atomic context
drivers/scsi/arcmsr/arcmsr_hba.c:447 arcmsr_hbaC_wait_msgint_ready() warn: sleeping in atomic context
drivers/scsi/arcmsr/arcmsr_hba.c:465 arcmsr_hbaD_wait_msgint_ready() warn: sleeping in atomic context
drivers/scsi/arcmsr/arcmsr_hba.c:483 arcmsr_hbaE_wait_msgint_ready() warn: sleeping in atomic context
drivers/scsi/BusLogic.c:1939 blogic_initadapter() warn: sleeping in atomic context
drivers/scsi/BusLogic.c:254 blogic_create_addlccbs() warn: sleeping in atomic context
drivers/scsi/elx/libefc/efc_els.c:69 efc_els_io_alloc_size() warn: sleeping in atomic context
drivers/scsi/fcoe/fcoe_ctlr.c:441 fcoe_ctlr_link_up() warn: sleeping in atomic context
drivers/scsi/fnic/fnic_fcs.c:500 fnic_fcoe_start_fcf_disc() warn: sleeping in atomic context
drivers/scsi/fnic/vnic_dev.c:597 fnic_dev_stats_dump() warn: sleeping in atomic context
drivers/scsi/libfc/fc_exch.c:606 fc_seq_set_resp() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5310 lpfc_unreg_rpi() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5865 lpfc_issue_clear_la() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5887 lpfc_issue_reg_vpi() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:6563 lpfc_nlp_init() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_init.c:8987 lpfc_sli4_create_rpi_hdr() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_sli.c:19541 lpfc_sli4_post_rpi_hdr() warn: sleeping in atomic context
drivers/scsi/mvumi.c:130 mvumi_alloc_mem_resource() warn: sleeping in atomic context
drivers/spi/spi.c:3863 __spi_validate() warn: sleeping in atomic context
drivers/spi/spi.c:4245 spi_sync() warn: sleeping in atomic context
drivers/ssb/driver_pcicore.c:702 ssb_pcicore_dev_irqvecs_enable() warn: sleeping in atomic context
drivers/ssb/pcmcia.c:106 ssb_pcmcia_switch_coreidx() warn: sleeping in atomic context
drivers/ssb/pcmcia.c:159 ssb_pcmcia_switch_core() warn: sleeping in atomic context
drivers/ssb/pcmcia.c:210 select_core_and_segment() warn: sleeping in atomic context
drivers/ssb/pcmcia.c:75 ssb_pcmcia_cfg_write() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_pwrctrl.c:50 ips_leave() warn: sleeping in atomic context
drivers/staging/r8188eu/hal/usb_ops_linux.c:24 usb_read() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:560 LeaveAllPowerSaveMode() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:563 LeaveAllPowerSaveMode() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:582 LPS_Leave_check() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:80 ips_leave() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_xmit.c:2520 rtw_sctx_wait() warn: sleeping in atomic context
drivers/staging/rts5208/xd.c:1320 xd_build_l2p_tbl() warn: sleeping in atomic context
drivers/staging/rts5208/xd.c:800 xd_init_l2p_tbl() warn: sleeping in atomic context
drivers/staging/rts5208/xd.c:825 free_zone() warn: sleeping in atomic context
drivers/staging/rts5208/xd.c:852 xd_set_unused_block() warn: sleeping in atomic context
drivers/target/iscsi/iscsi_target.c:3435 iscsit_build_sendtargets_response() warn: sleeping in atomic context
drivers/target/iscsi/iscsi_target_erl0.c:878 iscsit_cause_connection_reinstatement() warn: sleeping in atomic context
drivers/target/iscsi/iscsi_target_util.c:144 iscsit_wait_for_tag() warn: sleeping in atomic context
drivers/target/target_core_tpg.c:228 target_tpg_has_node_acl() warn: sleeping in atomic context
drivers/tty/serial/serial_core.c:1385 uart_set_rs485_termination() warn: sleeping in atomic context
drivers/tty/serial/serial_mctrl_gpio.c:345 mctrl_gpio_disable_ms() warn: sleeping in atomic context
drivers/usb/cdns3/core.c:64 cdns_role_stop() warn: sleeping in atomic context
drivers/usb/gadget/udc/bdc/bdc_core.c:38 poll_oip() warn: sleeping in atomic context
drivers/usb/gadget/udc/core.c:740 usb_gadget_disconnect() warn: sleeping in atomic context
drivers/usb/gadget/udc/max3420_udc.c:1308 max3420_remove() warn: sleeping in atomic context
drivers/usb/host/max3421-hcd.c:1934 max3421_remove() warn: sleeping in atomic context
drivers/vhost/vhost.c:1291 vhost_iotlb_miss() warn: sleeping in atomic context
drivers/vhost/vhost.c:2091 translate_desc() warn: sleeping in atomic context
drivers/vhost/vhost.c:2585 vhost_new_msg() warn: sleeping in atomic context
drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c:538 dispc_mgr_enable_digit_out() warn: sleeping in atomic context
drivers/xen/events/events_base.c:1213 bind_evtchn_to_irq_chip() warn: sleeping in atomic context
drivers/xen/events/events_base.c:1427 unbind_from_irq() warn: sleeping in atomic context
drivers/xen/xenbus/xenbus_client.c:290 xenbus_va_dev_error() warn: sleeping in atomic context
drivers/xen/xenbus/xenbus_client.c:321 xenbus_dev_error() warn: sleeping in atomic context
drivers/xen/xenbus/xenbus_client.c:342 xenbus_dev_fatal() warn: sleeping in atomic context
drivers/xen/xenbus/xenbus_client.c:473 xenbus_alloc_evtchn() warn: sleeping in atomic context
drivers/xen/xenbus/xenbus_client.c:494 xenbus_free_evtchn() warn: sleeping in atomic context
drivers/xen/xen-pciback/pci_stub.c:110 pcistub_device_release() warn: sleeping in atomic context
drivers/xen/xen-scsiback.c:1016 __scsiback_del_translation_entry() warn: sleeping in atomic context
drivers/xen/xen-scsiback.c:276 scsiback_free_translation_entry() warn: sleeping in atomic context
fs/afs/inode.c:132 afs_inode_init_from_status() warn: sleeping in atomic context
fs/btrfs/subpage.c:137 btrfs_attach_subpage() warn: sleeping in atomic context
fs/btrfs/subpage.c:169 btrfs_alloc_subpage() warn: sleeping in atomic context
fs/configfs/dir.c:1129 configfs_depend_item() warn: sleeping in atomic context
fs/crypto/inline_crypt.c:34 fscrypt_get_devices() warn: sleeping in atomic context
fs/debugfs/inode.c:765 debugfs_remove() warn: sleeping in atomic context
fs/ecryptfs/inode.c:1054 ecryptfs_getxattr_lower() warn: sleeping in atomic context
fs/fscache/volume.c:391 fscache_free_volume() warn: sleeping in atomic context
fs/fscache/volume.c:420 fscache_put_volume() warn: sleeping in atomic context
fs/fs_context.c:257 alloc_fs_context() warn: sleeping in atomic context
fs/fs_context.c:304 fs_context_for_mount() warn: sleeping in atomic context
fs/gfs2/glock.c:1336 gfs2_glock_wait() warn: sleeping in atomic context
fs/gfs2/glock.c:1587 gfs2_glock_nq() warn: sleeping in atomic context
fs/gfs2/super.c:542 gfs2_make_fs_ro() warn: sleeping in atomic context
fs/gfs2/util.c:166 signal_our_withdraw() warn: sleeping in atomic context
fs/gfs2/util.c:356 gfs2_withdraw() warn: sleeping in atomic context
fs/inode.c:1279 iget_locked() warn: sleeping in atomic context
fs/inode.c:1319 iget_locked() warn: sleeping in atomic context
fs/inode.c:1490 ilookup() warn: sleeping in atomic context
fs/inode.c:2400 inode_nohighmem() warn: sleeping in atomic context
fs/inode.c:262 alloc_inode() warn: sleeping in atomic context
fs/jffs2/fs.c:275 jffs2_iget() warn: sleeping in atomic context
fs/jffs2/fs.c:660 jffs2_gc_fetch_inode() warn: sleeping in atomic context
fs/jffs2/malloc.c:188 jffs2_alloc_refblock() warn: sleeping in atomic context
fs/jffs2/malloc.c:221 jffs2_prealloc_raw_node_refs() warn: sleeping in atomic context
fs/jfs/jfs_logmgr.c:2064 lbmWrite() warn: sleeping in atomic context
fs/jfs/jfs_logmgr.c:2116 lbmStartIO() warn: sleeping in atomic context
fs/kernfs/dir.c:888 kernfs_find_and_get_ns() warn: sleeping in atomic context
fs/namespace.c:1055 vfs_kern_mount() warn: sleeping in atomic context
fs/notify/mark.c:496 fsnotify_destroy_mark() warn: sleeping in atomic context
fs/notify/mark.c:854 fsnotify_destroy_marks() warn: sleeping in atomic context
fs/proc/inode.c:267 proc_entry_rundown() warn: sleeping in atomic context
fs/sysv/itree.c:104 get_branch() warn: sleeping in atomic context
fs/ubifs/lpt.c:1462 ubifs_pnode_lookup() warn: sleeping in atomic context
fs/xfs/xfs_buf.c:283 xfs_buf_free_pages() warn: sleeping in atomic context
./include/asm-generic/pgalloc.h:129 pmd_alloc_one() warn: sleeping in atomic context
./include/linux/buffer_head.h:341 sb_bread() warn: sleeping in atomic context
./include/linux/dma-resv.h:345 dma_resv_lock() warn: sleeping in atomic context
./include/linux/fs.h:758 inode_lock() warn: sleeping in atomic context
./include/linux/fsnotify_backend.h:266 fsnotify_group_lock() warn: sleeping in atomic context
include/linux/highmem-internal.h:166 kmap() warn: sleeping in atomic context
./include/linux/interrupt.h:215 devm_request_irq() warn: sleeping in atomic context
./include/linux/interrupt.h:739 tasklet_disable() warn: sleeping in atomic context
./include/linux/kernfs.h:597 kernfs_find_and_get() warn: sleeping in atomic context
./include/linux/mmap_lock.h:117 mmap_read_lock() warn: sleeping in atomic context
./include/linux/mm.h:2705 pmd_ptlock_init() warn: sleeping in atomic context
./include/linux/mm.h:2741 pgtable_pmd_page_ctor() warn: sleeping in atomic context
./include/linux/percpu-rwsem.h:49 percpu_down_read() warn: sleeping in atomic context
./include/linux/ptr_ring.h:603 ptr_ring_resize() warn: sleeping in atomic context
./include/linux/ptr_ring.h:642 ptr_ring_resize_multiple() warn: sleeping in atomic context
./include/linux/wait_bit.h:181 wait_on_bit_lock() warn: sleeping in atomic context
./include/linux/wait_bit.h:73 wait_on_bit() warn: sleeping in atomic context
./include/linux/writeback.h:201 wait_on_inode() warn: sleeping in atomic context
./include/media/v4l2-ctrls.h:1103 v4l2_ctrl_s_ctrl() warn: sleeping in atomic context
./include/media/v4l2-ctrls.h:564 v4l2_ctrl_lock() warn: sleeping in atomic context
./include/net/sock.h:1725 lock_sock() warn: sleeping in atomic context
kernel/cpu.c:310 cpus_read_lock() warn: sleeping in atomic context
kernel/entry/common.c:159 exit_to_user_mode_loop() warn: sleeping in atomic context
kernel/events/core.c:5148 _free_event() warn: sleeping in atomic context
kernel/irq/manage.c:137 synchronize_irq() warn: sleeping in atomic context
kernel/irq/manage.c:732 disable_irq() warn: sleeping in atomic context
kernel/irq/msi.c:334 msi_lock_descs() warn: sleeping in atomic context
kernel/irq_work.c:279 irq_work_sync() warn: sleeping in atomic context
kernel/jump_label.c:217 static_key_enable() warn: sleeping in atomic context
kernel/kcov.c:428 kcov_put() warn: sleeping in atomic context
kernel/kthread.c:709 kthread_stop() warn: sleeping in atomic context
kernel/locking/mutex.c:870 ww_mutex_lock() warn: sleeping in atomic context
kernel/locking/rtmutex.c:1586 rt_mutex_handle_deadlock() warn: sleeping in atomic context
kernel/locking/rwsem.c:1519 down_read() warn: sleeping in atomic context
kernel/locking/semaphore.c:58 down() warn: sleeping in atomic context
kernel/locking/semaphore.c:82 down_interruptible() warn: sleeping in atomic context
kernel/notifier.c:381 blocking_notifier_call_chain() warn: sleeping in atomic context
kernel/printk/printk.c:2607 console_lock() warn: sleeping in atomic context
kernel/printk/printk.c:3071 console_unblank() warn: sleeping in atomic context
kernel/rcu/tree.c:3307 kvfree_call_rcu() warn: sleeping in atomic context
kernel/rcu/tree_nocb.h:1276 rcu_nocb_rdp_offload() warn: sleeping in atomic context
kernel/relay.c:354 relay_create_buf_file() warn: sleeping in atomic context
kernel/relay.c:620 relay_late_setup_files() warn: sleeping in atomic context
kernel/relay.c:798 relay_flush() warn: sleeping in atomic context
kernel/resource.c:1221 __request_region() warn: sleeping in atomic context
kernel/sched/completion.c:117 wait_for_common() warn: sleeping in atomic context
kernel/sched/completion.c:138 wait_for_completion() warn: sleeping in atomic context
kernel/softirq.c:901 tasklet_unlock_wait() warn: sleeping in atomic context
kernel/trace/fgraph.c:63 ftrace_graph_stop() warn: sleeping in atomic context
kernel/trace/trace_selftest.c:769 trace_graph_entry_watchdog() warn: sleeping in atomic context
kernel/workqueue.c:2913 __flush_workqueue() warn: sleeping in atomic context
lib/devres.c:356 pcim_iomap_table() warn: sleeping in atomic context
lib/kobject_uevent.c:524 kobject_uevent_env() warn: sleeping in atomic context
lib/kunit/test.c:735 kunit_kfree() warn: sleeping in atomic context
lib/locking-selftest.c:2236 ww_test_spin_block() warn: sleeping in atomic context
lib/locking-selftest.c:2277 ww_test_spin_context() warn: sleeping in atomic context
lib/locking-selftest.c:2642 MUTEX_in_HARDIRQ() warn: sleeping in atomic context
lib/maple_tree.c:6112 mas_erase() warn: sleeping in atomic context
lib/maple_tree.c:6221 mtree_store_range() warn: sleeping in atomic context
lib/maple_tree.c:6330 mtree_alloc_range() warn: sleeping in atomic context
lib/maple_tree.c:6363 mtree_alloc_rrange() warn: sleeping in atomic context
lib/scatterlist.c:900 sg_miter_next() warn: sleeping in atomic context
lib/test_maple_tree.c:1261 check_prev_entry() warn: sleeping in atomic context
lib/test_maple_tree.c:1296 check_root_expand() warn: sleeping in atomic context
mm/gup.c:2254 get_user_pages_unlocked() warn: sleeping in atomic context
mm/gup.c:2941 internal_get_user_pages_fast() warn: sleeping in atomic context
mm/huge_memory.c:161 get_huge_zero_page() warn: sleeping in atomic context
mm/kmemleak.c:804 delete_object_part() warn: sleeping in atomic context
mm/memblock.c:442 memblock_double_array() warn: sleeping in atomic context
mm/memory.c:5823 ptlock_alloc() warn: sleeping in atomic context
mm/mempolicy.c:2615 mpol_misplaced() warn: sleeping in atomic context
mm/vmalloc.c:2244 vm_unmap_ram() warn: sleeping in atomic context
mm/vmalloc.c:3279 vmalloc() warn: sleeping in atomic context
mm/vmalloc.c:3319 vzalloc() warn: sleeping in atomic context
net/bluetooth/l2cap_core.c:3134 l2cap_build_cmd() warn: sleeping in atomic context
net/bluetooth/sco.c:1295 sco_conn_ready() warn: sleeping in atomic context
net/core/dev.c:6397 napi_disable() warn: sleeping in atomic context
net/core/sock.c:3253 sock_no_sendpage_locked() warn: sleeping in atomic context
net/core/sock.c:3474 lock_sock_nested() warn: sleeping in atomic context
net/core/stream.c:145 sk_stream_wait_memory() warn: sleeping in atomic context
net/core/stream.c:75 sk_stream_wait_connect() warn: sleeping in atomic context
net/ipv4/tcp.c:4468 tcp_alloc_md5sig_pool() warn: sleeping in atomic context
net/ipv6/addrconf.c:2192 addrconf_leave_solict() warn: sleeping in atomic context
net/ipv6/mcast.c:925 __ipv6_dev_mc_inc() warn: sleeping in atomic context
net/ipv6/mcast.c:970 __ipv6_dev_mc_dec() warn: sleeping in atomic context
net/sctp/primitive.c:198 sctp_primitive_ASCONF() warn: sleeping in atomic context
net/sctp/socket.c:482 sctp_send_asconf() warn: sleeping in atomic context
net/smc/smc_core.c:1306 smcr_buf_free() warn: sleeping in atomic context
net/smc/smc_wr.c:215 smc_wr_tx_get_free_slot() warn: sleeping in atomic context
net/socket.c:3607 kernel_sendpage_locked() warn: sleeping in atomic context
net/sunrpc/xprt.c:1120 xprt_wait_on_pinned_rqst() warn: sleeping in atomic context
net/sunrpc/xprt.c:1448 xprt_request_dequeue_xprt() warn: sleeping in atomic context
net/sunrpc/xprt.c:2113 xprt_destroy() warn: sleeping in atomic context
net/sunrpc/xprt.c:2134 xprt_destroy_kref() warn: sleeping in atomic context
net/sunrpc/xprt.c:2158 xprt_put() warn: sleeping in atomic context
security/apparmor/lsm.c:1663 aa_get_buffer() warn: sleeping in atomic context
sound/core/jack.c:673 snd_jack_report() warn: sleeping in atomic context
sound/core/pcm_native.c:1226 snd_pcm_action_group() warn: sleeping in atomic context
sound/core/pcm_native.c:168 _snd_pcm_stream_lock_irqsave() warn: sleeping in atomic context
sound/core/pcm_native.c:95 snd_pcm_group_lock() warn: sleeping in atomic context
sound/isa/msnd/msnd.c:183 snd_msnd_disable_irq() warn: sleeping in atomic context

--JKBL4U+/qNXwMCeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=errs-unreviewed

arch/x86/mm/mmio-mod.c:318 mmiotrace_iounmap() warn: sleeping in atomic context
block/blk-wbt.c:673 wbt_enable_default() warn: sleeping in atomic context
block/blk-wbt.c:843 wbt_init() warn: sleeping in atomic context
drivers/accel/habanalabs/common/context.c:112 hl_ctx_fini() warn: sleeping in atomic context
drivers/accel/habanalabs/common/context.c:141 hl_ctx_do_release() warn: sleeping in atomic context
drivers/accel/habanalabs/common/device.c:1071 hl_device_set_debug_mode() warn: sleeping in atomic context
drivers/accel/habanalabs/common/memory.c:1300 unmap_device_va() warn: sleeping in atomic context
drivers/accel/habanalabs/common/memory.c:2842 hl_vm_ctx_fini() warn: sleeping in atomic context
drivers/base/power/sysfs.c:789 wakeup_sysfs_remove() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/intel_gt_mcr.c:379 intel_gt_mcr_lock() warn: sleeping in atomic context
drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c:784 intel_guc_ct_send() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:220 pcap_set_ts_bits() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:232 pcap_disable_adc() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:247 pcap_adc_trigger() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:252 pcap_adc_trigger() warn: sleeping in atomic context
drivers/mfd/ezx-pcap.c:280 pcap_adc_irq() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:330 ppm_destroy() warn: sleeping in atomic context
drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:338 cxgbi_ppm_release() warn: sleeping in atomic context
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1861 cmd_exec() warn: sleeping in atomic context
drivers/net/phy/phy.c:1027 phy_ethtool_ksettings_set() warn: sleeping in atomic context
drivers/net/wireless/ath/ath11k/peer.c:396 ath11k_peer_create() warn: sleeping in atomic context
drivers/net/wwan/t7xx/t7xx_state_monitor.c:416 t7xx_fsm_append_cmd() warn: sleeping in atomic context
drivers/pci/msi/msi.c:864 __pci_restore_msix_state() warn: sleeping in atomic context
drivers/pcmcia/pcmcia_resource.c:168 pcmcia_access_config() warn: sleeping in atomic context
drivers/pcmcia/pcmcia_resource.c:208 pcmcia_write_config_byte() warn: sleeping in atomic context
drivers/phy/phy-core.c:404 phy_set_mode_ext() warn: sleeping in atomic context
drivers/platform/olpc/olpc-xo175-ec.c:567 olpc_xo175_ec_cmd() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5310 lpfc_unreg_rpi() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5865 lpfc_issue_clear_la() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:5887 lpfc_issue_reg_vpi() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_hbadisc.c:6563 lpfc_nlp_init() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_init.c:8987 lpfc_sli4_create_rpi_hdr() warn: sleeping in atomic context
drivers/scsi/lpfc/lpfc_sli.c:19541 lpfc_sli4_post_rpi_hdr() warn: sleeping in atomic context
drivers/spi/spi.c:4245 spi_sync() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:560 LeaveAllPowerSaveMode() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:563 LeaveAllPowerSaveMode() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:80 ips_leave() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_xmit.c:2520 rtw_sctx_wait() warn: sleeping in atomic context
drivers/usb/cdns3/core.c:64 cdns_role_stop() warn: sleeping in atomic context
drivers/usb/gadget/udc/core.c:740 usb_gadget_disconnect() warn: sleeping in atomic context
drivers/usb/gadget/udc/max3420_udc.c:1308 max3420_remove() warn: sleeping in atomic context
drivers/usb/host/max3421-hcd.c:1934 max3421_remove() warn: sleeping in atomic context
drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c:538 dispc_mgr_enable_digit_out() warn: sleeping in atomic context
drivers/xen/events/events_base.c:1213 bind_evtchn_to_irq_chip() warn: sleeping in atomic context
drivers/xen/events/events_base.c:1427 unbind_from_irq() warn: sleeping in atomic context
drivers/xen/xen-scsiback.c:1016 __scsiback_del_translation_entry() warn: sleeping in atomic context
drivers/xen/xen-scsiback.c:276 scsiback_free_translation_entry() warn: sleeping in atomic context
fs/debugfs/inode.c:765 debugfs_remove() warn: sleeping in atomic context
fs/fscache/volume.c:420 fscache_put_volume() warn: sleeping in atomic context
fs/gfs2/util.c:356 gfs2_withdraw() warn: sleeping in atomic context
fs/notify/mark.c:496 fsnotify_destroy_mark() warn: sleeping in atomic context
fs/notify/mark.c:854 fsnotify_destroy_marks() warn: sleeping in atomic context
fs/proc/inode.c:267 proc_entry_rundown() warn: sleeping in atomic context
./include/linux/fsnotify_backend.h:266 fsnotify_group_lock() warn: sleeping in atomic context
./include/net/sock.h:1725 lock_sock() warn: sleeping in atomic context
kernel/cpu.c:310 cpus_read_lock() warn: sleeping in atomic context
kernel/irq/msi.c:334 msi_lock_descs() warn: sleeping in atomic context
kernel/jump_label.c:217 static_key_enable() warn: sleeping in atomic context
kernel/kthread.c:709 kthread_stop() warn: sleeping in atomic context
kernel/locking/semaphore.c:58 down() warn: sleeping in atomic context
kernel/relay.c:798 relay_flush() warn: sleeping in atomic context
kernel/sched/completion.c:117 wait_for_common() warn: sleeping in atomic context
kernel/sched/completion.c:138 wait_for_completion() warn: sleeping in atomic context
kernel/trace/fgraph.c:63 ftrace_graph_stop() warn: sleeping in atomic context
kernel/trace/trace_selftest.c:769 trace_graph_entry_watchdog() warn: sleeping in atomic context
kernel/workqueue.c:2913 __flush_workqueue() warn: sleeping in atomic context
net/core/stream.c:145 sk_stream_wait_memory() warn: sleeping in atomic context
net/core/stream.c:75 sk_stream_wait_connect() warn: sleeping in atomic context
net/ipv6/addrconf.c:2192 addrconf_leave_solict() warn: sleeping in atomic context
net/ipv6/mcast.c:970 __ipv6_dev_mc_dec() warn: sleeping in atomic context
net/sunrpc/xprt.c:2134 xprt_destroy_kref() warn: sleeping in atomic context
net/sunrpc/xprt.c:2158 xprt_put() warn: sleeping in atomic context
sound/core/jack.c:673 snd_jack_report() warn: sleeping in atomic context
sound/core/pcm_native.c:1226 snd_pcm_action_group() warn: sleeping in atomic context

--JKBL4U+/qNXwMCeG--
