Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B35962CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiHPTA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPTA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:00:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC00857F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:00:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a89so14682623edf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=GPhJf/V9NFKKBvOE+jWQ6Jny25ln9DQHeUBrTTekG8Y=;
        b=MzRYpEAO5G9GMFlz5fK/u6Dq/88Vl2/2ynCGU9tfF6ZUp4UmF3ogO/i5D3btUf1rqi
         UN8+nqACURijdwgsv6Ih+V3kKL8rGXkzHCxzWDq2/M/DawVt3ins2CsGd4o3L86ezFrW
         OMcMKcA9rpnr5hiw5J54Qv5/fPUqLxi6949q78rnjxeult3ZR0q5Rgje9XLKtDzyWcB+
         Z6Y1o4oSBnSr9Wap58j14VO44crUnKlZJjcoe5qXRrcZ+vWyZvUFwiIcpI7mY3StPx8F
         jUqvVinSysfE8LpG1Hw17W9m5YYi2veCePA+YSeKhUakrUR2BaMdRSV+Ot4K5Bdrroe8
         0Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=GPhJf/V9NFKKBvOE+jWQ6Jny25ln9DQHeUBrTTekG8Y=;
        b=pjdzFG8qwUlvLiuWyZZA6nMmslZ2AZ/OnJqjZJty1FjL4KnYIgcQDUyOKH2F4vbYXK
         voL/CV9wD61UtT/q2W5AbaEd3S9RenZpybQ/dKbkkcz60RJCs/d7GA325zms1+Id3VrO
         0ecG8M3w2F0a2zkBKsI+FThjtjuoPYtxX7wWY8VJ/syIOnbrYpnSW9ZV0JqfDxzRBLQS
         uAj93ntSgXS1RIIMMAfemX4hnR5MjWaqV5Kcw0hjgQWPas+ibCQchrxRBh9acTOpmiH4
         lEJpvNT8MyLDmUGvSd/qksW11U82TZEqv3BmBth13l+ZKose84QfVwwB/gkPUQaxodVp
         7vFA==
X-Gm-Message-State: ACgBeo0HMODuuLGwtyUcZCcvQWYhRMEU8txkfYVd9vcrdmfSJG2CLHLg
        bLx0eUitOKdsDxpIPtSvXtbqpA5kXtfRJXnBt39xuQ==
X-Google-Smtp-Source: AA6agR6/INaPLYxt95pYwq1zkt35uDm6YnJGdJsfEMn2xpGyyP0suBWBuDhNqh5PwHTBxpv4qQzCdgumBaMHhFY5aHE=
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id
 f40-20020a05640232a800b0043e5490295fmr19879457eda.193.1660676454486; Tue, 16
 Aug 2022 12:00:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Aug 2022 00:30:43 +0530
Message-ID: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
Subject: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error: Oops -
 BUG: 0 - pc : clear_inode
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following kernel BUG found while booting arm64 Qcom dragonboard 410c with
Linux next-20220816 kernel Image.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: e1084bacab44f570691c0fdaa1259acf93ed0098
  git_describe: next-20220816
  kernel_version: 6.0.0-rc1
  kernel-config: https://builds.tuxbuild.com/2DQCqsegDOgC0htScIz07RRDr7J/config
  artifact-location: https://builds.tuxbuild.com/2DQCqsegDOgC0htScIz07RRDr7J
  vmlinux: https://builds.tuxbuild.com/2DQCqsegDOgC0htScIz07RRDr7J/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2DQCqsegDOgC0htScIz07RRDr7J/System.map
  toolchain: gcc-11

