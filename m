Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C82D7563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 13:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405895AbgLKMO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 07:14:28 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41778 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405843AbgLKMN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:13:59 -0500
Received: by mail-il1-f200.google.com with SMTP id f19so6925351ilk.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 04:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=trAsHS3H3DwMvQCSOWs0SnFO00Wxs6W+MX8Qz0q0h0Y=;
        b=bc6LsYWRJq90aqDVHMWt3Bl3hkUZ60pUfDEk+cobbIzDj0izKITQBSjaK8oIvdBEH4
         KGrAu3I0W6AJsHvmA3UQ4umg+yQ0SGc4mVBu7eHhgsz2aAuVq8vFwO83D6ZlOZWTxvBF
         CmkhhSHKkURiD5t3NV+xxdLsDg+C7UE13WbqpRt9o/3fpU0nlBRtrqB602uftni30bwX
         IchmLoAXOCjSSfiqG9BuIbEeOWf4piXBa1Eq+1+v5qHZhmLy4WOPcWwyh1AsSYKbZUAa
         f20l9KagW/vo4+h0v+FaM0OeqEMWfMHBtPbVWuICM21hvDA/yoxkk39bn9SdHWa1EXZH
         hdUA==
X-Gm-Message-State: AOAM533Ss6YtB+o4Hnw3Ef2RFWwCUgLI77fipn03fwhKyBUUYUo9npjf
        ILSa8dXlySA7+I61FR/qgVTd5R9hulEgKhUEIf8jZIiCx1VU
X-Google-Smtp-Source: ABdhPJw103nl5XZexMP/Dze6TbQjtTSh4v5ad2agj7aF7mBg8DKEPUECmme1q/0fnJVh1b+js7kUYzVzfymqz/pnetkd6cKyywK0
MIME-Version: 1.0
X-Received: by 2002:a02:23ce:: with SMTP id u197mr15323145jau.113.1607688797893;
 Fri, 11 Dec 2020 04:13:17 -0800 (PST)
Date:   Fri, 11 Dec 2020 04:13:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b53deb05b62f3777@google.com>
Subject: linux-next boot error: KASAN: global-out-of-bounds Read in fs_validate_description
From:   syzbot <syzbot+37dba74686ae4898e969@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3cc2bd44 Add linux-next specific files for 20201211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11627b13500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dbe20fdaa5aaebe
dashboard link: https://syzkaller.appspot.com/bug?extid=37dba74686ae4898e969
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37dba74686ae4898e969@syzkaller.appspotmail.com

FS-Cache: Loaded
CacheFiles: Loaded
TOMOYO: 2.6.0
Mandatory Access Control activated.
AppArmor: AppArmor Filesystem Enabled
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 327680 bytes, vmalloc)
TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc)
TCP: Hash tables configured (established 65536 bind 65536)
MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered protocol family 44
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000b5c00000-0x00000000b9c00000] (64MB)
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
kvm: already loaded the other module
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212735223b2, max_idle_ns: 440795277976 ns
clocksource: Switched to clocksource tsc
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
zbud: loaded
DLM installed
squashfs: version 4.0 (2009/01/31) Phillip Lougher
FS-Cache: Netfs 'nfs' registered for caching
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
FS-Cache: Netfs 'cifs' registered for caching
Key type cifs.spnego registered
Key type cifs.idmap registered
==================================================================
BUG: KASAN: global-out-of-bounds in fs_validate_description+0x1a5/0x1d0 fs/fs_parser.c:371
Read of size 8 at addr ffffffff899b8320 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc7-next-20201211-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 fs_validate_description+0x1a5/0x1d0 fs/fs_parser.c:371
 register_filesystem+0x78/0x320 fs/filesystems.c:78
 init_cifs+0x7a4/0x8cf fs/cifs/cifsfs.c:1609
 do_one_initcall+0x103/0x690 init/main.c:1220
 do_initcall_level init/main.c:1293 [inline]
 do_initcalls init/main.c:1309 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x600/0x684 init/main.c:1535
 kernel_init+0xe/0x1e0 init/main.c:1418
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the variable:
 smb3_fs_parameters+0xc60/0xf40

Memory state around the buggy address:
 ffffffff899b8200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff899b8280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff899b8300: 00 00 00 00 f9 f9 f9 f9 05 f9 f9 f9 f9 f9 f9 f9
                               ^
 ffffffff899b8380: 06 f9 f9 f9 f9 f9 f9 f9 06 f9 f9 f9 f9 f9 f9 f9
 ffffffff899b8400: 00 01 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
