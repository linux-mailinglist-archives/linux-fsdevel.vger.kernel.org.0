Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6C7363A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFTGeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 02:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjFTGes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:34:48 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174510DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 23:34:47 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77a0fd9d2eeso351235639f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 23:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687242887; x=1689834887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=We8YE5EQAIFaYQr+MuMXLwd+wbKERUdwgznUFduzeu4=;
        b=POS3CnTRNUqKYSn0k7bN4hgSOGM5QI7o2ZPVSsGvqfP+ADmE9CXKZfW5G7HdzyH8NN
         oAo4fjvxCw+5EGap6tB5ab4J7JqLFI1gTO4jrS4NrfPycG/dQJ3xbwlnVFBPxzVeDyoU
         1VqV+o7PDT/5wAEwwq1dF+l7sWuMPAdICvxuGdQOD4FVkrkYRYUnbDCGQVdtU8EY4iWE
         x88vFWxGDYIvjy4zItYb1hc80vutYPo/z2fWjdco0uYMRX5x207YcQtbcgVG/L05zIqU
         KdzSzEh9qsK+z9+dHC1z8fePgiGvfdMiXlqnPJoJ9uaAbhL/wJw9QgVHWJoT1tJIg38t
         DEoQ==
X-Gm-Message-State: AC+VfDwKmch4O3dSIPEa2moBl5AEjfqEp0zigh1KCA3/77GtoCy2d+yS
        ynRyvvXpUfGxM0yMyNW1L04eCBHxMGjNW9a90tMCzhYXUU/6
X-Google-Smtp-Source: ACHHUZ4/vE6+hr+shvKp1owmc/f//ZyGYFWQ9XOqR9wpJfYctdNNESalvhfzYzAyQMzMSQ/DGOACTqJ/inT08ZKX8hiMuatP/Z+W
MIME-Version: 1.0
X-Received: by 2002:a05:6638:111c:b0:423:13e1:8092 with SMTP id
 n28-20020a056638111c00b0042313e18092mr3056182jal.5.1687242886913; Mon, 19 Jun
 2023 23:34:46 -0700 (PDT)
Date:   Mon, 19 Jun 2023 23:34:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eca59805fe89d845@google.com>
Subject: [syzbot] [udf?] WARNING in udf_rmdir
From:   syzbot <syzbot+a2437d95d06a2981a064@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    62d8779610bb Merge tag 'ext4_for_linus_stable' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141c82cf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=a2437d95d06a2981a064
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccba1c442e42/disk-62d87796.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/440c5fc50bd7/vmlinux-62d87796.xz
kernel image: https://storage.googleapis.com/syzbot-assets/868795f3b102/bzImage-62d87796.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2437d95d06a2981a064@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 950 at fs/udf/udfdecl.h:123 udf_add_fid_counter fs/udf/namei.c:350 [inline]
WARNING: CPU: 1 PID: 950 at fs/udf/udfdecl.h:123 udf_rmdir+0x7f5/0x8f0 fs/udf/namei.c:529
Modules linked in:
CPU: 1 PID: 950 Comm: syz-executor.3 Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_fid_counter fs/udf/namei.c:350 [inline]
RIP: 0010:udf_rmdir+0x7f5/0x8f0 fs/udf/namei.c:529
Code: fe 48 8d 9c 24 70 01 00 00 e9 4c fa ff ff e8 72 66 8b fe 4c 89 ef e8 0a bf 01 00 bb d9 ff ff ff e9 4e ff ff ff e8 5b 66 8b fe <0f> 0b e9 f2 fc ff ff 89 f9 80 e1 07 38 c1 0f 8c 30 f9 ff ff be 06
RSP: 0018:ffffc9000efdfb00 EFLAGS: 00010287
RAX: ffffffff83001945 RBX: 000000000d1c1470 RCX: 0000000000040000
RDX: ffffc90004243000 RSI: 0000000000002abd RDI: 0000000000002abe
RBP: ffffc9000efdfd98 R08: ffffffff83001631 R09: fffffbfff1cabb6e
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff11003f038cf
R13: ffff888038af401c R14: ffff88801f81c678 R15: dffffc0000000000
FS:  00007fd39ef2f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 0000000033b6f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_rmdir+0x35f/0x4c0 fs/namei.c:4198
 do_rmdir+0x3a7/0x6a0 fs/namei.c:4257
 __do_sys_rmdir fs/namei.c:4276 [inline]
 __se_sys_rmdir fs/namei.c:4274 [inline]
 __x64_sys_rmdir+0x49/0x50 fs/namei.c:4274
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd39e28c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd39ef2f168 EFLAGS: 00000246
 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007fd39e3abf80 RCX: 00007fd39e28c389
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000640
RBP: 00007fd39e2d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd527f4b7f R14: 00007fd39ef2f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