[   17.950163] kernel BUG at fs/inode.c:622!
[   17.954719] Internal error: Oops - BUG: 0 [#6] PREEMPT SMP
[   17.959290] Modules linked in: rfkill snd_soc_hdmi_codec venus_enc
venus_dec videobuf2_dma_contig pm8916_wdt crct10dif_ce qcom_wcnss_pil
adv7511 cec msm qrtr qcom_camss gpu_sched drm_dp_aux_bus venus_core
display_connector videobuf2_dma_sg drm_display_helper qcom_q6v5_mss
v4l2_fwnode qcom_pil_info snd_soc_lpass_apq8016 qcom_q6v5
snd_soc_lpass_cpu v4l2_async snd_soc_msm8916_digital drm_kms_helper
snd_soc_apq8016_sbc qcom_sysmon v4l2_mem2mem snd_soc_qcom_common
snd_soc_lpass_platform qcom_spmi_temp_alarm snd_soc_msm8916_analog
videobuf2_memops rtc_pm8xxx qcom_common videobuf2_v4l2 qcom_spmi_vadc
qcom_glink_smem qcom_vadc_common qcom_pon qmi_helpers videobuf2_common
mdt_loader i2c_qcom_cci drm qcom_stats qnoc_msm8916 qcom_rng
icc_smd_rpm socinfo rmtfs_mem fuse
[   18.023315] CPU: 3 PID: 457 Comm: systemd-udevd Tainted: G      D
         6.0.0-rc1-next-20220816 #1
[   18.030656] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   18.039973] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.046925] pc : clear_inode+0x88/0x9c
[   18.053570] lr : clear_inode+0x3c/0x9c
[   18.058064] sp : ffff80000c9f3c30
[   18.062518] x29: ffff80000c9f3c30 x28: ffff000004f19080 x27: 0000000000000000
[   18.067099] x26: ffff000005b2ad90 x25: 0000000000000002 x24: 00000000ffffffec
[   18.073181] x23: ffff80000aaaea80 x22: ffff000005b2ad58 x21: ffff0000037c3340
[   18.077364] ax88179_178a 1-1.2:1.0 eth0: ax88179 - Link status is: 1
[   18.080288] x20: ffff000005b2af10 x19: ffff000005b2ad90 x18: 0000000000000000
[   18.080306] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   18.080319] x14: 0000ffffffffffff x13: 0000000000000000
[   18.094909] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   18.096330]  x12: fefefefefefefeff
[   18.131891] x11: 0000fffffffffff8 x10: ffff00000a0776c0 x9 : ffff800009443f98
[   18.136734] x8 : ffff80000c9f3d08 x7 : 0000000000000000 x6 : 0000000000000001
[   18.142836] x5 : ffff80000aaaf000 x4 : ffff80000aaaf2e8 x3 : 0000000000000000
[   18.149910] x2 : ffff000005043040 x1 : ffff000005b2af90 x0 : ffff000005b2afb0
[   18.157031] Call trace:
[   18.164169]  clear_inode+0x88/0x9c
[   18.169006]  shmem_evict_inode+0xa4/0x29c
[   18.173853]  evict+0xac/0x190
[   18.178674]  iput+0x174/0x240
[   18.183499]  do_unlinkat+0x1c4/0x270
[   18.188333]  __arm64_sys_unlinkat+0x4c/0x90
[   18.193195]  invoke_syscall+0x50/0x120
[   18.198036]  el0_svc_common.constprop.0+0x104/0x124
[   18.202891]  do_el0_svc+0x3c/0xd0
[   18.207775]  el0_svc+0x30/0x94
[   18.212631]  el0t_64_sync_handler+0xc0/0x13c
[   18.217542]  el0t_64_sync+0x18c/0x190
[   18.222401] Code: a8c27bfd d50323bf d65f03c0 d4210000 (d4210000)
[   18.227277] ---[ end trace 0000000000000000 ]---
[   18.232281] note: systemd-udevd[457] exited with preempt_count 1
[   18.287738] ------------[ cut here ]------------
[   18.292616] WARNING: CPU: 3 PID: 0 at kernel/context_tracking.c:128
ct_kernel_exit.constprop.0+0x108/0x120
[   18.297548] Modules linked in: rfkill snd_soc_hdmi_codec venus_enc
venus_dec videobuf2_dma_contig pm8916_wdt crct10dif_ce qcom_wcnss_pil
adv7511 cec msm qrtr qcom_camss gpu_sched drm_dp_aux_bus venus_core
display_connector videobuf2_dma_sg drm_display_helper qcom_q6v5_mss
v4l2_fwnode qcom_pil_info snd_soc_lpass_apq8016 qcom_q6v5
snd_soc_lpass_cpu v4l2_async snd_soc_msm8916_digital drm_kms_helper
snd_soc_apq8016_sbc qcom_sysmon v4l2_mem2mem snd_soc_qcom_common
snd_soc_lpass_platform qcom_spmi_temp_alarm snd_soc_msm8916_analog
videobuf2_memops rtc_pm8xxx qcom_common videobuf2_v4l2 qcom_spmi_vadc
qcom_glink_smem qcom_vadc_common qcom_pon qmi_helpers videobuf2_common
mdt_loader i2c_qcom_cci drm qcom_stats qnoc_msm8916 qcom_rng
icc_smd_rpm socinfo rmtfs_mem fuse
[   18.368071] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
   6.0.0-rc1-next-20220816 #1
[   18.373948] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   18.383033] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   18.389948] pc : ct_kernel_exit.constprop.0+0x108/0x120
[   18.397848] lr : ct_idle_enter+0x14/0x20
[   18.404845] sp : ffff80000b0c3d60
[   18.410655] x29: ffff80000b0c3d60 x28: 0000000000000000 x27: 0000000000000000
[   18.417235] x26: 0000000000000000 x25: 0000000000000000 x24: 00000004420862ef
[   18.424585] x23: 0000000000000000 x22: ffff000004cf2880 x21: ffff00003fca5940
[   18.431994] x20: ffff000004cf2898 x19: ffff00003fca3b00 x18: 0000000000000000
[   18.439447] x17: 0000000000000000 x16: ffff00003fc89040 x15: 0000000000000000
[   18.446941] x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
[   18.454423] x11: 0000000000000001 x10: 0000000000000c00 x9 : ffff80000901f4f0
[   18.461904] x8 : ffff000003704e60 x7 : 0000000000000000 x6 : 000000000523b3e8
[   18.469278] x5 : 4000000000000002 x4 : ffff800035adc000 x3 : ffff80000b0c3d60
[   18.476594] x2 : ffff80000a1c7b00 x1 : 4000000000000000 x0 : ffff80000a1c7b00
[   18.483850] Call trace:
[   18.491111]  ct_kernel_exit.constprop.0+0x108/0x120
[   18.498465]  ct_idle_enter+0x14/0x20
[   18.505793]  cpuidle_enter_state+0x2cc/0x4c0
[   18.513112]  cpuidle_enter+0x44/0x60
[   18.518978]  do_idle+0x24c/0x2e0
[   18.524950]  cpu_startup_entry+0x34/0x40
[   18.531686]  secondary_start_kernel+0x13c/0x150
[   18.538141]  __secondary_switched+0xb0/0xb4
[   18.544315] ---[ end trace 0000000000000000 ]---
[   19.722064]  mmcblk1: p1
[   19.740791]  mmcblk1: p1
[   19.759017]  mmcblk1: p1
[   19.769040] EXT4-fs (mmcblk0p14): resizing filesystem from 652544
to 1826299 blocks
[   19.852550] EXT4-fs (mmcblk0p14): resized filesystem to 1826299


ref:
https://lkft.validation.linaro.org/scheduler/job/5391332#L2911
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220816/testrun/11378204/suite/log-parser-boot/tests/

--
Linaro LKFT
https://lkft.linaro.org
