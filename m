Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E124C3E0AEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhHDXlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 19:41:36 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:33416 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhHDXlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:41:35 -0400
Received: by mail-il1-f200.google.com with SMTP id d6-20020a056e020506b0290208fe58bd16so1775255ils.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 16:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aEfuAixG+gq35I7KjD5wnNAArKWS8WpJhEmIQRVu3Pw=;
        b=a6j3Hyfy5DKs0hqViXyqahQITTSwkSNcBq839HWd5d91e3hAcm0XA+z0hhKgLJjY8G
         TZPg53S0PKxhb36T3yaZceqyAI9J7vrlYoMQbY4qEpmiaqBgD0KofGB12hZzRArSLAWE
         6nnNgy4qxKZ3exaIDqJPshS8Is+itmp+Zd6TmL+FlfbQ/8p/saT7QaRg9CxEF2NOT/Et
         4ZKWVSWw7m08cp0XpHxXGFc/BLyRupMfsFEd/EXHi6p/ibwdsR7LPOIZqNKK+lQ2tLYf
         gwnnoTLtUZNKJYEqFzqcyCXyJ1gJMIj03BPS4CuhbVNBg1hv1HVTFFxcHmZUQSbiQh4I
         WGFA==
X-Gm-Message-State: AOAM531cfdVILnWjcJsPbWLPV0go49g8KBpAUH8rz0Mj2nICzsoznKra
        16Vuq/G/0Rk1SFenlbAsTYSG9pT5Au8HsirqhmqA6sRFcacs
X-Google-Smtp-Source: ABdhPJxBPUnp6THFfHqBnALZZ0/hwHQ0xXpWHvxK4hS1LIa3+8vWhbeoZyoHVWQiKxId2UoLtnStAydbRAgvGm9xzrkUG0t4SQj5
MIME-Version: 1.0
X-Received: by 2002:a02:2243:: with SMTP id o64mr1834294jao.40.1628120481519;
 Wed, 04 Aug 2021 16:41:21 -0700 (PDT)
Date:   Wed, 04 Aug 2021 16:41:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3ee6005c8c45628@google.com>
Subject: [syzbot] WARNING in iov_iter_pipe (2)
From:   syzbot <syzbot+7e3ea7eaebc6168ab4d5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d5ad8ec3cfb5 Merge tag 'media/v5.14-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156d81ae300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=343fd21f6f4da2d6
dashboard link: https://syzkaller.appspot.com/bug?extid=7e3ea7eaebc6168ab4d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e3ea7eaebc6168ab4d5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 31934 at lib/iov_iter.c:1158 iov_iter_pipe+0x228/0x2d0 lib/iov_iter.c:1158
Modules linked in:
CPU: 0 PID: 31934 Comm: syz-executor.2 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:iov_iter_pipe+0x228/0x2d0 lib/iov_iter.c:1158
Code: 83 c0 03 38 d0 7c 04 84 d2 75 54 44 89 63 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 5f 6f a1 fd 0f 0b e8 58 6f a1 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 14 24 48 c1 ea 03 0f b6
RSP: 0018:ffffc90001c9f9e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffc90001c9fa60 RCX: ffffc90003359000
RDX: 0000000000040000 RSI: ffffffff83d42c08 RDI: 0000000000000003
RBP: ffff88807eb65400 R08: 0000000000000010 R09: 0000000000008000
R10: ffffffff83d42aca R11: 0000000000004000 R12: 0000000000000050
R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000010
FS:  00007f0929a3d700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f548000 CR3: 000000007e97f000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 generic_file_splice_read+0x9c/0x6c0 fs/splice.c:307
 do_splice_to+0x1bf/0x250 fs/splice.c:796
 splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
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
RSP: 002b:00007f0929a3d188 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000056c038 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000008
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000800100020001 R11: 0000000000000246 R12: 000000000056c038
R13: 00007ffc9a3f6d4f R14: 00007f0929a3d300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
