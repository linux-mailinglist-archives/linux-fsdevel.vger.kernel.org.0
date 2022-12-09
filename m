Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF2648933
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 20:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLITup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 14:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLITun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:50:43 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7154367
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Dec 2022 11:50:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so506843ilv.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Dec 2022 11:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1B4yy+jcFEyr9XmliYRcMTHvapMRmJPSRkI5eNsWgw=;
        b=X9xGEsugdkvWn0H/IU/LT8MmkvMLir5TO9WZ8saeawaPn0XXKoviWrlHfPQNQzuG7p
         GhvKR+66EYStxKGoWex3xbtIglc4jgb2oBVcnc09seOa1tNHAzVOzldyCqQnvE4L3Aej
         Ov9yETI+5v5tLaXNi+TA3m+yRlU4yV86Kdx8ydtKuZQN+oIPnLYXoNc/F1OVpwNVS3Z2
         XL3K80u0hGoWWNHR8sfqdM4PmgNZeQ/mD472Fs4OWl5asEfo6RehL8CC7y/vbUgd8FXn
         dAhfWzq/ACXGNpshE9HoRzKgaP8Ka8pDVvfil6bujnlFtHUN4Cq5OV82AMacGYIYsRHZ
         Wcwg==
X-Gm-Message-State: ANoB5pk0IWFBfUmdspytOHmQvMwe7If3RnyHzSflU7hz+DfeAllBnlJb
        UHzEd1ij+yyLyhK2qSn/RjWJzU7k5QdjWCrcnBK9E+krG8Xt
X-Google-Smtp-Source: AA0mqf7Odl5v7SxeVzPmVBlmjiKzz7LCaQaJChj68GswgYdIYp91EKFoDPSMfcro7Lkutf/1xDEsQrA4kJFj+1XuWamkUE2g6TWY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:507:b0:303:1379:c325 with SMTP id
 d7-20020a056e02050700b003031379c325mr20188083ils.7.1670615441889; Fri, 09 Dec
 2022 11:50:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 11:50:41 -0800
In-Reply-To: <00000000000064d06705eeed9b4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f865be05ef6a77fa@google.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
From:   syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
To:     dvyukov@google.com, elver@google.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    0d1409e4ff08 Merge tag 'drm-fixes-2022-12-09' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172b960b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145fde33880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ab0143f95cb/disk-0d1409e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e574d5eaa32f/vmlinux-0d1409e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31109436b00b/bzImage-0d1409e4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5cec1c83630e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 4982 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 1 PID: 4982 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 1 PID: 4982 Comm: syz-executor.4 Not tainted 6.1.0-rc8-syzkaller-00148-g0d1409e4ff08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 c0 a3 ed 8a 48 c7 c6 60 a6 ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 ab 7c e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 18 2a 76 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000564fd40 EFLAGS: 00010292
RAX: 9a2b61996b411800 RBX: ffffffff8aeda4a0 RCX: ffff88801f5d3a80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000564fe10 R08: ffffffff816e5c7d R09: fffff52000ac9f61
R10: fffff52000ac9f61 R11: 1ffff92000ac9f60 R12: 0000000000000000
R13: ffff888069880a90 R14: 1ffff92000ac9fb0 R15: dffffc0000000000
FS:  00007f71b6d62700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f825d9ff000 CR3: 000000006cef1000 CR4: 00000000003506e0
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
RIP: 0033:0x7f71b608c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f71b6d62168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f71b61ac050 RCX: 00007f71b608c0d9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 00007f71b60e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeac9136ff R14: 00007f71b6d62300 R15: 0000000000022000
 </TASK>

