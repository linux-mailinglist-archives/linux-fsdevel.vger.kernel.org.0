Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C44DCB89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiCQQit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiCQQis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:38:48 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056641FE550
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 09:37:30 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id 3-20020a056e020ca300b002c2cf74037cso3318526ilg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 09:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3qe8aLcAOkT7n6QAlmd+508Z97v0g9bTF25s2pX78nc=;
        b=GH+TjD0kT/md4wQtjh+L8sK8cyJcaStm3a16ZO0yHd5dVytedbXZB2/nF2fPZhh+1d
         S1lsisgq+uHfgAAPwkqY8ZLwiLB4bE3f94+0LgoOl8JJkAqM9JjwphCgA+lcyv/0GRzv
         rLEAS7wtUkP5YllUDygN7973qr974lXibO6iDQU8VLgqXJwdFUWcyQc4nYX9Af6gxpa0
         0hrKLHGgtDPPUJc1qMOBD2B+UDK/3XhhMUBEDJITtr32gpBUm/Y2T9L+agpNjmliTLnt
         tynwf63rkoBSZfgvMJUWVQLX/ALbm1C6s8JBkknDP4vnwEkTWKmKjQHnxWWiKpOXGnL4
         fa6g==
X-Gm-Message-State: AOAM532/ePVl7mRtdJYfexw9Uf5DXqR7ey4fSoL5Sc/iSrjPAgG1osCJ
        H3lgh+80/DqmWDsNGdE/X2K4M1P/vtGWj73Oj9429pf+Be/S
X-Google-Smtp-Source: ABdhPJw4V0lIONtc6Jx/sU6+owHZ6SSY+YoSdTtghDVwwXZ35TcS992KmkJCWgHdHGIZltO0CP9IH3G0/nqvsm/ALMe/FYQErXTq
MIME-Version: 1.0
X-Received: by 2002:a02:294a:0:b0:317:3541:3b9a with SMTP id
 p71-20020a02294a000000b0031735413b9amr2474587jap.101.1647535049146; Thu, 17
 Mar 2022 09:37:29 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:37:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c067605da6ca58e@google.com>
Subject: [syzbot] WARNING in inc_nlink (3)
From:   syzbot <syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    aad611a868d1 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ae4ede700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b9eb31700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429c4c5700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 3671 at fs/inode.c:388 inc_nlink+0x144/0x160 fs/inode.c:388
Modules linked in:
CPU: 3 PID: 3671 Comm: syz-executor254 Not tainted 5.17.0-rc7-syzkaller-00235-gaad611a868d1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:inc_nlink+0x144/0x160 fs/inode.c:388
Code: ff 4c 89 e7 e8 0d 97 ec ff e9 42 ff ff ff 4c 89 e7 e8 90 96 ec ff e9 fc fe ff ff 4c 89 e7 e8 83 96 ec ff eb d4 e8 9c b0 a5 ff <0f> 0b e9 6e ff ff ff e8 80 96 ec ff e9 44 ff ff ff e8 76 96 ec ff
RSP: 0018:ffffc900027cfcc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880266e06c0 RCX: 0000000000000000
RDX: ffff888022f24100 RSI: ffffffff81d244f4 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8880266e0183
R10: ffffffff81d24460 R11: 000000000000001d R12: ffff8880266e0708
R13: ffff888026531d78 R14: ffff8880266e00f8 R15: ffff88801d309c00
FS:  00005555565363c0(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564785040878 CR3: 000000001626c000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 v9fs_vfs_mkdir_dotl+0x478/0x770 fs/9p/vfs_inode_dotl.c:454
 vfs_mkdir+0x1c3/0x3b0 fs/namei.c:3933
 do_mkdirat+0x285/0x300 fs/namei.c:3959
 __do_sys_mkdir fs/namei.c:3979 [inline]
 __se_sys_mkdir fs/namei.c:3977 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:3977
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5da8ba5829
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6deb21e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffd6deb21f8 RCX: 00007f5da8ba5829
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200002c0
RBP: 00007ffd6deb21f0 R08: 00007f5da8b63af0 R09: 00007f5da8b63af0
R10: 0000000020000340 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
