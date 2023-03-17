Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E16BE7E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCQLVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCQLVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:21:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94807868B
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 04:20:49 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g14-20020a92dd8e000000b00316ea7ce6d3so2228732iln.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 04:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqnk41ySeSNX2yCHZGZE/dWEboCHTt1MyXh/PnBDvLQ=;
        b=VurJ22DZvmwg43Tdbsp2ZAGXBbxQItoE8KNlYH9o7nmcUSBuBEqt+ZXS2ouwlHuvG2
         T01VcQXxhB5Nb6gdWc47qWT1/iATmh/7r0pdzpQrn94XpaVb0k/XrtscAQnfGJDOc2LC
         N+NpLhpbn2Fxoy2eA43E0Opb5wfwsf1sJTcFb+q0tlP6y8OUspJHKowr4OEBJ1IO0PH2
         Y3rXrLrSEfGHplSWG9TBq699yZ0pnwWTTau/a71ZhyfdzC8ZQSq9pfRg6jI3KpphcVeR
         q1OXuSt0Tpi5LWGaz6iEzN0I+bbCf5O9iOp6XrOeLh+m9Gtu4pcx0vzgo+RcryOANN1+
         pOMA==
X-Gm-Message-State: AO0yUKXORqcnAeZlPoPj9B3AGDPYw7kzIKlg/yctyzY+t56KQAUeqx3t
        0qltEBAWgM0gu2q4EtYEhZDqxSHEJE/fgpEHMrjzlbthaWF8
X-Google-Smtp-Source: AK7set/E46YUb/h8n4P1dIpqcv0BhxhTRIa/AlZKjOHC1IjT6dYDvSb1+C4bOw1cBKRbe6vxJJyG8SchGgcG/0BpqrnEGXVGqslS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2147:b0:3c5:1971:1b7f with SMTP id
 z7-20020a056638214700b003c519711b7fmr1037599jaj.6.1679052048555; Fri, 17 Mar
 2023 04:20:48 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:20:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9e9ee05f716c445@google.com>
Subject: [syzbot] [udf?] WARNING in udf_new_block
From:   syzbot <syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eeac8ede1755 Linux 6.3-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e97a70c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbab9019ad6fc418
dashboard link: https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/204f10b1db6d/disk-eeac8ede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0ab57601df9/vmlinux-eeac8ede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21d53c00efd1/bzImage-eeac8ede.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14411 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:125 [inline]
WARNING: CPU: 1 PID: 14411 at fs/udf/udfdecl.h:123 udf_table_new_block fs/udf/balloc.c:667 [inline]
WARNING: CPU: 1 PID: 14411 at fs/udf/udfdecl.h:123 udf_new_block+0x1dc2/0x2130 fs/udf/balloc.c:733
Modules linked in:
CPU: 1 PID: 14411 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:125 [inline]
RIP: 0010:udf_table_new_block fs/udf/balloc.c:667 [inline]
RIP: 0010:udf_new_block+0x1dc2/0x2130 fs/udf/balloc.c:733
Code: fe e9 00 fd ff ff e8 ed 61 8d fe 48 8b bc 24 88 00 00 00 e8 60 82 b8 07 45 31 f6 48 8b 5c 24 78 e9 6d fd ff ff e8 ce 61 8d fe <0f> 0b e9 64 fc ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 7d e3 ff ff
RSP: 0018:ffffc9001688f580 EFLAGS: 00010287
RAX: ffffffff82fde5b2 RBX: 000000004c84c04c RCX: 0000000000040000
RDX: ffffc90012967000 RSI: 0000000000000938 RDI: 0000000000000939
RBP: ffffc9001688f7d0 R08: ffffffff82fde210 R09: fffffbfff1ca8066
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880489d301c R15: 0000000000000037
FS:  00007fe1f2f80700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002004c000 CR3: 000000001e4ed000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_new_inode+0x389/0xd10 fs/udf/ialloc.c:71
 udf_create+0x21/0xe0 fs/udf/namei.c:384
 lookup_open fs/namei.c:3416 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3712
 do_filp_open+0x234/0x490 fs/namei.c:3742
 do_sys_openat2+0x13f/0x500 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1f228c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1f2f80168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fe1f23ac050 RCX: 00007fe1f228c0f9
RDX: 0000000000000048 RSI: 00000000000060c2 RDI: 0000000020000100
RBP: 00007fe1f22e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffec8d11ecf R14: 00007fe1f2f80300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
