Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD78A456B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhKSHvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSHvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:51:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD73C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:48:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d5so16603644wrc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:content-language
         :to:from:subject:content-transfer-encoding;
        bh=T2GAmBkFQSlSh/OpqqH6DV4cmlFWmugPInvSWMB+cB4=;
        b=FVEJEnOWF7suyhanFHjmyzTvelzX/sEy2KIiG+CVco/T0hpA1NN7HXZ+wZQM1otz1W
         u1fKe4U7/6GXpVMBzNhZqsZ7sPgBelzskMHuBYHaV4nSzjmtvJj0jukfSt4MWX0I6F6X
         AXuqou/PcsQc77jjo5+FiE0pQPdWNsu6mu2OtwfeIcwTW3QqniIEhZScJCoEYXrcmHPS
         hMepmO8OJ7caXmHHtonn/bgUnGTTN9R44GJR/IM5zoBXVselFawUSsSdQjoKEKex9yEl
         YIkrCSm6FssKwU2Wsu9+tUsnzXELWI9lmpg8fMvnD5VrbA5jlUQezzYDYvp74AHv/ihO
         bhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :content-language:to:from:subject:content-transfer-encoding;
        bh=T2GAmBkFQSlSh/OpqqH6DV4cmlFWmugPInvSWMB+cB4=;
        b=kqojT7iqS6vt0OM30TrZLw1jiHyQOvvo17rs6j0aW22Xq/O6bKwc15eaXGqSwATLSm
         KW8dcyqk0ZgXtXSpEHyrrh9vDj7IEB9m8DIpe2qH4RiBW8sfpxCasNZTwQ1MELHOUutu
         SpxAS73nWXfn+6LaPJFfAtELzAdBgsFuokRk6PCSiU1Y9mfRW0OiT7MV1WGvp/5jTCKl
         sCPXm5JjBRFjz+AhXIKx/xVJ+d5cR342KP94jVmGJbVrmcHYwE2XTIwzNHXUkeEvr+Ut
         24DC2Xxj/HFQ6d9bkul+Fe8voChw5OfqUB2PDDIxn3heqlGvTfSrtpq8jGt7BXP1s1xB
         hbUA==
X-Gm-Message-State: AOAM532nlL62zUECEyxvnKLT3DPmEekBRBTzxVdKqrApMup5R28cLF66
        bd7pKjAECXXU8ixSegwQWXA=
X-Google-Smtp-Source: ABdhPJw7NoS19GqiyoECiZW3DGEIEAn8svXH5dQpUYo9EeOh5IQ1aNvFr90p6eNSjYU86PTekg+RDg==
X-Received: by 2002:adf:eb06:: with SMTP id s6mr4807786wrn.96.1637308092678;
        Thu, 18 Nov 2021 23:48:12 -0800 (PST)
Received: from ?IPV6:2a02:8070:a2a8:1a00:815a:3ed0:1912:b9b7? ([2a02:8070:a2a8:1a00:815a:3ed0:1912:b9b7])
        by smtp.googlemail.com with ESMTPSA id o8sm2141594wrm.67.2021.11.18.23.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 23:48:12 -0800 (PST)
Message-ID: <aea2a926-8ce6-fcb0-cd60-03202c30cca1@gmail.com>
Date:   Fri, 19 Nov 2021 08:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Reply-To: uwe.sauter.de@gmail.com
Content-Language: de-DE
To:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
From:   Uwe Sauter <uwe.sauter.de@gmail.com>
Subject: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear devs and maintainers,

during the first heavy usage of the new ntfs3 driver I experienced the following kernel bug.
I wanted to rsync several GB from a NTFS file system stored on a ZFS volume to another NTFS file system on a plain 
partition.
Both drives were connected to a SAS controller (LSISAS2008, mpt2sas). The host has ECC memory.

After this bug I remounted both file systems using the FUSE NTFS-3g driver and sync'd the data without problems.

I'm not sure if this really is ntfs3 related but being the most prominent change in my workflow, this is my best bet.



Thanks for your work,

   Uwe Sauter


