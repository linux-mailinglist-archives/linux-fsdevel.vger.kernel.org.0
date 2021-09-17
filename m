Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC840F37D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 09:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbhIQHrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 03:47:43 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51977 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbhIQHrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:47:40 -0400
Received: by mail-io1-f70.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso18921967iov.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 00:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pz7rMisz779RgtlmAlE9XLOpDgY+C5y+60Pf5t9EgBg=;
        b=5o7mOT2fdKMKYYwz+gfjitleFhaDAa8Ig748z0r80gqU082199lq29pM9EcVl2ySuD
         XFaoA00YzgPFg+88J2blRkQjjmspuzN++358XY+DEkXcWdVD2ha2lYQhKbIgrLy1iYmJ
         OEa9Vm89H5t83NbJbzkgc37N4QT8Jt4RVR24wCguDoO8dnRjl5bYdWOFr2oroadoO2jZ
         DLpQEMZfxffAjG8k+ySVNQ8qMn40shr+sJ3BF1NdIATVOsqtqTR7zZSE/CYy07ec2C4u
         DbLHRCPw7LECBW2Pm1YFGyquuaFJpg9JVyL0/AM0UIbcRU8n7ZuJ5zUb6xk88uHZ/hG8
         CbWg==
X-Gm-Message-State: AOAM533pbE4TSKBkZ6Ek30FeS4oMtTJ3EgIWqcoQxIHiWaApAAzLnqat
        NsSuV9ztbKDDy9Et3DjCjiVGtL3DWsrLS965goKTenJ00/rF
X-Google-Smtp-Source: ABdhPJzZjaVnfQdLlj3lm+kZ7ZlreRVDCGhNk4FlsJ5DW1KoQFOoehlYHIpzHtOrFN3kwYAmuMokrPtjEKVPZYfQ1MERHu2tWyB8
MIME-Version: 1.0
X-Received: by 2002:a92:c26f:: with SMTP id h15mr6795624ild.271.1631864779084;
 Fri, 17 Sep 2021 00:46:19 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:46:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a99f605cc2c2066@google.com>
Subject: [syzbot] general protection fault in path_init
From:   syzbot <syzbot+ae0fa0f86eb10f87db2d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49624efa65ac Merge tag 'denywrite-for-5.15' of git://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1289787d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=172cce3513a61f40
dashboard link: https://syzkaller.appspot.com/bug?extid=ae0fa0f86eb10f87db2d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae0fa0f86eb10f87db2d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 12334 Comm: iou-wrk-12330 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:path_init+0x8d/0x1920 fs/namei.c:2321
Code: 48 c1 ea 03 80 3c 02 00 0f 85 e7 15 00 00 48 8b 45 c8 48 8b 98 c0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 b4 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc900019b77c0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81cac27f RDI: ffffc900019b7998
RBP: ffffc900019b7860 R08: 0000000000200000 R09: ffffc900019b7a98
R10: ffffffff81cac266 R11: 0000000000000024 R12: 0000000000000040
R13: ffffc900019b78d8 R14: ffffc900019b78d8 R15: ffffc900019b78d8
FS:  00007f8de3d0b700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8de3cea718 CR3: 000000008b11c000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 path_parentat+0x22/0x1c0 fs/namei.c:2504
 __filename_parentat+0x1bb/0x5a0 fs/namei.c:2527
 do_unlinkat+0xc4/0x650 fs/namei.c:4140
 io_unlinkat fs/io_uring.c:3703 [inline]
 io_issue_sqe+0x46c9/0x6ba0 fs/io_uring.c:6650
 io_wq_submit_work+0x1d4/0x300 fs/io_uring.c:6707
 io_worker_handle_work+0xcb1/0x1950 fs/io-wq.c:560
 io_wqe_worker+0x2cc/0xbb0 fs/io-wq.c:609
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
---[ end trace 55738b1526c3e749 ]---
RIP: 0010:path_init+0x8d/0x1920 fs/namei.c:2321
Code: 48 c1 ea 03 80 3c 02 00 0f 85 e7 15 00 00 48 8b 45 c8 48 8b 98 c0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 b4 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc900019b77c0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81cac27f RDI: ffffc900019b7998
RBP: ffffc900019b7860 R08: 0000000000200000 R09: ffffc900019b7a98
R10: ffffffff81cac266 R11: 0000000000000024 R12: 0000000000000040
R13: ffffc900019b78d8 R14: ffffc900019b78d8 R15: ffffc900019b78d8
FS:  00007f8de3d0b700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc0711ca108 CR3: 000000008b11c000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 e7 15 00 00    	jne    0x15f5
   e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  12:	48 8b 98 c0 00 00 00 	mov    0xc0(%rax),%rbx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 b4 15 00 00    	jne    0x15e8
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
