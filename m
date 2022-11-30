Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1163D185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 10:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiK3JRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 04:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiK3JRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:17:38 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296E26C5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 01:17:35 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id n10-20020a056e02140a00b00302aa23f73fso14864372ilo.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 01:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zphegq90GW1x9G8vrnMaANEk0Gmkp3erLONgtZDYO0=;
        b=ttjdnh6dcQ+Bj20APG3OpQKts25l5rgqEHv9DV8zUp5a8J/teOy8+eg9K8qXgXxr3A
         wgVzY9VglWibD2/LAZOLa/YFVRxnTwIoONYR9vzZMJCvEFYPNUr+Ym5pY0USGvzoMa/w
         4OrkAhJH1j2n4vk/dYtIpEMt1VV30cvrqTZYWa/JfGnF/hdPWrmZmzydH9hGsdarhCRi
         VRXHAFmAdB+QPhkFIckXBlw2lIBX/pTfNFXj5eMJuV9xltRGOtwkbXlKgMriNSncq2bY
         eqf8Dg+qz1pAbRWA8Un+nGlCB9xPsCWqsy8eQ/zoFWsCEydBCoCHvewqJCmlSxezhKH3
         xdDQ==
X-Gm-Message-State: ANoB5plJFKOJVuh8WjslNeAU0ZpxzdeT0cD5s6nmZtbh9GQ0/bvxQBud
        Bqy/3tS3uLRD7ovpNMrrMfefPTWWYKc3B7gdt0bDf0xQqjUl
X-Google-Smtp-Source: AA0mqf7tfi02Qx8uj7wciiDDsiTC1DMXgJn9QUXyX1nR2F0HHMXoiZAgRlcowV4pwedZ4qg9inLJ/HiiLatuC+3veGO00AMd5x9m
MIME-Version: 1.0
X-Received: by 2002:a92:ad0c:0:b0:302:e073:6149 with SMTP id
 w12-20020a92ad0c000000b00302e0736149mr16194154ilh.241.1669799855116; Wed, 30
 Nov 2022 01:17:35 -0800 (PST)
Date:   Wed, 30 Nov 2022 01:17:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d6f905eeac935e@google.com>
Subject: [syzbot] kernel BUG in hfs_bnode_unhash
From:   syzbot <syzbot+b7ceb040f7552ed64dc9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    01f856ae6d0c Merge tag 'net-6.1-rc8-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1136a06b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=b7ceb040f7552ed64dc9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5428d604f56a/disk-01f856ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e953d290d254/vmlinux-01f856ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f71610a4904/bzImage-01f856ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7ceb040f7552ed64dc9@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/hfs/bnode.c:310!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27750 Comm: syz-executor.3 Not tainted 6.1.0-rc7-syzkaller-00101-g01f856ae6d0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfs_bnode_unhash+0x155/0x160 fs/hfs/bnode.c:310
Code: ff ff 48 89 df e8 4b 8e 80 ff e9 17 ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 7c c6 48 89 df e8 32 8e 80 ff eb bc e8 3b 72 2c ff <0f> 0b 66 0f 1f 84 00 00 00 00 00 53 48 89 fb e8 27 72 2c ff 48 85
RSP: 0018:ffffc900033cf2a8 EFLAGS: 00010246
RAX: ffffffff825e25b5 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000d24b000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100e8b5428 R08: ffffffff825f3bb7 R09: ffffed1028a44c51
R10: ffffed1028a44c51 R11: 1ffff11028a44c50 R12: dffffc0000000000
R13: ffff8880745aa140 R14: ffff888145226200 R15: 0000000000000004
FS:  00007f33db891700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556f50848 CR3: 0000000027323000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfs_release_folio+0x34c/0x530 fs/hfs/inode.c:122
 fallback_migrate_folio+0x196/0x3e0 mm/migrate.c:909
 move_to_new_folio+0x259/0xd80 mm/migrate.c:951
 __unmap_and_move+0x6b6/0xeb0 mm/migrate.c:1112
 unmap_and_move+0x39a/0x1090 mm/migrate.c:1184
 migrate_pages+0x572/0x1450 mm/migrate.c:1461
 compact_zone+0x282e/0x3770 mm/compaction.c:2421
 compact_node+0x279/0x610 mm/compaction.c:2703
 compact_nodes mm/compaction.c:2719 [inline]
 sysctl_compaction_handler+0xa8/0x140 mm/compaction.c:2761
 proc_sys_call_handler+0x576/0x890 fs/proc/proc_sysctl.c:604
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f33daa8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f33db891168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f33dababf80 RCX: 00007f33daa8c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f33daae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe0f1fd16f R14: 00007f33db891300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_bnode_unhash+0x155/0x160 fs/hfs/bnode.c:310
Code: ff ff 48 89 df e8 4b 8e 80 ff e9 17 ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 7c c6 48 89 df e8 32 8e 80 ff eb bc e8 3b 72 2c ff <0f> 0b 66 0f 1f 84 00 00 00 00 00 53 48 89 fb e8 27 72 2c ff 48 85
RSP: 0018:ffffc900033cf2a8 EFLAGS: 00010246
RAX: ffffffff825e25b5 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000d24b000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100e8b5428 R08: ffffffff825f3bb7 R09: ffffed1028a44c51
R10: ffffed1028a44c51 R11: 1ffff11028a44c50 R12: dffffc0000000000
R13: ffff8880745aa140 R14: ffff888145226200 R15: 0000000000000004
FS:  00007f33db891700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556f50848 CR3: 0000000027323000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
