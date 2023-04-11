Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7533F6DD381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDKGzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjDKGzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:55:09 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D863A8B
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id i4-20020a056e020d8400b00325a80f683cso5599918ilj.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196085; x=1683788085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfTgGdguF9M84e7Y6NR55V4VOP2Cku6V0Y4xH17obKw=;
        b=1wREDT8QWgOUs+t88AqTyahymk5GvGrsNhp6gh/EHLigPQkgMf9PgntlgJjrGCn72p
         rkWEgOlcPFcbzSBYtQJfBeMyn0sJKGIZ+rw0+klL03ldHk0rhzNDNWTkJFfITw2LsAhF
         1bIeAR4Di1iKdE0M0maqPOxI1IiZlfrzqJ3NrBkDwSfKFBHdNHzS5W8NMDwM18JnxKNP
         eqiUQojXZ4RYayEgirZqDvPTYvKNFblE0HNQT0Rg/L2gf+I9E53xOQE+pxOWWM/HjdGh
         xHO8c48Nofz0ixDZ+XZu5w/0ULb0sgqFRtTnMPH3vEembXNMtyhD86wD/RuTAzVnNlOY
         JXpg==
X-Gm-Message-State: AAQBX9db88OjIHIcMkFKfAr2NitUe2tOxOhlW4W1hqPN5HT/4dfFAghA
        hb+5zEICKUxTBODqmDWr64XP5rNe/CpbOqBF0nDkVPDxvEox
X-Google-Smtp-Source: AKy350bYjl2LYkRl6Vbnxwo+eaFcjfV/0IeAOd7psepOghtUXGREk78tlQcz8jDj/OG4pLXJggjiTwkrKkzOkzTMN2LU2i8SXzbx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190d:b0:328:f165:de3b with SMTP id
 w13-20020a056e02190d00b00328f165de3bmr1616731ilu.2.1681196085690; Mon, 10 Apr
 2023 23:54:45 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:54:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c47b505f909f71d@google.com>
Subject: [syzbot] [f2fs?] general protection fault in __drop_extent_tree
From:   syzbot <syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7e364e56293b Linux 6.3-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1666b8f1c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9a438ce47536f0c
dashboard link: https://syzkaller.appspot.com/bug?extid=d015b6c2fbb5c383bf08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54c56bddacf4/disk-7e364e56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/447e5d1af596/vmlinux-7e364e56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e2d1545e7be/bzImage-7e364e56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 PID: 17900 Comm: syz-executor.4 Not tainted 6.3.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:__lock_acquire+0x69/0x1f80 kernel/locking/lockdep.c:4926
Code: df 0f b6 04 10 84 c0 0f 85 fb 15 00 00 83 3d 41 b7 e9 0c 00 0f 84 a8 14 00 00 83 3d d0 29 75 0b 00 74 2b 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 29 04 76 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900167a7b00 EFLAGS: 00010006
RAX: 0000000000000009 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff88802b86ba80 R14: 0000000000000048 R15: 0000000000000001
FS:  00007f37ad035700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37ad014718 CR3: 00000000912ec000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
 _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
 __drop_extent_tree+0x3ac/0x660 fs/f2fs/extent_cache.c:1192
 f2fs_drop_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1208
 f2fs_insert_range+0x2d5/0x3c0 fs/f2fs/file.c:1664
 f2fs_fallocate+0x4e4/0x6d0 fs/f2fs/file.c:1838
 vfs_fallocate+0x54b/0x6b0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f37ac28c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f37ad035168 EFLAGS: 00000246
 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f37ac3ac120 RCX: 00007f37ac28c0f9
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000005
RBP: 00007f37ac2e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000ff8000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff1081525f R14: 00007f37ad035300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x69/0x1f80 kernel/locking/lockdep.c:4926
Code: df 0f b6 04 10 84 c0 0f 85 fb 15 00 00 83 3d 41 b7 e9 0c 00 0f 84 a8 14 00 00 83 3d d0 29 75 0b 00 74 2b 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 29 04 76 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900167a7b00 EFLAGS: 00010006
RAX: 0000000000000009 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff88802b86ba80 R14: 0000000000000048 R15: 0000000000000001
FS:  00007f37ad035700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37ad014718 CR3: 00000000912ec000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df 0f                	fisttps (%rdi)
   2:	b6 04                	mov    $0x4,%dh
   4:	10 84 c0 0f 85 fb 15 	adc    %al,0x15fb850f(%rax,%rax,8)
   b:	00 00                	add    %al,(%rax)
   d:	83 3d 41 b7 e9 0c 00 	cmpl   $0x0,0xce9b741(%rip)        # 0xce9b755
  14:	0f 84 a8 14 00 00    	je     0x14c2
  1a:	83 3d d0 29 75 0b 00 	cmpl   $0x0,0xb7529d0(%rip)        # 0xb7529f1
  21:	74 2b                	je     0x4e
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 29 04 76 00       	callq  0x760461
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
