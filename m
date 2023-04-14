Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF116E2B09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 22:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNUTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDNUTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:19:53 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B176A6F
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 13:19:50 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id d20-20020a056e020c1400b003261821bf26so5092321ile.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 13:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503590; x=1684095590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZJFh2lneSO2O2apuZY38a9QpaHYW44PXRNeRva/kLA=;
        b=dB76uK8hTJnHg04qrLea3eM91wonOP5aOybfY7cvL6Xh00kwS6tyyjC9wXx2n7nzvw
         YPZbjmbvzLBRHJ2LGsPo2lVnJjtgzpvp73XWO1hw73r7cg4TCkyeb+A5tCe0V8bJtiV4
         Orby9mYI3sFaXAouZfuApGCfwZEE+DrPUIFKzqxeMXVC22hnrLopGg4rFvfF+a1tbFfx
         KUxXuk9yoLR2Dl9B7GZ+QZKPmIH9xXU+9znHpiLY5rmxpjPE+0VpIrjbYNbw10AaCoK6
         cblQCFshRiSxG1n3Q4kAGotKXDMe2LrLQDTwzh1zucytTPEA28KIxuQ9z02waQpyToYA
         YYDA==
X-Gm-Message-State: AAQBX9e8QgXpeXgKGf7+IVLkyi5xvm+OLG5uZpES5XVXMRNhUoxJfs7+
        nhFfpHuDkQIrCxjfLM9a4e21EMqwSSfdY2bC13cZWnlE0j4L
X-Google-Smtp-Source: AKy350buB1FR3HC2W63OvVvWcogrZGb23vOC1mxQwtrXgZDnuMfzHNlsggYdBDoairXrtR01lwqfLiJilwpTBHRA6lLEXVhJrrbA
MIME-Version: 1.0
X-Received: by 2002:a02:624d:0:b0:406:5e9b:87bd with SMTP id
 d74-20020a02624d000000b004065e9b87bdmr2681488jac.2.1681503590185; Fri, 14 Apr
 2023 13:19:50 -0700 (PDT)
Date:   Fri, 14 Apr 2023 13:19:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e88ef05f9519048@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_remove_ordered_extent
From:   syzbot <syzbot+f7df8841df368e155864@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    09a9639e56c0 Linux 6.3-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16491af9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=f7df8841df368e155864
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/322ee98e9b51/disk-09a9639e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7f428bb61b7/vmlinux-09a9639e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c3310bcdc76/bzImage-09a9639e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7df8841df368e155864@syzkaller.appspotmail.com

assertion failed: trans, in fs/btrfs/ordered-data.c:586
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 17716 Comm: kworker/u4:17 Not tainted 6.3.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 2c 6c 43 f7 e9 50 fb ff ff e8 42 80 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 ee 2b 8b e8 e8 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 a3 ab ed f6 48
RSP: 0018:ffffc900163ef998 EFLAGS: 00010246
RAX: 0000000000000037 RBX: ffff88802c25c538 RCX: 34a4a5ce511e7800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816df7fc R09: fffff52002c7deed
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802c25cc10
R13: ffff88802c25c000 R14: ffff88802bad71f0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f900f261000 CR3: 000000000cd30000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_remove_ordered_extent+0x7f0/0x9b0 fs/btrfs/ordered-data.c:586
 btrfs_finish_ordered_io+0x153e/0x1cc0 fs/btrfs/inode.c:3328
 btrfs_work_helper+0x380/0xbe0 fs/btrfs/async-thread.c:280
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 2c 6c 43 f7 e9 50 fb ff ff e8 42 80 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 ee 2b 8b e8 e8 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 a3 ab ed f6 48
RSP: 0018:ffffc900163ef998 EFLAGS: 00010246
RAX: 0000000000000037 RBX: ffff88802c25c538 RCX: 34a4a5ce511e7800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816df7fc R09: fffff52002c7deed
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802c25cc10
R13: ffff88802c25c000 R14: ffff88802bad71f0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa101bad988 CR3: 00000000323b9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
