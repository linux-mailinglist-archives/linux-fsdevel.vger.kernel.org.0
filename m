Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042F6DD2F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjDKGfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDKGfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:35:50 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2892D70
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:35:49 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id m22-20020a0566022e9600b007608fe7d67dso1454403iow.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681194948; x=1683786948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWBfGC8qUn5cdld8DfvyB++HgPa+SWhqOK3mDeu+k4o=;
        b=XDL8dCWY8J68fBJRrwdAzP4gXlYhYEtK27iblo0exx4bwl79JlceLs4oLcCYMnmJSf
         PtpfplK27/zDz4ZJWKuPkRyIok6tJqGlwZN8uQjh3ObA3aScvELNXIUDrHL1gKWG/0bW
         o+fMAtYGYzQHM801jmEW75ZIpayXINKcxJeKqVyCVaI8brqRlIK4e93Ro1HoGn3qBa7P
         canj2eGmHWwzRtYITO1fm/fVfuHKbDxXg+AXz4oaJL81Yk2OTf8mv9roeXu3AmhgVIGY
         1f4XpZhRXdrYjqVFBadMh4xYEhxfXDfWb7K/0nhIQLjTSTx0uBXTNne9Lws9BE5QEEH3
         ckIw==
X-Gm-Message-State: AAQBX9fBLkWZmX++9M2b+uO00H8iGsP5fwzWNx28TOxhkwrjzAIe57RS
        yyXTgMKTg2dxUG7A8tUYW8t4daTSLuaeG5+Rjhph7NJO9gNj
X-Google-Smtp-Source: AKy350bEeigu1zU8GTZHFwnwbbpO7b7Fa+obU8bmiVRRBKmtbn0P5ggmhv5h0/R7YIubfbfAqNdvBGfD3UFSTULmvkl02C89Dybm
MIME-Version: 1.0
X-Received: by 2002:a02:29c9:0:b0:40b:bd5e:7e2e with SMTP id
 p192-20020a0229c9000000b0040bbd5e7e2emr3163779jap.6.1681194948352; Mon, 10
 Apr 2023 23:35:48 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:35:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1e3f505f909b306@google.com>
Subject: [syzbot] [f2fs?] general protection fault in __replace_atomic_write_block
From:   syzbot <syzbot+4420fa19a8667ff0b057@syzkaller.appspotmail.com>
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

HEAD commit:    99ddf2254feb Merge tag 'trace-v6.3-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157372b5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=4420fa19a8667ff0b057
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/907a43450c5c/disk-99ddf225.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a142637e5396/vmlinux-99ddf225.xz
kernel image: https://storage.googleapis.com/syzbot-assets/447736ad6200/bzImage-99ddf225.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4420fa19a8667ff0b057@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 10867 Comm: syz-executor.1 Not tainted 6.3.0-rc5-syzkaller-00032-g99ddf2254feb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:__replace_atomic_write_block+0xf6b/0x1b40 fs/f2fs/segment.c:260
Code: 98 20 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 e4 40 10 fe 4c 8b 33 48 8b 54 24 40 48 89 d0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 ff 02 00 00 44 8b 3a 0f 1f 44 00 00 e8
RSP: 0018:ffffc9001575f5a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888036d63b90 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9001575f6d8
RBP: ffffc9001575f790 R08: dffffc0000000000 R09: ffffc9001575f6c8
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92002aebeda
R13: ffffc9001575f6c0 R14: ffff888036d62c88 R15: dffffc0000000000
FS:  00007f035f153700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ce021a000 CR3: 000000002a4e8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __complete_revoke_list fs/f2fs/segment.c:273 [inline]
 __f2fs_commit_atomic_write fs/f2fs/segment.c:363 [inline]
 f2fs_commit_atomic_write+0x1342/0x15e0 fs/f2fs/segment.c:381
 f2fs_ioc_commit_atomic_write fs/f2fs/file.c:2165 [inline]
 __f2fs_ioctl+0x3a5e/0xb5b0 fs/f2fs/file.c:4169
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f035e48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f035f153168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f035e5ac120 RCX: 00007f035e48c169
RDX: 0000000000000000 RSI: 000000000000f502 RDI: 0000000000000007
RBP: 00007f035e4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc598c6e9f R14: 00007f035f153300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__replace_atomic_write_block+0xf6b/0x1b40 fs/f2fs/segment.c:260
Code: 98 20 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 e4 40 10 fe 4c 8b 33 48 8b 54 24 40 48 89 d0 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 ff 02 00 00 44 8b 3a 0f 1f 44 00 00 e8
RSP: 0018:ffffc9001575f5a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888036d63b90 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9001575f6d8
RBP: ffffc9001575f790 R08: dffffc0000000000 R09: ffffc9001575f6c8
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92002aebeda
R13: ffffc9001575f6c0 R14: ffff888036d62c88 R15: dffffc0000000000
FS:  00007f035f153700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555556ff848 CR3: 000000002a4e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	98                   	cwtl
   1:	20 06                	and    %al,(%rsi)
   3:	00 00                	add    %al,(%rax)
   5:	48 89 d8             	mov    %rbx,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 e4 40 10 fe       	callq  0xfe1040ff
  1b:	4c 8b 33             	mov    (%rbx),%r14
  1e:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 ff 02 00 00    	jne    0x336
  37:	44 8b 3a             	mov    (%rdx),%r15d
  3a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
