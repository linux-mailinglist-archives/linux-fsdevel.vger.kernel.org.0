Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873E649019
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 19:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLJSGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLJSGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:06:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448992A9
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:06:43 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so2096992ilv.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JECtRbncHYvgBMdSUzE8pbHud/cHTvPqn5LLrWNFGFY=;
        b=Vc88oVn+ZzgZRdyeeK9wJmK/RCAZI5laRPuwQMOZx18vBUPi8cauwvkrVo9dKK6G+u
         QAwvhr2EJG/OYWEuR7jNtsd2ZFfGAlKF97om1vbDFf6trKrRCBz20GfZFAYy7ymu4P7G
         a3efKlzPIKPy2f+bA4kWGCCXAR7pDCHFSJ9jhisp6opG7ONIaWj0p7wMMhV1wH7aOj5e
         tjxR9w6u7CCk5mmeRmkYIkdC+jnvi7ZiuyIzxbwNgLGvGnh8lHlEIS5D91oIGM9Wb3WN
         3wBDosjqAQgzqyzuGM3kCpUxdx2nUfRRO0EGKB7WMfRIg3c01iyH914O7YxbA7Gh6cvs
         isrQ==
X-Gm-Message-State: ANoB5pk0IXGNzmDPxM2jfYD1cphgC6opLu6nmE6oR1GsieFwnPRIfj8a
        DKoesMPiAo1PDa9U0glqgb+ugpcFK9xn7YLUfexOKFAYwMEc
X-Google-Smtp-Source: AA0mqf6Ia0oAutUmIX0aGI/02T24yKYbhKYIt5JebEnniuwDbREF05docSBkOfV4gTmu85eollvx1qMBBlhT8J5egE1DHo/XLS5l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3470:b0:389:c976:846e with SMTP id
 q48-20020a056638347000b00389c976846emr26967141jav.246.1670695602581; Sat, 10
 Dec 2022 10:06:42 -0800 (PST)
Date:   Sat, 10 Dec 2022 10:06:42 -0800
In-Reply-To: <00000000000064d06705eeed9b4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb761405ef7d2113@google.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
From:   syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
To:     dvyukov@google.com, elver@google.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3ecc37918c80 Merge tag 'media/v6.1-4' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ae071d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aaf2b7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b652b7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be14794fd26b/disk-3ecc3791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35b850996388/vmlinux-3ecc3791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0eec0f8f6777/bzImage-3ecc3791.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/547e98eae9c0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888072216a70, owner = 0x0, curr 0xffff888078ce57c0, list empty
WARNING: CPU: 0 PID: 4093 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 0 PID: 4093 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 0 PID: 4093 Comm: syz-executor196 Not tainted 6.1.0-rc8-syzkaller-00152-g3ecc37918c80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 c0 a3 ed 8a 48 c7 c6 60 a6 ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 ab 7c e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 18 2a 76 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900043ffd40 EFLAGS: 00010292
RAX: 7c48dcb6c422ab00 RBX: ffffffff8aeda4a0 RCX: ffff888078ce57c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900043ffe10 R08: ffffffff816e5c7d R09: fffff5200087ff21
R10: fffff5200087ff21 R11: 1ffff9200087ff20 R12: 0000000000000000
R13: ffff888072216a70 R14: 1ffff9200087ffb0 R15: dffffc0000000000
FS:  00007f68743c0700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000026c1b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:761 [inline]
 done_path_create fs/namei.c:3857 [inline]
 do_mkdirat+0x2de/0x550 fs/namei.c:4064
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f687c635589
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68743c02f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f687c6d97b0 RCX: 00007f687c635589
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f687c6d97bc R08: 00007f68743c0700 R09: 0000000000000000
R10: 00007f68743c0700 R11: 0000000000000246 R12: 00007f687c6a6258
R13: 0032656c69662f2e R14: 69662f7375622f2e R15: 00007f687c6d97b8
 </TASK>

