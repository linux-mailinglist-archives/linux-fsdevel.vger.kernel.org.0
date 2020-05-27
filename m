Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41471E4C9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgE0SBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 14:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbgE0SBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 14:01:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB8C03E97D;
        Wed, 27 May 2020 11:01:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so293200ote.0;
        Wed, 27 May 2020 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4Psc7I4NV9+VOmLlHtYd2t3590+/OCoI7kXfoHSjkU4=;
        b=SZuEHdk+tA/xZ6SDGKDuNQQs2KMrOaj7mKQmxEQs8RKhd/6sb+gF5bu9lj3ag/Sy54
         vnbVVzxVk+7dauWCkFszrOHzVIVWbJj9S3S961UncrKhuZHwPbh5c13DIWaUNwHFYl30
         Ic4BErXTJs1fOk9CF6Kh3HnMXmfxcOeYjfKX5clbL2WIaxBjuxmP6n8U5zc82wR/m/vE
         QY3HQ3Lk6Z+8c0eGi7Sca6XadyQpT1oez2uJoxKJ8xC6cxLqtpHNeMldPzUBeWz7Yxa6
         r+CVemLANbCcHifeDbCnuYG5ktlOAMZgShs4uFPpMVHI+Rvvs89XNs8xFoBzb7n1ZTe0
         UAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4Psc7I4NV9+VOmLlHtYd2t3590+/OCoI7kXfoHSjkU4=;
        b=XnkIKtrTZI9VIvfCsNsFS5dl4XqSDWI9tONxhCDXJ+DzcG39RB/a0KNxG2Ey7ZMA3D
         66NEIycQz7YXb//84rVgG4KT5mN4pIePrCoT48ExbYm4/5S/BF+Pijwf40kWxSDNODQO
         aFdxClFXJQsRMvQgbp6V0BRosvJcj5uPSslwszNgvNYJQQ3asChZsd957fYKkdmjlmMu
         1I50oVCjI9OoPPFwPO15ekPDIkHfuQCuecFbhHxAIobdtwwqshx+adN47dC2nx6srxw8
         9FB4vHdex+KeqLaUX3XvAveK5bLAQbdhcCEs4vYInJOHrFnDmysQpe3SxQq6c03Lr9wt
         sdNg==
X-Gm-Message-State: AOAM531vMpi3myCkbpMhBLMFlOpfHA1gpLYi/4MyIeouTmU2NGkCZHUq
        yVhna3vQy6/+3/Rf1G0oCPrAMxQeqY91PuaoqR0=
X-Google-Smtp-Source: ABdhPJw/XkG5dgiw0MYCcn4EgV3eQ1gWbxyvlrWNskI+It1+vK65tjsIJ15QEEJjm76CHKJgsmrMnLyQrqylzHMChOo=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr5791294oto.295.1590602476142;
 Wed, 27 May 2020 11:01:16 -0700 (PDT)
MIME-Version: 1.0
From:   nirinA raseliarison <nirina.raseliarison@gmail.com>
Date:   Wed, 27 May 2020 21:05:55 +0300
Message-ID: <CANsGL8PFnEvBcfLV7eKZQCONoork3EQ7x_RdtkFPXuWZQbK=qg@mail.gmail.com>
Subject: kernel BUG at fs/inode.c:531!
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hello,
i hit again this bug with:

$ cat /proc/version
Linux version 5.7.0-rc7.20200525 (nirina@supernova.org) (gcc version
10.1.0 (GCC), GNU ld version 2.33.1-slack15) #1 SMP Mon May 25
02:49:28 EAT 2020


[99390.044690] ------------[ cut here ]------------
[99390.044695] kernel BUG at fs/inode.c:531!
[99390.044702] invalid opcode: 0000 [#1] SMP PTI
[99390.044705] CPU: 0 PID: 149 Comm: kswapd0 Not tainted 5.7.0-rc7.20200525 #1
[99390.044706] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5 01/07/2013
[99390.044712] RIP: 0010:clear_inode+0x75/0x80
[99390.044714] Code: a8 20 74 2a a8 40 75 28 48 8b 83 28 01 00 00 48
8d 93 28 01 00 00 48 39 c2 75 17 48 c7 83 98 00 00 00 60 00 00 00 5b
c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 90 0f 1f 44 00 00 53 ba 48 02
00 00
[99390.044716] RSP: 0018:ffffc900004c7b50 EFLAGS: 00010006
[99390.044717] RAX: 0000000000000000 RBX: ffff88808c5f9e38 RCX: 0000000000000000
[99390.044718] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88808c5f9fb8
[99390.044719] RBP: ffff88808c5f9e38 R08: ffffffffffffffff R09: ffffc900004c7cd8
[99390.044720] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88808c5f9fb0
[99390.044721] R13: ffff888215658000 R14: ffff888215658070 R15: 000000000000014c
[99390.044723] FS:  0000000000000000(0000) GS:ffff888217600000(0000)
knlGS:0000000000000000
[99390.044724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[99390.044725] CR2: 00000006f9004000 CR3: 00000001511da001 CR4: 00000000001606f0
[99390.044726] Call Trace:
[99390.044732]  ext4_clear_inode+0x16/0x80
[99390.044736]  ext4_evict_inode+0x58/0x4c0
[99390.044738]  evict+0xbf/0x180
[99390.044740]  prune_icache_sb+0x7e/0xb0
[99390.044743]  super_cache_scan+0x161/0x1e0
[99390.044746]  do_shrink_slab+0x146/0x290
[99390.044749]  shrink_slab+0xac/0x2a0
[99390.044752]  ? __switch_to_asm+0x40/0x70
[99390.044754]  shrink_node+0x16f/0x660
[99390.044757]  balance_pgdat+0x2cf/0x5b0
[99390.044759]  kswapd+0x1dc/0x3a0
[99390.044762]  ? __schedule+0x217/0x710
[99390.044764]  ? wait_woken+0x80/0x80
[99390.044766]  ? balance_pgdat+0x5b0/0x5b0
[99390.044768]  kthread+0x118/0x130
[99390.044770]  ? kthread_create_worker_on_cpu+0x70/0x70
[99390.044772]  ret_from_fork+0x35/0x40
[99390.044773] Modules linked in: 8021q garp stp mrp llc rtl8192cu
rtl_usb rtl8192c_common rtlwifi mac80211 cfg80211 uas usb_storage
nct6775 hwmon_vid ipv6 rfkill nf_defrag_ipv6 snd_pcm_oss snd_mixer_oss
fuse hid_generic usbhid hid snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic i2c_dev coretemp hwmon i915 x86_pkg_temp_thermal
intel_powerclamp kvm_intel kvm i2c_algo_bit irqbypass drm_kms_helper
evdev r8169 snd_hda_intel syscopyarea snd_intel_dspcfg realtek
snd_hda_codec libphy crc32_pclmul sysfillrect serio_raw sysimgblt
snd_hwdep fb_sys_fops snd_hda_core drm snd_pcm fan thermal
drm_panel_orientation_quirks snd_timer intel_gtt 8250 agpgart snd
8250_base ehci_pci serial_core button ehci_hcd video soundcore
i2c_i801 lpc_ich mfd_core mei_me mei loop
[99390.044800] ---[ end trace 2ca57858c52a0ad4 ]---

--
nirinA
