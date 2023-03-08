Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349D46B0F92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCHRB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 12:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCHRAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:00:52 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003ECD5159
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 08:59:37 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id d6-20020a92d786000000b00316f1737173so9146937iln.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 08:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678294777;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TW94PL94rAgtjTLgcx7A+NZZu9eTzckKL/XxL1c3UGc=;
        b=ojcPE8NCQ5laQtlgJ7bKWzBPmo8jWKstoEmtuMu8d1Us+yTusdfAbu1s0sfQ12Vv8L
         AUqW7UaORpe8yWq/OJvpiifNsKt0TtVTLInzJtegav18ENprR0JAnYzGEcvrZZnCJ8pm
         PsEkNlrfJn0iBWFOTY8KGqssPf1ynTuRB7hpRxZsf2rQqd5LAhSusxe/1s7eN6uvw17R
         W8z3mwTxboOtJkpAJN7fvqGRaUyw92fGsr0LNyZXOwUe9C3cV5k2UkMd7AA5zV4xeSCm
         1E3P/a2tG77+M+XwVTg4EIaVOGN9WTNcy3Pdfo8bqbJv5hSIIaTWbGGP3jqKe1ebCG72
         gd6w==
X-Gm-Message-State: AO0yUKVeU9JwL9Ji1CW+DFNgf+PIHk5TxrEtI8dYw/76IfS2zTWy5pA1
        5qoBzLI0/PC/OZHpBzPYsXXibYSt3gfPo7HCJENJUUlaFeyi
X-Google-Smtp-Source: AK7set9CaHwdImsr+AKNviMhC/MAiwkh8sc+H7gO78/S9FKmsyHdWYXPVNic30p293u8gUK928kJ+30QV7QzH/8/ZfeqVPMYs6hE
MIME-Version: 1.0
X-Received: by 2002:a02:620f:0:b0:3c9:562:1366 with SMTP id
 d15-20020a02620f000000b003c905621366mr9261142jac.3.1678294777238; Wed, 08 Mar
 2023 08:59:37 -0800 (PST)
Date:   Wed, 08 Mar 2023 08:59:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006a0df05f6667499@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (2)
From:   syzbot <syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17319698c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=6385d7d3065524c5ca6d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ab7acc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17459908c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0aa29e9ae74/disk-0988a0ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f64db0b58ef/vmlinux-0988a0ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db391408e15d/bzImage-0988a0ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40fdb4293020/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6385d7d3065524c5ca6d@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 5338 at fs/ext4/xattr.c:2141 ext4_xattr_block_set+0x2ef2/0x3680
Modules linked in:
CPU: 0 PID: 5338 Comm: syz-executor395 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:ext4_xattr_block_set+0x2ef2/0x3680 fs/ext4/xattr.c:2141
Code: b3 3d ff 48 8b 7c 24 50 4c 89 ee e8 88 2f c1 ff 45 31 ed e9 86 f4 ff ff e8 1b b3 3d ff 45 31 ed e9 79 f4 ff ff e8 0e b3 3d ff <0f> 0b e9 5d f2 ff ff e8 02 b3 3d ff 0f 0b 43 80 3c 26 00 0f 85 6f
RSP: 0018:ffffc90004a0f4a0 EFLAGS: 00010293
RAX: ffffffff824f0a52 RBX: 1ffff92000941f11 RCX: ffff888029c61d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90004a0f6d0 R08: ffffffff8213bec0 R09: ffffed100e12d2ae
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90004a0f860
FS:  00007f3928dee700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3920a0d000 CR3: 000000001c94d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_set_handle+0xcd4/0x15c0 fs/ext4/xattr.c:2458
 ext4_initxattrs+0xa3/0x110 fs/ext4/xattr_security.c:44
 security_inode_init_security+0x2df/0x3f0 security/security.c:1147
 __ext4_new_inode+0x347e/0x43d0 fs/ext4/ialloc.c:1324
 ext4_mkdir+0x425/0xce0 fs/ext4/namei.c:2992
 vfs_mkdir+0x29d/0x450 fs/namei.c:4038
 do_mkdirat+0x264/0x520 fs/namei.c:4061
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3928e426d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3928dee2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f3928ec77a0 RCX: 00007f3928e426d9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007f3928e94590 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3928e940c0
R13: 3d6469677365722c R14: 0030656c69662f2e R15: 00007f3928ec77a8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
