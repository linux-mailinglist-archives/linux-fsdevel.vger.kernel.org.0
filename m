Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3942641760
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLCOwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Dec 2022 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLCOwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:52:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8494E086
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Dec 2022 06:52:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so1105513ilh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Dec 2022 06:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJfmHXHkF5xmki1I+7OWxLY2r+t/61Zw8Fye8bgTnlE=;
        b=SpjyX8vJ6u+0hLLVYNeHhRqZWOi+Vo2s2zEeDy+288E11g1WesgBq2+Whv+GRYfwKT
         cpWv09H+omAyzSgmNA+opyubMdbXuRHjwg8+jHwYQRENmmXnZeI/WVfeyUPZ5z/S0bvV
         7i3W/isHxFhFRPHbK5MsuA5Rd5z02SfLneGItTfM7QBj99oVIsdAK+FVVsbdY+7JFyFw
         pCYECJmCGduyhoxBWAxpVf/ntbaDc2DqaxMRZohZu0/ylmmf0nZRAethZnoWaSXaAUgq
         lG/1WusWiELy9dMs7vjoUE8F+G4VfWDZCp1o60Ovl9m07xX39eVHpnn0nC0dBm9tH92i
         kc5A==
X-Gm-Message-State: ANoB5pneHceQ7DzslN9+kzHXfvtpHYNJFrARh24GZg3wXOk+soJhyMHp
        IUvfaH/CKiCz/AxCGw+Ufut6xO6E46r01101IZqZMSO+9Ve2
X-Google-Smtp-Source: AA0mqf6HtdCZE/zLlCPVXICmnjkmmAybT5D/zJI4mn5ocaxN7GKjRp2DkM1q9OjlHq5kL4NThblbXGj2A1OrgCbZVc/HLqwtwES4
MIME-Version: 1.0
X-Received: by 2002:a02:a803:0:b0:389:dc2a:a499 with SMTP id
 f3-20020a02a803000000b00389dc2aa499mr14401478jaj.50.1670079165286; Sat, 03
 Dec 2022 06:52:45 -0800 (PST)
Date:   Sat, 03 Dec 2022 06:52:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064d06705eeed9b4e@google.com>
Subject: [syzbot] WARNING in do_mkdirat
From:   syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    ca57f02295f1 afs: Fix fileserver probe RTT handling
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171b06a1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af66f1d3a389/disk-ca57f022.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0c7ec393108/vmlinux-ca57f022.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8871940eaa/bzImage-ca57f022.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 12206 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 0 PID: 12206 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 0 PID: 12206 Comm: syz-executor.0 Not tainted 6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 40 a3 ed 8a 48 c7 c6 e0 a5 ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 1b 83 e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 18 25 76 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000338fd40 EFLAGS: 00010292
RAX: 69eb1955c47aff00 RBX: ffffffff8aeda420 RCX: 0000000000040000
RDX: ffffc900046f6000 RSI: 0000000000023311 RDI: 0000000000023312
RBP: ffffc9000338fe10 R08: ffffffff816e560d R09: fffff52000671f61
R10: fffff52000671f61 R11: 1ffff92000671f60 R12: 0000000000000000
R13: ffff888027d20a90 R14: 1ffff92000671fb0 R15: dffffc0000000000
FS:  00007f928b35b700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f268cbad988 CR3: 000000001e90f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:761 [inline]
 done_path_create fs/namei.c:3857 [inline]
 do_mkdirat+0x2de/0x550 fs/namei.c:4064
 __do_sys_mkdir fs/namei.c:4081 [inline]
 __se_sys_mkdir fs/namei.c:4079 [inline]
 __x64_sys_mkdir+0x6a/0x80 fs/namei.c:4079
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f928a68c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f928b35b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f928a7ac050 RCX: 00007f928a68c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00007f928a6e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffeaab152f R14: 00007f928b35b300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
