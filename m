Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857A111A344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 05:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLKEAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 23:00:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53864 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKEAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:00:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so5475715wmd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 20:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=AylCe3uf0dy4Ysfu7bokSNgpZR9l9aXnMG5BnfzzcdE=;
        b=0jZJXjhS8vG9VIIrOp0si6GpSJdARm7VLvoQLHP2rQunFK2WdU0w4FyQF9AX+9FNWj
         ed4YtIfEkAtwfamwRO7zrjlwWvfVg5Unz7BrkJv4XuoLXzmKACWbSkWmqH3xt9jPACGB
         LWwYQp0cYgXEoaZrC5pG1fIUZzMAWz81KzdSjW7xBIvwQ2Y+ZfVxgd9HQrc79Zx1kxhS
         S+R66nPLQ5yEsL2d/r7tMzkiTDYplxyTiGJafUfZIVFg6tcfhZk82r70U2LbGcj6Y2Ty
         HrQGMfKcMyD22U4QGo7+pYIaLo7CIATSvs+mUP1EcNZ8sTlH2Z9kZ8S/TrAtjTk6JGnD
         dkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AylCe3uf0dy4Ysfu7bokSNgpZR9l9aXnMG5BnfzzcdE=;
        b=ATkD2RfI9uTPl/7iXegsdOmf0+V8U+6iet39jNf9eRrdE+U9OwPka5GM0A0GVKwudA
         6ep4kH7MuXbppX7XhK9QXKcfpqpzaRCQ+dDEi2Kr2zLTzVeJfd3DSwSetbppOpraBEO4
         niYEsP7CRkTO6StzikoWMSTaY9sW4v35BufPtgjtDMQWxUKDjyOn26W47SQ+MaMoCACf
         XVZiVy+q0JO/I2uwxE+3otCP07Mve/CwchlzuYfBjxWHXCtxItbkKL1lJfPVJUoUq6tG
         mKm0qVHDv+SW++mnGvcHmQRdjo4FzdI+RNzNg55m78b4ALSJX2tbmJB9JvrfmD2WI9G1
         bKeA==
X-Gm-Message-State: APjAAAWs5YkKoj1U68IFHY2Qzlo+mV/bJP7XNP8jY5cUfwu4libCjxYS
        UrHZVJ2Z7BX8s9au/cyVdIPzVCYl1BugAZbFSjr3Dw==
X-Google-Smtp-Source: APXvYqzeDnHhrPKkGC95hCgvsQAYrzNrhqvEMWq4O3USrCNXtDsYa5bCuXckVA4meOT7ziajrP/x5eQj7U6FOgc8YsY=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr884187wmd.44.1576036830857;
 Tue, 10 Dec 2019 20:00:30 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Tue, 10 Dec 2019 21:00:14 -0700
Message-ID: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
Subject: 5.5.0-0.rc1 hang, could be zstd compression related
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Could continue to chat in one application, the desktop environment was
responsive, but no shells worked and I couldn't get to a tty and I
couldn't ssh into remotely. Looks like the journal has everything up
until I pressed and held down the power button.


/dev/nvme0n1p7 on / type btrfs
(rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=274,subvol=/root)

dmesg pretty
https://pastebin.com/pvG3ERnd

