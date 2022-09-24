Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9EE5E89EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiIXIPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiIXINV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:13:21 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3CD33CD
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 01:10:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so1208887ioa.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 01:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yvBPMshcz/kWE8Vw7kHmZiN4GCHCWCuh24HP66lZfVM=;
        b=KKsmCtfJwiW/Rj0xmRc0hPPn87WNnk8b5nBmTe+a7YQTfghCVV9Y9HS09UAMk101im
         nvD+QEJNG3W5U1K9u981qHOV1EDqhfEh57XvuPWG57pEIe24CmjoMqETVDAPjouceVOQ
         bA0xqKW2fNTueyN+gFLFoVIV6iEg9QS5VV3MxSvfqOuCz89VA4JcQ2hKcmRnjBqoKMEw
         i2/qni30/gv/dnJeKXB5Ph1jUDGMmzaB/+l1boemqNB9OGkdPwAO3eYk7W+FuByde1AP
         xPvAx5IDMYYYAD160Y4qI/vF9wvpWQartTnU3BYXIvNWI32YanIg5TOQRGVHYwcBusDy
         FDKQ==
X-Gm-Message-State: ACrzQf1W/BIv43a9gQF7s5y6fVNlHP1y4ttaajnh0yjIE5ftMY6MRtrn
        6hhiryxJyFzgtnE89CJRjb/pl3fJv99YBEgXDziK7PhZSY9d
X-Google-Smtp-Source: AMsMyM7CAtqrAy9GVe0W8ayLWn3ZmJUJ4/EJf0NWqoqB1mRuIwWq7418bQ156QC86cfDD/yo+HrUqGT2NeAbNc9h92VNUDzXj64e
MIME-Version: 1.0
X-Received: by 2002:a02:94ea:0:b0:35b:25e2:c57d with SMTP id
 x97-20020a0294ea000000b0035b25e2c57dmr6723905jah.22.1664006918150; Sat, 24
 Sep 2022 01:08:38 -0700 (PDT)
Date:   Sat, 24 Sep 2022 01:08:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042a5d005e967cd34@google.com>
Subject: [syzbot] invalid opcode in writeback_single_inode
From:   syzbot <syzbot+15cb24a539075fc4c472@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e8dd5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7db7ad17eb14cb7
dashboard link: https://syzkaller.appspot.com/bug?extid=15cb24a539075fc4c472
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/853950e33581/disk-dc164f4f.raw.xz
vmlinux: https://storage.googleapis.com/1359f09c5a19/vmlinux-dc164f4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15cb24a539075fc4c472@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 8189
ntfs3: loop5: Different NTFS' sector size (1024) and media sector size (512)
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11292 Comm: syz-executor.5 Not tainted 6.0.0-rc6-syzkaller-00045-gdc164f4fb00a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
RIP: 0010:spin_lock include/linux/spinlock.h:349 [inline]
RIP: 0010:writeback_single_inode+0x2e/0x4c0 fs/fs-writeback.c:1676
Code: 41 55 41 54 49 89 f4 55 48 89 fd 53 4c 8d b5 88 00 00 00 4c 8d ad 08 02 00 00 48 83 ec 08 e8 b9 12 99 ff 4c 89 f7 e8 31 f0 a0 <07> be 04 00 00 00 4c 89 ef e8 94 b3 e4 ff 4c 89 ea 48 b8 00 00 00
RSP: 0018:ffffc90004dd7a10 EFLAGS: 00010292
RAX: 0000000000000000 RBX: 1ffff920009baf4b RCX: ffffffff815f1e80
RDX: 1ffff11006c6606d RSI: 0000000000000004 RDI: ffffc90004dd79a0
RBP: ffff8880363302d0 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520009baf34 R11: 0000000000000000 R12: ffffc90004dd7a88
R13: ffff8880363304d8 R14: ffff888036330358 R15: ffff8880363303a8
FS:  00007efc6583b700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020075000 CR3: 000000001d8c1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode_now+0x16a/0x1e0 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x45b/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efc6468bb9a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc6583af88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007efc6468bb9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007efc6583afe0
RBP: 00007efc6583b020 R08: 00007efc6583b020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007efc6583afe0 R15: 000000002007c6a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:spin_lock include/linux/spinlock.h:349 [inline]
RIP: 0010:writeback_single_inode+0x2e/0x4c0 fs/fs-writeback.c:1676
Code: 41 55 41 54 49 89 f4 55 48 89 fd 53 4c 8d b5 88 00 00 00 4c 8d ad 08 02 00 00 48 83 ec 08 e8 b9 12 99 ff 4c 89 f7 e8 31 f0 a0 <07> be 04 00 00 00 4c 89 ef e8 94 b3 e4 ff 4c 89 ea 48 b8 00 00 00
RSP: 0018:ffffc90004dd7a10 EFLAGS: 00010292
RAX: 0000000000000000 RBX: 1ffff920009baf4b RCX: ffffffff815f1e80
RDX: 1ffff11006c6606d RSI: 0000000000000004 RDI: ffffc90004dd79a0
RBP: ffff8880363302d0 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520009baf34 R11: 0000000000000000 R12: ffffc90004dd7a88
R13: ffff8880363304d8 R14: ffff888036330358 R15: ffff8880363303a8
FS:  00007efc6583b700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020075000 CR3: 000000001d8c1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
