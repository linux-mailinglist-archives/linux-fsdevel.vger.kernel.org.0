Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE16EC6F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjDXHWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjDXHWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:22:21 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38530D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:48 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32b58d571a8so29038885ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320906; x=1684912906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGGqV8290dEoTUrjp0SitShkagnOUqhe2Cg86H3zAX8=;
        b=W9vmbjaN8ekzbx3YVvLYahIynLPBnMVxG0ZpmL1nLqRi+nZGBUZ60gE8AY9W8MxEF9
         pl1FqD9qHzUD++0Wf61pUvF+rp4c43mgC623xkbJvxZcS4alERCb+q4P8FR5Ct7w0pAt
         bC74Mg1I/Sg0KpzMvoNAjVPO0g7Rt+eIYR75pxFGf7sgxe5VL4HiIjR2i93QoUvSxRFS
         n60qm/XtOvLzw9UqHQ/uF0YD4PDBWQIL5ldWPKsxM2z/jNwQi1SpF/OQ4DnD6kcM3f4U
         uucmLNaLaHZMBlCvR/GkTW+bBGlJFlOmljUwBbXod/q0aQgLcf8i45sXq+y4yTBlhmsC
         eGRg==
X-Gm-Message-State: AAQBX9fJh1uOCngWLzSHZ+7rHh0VYG08F8eQKkx+omHCdv9UXQWhv/UE
        XLFADhe97hLpwAtYwzJIfpEvxdmpfC8BQ+8IDQeFXeBiFmHC
X-Google-Smtp-Source: AKy350bZMKFVEyWINQcalkmTILRcwcKHwXh73NpxvTdxXknIGRlXMHUgImERNAXvfQTGlBGN667uNczc4ln/RFJjlOxE65PVRRgt
MIME-Version: 1.0
X-Received: by 2002:a92:daca:0:b0:324:5b4c:7087 with SMTP id
 o10-20020a92daca000000b003245b4c7087mr4659896ilq.0.1682320906232; Mon, 24 Apr
 2023 00:21:46 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:21:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003abd105fa0fdc4e@google.com>
Subject: [syzbot] [udf?] BUG: unable to handle kernel paging request in udf_add_fid_counter
From:   syzbot <syzbot+363633e9b96ffd442134@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2caeeb9d4a1b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108f06bfc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=363633e9b96ffd442134
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/187205513d6f/disk-2caeeb9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae84a1e0cbd0/vmlinux-2caeeb9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f0ff6d2e1aa/bzImage-2caeeb9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+363633e9b96ffd442134@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffed101931e9e3
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffee067 P4D 23ffee067 PUD 13fff5067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10059 Comm: syz-executor.4 Not tainted 6.3.0-rc7-syzkaller-00189-g2caeeb9d4a1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:udf_add_fid_counter+0x87/0x230
Code: f6 e8 bd ac aa 07 48 8d 45 20 48 89 ef 48 83 c7 24 41 0f b6 cf 4c 8d 3c 8d 20 00 00 00 84 c9 48 0f 44 f8 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 1d 01 00 00 46 01 74 3d 00 43 80 7c 25
RSP: 0018:ffffc900162ef668 EFLAGS: 00010a02
RAX: 1ffff1101931e9e3 RBX: ffff88807d746678 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b37fee0 RDI: ffff8880c98f4f18
RBP: ffff8880c98f4ef8 R08: dffffc0000000000 R09: fffffbfff1ca6956
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff1100fae8ccf R14: 00000000ffffffff R15: 0000000000000020
FS:  00007f03eb900700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed101931e9e3 CR3: 00000000280e6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_rename+0xb15/0xf30 fs/udf/namei.c:877
 vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
 do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
 __do_sys_rename fs/namei.c:4969 [inline]
 __se_sys_rename fs/namei.c:4967 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:4967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f03eac8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f03eb900168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f03eadabf80 RCX: 00007f03eac8c169
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000020000440
RBP: 00007f03eace7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd909bf24f R14: 00007f03eb900300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffffed101931e9e3
---[ end trace 0000000000000000 ]---
RIP: 0010:udf_add_fid_counter+0x87/0x230
Code: f6 e8 bd ac aa 07 48 8d 45 20 48 89 ef 48 83 c7 24 41 0f b6 cf 4c 8d 3c 8d 20 00 00 00 84 c9 48 0f 44 f8 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 1d 01 00 00 46 01 74 3d 00 43 80 7c 25
RSP: 0018:ffffc900162ef668 EFLAGS: 00010a02
RAX: 1ffff1101931e9e3 RBX: ffff88807d746678 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b37fee0 RDI: ffff8880c98f4f18
RBP: ffff8880c98f4ef8 R08: dffffc0000000000 R09: fffffbfff1ca6956
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff1100fae8ccf R14: 00000000ffffffff R15: 0000000000000020
FS:  00007f03eb900700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed101931e9e3 CR3: 00000000280e6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f6 e8                	imul   %al
   2:	bd ac aa 07 48       	mov    $0x4807aaac,%ebp
   7:	8d 45 20             	lea    0x20(%rbp),%eax
   a:	48 89 ef             	mov    %rbp,%rdi
   d:	48 83 c7 24          	add    $0x24,%rdi
  11:	41 0f b6 cf          	movzbl %r15b,%ecx
  15:	4c 8d 3c 8d 20 00 00 	lea    0x20(,%rcx,4),%r15
  1c:	00
  1d:	84 c9                	test   %cl,%cl
  1f:	48 0f 44 f8          	cmove  %rax,%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 1d 01 00 00    	jne    0x154
  37:	46 01 74 3d 00       	add    %r14d,0x0(%rbp,%r15,1)
  3c:	43                   	rex.XB
  3d:	80                   	.byte 0x80
  3e:	7c 25                	jl     0x65


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