dmesg (likely MUA stomped)
[10224.184137] flap.local kernel: perf: interrupt took too long (2522
> 2500), lowering kernel.perf_event_max_sample_rate to 79000
[14712.698184] flap.local kernel: perf: interrupt took too long (3153
> 3152), lowering kernel.perf_event_max_sample_rate to 63000
[17903.211976] flap.local kernel: Lockdown: systemd-logind:
hibernation is restricted; see man kernel_lockdown.7
[22877.667177] flap.local kernel: BUG: kernel NULL pointer
dereference, address: 00000000000006c8
[22877.667182] flap.local kernel: #PF: supervisor read access in kernel mode
[22877.667184] flap.local kernel: #PF: error_code(0x0000) - not-present page
[22877.667187] flap.local kernel: PGD 0 P4D 0
[22877.667191] flap.local kernel: Oops: 0000 [#1] SMP PTI
[22877.667194] flap.local kernel: CPU: 2 PID: 14747 Comm: kworker/u8:7
Not tainted 5.5.0-0.rc1.git0.1.fc32.x86_64+debug #1
[22877.667196] flap.local kernel: Hardware name: HP HP Spectre
Notebook/81A0, BIOS F.43 04/16/2019
[22877.667226] flap.local kernel: Workqueue: btrfs-delalloc
btrfs_work_helper [btrfs]
[22877.667233] flap.local kernel: RIP:
0010:bio_associate_blkg_from_css+0x1c/0x3b0
[22877.667235] flap.local kernel: Code: 66 89 6b 14 c7 43 1c 01 00 00
00 5b 5d c3 0f 1f 44 00 00 41 55 41 54 49 89 f4 55 48 89 fd 53 48 8b
47 08 65 ff 05 ac 6f ab 7d <4c> 8b a8 c8 06 00 00 68 85 3e 56 82 31 f6
45 31 c9 45 31 c0 b9 02
[22877.667238] flap.local kernel: RSP: 0018:ffff971181fcfca8 EFLAGS: 00010282
[22877.667240] flap.local kernel: RAX: 0000000000000000 RBX:
ffff8b76697cd3c0 RCX: 0000000000000000
[22877.667243] flap.local kernel: RDX: 000000000000c000 RSI:
ffff8b73eeabc800 RDI: ffff8b76385055b0
[22877.667245] flap.local kernel: RBP: ffff8b76385055b0 R08:
ffff8b76385055b0 R09: ffff8b7634800900
[22877.667247] flap.local kernel: R10: 00000000001f5c60 R11:
0000000000000000 R12: ffff8b73eeabc800
[22877.667249] flap.local kernel: R13: ffff8b75fbbc2808 R14:
ffff8b766b000000 R15: ffff8b76385055b0
[22877.667251] flap.local kernel: FS:  0000000000000000(0000)
GS:ffff8b7676a00000(0000) knlGS:0000000000000000
[22877.667254] flap.local kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[22877.667256] flap.local kernel: CR2: 00000000000006c8 CR3:
0000000009612001 CR4: 00000000003606e0
[22877.667257] flap.local kernel: Call Trace:
[22877.667287] flap.local kernel:
btrfs_submit_compressed_write+0x117/0x360 [btrfs]
[22877.667310] flap.local kernel:  submit_compressed_extents+0x315/0x460 [btrfs]
[22877.667317] flap.local kernel:  ? find_held_lock+0x32/0x90
[22877.667321] flap.local kernel:  ? mark_held_locks+0x2d/0x80
[22877.667345] flap.local kernel:  btrfs_work_helper+0x148/0x5b0 [btrfs]
[22877.667352] flap.local kernel:  process_one_work+0x272/0x5a0
[22877.667359] flap.local kernel:  worker_thread+0x50/0x3b0
[22877.667365] flap.local kernel:  kthread+0x106/0x140
[22877.667368] flap.local kernel:  ? process_one_work+0x5a0/0x5a0
[22877.667371] flap.local kernel:  ? kthread_park+0x90/0x90
[22877.667376] flap.local kernel:  ret_from_fork+0x3a/0x50
[22877.667384] flap.local kernel: Modules linked in: hidp thunderbolt
uinput rfcomm ccm xt_CHECKSUM xt_MASQUERADE nf_nat_tftp
nf_conntrack_tftp tun bridge stp llc nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat iptable_mangle iptable_raw iptable_security
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter cmac
bnep x86_pkg_temp_thermal intel_powerclamp coretemp sunrpc kvm
snd_soc_skl iwlmvm snd_soc_hdac_hda mac80211 snd_hda_ext_core
snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
libarc4 iTCO_wdt iTCO_vendor_support mei_hdcp intel_rapl_msr iwlwifi
uvcvideo snd_hda_codec_hdmi irqbypass snd_soc_core
snd_hda_codec_conexant vfat snd_compress snd_hda_codec_generic
ac97_bus crct10dif_pclmul ledtrig_audio fat videobuf2_vmalloc
[22877.667461] flap.local kernel: CR2: 00000000000006c8
[22877.667464] flap.local kernel: ---[ end trace 833e6c4636dfc480 ]---
[22877.667468] flap.local kernel: RIP:
0010:bio_associate_blkg_from_css+0x1c/0x3b0
[22877.667471] flap.local kernel: Code: 66 89 6b 14 c7 43 1c 01 00 00
00 5b 5d c3 0f 1f 44 00 00 41 55 41 54 49 89 f4 55 48 89 fd 53 48 8b
47 08 65 ff 05 ac 6f ab 7d <4c> 8b a8 c8 06 00 00 68 85 3e 56 82 31 f6
45 31 c9 45 31 c0 b9 02
[22877.667473] flap.local kernel: RSP: 0018:ffff971181fcfca8 EFLAGS: 00010282
[22877.667475] flap.local kernel: RAX: 0000000000000000 RBX:
ffff8b76697cd3c0 RCX: 0000000000000000
[22877.667477] flap.local kernel: RDX: 000000000000c000 RSI:
ffff8b73eeabc800 RDI: ffff8b76385055b0
[22877.667479] flap.local kernel: RBP: ffff8b76385055b0 R08:
ffff8b76385055b0 R09: ffff8b7634800900
[22877.667481] flap.local kernel: R10: 00000000001f5c60 R11:
0000000000000000 R12: ffff8b73eeabc800
[22877.667483] flap.local kernel: R13: ffff8b75fbbc2808 R14:
ffff8b766b000000 R15: ffff8b76385055b0
[22877.667485] flap.local kernel: FS:  0000000000000000(0000)
GS:ffff8b7676a00000(0000) knlGS:0000000000000000
[22877.667487] flap.local kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[22877.667490] flap.local kernel: CR2: 00000000000006c8 CR3:
0000000009612001 CR4: 00000000003606e0
[22877.667493] flap.local kernel: BUG: sleeping function called from
invalid context at include/linux/percpu-rwsem.h:38
[22877.667496] flap.local kernel: in_atomic(): 1, irqs_disabled(): 1,
non_block: 0, pid: 14747, name: kworker/u8:7
[22877.667498] flap.local kernel: INFO: lockdep is turned off.
[22877.667500] flap.local kernel: irq event stamp: 136012
[22877.667504] flap.local kernel: hardirqs last  enabled at (136011):
[<ffffffff822b8e66>] __test_set_page_writeback+0x2c6/0x4e0
[22877.667509] flap.local kernel: hardirqs last disabled at (136012):
[<ffffffff820038d7>] trace_hardirqs_off_thunk+0x1a/0x1c
[22877.667532] flap.local kernel: softirqs last  enabled at (135852):
[<ffffffffc098c2a2>] zstd_put_workspace+0x82/0x160 [btrfs]
[22877.667553] flap.local kernel: softirqs last disabled at (135850):
[<ffffffffc098c23a>] zstd_put_workspace+0x1a/0x160 [btrfs]
[22877.667557] flap.local kernel: CPU: 2 PID: 14747 Comm: kworker/u8:7
Tainted: G      D           5.5.0-0.rc1.git0.1.fc32.x86_64+debug #1
[22877.667559] flap.local kernel: Hardware name: HP HP Spectre
Notebook/81A0, BIOS F.43 04/16/2019
[22877.667580] flap.local kernel: Workqueue: btrfs-delalloc
btrfs_work_helper [btrfs]
[22877.667582] flap.local kernel: Call Trace:
[22877.667587] flap.local kernel:  dump_stack+0x8f/0xd0
[22877.667592] flap.local kernel:  ___might_sleep.cold+0xb3/0xc3
[22877.667596] flap.local kernel:  exit_signals+0x30/0x2d0
[22877.667600] flap.local kernel:  do_exit+0xc1/0xcd0
[22877.667605] flap.local kernel:  ? kthread+0x106/0x140
[22877.667610] flap.local kernel:  rewind_stack_do_exit+0x17/0x20
[22877.667618] flap.local kernel: note: kworker/u8:7[14747] exited
with preempt_count 1
[23112.137098] flap.local kernel: psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
[23112.138141] flap.local kernel: psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
[23112.139241] flap.local kernel: psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
[23112.140272] flap.local kernel: psmouse serio1: TouchPad at
isa0060/serio1/input0 lost sync at byte 1
[23112.151582] flap.local kernel: psmouse serio1: TouchPad at
isa0060/serio1/input0 - driver resynced.
[24074.296721] flap.local kernel: perf: interrupt took too long (3944
> 3941), lowering kernel.perf_event_max_sample_rate to 50000
[25580.723981] flap.local kernel: Lockdown: systemd-logind:
hibernation is restricted; see man kernel_lockdown.7
[25589.124775] flap.local kernel: hp_wmi: Unknown event_id - 131073 - 0x0
[chris@flap ~]$


dmesg full
https://drive.google.com/open?id=1mZlSn0N6rVwLpr42EtQbF1qrggQ0ygfF




-- 
Chris Murphy
