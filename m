Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEC733DCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 05:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFQDaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 23:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjFQD36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 23:29:58 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36191987
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 20:29:56 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77ade29e1easo136381039f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 20:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686972596; x=1689564596;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvdhhAyjIGqiW/2XaJEPMrzfoSJmUNIqvaXkqDku/uU=;
        b=iUJ36687hus/x8sFtN/4p+Q+PRffFFcGYWw2remAK9vkzTcBXt/UsLY238n4OxfjrV
         PfIYPK7hQrBMLGHQznXCd/fofqCZlfVHOgR4XChRe9tnJ8qCscXkJzukQEDCSLvMr3i5
         Pq8yuaNUphAFCUd5hMe5x12hgbu/FmDCzd1ZwwnnFI0IOYGKBVI24B+4dEpTbl9MQ7zu
         o8KBXauvNFxAqTKcrnBRFy2TmKxH53Y3FUSdeyhdz6ZZ0X/kCp54vp1nOS1p12V26Roq
         EKV7+njstybvDE/IKwv/WMXMjMYCzCGXJICCmWkbht+jDRMvZ4rfsrCovez+YJSrne3G
         xawQ==
X-Gm-Message-State: AC+VfDzCLz5MMwoOjl1NSVYK9SSQs5TJCjXCe3bZC+E0Rv+PU4AZBqUX
        /lYr1PTcEpivA+qNkA+C0NEFtWSannqEumslguPp7iktv/Ph
X-Google-Smtp-Source: ACHHUZ5Lvop51/XvhgL85KDAnkiM7HfyEFYyPSR/+02iWPT6gpvtZyMS/y1rH3DnCBq3enf5SkVXwAhh/FVTnlXsK1JSuzcnRktZ
MIME-Version: 1.0
X-Received: by 2002:a02:a1dc:0:b0:423:1ab9:c57e with SMTP id
 o28-20020a02a1dc000000b004231ab9c57emr865646jah.6.1686972596130; Fri, 16 Jun
 2023 20:29:56 -0700 (PDT)
Date:   Fri, 16 Jun 2023 20:29:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005697bd05fe4aea49@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
From:   syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d745dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=307da6ca5cb0d01d581a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9503 at fs/ext4/inode.c:3326 ext4_iomap_begin+0x1ae/0x7a0 fs/ext4/inode.c:3326
Modules linked in:
CPU: 1 PID: 9503 Comm: syz-executor.1 Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:ext4_iomap_begin+0x1ae/0x7a0 fs/ext4/inode.c:3326
Code: 83 c0 01 38 d0 7c 08 84 d2 0f 85 ee 05 00 00 41 0f b7 9f ba 05 00 00 31 ff 89 de e8 4c a5 57 ff 66 85 db 74 5c e8 42 a9 57 ff <0f> 0b 41 bd de ff ff ff e8 35 a9 57 ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90006a1f560 EFLAGS: 00010216
RAX: 000000000002ebb2 RBX: 00000000000000a4 RCX: ffffc90004103000
RDX: 0000000000040000 RSI: ffffffff822c7a6e RDI: 0000000000000003
RBP: 0000000000000080 R08: 0000000000000003 R09: 0000000000000000
R10: 00000000000000a4 R11: 0000000000094001 R12: 000000000000000b
R13: ffff88803f00bf7a R14: ffffc90006a1f838 R15: ffff88803f00beb0
FS:  00007f3cc037b700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000008f1f7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x446/0x10e0 fs/iomap/iter.c:91
 __iomap_dio_rw+0x7a5/0x1f90 fs/iomap/direct-io.c:597
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:688
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:419
 do_splice_to+0x1b9/0x240 fs/splice.c:902
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:973
 do_splice_direct+0x1ab/0x280 fs/splice.c:1082
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3cbf68c199
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3cc037b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f3cbf7abf80 RCX: 00007f3cbf68c199
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f3cbf6e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffebb26bb1f R14: 00007f3cc037b300 R15: 0000000000022000
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
