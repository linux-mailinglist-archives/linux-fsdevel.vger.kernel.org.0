Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8A480D1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhL1VBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 16:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbhL1VBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:01:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058FC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 13:01:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f5so78375238edq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU4PjftdeYPyhuEQhv6UTPS8Qab10sSiPyrfaWEOmvM=;
        b=Fg1TtB46wKOPq/WxTo/k4pidM1IoR/AtmDzu2XgHsP3EQtwV8oicBb8sNB8X8mdDqt
         tmTKqOWeTXaKEHVBjc8n5M0+HdMU7/CalwZ9OSt/o71pnijqxfEWrWcJI0CIX0Yvbtfc
         AvaHukSqUzlIBJpmT1AhJFJw29JZcRH7u878qgTXUhBA3o4+7E7WFG8y+HL+3hp+fJ2X
         GrzVqDz0EUdUM8oEx3TeM4h0TRqhWs8f/0N6I1HW5YiG6RLDsIWhHCWskcZRVt49COli
         EDDBegyHBvE8m6wDvAOREajt40AWbFrRD3R7uiOuYEhSmydkoBUblBwJYPmmcDDMO9QW
         wXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU4PjftdeYPyhuEQhv6UTPS8Qab10sSiPyrfaWEOmvM=;
        b=p9RMe390eFl6Q8cb1hwRPxJlD2ijefg6aHxPbYnQHsq9M9M4QR7baq2wmamafAOsBg
         XDFQ1qiYVqBim3YK/g0VC5pfDOtZzP/N/euRMD5+RQJcmAkyyUhayUyBC33iDIeXDJks
         syp5Dgi5x02IPhZy2+4tPmsJKlaSYQSUpBjeCSZkGE7ik0j688SLLqkSH1RR4hiYhEEp
         zBckYNZTU657rO4ncXALYC8vaj7cQGGWWAv4FbNjS2eydPWSIEgGWIV2gU/T1T80/JE3
         nFcYKco7ykfBe511G37p/mHGX9u+ZAUnsJ+RUOMfnjbSufxXwWDqmP6WTSqzJMNnSkSc
         S9iw==
X-Gm-Message-State: AOAM532SjBt1v3z/azl35U2jfg5J8H+l5+ufyFHTzyfQ37fXwgbnq2jd
        yEjhkdayTha4Qm7TlrFyNXmzS5o8tpc9SJV+H5c=
X-Google-Smtp-Source: ABdhPJw+Lioe45L5YjVqGGKKHiEARkz52a0QlHuCINLgAKRlanok+johSc5Vv1mudH8qIVZwpme6VHTeVnGMKGU1c5M=
X-Received: by 2002:aa7:d2d1:: with SMTP id k17mr22513798edr.250.1640725265338;
 Tue, 28 Dec 2021 13:01:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFYqD2pe-sjPrHXGsNCHa2fcdECNm44UEZbEn4P5VgygFnrn7A@mail.gmail.com>
 <YaJFoadpGAwPfdLv@casper.infradead.org>
In-Reply-To: <YaJFoadpGAwPfdLv@casper.infradead.org>
From:   August Wikerfors <august.wikerfors@gmail.com>
Date:   Tue, 28 Dec 2021 22:00:53 +0100
Message-ID: <CAP62yhUh2ULCaD4+RX6Lj_QZmJN+uh5L46xzb7NvrWU3vHeCfw@mail.gmail.com>
Subject: Re: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mohan R <mohan43u@gmail.com>, uwe.sauter.de@gmail.com,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(resending from gmail due to bounce with outlook)

Hi, I ran into a bug with a very similar call trace, also when copying files
with rsync from a filesystem mounted using ntfs3. I was able to reproduce it
on both the default Arch Linux kernel (5.15.11-arch2-1) and on mainline
5.16-rc7.

> This is where the real bug happened.  It would be helpful if you
> could run
> ./scripts/faddr2line /path/to/vmlinux page_cache_ra_unbounded+0x1c5/0x250
>
> It'll spit out something like:
> page_cache_ra_unbounded at mm/readahead.c:241
>
> but probably a different line number from that.
I had to rebuild the vmlinux of my kernels in order for this to work but the
output for the page_cache_ra_unbounded line is below the dmesg outputs.

