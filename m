Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBC743A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjF3LNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjF3LNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:13:05 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C93C1D
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 04:12:47 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-666ecb21fb8so1702695b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 04:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688123567; x=1690715567;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAJOvZGIMDeg8LkbOvx+dt/UAJ1Ssgr5c9E39fkVVv0=;
        b=VYC5cJB6lgrajvwL/aQB58uYzP8iskznR/HFHr5ic5JgBckxS5I6wA5aTkcEai8YHE
         EXYo99We83xxbALHqFtnarhr9Se2UEN10G27mhCHDQgjt3569HLleJbtNUcojIOfeC2m
         Mr8+Yns3ESEVIz7GFNiFidsdFUp0MfwRiknfXXllvodFLBlNkclDyve1GcV3A9Qla2IK
         H1M0GvpXifflw5VHtVxSLeS3Xwss5c1vPjKr3Sbu0HM4190lG8EG+/+khDa/pFfnqxpd
         UC5DbpA36xQPZHsQmtQIeA+boOefj0hmk/wMcVtLcMurN7NR3f0NJzL033ZFYZM/v4BM
         ZMiQ==
X-Gm-Message-State: ABy/qLYG/uLgjzHTkUpYqTp5sk3pKX5RoZ5aV/5zFaEwqchshNUpk2eQ
        PCgLE21jwbUlA3ohYlmiYCXxrhtp+C85Wtp23vyFm/9Lbw1r
X-Google-Smtp-Source: APBJJlEHnwqSEub3QzmXNtW/fc3P9CwHITGBhlxSfYq6Ep+zc2ETNhyQAmFz4Qvj4aJwt4b2zLNSazu79DZbjqUguw1ke/PHP1Kw
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:228b:b0:658:43e0:c812 with SMTP id
 f11-20020a056a00228b00b0065843e0c812mr2171872pfe.5.1688123566808; Fri, 30 Jun
 2023 04:12:46 -0700 (PDT)
Date:   Fri, 30 Jun 2023 04:12:46 -0700
In-Reply-To: <00000000000049c61505fe026632@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089621005ff56e57c@google.com>
Subject: Re: [syzbot] [udf?] WARNING in __udf_add_aext (2)
From:   syzbot <syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b19edac5992d Merge tag 'nolibc.2023.06.22a' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1425350b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
dashboard link: https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1515b4f0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1a4f239105a/disk-b19edac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25776c3e9785/vmlinux-b19edac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca7e959d451d/bzImage-b19edac5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/531715d2031b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5874 at fs/udf/inode.c:2050 __udf_add_aext+0x550/0x6f0
Modules linked in:
CPU: 1 PID: 5874 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-01312-gb19edac5992d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__udf_add_aext+0x550/0x6f0 fs/udf/inode.c:2049
Code: 4c 89 e7 e8 02 1d e3 fe 49 8b 3c 24 4c 89 fe e8 56 21 03 ff 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 e0 26 8b fe <0f> 0b e9 ed fb ff ff e8 d4 26 8b fe 0f 0b e9 5c fc ff ff e8 c8 26
RSP: 0018:ffffc900069a6af8 EFLAGS: 00010293
RAX: ffffffff83008300 RBX: 1ffff92000d34df9 RCX: ffff888028cb8000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83007ee6 R09: ffffffff83007e16
R10: 0000000000000002 R11: ffff888028cb8000 R12: ffffc900069a6fc0
R13: 0000000000000004 R14: dffffc0000000000 R15: ffffc900069a6fc8
FS:  00007f9f9186d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f9182c000 CR3: 000000001f981000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_add_aext fs/udf/inode.c:2107 [inline]
 udf_do_extend_file+0xcb5/0x11e0 fs/udf/inode.c:592
 inode_getblk fs/udf/inode.c:822 [inline]
 udf_map_block+0x16c0/0x4ff0 fs/udf/inode.c:450
 __udf_get_block+0x126/0x410 fs/udf/inode.c:464
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2063
 __block_write_begin fs/buffer.c:2113 [inline]
 block_write_begin+0x9c/0x1f0 fs/buffer.c:2174
 udf_write_begin+0x10d/0x1a0 fs/udf/inode.c:265
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3946
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:4074
 udf_file_write_iter+0x2fd/0x660 fs/udf/file.c:115
 do_iter_write+0x84f/0xde0 fs/read_write.c:860
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:762
 do_splice_from fs/splice.c:840 [inline]
 direct_splice_actor+0xea/0x1c0 fs/splice.c:1027
 splice_direct_to_actor+0x37e/0x9a0 fs/splice.c:982
 do_splice_direct+0x286/0x3d0 fs/splice.c:1070
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9f90a8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f9186d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9f90babf80 RCX: 00007f9f90a8c389
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000005
RBP: 00007f9f90ad7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5898ad1f R14: 00007f9f9186d300 R15: 0000000000022000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
