Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B36EBC1E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 01:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDVXqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Apr 2023 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDVXqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Apr 2023 19:46:37 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E4268C
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Apr 2023 16:46:35 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-32aff212197so53906555ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Apr 2023 16:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682207194; x=1684799194;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk97rR7/vXImouur5vtnRKbmRDnRpfwYKx1WX5/3Z8s=;
        b=Uk6LT0g8j5MEp9Q/TNwzf3AAcSXwE26p/YPrXwl512rsg3Jhli3rQcv2UMM8Lx0KH6
         1f5BwpJZfOIOwRgYYApuFBkz334p0Ai2jQNx9a3bDg+XLvDegyzLV3dAnWqJA/DUJtmY
         2CRkfYHmBeW47I6lXQojcu1Ox/BitWWONr8djHUWvGuWrBcBnWIx9APblFMWKXMw/eus
         iP69jCAAsgNZmFS+vTwFbqeAoiri06XI99f1kJ9P92hALGXF33/Cf+MoxpQyJGzvZMsv
         m339Q6rjrQ0fIGK7Rn+Zcu16POoCgffXa+9zU0kU7kMZEAauqd6FQXOOMQTLrAMiESQ6
         DlZQ==
X-Gm-Message-State: AAQBX9cYyec0dgSBEcs9xvuuZCLX7VQ2FmJT6od3hCmFURxkyA/Rljms
        qbAyXq8r1TFN5rXT04HOIEENXll0Ij1e2LaTBZiJkef7kdyQ
X-Google-Smtp-Source: AKy350amD816Ko7C8FcW8O+eurgJ82Jp4CjRYp0bNV919Y91N0p9QW0WPZU4fRChKCARP4W37KLYX1J2OdZ3WrcObH4HpOVICmp3
MIME-Version: 1.0
X-Received: by 2002:a92:dc4c:0:b0:328:4e63:795f with SMTP id
 x12-20020a92dc4c000000b003284e63795fmr2235036ilq.0.1682207194336; Sat, 22 Apr
 2023 16:46:34 -0700 (PDT)
Date:   Sat, 22 Apr 2023 16:46:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041d47405f9f56290@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in scrub_handle_errored_block
From:   syzbot <syzbot+e19c41a2f26eccf41aab@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    af67688dca57 Merge tag 'mmc-v6.3-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f8020bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=e19c41a2f26eccf41aab
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaa3ac1127b4/disk-af67688d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02dd376f6bb3/vmlinux-af67688d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0162b8821f2f/bzImage-af67688d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e19c41a2f26eccf41aab@syzkaller.appspotmail.com

BTRFS warning (device loop5): tree block 5423104 mirror 1 has bad bytenr, has 0 want 5423104
assertion failed: 0, in fs/btrfs/scrub.c:614
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 17944 Comm: kworker/u4:18 Tainted: G      D            6.3.0-rc7-syzkaller-00043-gaf67688dca57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: btrfs-scrub scrub_bio_end_io_worker
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 2c 4c 43 f7 e9 50 fb ff ff e8 42 80 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 ef 2b 8b e8 68 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 a3 8b ed f6 48
RSP: 0018:ffffc900166a7638 EFLAGS: 00010246
RAX: 000000000000002c RBX: 0000000004248060 RCX: 8c5f616438692d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900166a7910 R08: ffffffff816df7fc R09: fffff52002cd4e41
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffc900166a7860
R13: ffff888030d3d000 R14: dffffc0000000000 R15: ffff88801cd20000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33342000 CR3: 0000000029ac2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_full_stripe fs/btrfs/scrub.c:614 [inline]
 scrub_handle_errored_block+0x1ee1/0x4730 fs/btrfs/scrub.c:1067
 scrub_bio_end_io_worker+0x9bb/0x1370 fs/btrfs/scrub.c:2559
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