#### snip ####
[ 1132.645038] BUG: unable to handle page fault for address: 0000000000400000
[ 1132.645045] #PF: supervisor instruction fetch in kernel mode
[ 1132.645047] #PF: error_code(0x0010) - not-present page
[ 1132.645050] PGD 0 P4D 0
[ 1132.645053] Oops: 0010 [#1] PREEMPT SMP PTI
[ 1132.645057] CPU: 7 PID: 429941 Comm: rsync Tainted: P           OE     5.15.2-arch1-1 #1 
e3bfbeb633edc604ba956e06f24d5659e31c294f
[ 1132.645061] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
[ 1132.645063] RIP: 0010:0x400000
[ 1132.645067] Code: Unable to access opcode bytes at RIP 0x3fffd6.
[ 1132.645068] RSP: 0018:ffffac7e63a7fab8 EFLAGS: 00010246
[ 1132.645071] RAX: 0000000000000000 RBX: ffff95e55b7e3f80 RCX: 0000000000000000
[ 1132.645074] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 1132.645075] RBP: ffff95e55b7e3f80 R08: 0000000000000000 R09: 0000000000000000
[ 1132.645077] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1132.645079] R13: ffffac7e63a7fb30 R14: ffffee3e0e250380 R15: ffffffffb4e09158
[ 1132.645081] FS:  00007fa8065b7580(0000) GS:ffff95ec003c0000(0000) knlGS:0000000000000000
[ 1132.645084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1132.645086] CR2: 0000000000400000 CR3: 0000000264e28002 CR4: 00000000001706e0
[ 1132.645089] Call Trace:
[ 1132.645093]  ? io_schedule+0x42/0x70
[ 1132.645100]  ? wait_on_page_bit_common+0x10d/0x3c0
[ 1132.645105]  ? __page_cache_alloc+0x90/0x90
[ 1132.645109]  ? filemap_get_pages+0x6ed/0x730
[ 1132.645113]  ? filemap_read+0xb9/0x360
[ 1132.645117]  ? pty_write+0x8e/0x90
[ 1132.645123]  ? new_sync_read+0x159/0x1f0
[ 1132.645128]  ? vfs_read+0xff/0x1a0
[ 1132.645131]  ? ksys_read+0x67/0xf0
[ 1132.645135]  ? do_syscall_64+0x5c/0x90
[ 1132.645140]  ? ksys_write+0x67/0xf0
[ 1132.645143]  ? syscall_exit_to_user_mode+0x23/0x50
[ 1132.645146]  ? do_syscall_64+0x69/0x90
[ 1132.645150]  ? syscall_exit_to_user_mode+0x23/0x50
[ 1132.645153]  ? do_syscall_64+0x69/0x90
[ 1132.645156]  ? exit_to_user_mode_prepare+0x12d/0x180
[ 1132.645161]  ? syscall_exit_to_user_mode+0x23/0x50
[ 1132.645163]  ? __x64_sys_close+0xd/0x50
[ 1132.645168]  ? do_syscall_64+0x69/0x90
[ 1132.645171]  ? do_syscall_64+0x69/0x90
[ 1132.645174]  ? do_syscall_64+0x69/0x90
[ 1132.645178]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1132.645183] Modules linked in: ntfs3 dm_mod vhost_net vhost vhost_iotlb tap tun xt_MASQUERADE xt_CHECKSUM 
ip6table_mangle iptable_mangle bridge stp llc ip6table_nat ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables 
iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_multiport xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 libcrc32c crc32c_generic iptable_filter rpcrdma sunrpc rdma_ucm ib_iser libiscsi scsi_transport_iscsi 
ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx4_en mlx4_ib ib_uverbs ib_core intel_rapl_msr intel_rapl_common 
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel tda18212 cxd2841er kvm irqbypass snd_hda_codec_realtek 
snd_ice1712 crct10dif_pclmul snd_hda_codec_generic snd_cs8427 iTCO_wdt intel_spi_platform intel_spi ledtrig_audio 
crc32_pclmul crc32c_intel snd_i2c spi_nor snd_ice17xx_ak4xxx snd_hda_intel intel_pmc_bxt ddbridge ghash_clmulni_intel 
snd_ak4xxx_adda at24 mtd iTCO_vendor_support mei_hdcp snd_intel_dspcfg snd_ac97_codec aesni_intel
[ 1132.645256]  snd_intel_sdw_acpi dvb_core crypto_simd videobuf2_vmalloc snd_hda_codec snd_mpu401_uart cryptd 
snd_rawmidi videobuf2_memops rapl snd_hda_core snd_seq_device intel_cstate ac97_bus intel_uncore snd_hwdep 
videobuf2_common pcspkr snd_pcm i2c_i801 videodev snd_timer i2c_smbus joydev mousedev mc igb lpc_ich mei_me snd dca 
mlx4_core mei soundcore ie31200_edac mac_hid acpi_pad vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user fuse 
bpf_preload ip_tables x_tables hid_microsoft ff_memless usbhid raid1 md_mod xhci_pci xhci_pci_renesas zfs(POE) 
zunicode(POE) zzstd(OE) zlua(OE) zavl(POE) icp(POE) zcommon(POE) znvpair(POE) spl(OE) mpt3sas raid_class 
scsi_transport_sas i915 video ttm intel_agp intel_gtt
[ 1132.645320] CR2: 0000000000400000
[ 1132.645323] ---[ end trace 08a4d6a7ac863916 ]---
[ 1132.648651] RIP: 0010:0x400000
[ 1132.648654] Code: Unable to access opcode bytes at RIP 0x3fffd6.
[ 1132.648655] RSP: 0018:ffffac7e63a7fab8 EFLAGS: 00010246
[ 1132.648657] RAX: 0000000000000000 RBX: ffff95e55b7e3f80 RCX: 0000000000000000
[ 1132.648658] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ 1132.648659] RBP: ffff95e55b7e3f80 R08: 0000000000000000 R09: 0000000000000000
[ 1132.648660] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1132.648661] R13: ffffac7e63a7fb30 R14: ffffee3e0e250380 R15: ffffffffb4e09158
[ 1132.648662] FS:  00007fa8065b7580(0000) GS:ffff95ec003c0000(0000) knlGS:0000000000000000
[ 1132.648663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1132.648676] CR2: 0000000000400000 CR3: 0000000264e28002 CR4: 00000000001706e0
[ 1132.648678] note: rsync[429941] exited with preempt_count 1
#### snap ####



#### Environment ####
Arch Linux with packages:
linux 5.15.2.arch1-1
ntfs-3g 2021.8.22-1
zfs-linux-git 2021.11.13.r7179.g8ac58c3f56_5.15.2.arch1.1-1
zfs-utils-git 2021.11.13.r7179.g8ac58c3f56-1
rsync 3.2.3-4
