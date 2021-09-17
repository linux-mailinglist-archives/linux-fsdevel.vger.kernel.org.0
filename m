Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0640F378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhIQHqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 03:46:50 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39737 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhIQHqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:46:50 -0400
Received: by mail-il1-f197.google.com with SMTP id x7-20020a920607000000b002302afca41bso20411946ilg.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 00:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OP3uxeBYi8SHf3RS1WfoO/qNwbCuJtSaDhutWqW2LcI=;
        b=v5GAnaUkf5wkbn8B1J7s6xyJopHwyvi5t6siFvrBlU68IPWenAMoZTdcX88Ylg1bCW
         E36Nza5uNC2G/HTMlW80sip5vkFCMjvR9Bi0S+4jLMrzUTe6QoILC2BQ+vYgUyHm96yF
         Va6Ke4NSDm1PgM324gSXA5Con9kpVuUAXJg+hEd/l+Rt2rkKPInL7iq94iEhM9FOW6ip
         q4nScOBg4B6JzrtMGpYTuCmzuQnA+/YLS9IQkr+TRnrncS/Xsv2+YDSe4fsRg7WMT1YW
         BVYCl86HSa3i5cVPgZyyh5KdqaRF09YemlZhwHruY4qLp4Pru8P0uRtkgqH9aDDY0qTb
         LJMg==
X-Gm-Message-State: AOAM531q4bUoIxBMs42rodD1d6RPcReAPWUkC83KuxvHhj+tUgGZN1Q9
        TFQJYLQrSeIrWxMzS6gOdqYEV2g/zHfU2INo3J6y4vD/mv02
X-Google-Smtp-Source: ABdhPJyS+nD1otgB9QscY6RNWtqr5kA1uomVmGTvE2TycrcAP36U43t8ggdNzAibuGDlW607zC2FTqRWhh35W1k3d3Qo2nsc9zvL
MIME-Version: 1.0
X-Received: by 2002:a92:2a04:: with SMTP id r4mr6799411ile.221.1631864728489;
 Fri, 17 Sep 2021 00:45:28 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:45:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007692c305cc2c1df8@google.com>
Subject: [syzbot] general protection fault in sync_file_range
From:   syzbot <syzbot+0d2a4f11e03455f608de@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0319b848b155 binfmt: a.out: Fix bogus semicolon
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163986cd300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=faed7df0f442c217
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2a4f11e03455f608de
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d2a4f11e03455f608de@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 PID: 12026 Comm: iou-wrk-12025 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:file_inode include/linux/fs.h:1350 [inline]
RIP: 0010:sync_file_range+0xc3/0x290 fs/sync.c:283
Code: 7f e8 c1 47 9f ff 4d 85 ed 0f 85 7f 01 00 00 e8 53 42 9f ff 49 8d 7c 24 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 b7 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0000:ffffc9000256fb20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff81d6deed RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff81e357a8
R10: ffffffff81d6dedf R11: 0000000000000008 R12: 0000000000000000
R13: 0000000000000000 R14: 7fffffffffffffff R15: 0000000000000000
FS:  00007f3dda997700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c02aa00000 CR3: 000000002522f000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 io_sync_file_range fs/io_uring.c:4603 [inline]
 io_issue_sqe+0xdc5/0x6ba0 fs/io_uring.c:6575
 io_wq_submit_work+0x1d4/0x300 fs/io_uring.c:6707
 io_worker_handle_work+0xcb1/0x1950 fs/io-wq.c:560
 io_wqe_worker+0x2cc/0xbb0 fs/io-wq.c:609
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
---[ end trace d1a0c5dc7ddb668f ]---
RIP: 0010:file_inode include/linux/fs.h:1350 [inline]
RIP: 0010:sync_file_range+0xc3/0x290 fs/sync.c:283
Code: 7f e8 c1 47 9f ff 4d 85 ed 0f 85 7f 01 00 00 e8 53 42 9f ff 49 8d 7c 24 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 b7 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0000:ffffc9000256fb20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff81d6deed RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff81e357a8
R10: ffffffff81d6dedf R11: 0000000000000008 R12: 0000000000000000
R13: 0000000000000000 R14: 7fffffffffffffff R15: 0000000000000000
FS:  00007f3dda997700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000206d6100 CR3: 000000002522f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	7f e8                	jg     0xffffffea
   2:	c1 47 9f ff          	roll   $0xff,-0x61(%rdi)
   6:	4d 85 ed             	test   %r13,%r13
   9:	0f 85 7f 01 00 00    	jne    0x18e
   f:	e8 53 42 9f ff       	callq  0xff9f4267
  14:	49 8d 7c 24 20       	lea    0x20(%r12),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 b7 01 00 00    	jne    0x1eb
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	4d                   	rex.WRB
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
