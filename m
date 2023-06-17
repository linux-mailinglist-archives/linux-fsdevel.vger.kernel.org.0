Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F7733FA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbjFQI2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbjFQI2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:28:05 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30DE1FFE
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 01:28:03 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77ad4f28a23so145000839f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686990483; x=1689582483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v7zJpbVn4pQlwVyeTR+IJ1KhBxmoUGydBGoDXqtT5s=;
        b=MfYse1sYjeQzf7WD5J3vAd/ZTOo6l7Dx22lOS4UgpkkmgFrwhMLncgLq8IlmtDMJRi
         XBSktLMaUuMLqLreXq3OreSBLNmNTXG/R/goUskjp4DTrfa8alz9EtajA6QjaI8uFkAT
         30l3nx5+L6hfEet6Tp857ojLIQ8AVdSB5mYdZBSrKoVpUFE/qqL3xewYMMVWUbn+uMN5
         p0nhVnlgM1LxeEAGqIIj2+fqKRQIUeXuP8RBUeUVfST//3em4wcE9WpgXa7IJJtPIvPP
         sg5ZpJVAXTLyehD4/Gbo+307VTWgI7D27SgUMmikQFJsLSOYyFuPjKGFfg1uQo3cJIZS
         cVBw==
X-Gm-Message-State: AC+VfDyW7M/i+7+a3xSA7U9lkqhguv4ST2zf+rL261Xjtvk7t9+VuzW1
        +aFwFXXdL5l2fvrAdWWLoR6/gkHAqWFPyKxhhxQv4ibV6mWA
X-Google-Smtp-Source: ACHHUZ6Acvbd1grZxHyWovYYNSTF9JTF7UqexvA3cF4TMD1kndKcZa0E387aHMcLolyKEKkfGEtz7tkfxtTTvg7hnGEbFjeumhKv
MIME-Version: 1.0
X-Received: by 2002:a92:cac8:0:b0:33b:f9b5:d6c2 with SMTP id
 m8-20020a92cac8000000b0033bf9b5d6c2mr1100973ilq.5.1686990483333; Sat, 17 Jun
 2023 01:28:03 -0700 (PDT)
Date:   Sat, 17 Jun 2023 01:28:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007faf0005fe4f14b9@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_file_write_iter
From:   syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>
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

HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144c7b07280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bcbee03439/disk-f7efed9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fd295caa4de/vmlinux-f7efed9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69c038a34b5f/bzImage-f7efed9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 17447 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
WARNING: CPU: 1 PID: 17447 at fs/ext4/file.c:611 ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
Modules linked in:
CPU: 1 PID: 17447 Comm: syz-executor.2 Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:ext4_dio_write_iter fs/ext4/file.c:611 [inline]
RIP: 0010:ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
Code: 84 03 00 00 48 8b 04 24 31 ff 8b 40 20 89 c3 89 44 24 10 83 e3 08 89 de e8 bd 5e 5b ff 85 db 0f 85 d5 fc ff ff e8 90 62 5b ff <0f> 0b e9 c9 fc ff ff e8 84 62 5b ff 48 8b 4c 24 40 4c 89 fa 4c 89
RSP: 0018:ffffc9000bc5f9e8 EFLAGS: 00010216
RAX: 000000000003523a RBX: 0000000000000000 RCX: ffffc9000b3d9000
RDX: 0000000000040000 RSI: ffffffff8228ff90 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a832160
R13: 0000000000000000 R14: 0000000000000000 R15: fffffffffffffff5
FS:  00007f129f62e700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020105000 CR3: 0000000044e0d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 call_write_iter include/linux/fs.h:1871 [inline]
 aio_write+0x350/0x7d0 fs/aio.c:1596
 __io_submit_one fs/aio.c:1968 [inline]
 io_submit_one+0xf4c/0x1c50 fs/aio.c:2015
 __do_sys_io_submit fs/aio.c:2074 [inline]
 __se_sys_io_submit fs/aio.c:2044 [inline]
 __x64_sys_io_submit+0x190/0x320 fs/aio.c:2044
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f129e88c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f129f62e168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f129e9abf80 RCX: 00007f129e88c389
RDX: 0000000020000780 RSI: 0000000000000001 RDI: 00007f129f5e4000
RBP: 00007f129e8d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd72c552f R14: 00007f129f62e300 R15: 0000000000022000
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