5.15.11-arch2-1 dmesg:
[  486.360050] BUG: unable to handle page fault for address: ffffff8306d925ff
[  486.360083] #PF: supervisor instruction fetch in kernel mode
[  486.360113] #PF: error_code(0x0010) - not-present page
[  486.360142] PGD 171815067 P4D 171815067 PUD 0
[  486.360160] Oops: 0010 [#1] PREEMPT SMP PTI
[  486.360177] CPU: 2 PID: 1129 Comm: rsync Tainted: G           OE
 5.15.11-arch2-1 #1 03010ffba27108079ccfa4d61c5b01422e5fb7c7
[  486.360216] Hardware name: ASUSTeK COMPUTER INC. S551LN/S551LN,
BIOS S551LN.209 07/08/2014
[  486.360243] RIP: 0010:0xffffff8306d925ff
[  486.360260] Code: Unable to access opcode bytes at RIP 0xffffff8306d925d5.
[  486.360302] RSP: 0018:ffffaa9ec0f8fb37 EFLAGS: 00010246
[  486.360322] RAX: 0000000000000000 RBX: 00000000000002ab RCX: 0000000000000000
[  486.360355] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  486.360389] RBP: ffaa9ec0f8fbf800 R08: 0000000000000000 R09: 0000000000000000
[  486.360413] R10: 0000000000000000 R11: 0000000000000000 R12: ff99687f5746e000
[  486.360456] R13: 00000001112ccaff R14: fffcbb8097368000 R15: 00000000000001ff
[  486.360481] FS:  00007f9a38011580(0000) GS:ffff9968a6f00000(0000)
knlGS:0000000000000000
[  486.360509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  486.360529] CR2: ffffff8306d925d5 CR3: 000000013e140001 CR4: 00000000001706e0
[  486.360553] Call Trace:
[  486.360564]  <TASK>
[  486.360584] BUG: unable to handle page fault for address: ffffaa9ec0f90000
[  486.360608] #PF: supervisor read access in kernel mode
[  486.360626] #PF: error_code(0x0000) - not-present page
[  486.360644] PGD 100000067 P4D 100000067 PUD 1001be067 PMD 10ed20067 PTE 0
[  486.360669] Oops: 0000 [#2] PREEMPT SMP PTI
[  486.360685] CPU: 2 PID: 1129 Comm: rsync Tainted: G           OE
 5.15.11-arch2-1 #1 03010ffba27108079ccfa4d61c5b01422e5fb7c7
[  486.360723] Hardware name: ASUSTeK COMPUTER INC. S551LN/S551LN,
BIOS S551LN.209 07/08/2014
[  486.360769] RIP: 0010:show_trace_log_lvl+0x1a4/0x32d
[  486.360789] Code: c7 c4 64 25 84 e8 0f be 00 00 4d 85 ed 74 41 0f
b6 95 37 ff ff ff 4c 89 f1 4c 89 ee 48 8d bd 50 ff ff ff e8 dc fd ff
ff eb 26 <4c> 8b 3b 48 8d bd 70 ff ff ff e8 2e 2e 52 ff 4c 89 ff 48 89
85 28
[  486.360866] RSP: 0018:ffffaa9ec0f8f8c8 EFLAGS: 00010012
[  486.360885] RAX: 0000000000000000 RBX: ffffaa9ec0f8ffff RCX: 0000000000000000
[  486.360910] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  486.360934] RBP: ffffaa9ec0f8f9a8 R08: 0000000000000000 R09: 0000000000000000
[  486.360958] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9967a2801fc0
[  486.360983] R13: 0000000000000000 R14: ffffffff8427d77f R15: 0000000000002b00
[  486.361006] FS:  00007f9a38011580(0000) GS:ffff9968a6f00000(0000)
knlGS:0000000000000000
[  486.361033] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  486.361053] CR2: ffffaa9ec0f90000 CR3: 000000013e140001 CR4: 00000000001706e0
[  486.361077] Call Trace:
[  486.361087]  <TASK>
[  486.361098]  __die_body.cold+0x1a/0x1f
[  486.361114]  page_fault_oops+0x19e/0x310
[  486.361142]  exc_page_fault+0xda/0x180
[  486.361159]  asm_exc_page_fault+0x1e/0x30
[  486.361177] RIP: 0010:0xffffff8306d925ff
[  486.361192] Code: Unable to access opcode bytes at RIP 0xffffff8306d925d5.
[  486.361214] RSP: 0018:ffffaa9ec0f8fb37 EFLAGS: 00010246
[  486.361232] RAX: 0000000000000000 RBX: 00000000000002ab RCX: 0000000000000000
[  486.361255] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  486.361279] RBP: ffaa9ec0f8fbf800 R08: 0000000000000000 R09: 0000000000000000
[  486.361302] R10: 0000000000000000 R11: 0000000000000000 R12: ff99687f5746e000
[  486.361324] R13: 00000001112ccaff R14: fffcbb8097368000 R15: 00000000000001ff
[  486.361349]  ? page_cache_ra_unbounded+0x1c5/0x250
[  486.361369]  ? filemap_get_pages+0x117/0x730
[  486.361386]  ? make_kuid+0xf/0x20
[  486.361401]  ? generic_permission+0x27/0x210
[  486.361419]  ? walk_component+0x11d/0x1c0
[  486.361435]  ? filemap_read+0xb9/0x360
[  486.361451]  ? new_sync_read+0x159/0x1f0
[  486.361467]  ? vfs_read+0xff/0x1a0
[  486.361489]  ? ksys_read+0x67/0xf0
[  486.361503]  ? do_syscall_64+0x5c/0x90
[  486.361517]  ? __audit_syscall_exit+0x255/0x2c0
[  486.361533]  ? syscall_exit_to_user_mode+0x23/0x50
[  486.362508]  ? do_syscall_64+0x69/0x90
[  486.363455]  ? do_syscall_64+0x69/0x90
[  486.364401]  ? do_syscall_64+0x69/0x90
[  486.365322]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[  486.366263]  </TASK>
[  486.367197] Modules linked in: 8021q garp mrp stp llc nls_iso8859_1
vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
videobuf2_common videodev mc x86_pkg_temp_thermal intel_powerclamp
mt76x0e snd_hda_codec_realtek coretemp snd_hda_codec_generic
ledtrig_audio rtsx_usb_ms snd_hda_codec_hdmi memstick kvm_intel
mt76x0_common ntfs3 snd_hda_intel kvm mt76x02_lib joydev asus_nb_wmi
intel_spi_platform intel_spi spi_nor asus_wmi mt76 mtd mousedev
iTCO_wdt snd_intel_dspcfg sparse_keymap intel_pmc_bxt mei_hdcp
intel_rapl_msr iTCO_vendor_support at24 irqbypass platform_profile
mxm_wmi mac80211 snd_intel_sdw_acpi snd_hda_codec snd_hda_core
crct10dif_pclmul i915 crc32_pclmul r8169 snd_hwdep libarc4 cfg80211
snd_pcm ghash_clmulni_intel aesni_intel crypto_simd snd_timer rfkill
realtek cryptd mdio_devres processor_thermal_device_pci_legacy libphy
rapl processor_thermal_device intel_cstate snd pcspkr
processor_thermal_rfim processor_thermal_mbox intel_uncore
processor_thermal_rapl
[  486.367240]  mei_me intel_rapl_common soundcore ttm mei
intel_soc_dts_iosf intel_gtt video lpc_ich i2c_i801 int3402_thermal
i2c_smbus intel_pch_thermal psmouse int3400_thermal
int340x_thermal_zone wmi acpi_thermal_rel asus_wireless mac_hid
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) crypto_user fuse bpf_preload
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq rtsx_usb_sdmmc mmc_core rtsx_usb serio_raw atkbd libps2
crc32c_intel xhci_pci sr_mod i8042 cdrom xhci_pci_renesas serio
[  486.376305] CR2: ffffaa9ec0f90000
[  486.377512] ---[ end trace 2b657e7ade0f9e60 ]---
[  486.378748] RIP: 0010:0xffffff8306d925ff
[  486.380001] Code: Unable to access opcode bytes at RIP 0xffffff8306d925d5.
[  486.381220] RSP: 0018:ffffaa9ec0f8fb37 EFLAGS: 00010246
[  486.382432] RAX: 0000000000000000 RBX: 00000000000002ab RCX: 0000000000000000
[  486.383656] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  486.384871] RBP: ffaa9ec0f8fbf800 R08: 0000000000000000 R09: 0000000000000000
[  486.386072] R10: 0000000000000000 R11: 0000000000000000 R12: ff99687f5746e000
[  486.387278] R13: 00000001112ccaff R14: fffcbb8097368000 R15: 00000000000001ff
[  486.388478] FS:  00007f9a38011580(0000) GS:ffff9968a6f00000(0000)
knlGS:0000000000000000
[  486.389684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  486.390890] CR2: ffffff8306d925d5 CR3: 000000013e140001 CR4: 00000000001706e0

