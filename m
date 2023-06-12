Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2CC72CDB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjFLSS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjFLSS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:18:57 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776C196
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:18:56 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-777ab76f328so460031739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593936; x=1689185936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNVjzsp4Q/R2CWTBkS3HkSnT+cmZY3d7Ck+YqHTxaQ4=;
        b=QWBl1l2vQFGABTnfG3Mm3k0ikTIh+WBHgfS1RuVguC9UZU+ooscM9026hTbBKCwJ6W
         BcE6YJtktLWCGTQfkGxoc/KimgWNKBGPhueaeazuvH0g0cr69JWikQzfM2P0/1fjzl7b
         q8eUyThNXQMjWahKywOfvSj08VjPeL6T/n2sRCN+EIJZkOfzk5DNkJQ1am68oiMwah49
         upqLhj4u8gAvJMWiUrQclDlzZYXHoUTRQ5WQh2HEfBplPrLUCmBmq7i7FFH1BGkQvkS7
         mRI4Ej9/LlpLP1ppNwiMIRGhAAjaap6Kdl69uFUlylzmdthXBrUIQxHnO+sdjTNnAzas
         2KzA==
X-Gm-Message-State: AC+VfDwATlMkpPJDVWOputa3PJ9UApdFtsom3JdDgbL/xFZ+0vImoBV8
        glKtMHu2t0e9TQ7bCacYc3biRzbvtCS7ySUgvxecDH51MeAi
X-Google-Smtp-Source: ACHHUZ48aJTTbei/IPjlSAzi7Oev8nrti4c/FPklaMEgFKL6RI2JOZdjcLwEfJQUPCHWd9fcQuqZV5tLv1kW0hU+JWnSVlPCnyWW
MIME-Version: 1.0
X-Received: by 2002:a5e:c10c:0:b0:77a:c494:b4b8 with SMTP id
 v12-20020a5ec10c000000b0077ac494b4b8mr4397762iol.1.1686593936274; Mon, 12 Jun
 2023 11:18:56 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:18:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073c14105fdf2c0f0@google.com>
Subject: [syzbot] [udf?] WARNING in udf_setsize (2)
From:   syzbot <syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5f63595ebd82 Merge tag 'input-for-v6.4-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1667baf1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d12b9e46ffe8/disk-5f63595e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9044ded7edd/vmlinux-5f63595e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09f0fd3926e8/bzImage-5f63595e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8731 at fs/udf/inode.c:673 udf_setsize+0x1092/0x1480 fs/udf/inode.c:1275
Modules linked in:
CPU: 1 PID: 8731 Comm: syz-executor.4 Not tainted 6.4.0-rc5-syzkaller-00024-g5f63595ebd82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:udf_extend_file fs/udf/inode.c:672 [inline]
RIP: 0010:udf_setsize+0x1092/0x1480 fs/udf/inode.c:1275
Code: 00 00 00 00 fc ff df 74 0a e8 4a fc 8c fe e9 18 ff ff ff 4c 89 64 24 20 e8 3b fc 8c fe 4c 89 fb e9 a7 fd ff ff e8 2e fc 8c fe <0f> 0b e9 1b f6 ff ff 44 89 f9 80 e1 07 38 c1 0f 8c 2b f0 ff ff 4c
RSP: 0018:ffffc90004fcfae0 EFLAGS: 00010293
RAX: ffffffff82fe8302 RBX: 0000000000000800 RCX: ffff888035f93b80
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000000800
RBP: ffffc90004fcfcd0 R08: ffffffff82fe7900 R09: ffffed100ea45358
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff920009f9f70
R13: 0000000000000751 R14: 0000000000000009 R15: 0000000000001000
FS:  00007f3365a37700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000000797b8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_setattr+0x370/0x540 fs/udf/file.c:239
 notify_change+0xc8b/0xf40 fs/attr.c:483
 do_truncate+0x220/0x300 fs/open.c:66
 do_sys_ftruncate+0x2e4/0x380 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3364c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3365a37168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f3364dac120 RCX: 00007f3364c8c169
RDX: 0000000000000000 RSI: 0000000000000751 RDI: 0000000000000004
RBP: 00007f3364ce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff6db1fcaf R14: 00007f3365a37300 R15: 0000000000022000
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
