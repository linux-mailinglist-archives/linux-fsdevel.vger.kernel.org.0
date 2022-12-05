Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3A6423FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 09:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiLEICo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 03:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiLEICk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:02:40 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF57BD2
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 00:02:38 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id h21-20020a05660224d500b006debd7dedccso9396670ioe.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 00:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqxrsKN+H0HttrZ3bVe8/YeNqea6lzdAdrNkmmS7BQ4=;
        b=61E5kRuqNj+NTSrc1II9VEWI+T+aqpoy0HIbC86OE7gCwE5nAMaRyFFcPPSZhFXGKo
         /BJ/ttyOMGe8Z8rHCDfbwpx91c36a4y7sI11BDq7Do1E6GuTajzKZE+U35PWZha9/So5
         ehvs+Fu3dYF7DsI0uwqeP5Og6ZADdB65PJ/eqeiulXoQNGvh8FBdtE0+3dTtxoO5OHJL
         VsgRtWc29NmeEDvcjWELY0K34e2yTPsw+DqnUZbIgD0Bk/iYJIwjdGzF3679jeb6fvcR
         wExQKb45tmnXdwInwIw9kOu+xd6bMjowDPoJOK+eWjMqOL4HOta7rMm0rIaNSEA1xjdX
         4UnQ==
X-Gm-Message-State: ANoB5pkRpnhCSqnOVQ8Ubc29YucTfxgLghOSXHZzshfxgA/u3PR643XZ
        GtOfEH4Zav6SZ7EL+g7ayIiw8vY01f8frDeGwg9MiiyjvwIv
X-Google-Smtp-Source: AA0mqf6zJcaH711WwLDTsycHAVN3q+BqnSGUKtaRSbvAN/y8HTSMRevRNQJM1ikJOW7mlW1rt92MY9uCB0KP26o6eSijLgtubV4j
MIME-Version: 1.0
X-Received: by 2002:a5d:9f1a:0:b0:6df:f1ea:70f9 with SMTP id
 q26-20020a5d9f1a000000b006dff1ea70f9mr4701796iot.3.1670227357589; Mon, 05 Dec
 2022 00:02:37 -0800 (PST)
Date:   Mon, 05 Dec 2022 00:02:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057fa4605ef101c4c@google.com>
Subject: [syzbot] WARNING in hfsplus_free_extents
From:   syzbot <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    c2bf05db6c78 Merge tag 'i2c-for-6.1-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169efe83880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0bc9f818702ff75b76
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4476d2eff1ae/disk-c2bf05db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f4a704ffc14/vmlinux-c2bf05db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfb09481a98b/bzImage-c2bf05db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346 hfsplus_free_extents+0x700/0xad0
Modules linked in:
CPU: 0 PID: 4400 Comm: syz-executor.2 Not tainted 6.1.0-rc7-syzkaller-00200-gc2bf05db6c78 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfsplus_free_extents+0x700/0xad0 fs/hfsplus/extents.c:346
Code: 0f cb 44 89 ef 89 de e8 3e 27 2f ff 41 39 dd 75 20 49 83 c7 28 e8 90 25 2f ff 41 bc 05 00 00 00 e9 e3 f9 ff ff e8 80 25 2f ff <0f> 0b e9 86 f9 ff ff 44 89 ef 89 de e8 0f 27 2f ff 41 29 dd 73 0a
RSP: 0000:ffffc90015d0f7f0 EFLAGS: 00010287
RAX: ffffffff825b74b0 RBX: ffff888075df8820 RCX: 0000000000040000
RDX: ffffc90005a7c000 RSI: 00000000000104a4 RDI: 00000000000104a5
RBP: ffff88802ea40000 R08: dffffc0000000000 R09: ffffed10055f140a
R10: ffffed10055f140a R11: 1ffff110055f1409 R12: 0000000000000124
R13: 0000000000000027 R14: 0000000000000002 R15: ffff8880685ebd18
FS:  00007f2ea3f28700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4fb2a7fc00 CR3: 000000006dd64000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
 hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
 cont_expand_zero fs/buffer.c:2383 [inline]
 cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
 hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
 generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
 hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ea328c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2ea3f28168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f2ea33abf80 RCX: 00007f2ea328c0d9
RDX: 0000000000000000 RSI: 0000000002008000 RDI: 0000000000000005
RBP: 00007f2ea32e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe834f28ff R14: 00007f2ea3f28300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