$ scripts/faddr2line vmlinux.5.15.11-arch2-1 page_cache_ra_unbounded+0x1c5/0x250
page_cache_ra_unbounded+0x1c5/0x250:
filemap_invalidate_unlock_shared at include/linux/fs.h:853
(inlined by) page_cache_ra_unbounded at mm/readahead.c:240

5.16-rc7 dmesg:
[  258.570806] ------------[ cut here ]------------
[  258.570810] kernel BUG at mm/readahead.c:151!
[  258.570817] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  258.570822] CPU: 0 PID: 1136 Comm: rsync Not tainted
5.16.0-rc7-1-mainline #1 b49cff4185a0eb169c9f956a386eb3a9156e4796
[  258.570827] Hardware name: ASUSTeK COMPUTER INC. S551LN/S551LN,
BIOS S551LN.209 07/08/2014
[  258.570829] RIP: 0010:read_pages+0x26c/0x280
[  258.570836] Code: eb 87 48 8b 07 48 c1 e8 38 83 e0 07 83 f8 04 75
e4 48 8b 47 08 8b 40 68 83 e8 01 83 f8 01 77 d5 e8 39 18 00 00 e9 5f
ff ff ff <0f> 0b 0f 0b e8 bb 4d 96 00 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f
[  258.570838] RSP: 0018:ffff9d59c0b1fa78 EFLAGS: 00010206
[  258.570842] RAX: ff9d59c0b1fb1000 RBX: ffff9d59c0b1fbc0 RCX: 0000000000000000
[  258.570844] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  258.570846] RBP: ffff9d59c0b1fb0f R08: 0000000000000000 R09: 0000000000000000
[  258.570848] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  258.570850] R13: 0000000000000000 R14: ffffc4ba4632d680 R15: 0000000000000002
[  258.570852] FS:  00007f9a9ec98580(0000) GS:ffff8b9f26e00000(0000)
knlGS:0000000000000000
[  258.570855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  258.570857] CR2: 00005646e709b000 CR3: 00000001361ee005 CR4: 00000000001706f0
[  258.570860] Call Trace:
[  258.570862]  <TASK>
[  258.570865]  page_cache_ra_unbounded+0x1d9/0x270
[  258.570872]  filemap_get_pages+0x11e/0x7e0
[  258.570878]  ? generic_permission+0x27/0x210
[  258.570885]  ? walk_component+0x11d/0x1c0
[  258.570891]  filemap_read+0xcc/0x380
[  258.570897]  new_sync_read+0x159/0x1f0
[  258.570902]  vfs_read+0xff/0x1a0
[  258.570907]  ksys_read+0x67/0xf0
[  258.570911]  do_syscall_64+0x5c/0x90
[  258.570919]  ? syscall_exit_to_user_mode+0x23/0x50
[  258.570923]  ? do_syscall_64+0x69/0x90
[  258.570927]  ? exit_to_user_mode_prepare+0x8d/0x180
[  258.570932]  ? syscall_exit_to_user_mode+0x23/0x50
[  258.570935]  ? do_syscall_64+0x69/0x90
[  258.570938]  ? do_syscall_64+0x69/0x90
[  258.570942]  ? do_syscall_64+0x69/0x90
[  258.570946]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  258.570951] RIP: 0033:0x7f9a9edb0862
[  258.570954] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 5a 29 0a 00 e8 55
e4 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[  258.570957] RSP: 002b:00007ffdd97ee518 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  258.570960] RAX: ffffffffffffffda RBX: 00005646e6850640 RCX: 00007f9a9edb0862
[  258.570962] RDX: 000000000000219e RSI: 00005646e6f1cab0 RDI: 0000000000000003
[  258.570964] RBP: 000000000000219e R08: 0000000000000000 R09: 00007f9a9ee81a60
[  258.570966] R10: 00007f9a9ee821b0 R11: 0000000000000246 R12: 0000000000000000
[  258.570968] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000219e
[  258.570971]  </TASK>
[  258.570972] Modules linked in: 8021q garp mrp stp llc nls_iso8859_1
vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
videobuf2_common videodev mc ntfs3 intel_spi_platform intel_spi
x86_pkg_temp_thermal spi_nor intel_powerclamp mtd
snd_hda_codec_realtek rtsx_usb_ms coretemp iTCO_wdt
snd_hda_codec_generic memstick intel_pmc_bxt snd_hda_codec_hdmi
kvm_intel iTCO_vendor_support ledtrig_audio kvm joydev mousedev at24
asus_nb_wmi intel_rapl_msr mei_hdcp asus_wmi mt76x0e sparse_keymap
platform_profile irqbypass crct10dif_pclmul snd_hda_intel
mt76x0_common snd_intel_dspcfg crc32_pclmul mt76x02_lib
ghash_clmulni_intel aesni_intel mt76 crypto_simd snd_intel_sdw_acpi
mac80211 snd_hda_codec libarc4 cfg80211 cryptd snd_hda_core rfkill
r8169 rapl intel_cstate realtek intel_uncore mxm_wmi mdio_devres
libphy i915 processor_thermal_device_pci_legacy
processor_thermal_device processor_thermal_rfim snd_hwdep i2c_i801
processor_thermal_mbox snd_pcm snd_timer processor_thermal_rapl mei_me
[  258.571036]  video mei i2c_smbus ttm lpc_ich intel_rapl_common snd
intel_gtt intel_pch_thermal soundcore mac_hid intel_soc_dts_iosf
psmouse pcspkr int3400_thermal wmi int3402_thermal acpi_thermal_rel
int340x_thermal_zone asus_wireless crypto_user fuse bpf_preload
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq rtsx_usb_sdmmc mmc_core rtsx_usb serio_raw atkbd libps2
xhci_pci crc32c_intel sr_mod i8042 cdrom xhci_pci_renesas serio
[  258.571071] ---[ end trace 685ffdce3faf85b7 ]---
[  258.571073] RIP: 0010:read_pages+0x26c/0x280
[  258.571077] Code: eb 87 48 8b 07 48 c1 e8 38 83 e0 07 83 f8 04 75
e4 48 8b 47 08 8b 40 68 83 e8 01 83 f8 01 77 d5 e8 39 18 00 00 e9 5f
ff ff ff <0f> 0b 0f 0b e8 bb 4d 96 00 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f
[  258.571079] RSP: 0018:ffff9d59c0b1fa78 EFLAGS: 00010206
[  258.571081] RAX: ff9d59c0b1fb1000 RBX: ffff9d59c0b1fbc0 RCX: 0000000000000000
[  258.571083] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  258.571085] RBP: ffff9d59c0b1fb0f R08: 0000000000000000 R09: 0000000000000000
[  258.571087] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  258.571088] R13: 0000000000000000 R14: ffffc4ba4632d680 R15: 0000000000000002
[  258.571090] FS:  00007f9a9ec98580(0000) GS:ffff8b9f26e00000(0000)
knlGS:0000000000000000
[  258.571093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  258.571095] CR2: 00005646e709b000 CR3: 00000001361ee005 CR4: 00000000001706f0

$ scripts/faddr2line vmlinux.5.16.0-rc7-1-mainline
page_cache_ra_unbounded+0x1d9/0x270
page_cache_ra_unbounded+0x1d9/0x270:
filemap_invalidate_unlock_shared at include/linux/fs.h:850
(inlined by) page_cache_ra_unbounded at mm/readahead.c:239
