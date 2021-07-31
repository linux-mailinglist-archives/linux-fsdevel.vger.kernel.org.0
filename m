Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80B3DC38C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 07:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhGaFbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 01:31:34 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47837 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhGaFbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:31:34 -0400
Received: by mail-io1-f71.google.com with SMTP id p7-20020a6b63070000b02904f58bb90366so7252667iog.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 22:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ybhqdh1oYd31ci+HGWGSrGtMp6EI7IzrFPCbt4B92Rk=;
        b=Df8Vh77DDqSeYaU9z8Y3uskaPTtw4OoLSTrf/D5AdlGLZRtSgUBVMSaOd6q+EFVGGv
         JST0X0VEwQ2viM8rtoFXVRuSeKUr5dHsgXW6tA8tHc/T7aPSX+h9oL1MDlciAvltR3ni
         t2CVYZfX33L1PvtLjetbM2JOjieH0cJwj8DFhJoiQQO3+Fq2uA+8CotI5yXS0rWctlnU
         GGz2gPmfCUGmUJLEFguID9TzQ9O1Xoc3BlqGOf0cKhEwJWLpNFcEQjW2npXd3ic4bdwy
         1SFZ8HSsM9iwJ1xdXUUmEF9mDGZ2yCuIwe6NxKRVXr7QJ27cyeEPH0IBtWnDsT18q2rL
         xB/g==
X-Gm-Message-State: AOAM532OZn4aoPFxq10MeqXj+WC7hkACdXv1Qr2ermQAWYrfykyezOVO
        yRcDOqM1TW7Ovtc5GVgnpwmvSYk1DUEEqG7xf9pEynFL0r/w
X-Google-Smtp-Source: ABdhPJy6LYtw5jeTSRqjdhMSsg7KnPwClEQsL7kwZkfKosDBBQl+Vhzy4l3I5accRC/Ng+FO8iFn28tDmcfQlGCkK174j6m1JoDp
MIME-Version: 1.0
X-Received: by 2002:a02:6a24:: with SMTP id l36mr4919100jac.4.1627709487368;
 Fri, 30 Jul 2021 22:31:27 -0700 (PDT)
Date:   Fri, 30 Jul 2021 22:31:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cacd1705c864a53a@google.com>
Subject: [syzbot] general protection fault in __block_write_begin_int
From:   syzbot <syzbot+dda2ebbaa98b7ee29c87@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    764a5bc89b12 Merge tag 'drm-fixes-2021-07-30' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169e4966300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40eef000d7648480
dashboard link: https://syzkaller.appspot.com/bug?extid=dda2ebbaa98b7ee29c87
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dda2ebbaa98b7ee29c87@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xfbd59c0000000040: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xdead000000000200-0xdead000000000207]
CPU: 0 PID: 14330 Comm: syz-executor.0 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__block_write_begin_int+0xdf/0x1810 fs/buffer.c:1973
Code: c1 e8 03 42 80 3c 28 00 41 89 ec 0f 85 4e 16 00 00 48 8b 04 24 48 8b 58 18 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 16 00 00 48 8b 03 48 89 44 24 48 48 8b 04 24
RSP: 0018:ffffc900028df408 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: dead000000000200 RCX: ffffc9000a883000
RDX: 1bd5a00000000040 RSI: ffffffff81d82909 RDI: ffffea00020b8058
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff819c2dde R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000001000 R15: 0000000000001000
FS:  00007fdaaa33b700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055640707d930 CR3: 0000000030e6f000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2116
 generic_perform_write+0x202/0x500 mm/filemap.c:3656
 __generic_file_write_iter+0x24e/0x610 mm/filemap.c:3783
 blkdev_write_iter+0x298/0x550 fs/block_dev.c:1643
 call_write_iter include/linux/fs.h:2114 [inline]
 do_iter_readv_writev+0x46f/0x740 fs/read_write.c:740
 do_iter_write+0x188/0x670 fs/read_write.c:866
 vfs_iter_write+0x70/0xa0 fs/read_write.c:907
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0x9f0/0x1120 fs/read_write.c:1260
 __do_sys_sendfile64 fs/read_write.c:1325 [inline]
 __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdaaa33b188 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000080006 R11: 0000000000000246 R12: 000000000056bf80
R13: 0000000000a9fb1f R14: 00007fdaaa33b300 R15: 0000000000022000
Modules linked in:
---[ end trace 525ffcbbca5b966c ]---
RIP: 0010:__block_write_begin_int+0xdf/0x1810 fs/buffer.c:1973
Code: c1 e8 03 42 80 3c 28 00 41 89 ec 0f 85 4e 16 00 00 48 8b 04 24 48 8b 58 18 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 16 00 00 48 8b 03 48 89 44 24 48 48 8b 04 24
RSP: 0018:ffffc900028df408 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: dead000000000200 RCX: ffffc9000a883000
RDX: 1bd5a00000000040 RSI: ffffffff81d82909 RDI: ffffea00020b8058
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff819c2dde R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000001000 R15: 0000000000001000
FS:  00007fdaaa33b700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000030e6f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
