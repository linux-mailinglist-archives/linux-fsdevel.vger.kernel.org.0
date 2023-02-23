Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDA6A0C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjBWOsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 09:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjBWOsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:48:37 -0500
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BAF4480
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 06:48:35 -0800 (PST)
Received: by mail-io1-f79.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so886210iog.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 06:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdyqgUyLnS+DvN208ai9ULnRy8DgSl0tKtszAhblEVw=;
        b=jY96rUW3brdf/SIRXJf71QtWM+qp5szRenYUMj8O7shlSXhJRtEEA/5O+Kr3fNvTU9
         l11RmAUtNc507DN9FaFC6k9YOqXcdRCpQhZdXyZl1zwyucGkF7Ql09b7wVhYFpf9bpw/
         3cDTKyK/ZDEb+DqgS4DF1DEiSijiFlZS5gGFF939mOSGHylh0rd2dSB2nLwAb85Rmz1v
         UXwus7GSvNhr28syPHvS7kiQOBSHvPV2gFM7ExZLhBLt205vZNwOqaYWVzPXnfSx3/bQ
         LU7LCqyK6z+JGQs2fRhIv0qaAgewCigILXb0VoOs/zAAnMZEmX0MOMOv7kxjUdbxtaux
         9GiA==
X-Gm-Message-State: AO0yUKWilm+Trl2mrtjV4PMJl88JEfja23D9gos1l/PwpUkyd/wxOXa+
        yaKSwgEkilosEOLLtM/dci1KxAHL+0ngN2d50GyqYZzJC4j+
X-Google-Smtp-Source: AK7set9rdXRBIruzOLSnLcI9hXWoQEK4Cadymx1Il+ZU/cwwzU4FyswkFmP8cUSPM+Uf2cdqi4KtB3AX8Rr1gTUh9bb9/TSWxgcN
MIME-Version: 1.0
X-Received: by 2002:a6b:c8cf:0:b0:71b:8c6:6123 with SMTP id
 y198-20020a6bc8cf000000b0071b08c66123mr637694iof.3.1677163714465; Thu, 23 Feb
 2023 06:48:34 -0800 (PST)
Date:   Thu, 23 Feb 2023 06:48:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e541a05f55f1b06@google.com>
Subject: [syzbot] [ntfs?] kernel BUG in ntfs_malloc_nofs
From:   syzbot <syzbot+6cbda114570e858851b7@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0136d86b7852 Merge tag 'block-6.2-2023-02-03' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1491dc8d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de1f4b1f70af0b59
dashboard link: https://syzkaller.appspot.com/bug?extid=6cbda114570e858851b7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c63dfadfcd7e/disk-0136d86b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a5df54d745a/vmlinux-0136d86b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8a388fa8486/bzImage-0136d86b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cbda114570e858851b7@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/malloc.h:31!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24702 Comm: syz-executor.0 Not tainted 6.2.0-rc6-syzkaller-00239-g0136d86b7852 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:ntfs_malloc_nofs+0xfd/0x100
Code: 17 e8 97 a9 ca fe 48 89 df be 42 0c 00 00 5b 41 5e 41 5f e9 a5 7c 11 ff e8 80 a9 ca fe 31 c0 5b 41 5e 41 5f c3 e8 73 a9 ca fe <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 49 89 fe 49 bc
RSP: 0018:ffffc9001253f820 EFLAGS: 00010287
RAX: ffffffff82bf8d9d RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900042e1000 RSI: 000000000000c21c RDI: 000000000000c21d
RBP: dffffc0000000000 R08: ffffffff82bf8ccd R09: ffffed10116c7a5b
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88808b63d2d0
R13: ffff88808b63d5a0 R14: 1ffff110116c7a88 R15: 1ffff1101302e191
FS:  00007fdebddd5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2683f0a000 CR3: 0000000032300000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_read_locked_inode+0x1fae/0x4a50
 ntfs_iget+0x113/0x190
 load_system_files+0x248d/0x4740
 ntfs_fill_super+0x19b4/0x2bd0
 mount_bdev+0x271/0x3a0
 legacy_get_tree+0xef/0x190
 vfs_get_tree+0x8c/0x270
 do_new_mount+0x28f/0xae0
 __se_sys_mount+0x2c9/0x3b0
 do_syscall_64+0x41/0xc0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdebd08d5fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdebddd4f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001e70f RCX: 00007fdebd08d5fa
RDX: 0000000020000080 RSI: 0000000020000000 RDI: 00007fdebddd4fe0
RBP: 00007fdebddd5020 R08: 00007fdebddd5020 R09: 0000000000000005
R10: 0000000000000005 R11: 0000000000000202 R12: 0000000020000080
R13: 0000000020000000 R14: 00007fdebddd4fe0 R15: 0000000020001400
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_malloc_nofs+0xfd/0x100
Code: 17 e8 97 a9 ca fe 48 89 df be 42 0c 00 00 5b 41 5e 41 5f e9 a5 7c 11 ff e8 80 a9 ca fe 31 c0 5b 41 5e 41 5f c3 e8 73 a9 ca fe <0f> 0b 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 53 49 89 fe 49 bc
RSP: 0018:ffffc9001253f820 EFLAGS: 00010287
RAX: ffffffff82bf8d9d RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900042e1000 RSI: 000000000000c21c RDI: 000000000000c21d
RBP: dffffc0000000000 R08: ffffffff82bf8ccd R09: ffffed10116c7a5b
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88808b63d2d0
R13: ffff88808b63d5a0 R14: 1ffff110116c7a88 R15: 1ffff1101302e191
FS:  00007fdebddd5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f591d1a8000 CR3: 0000000032300000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
