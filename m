Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7899F6E5879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 07:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDRFT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 01:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRFTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:19:55 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89A40E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 22:19:54 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7606d443ba6so173530039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 22:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795193; x=1684387193;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EkSKbD3eoojm/3dW3UUphvfgDJcrY6Csmz7EFWMEeI=;
        b=MW6RQIvEMT4vD4+yfpauAXK3fWkF/11F8qnH+8sDyQJgG4uPnLDiDzrhcoGZqor2X3
         d+v9FmwM14xZ59yXDnDigZ9lsAl4uJIaTffxo5zJnPxbr8GPrmRwcrgZrlFjF5jD8WkB
         tHiJ1ceXPT7Cf1PpQQAzdtUg6/x0Ujhm5szhv7UZJM4T+kyLXvlvIQZRWB7S0ZXtbBdB
         H+E9YkJiH2XhaEEYVorkoR+KiE278l87SXvnbTEEKpHKEoYHDIPdWZl6CMypY3IEEsYH
         YGGnJpjY+oPnEQpOx8EzmW/joHW11mguEJpt/+OhmCS4uGy9eFhRbLURLo4XdthUWueY
         iZmw==
X-Gm-Message-State: AAQBX9cHgoSoxE8fmcflq6zhGicdRyCFotoPrUxwTEeVnG/j5YQGbnsF
        br4wM0QZq4ViRJOa9t++kBiSUygs/xK85GO2DpwNNvQn+FuQ
X-Google-Smtp-Source: AKy350Y+6Nb7R/u2bBiERtZyM4fdgLtGUv0S4JmPAcRL+EXLv47lZCcTt5pcp3yNqZcYO00mGbb38VZoqVhb9LrxRWouJXCQuIbE
MIME-Version: 1.0
X-Received: by 2002:a02:2a0d:0:b0:40f:6396:7ec2 with SMTP id
 w13-20020a022a0d000000b0040f63967ec2mr612125jaw.6.1681795193523; Mon, 17 Apr
 2023 22:19:53 -0700 (PDT)
Date:   Mon, 17 Apr 2023 22:19:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001852d105f99575a4@google.com>
Subject: [syzbot] [ext4?] general protection fault in ext4_write_begin
From:   syzbot <syzbot+30250de45664aed70a33@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3f2cd248191 Add linux-next specific files for 20230414
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1515f12bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bfb4b5a90a0c284c
dashboard link: https://syzkaller.appspot.com/bug?extid=30250de45664aed70a33
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/332dc2b1c8dc/disk-d3f2cd24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f7ee353fbc5/vmlinux-d3f2cd24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29e1c27a3e68/bzImage-d3f2cd24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30250de45664aed70a33@syzkaller.appspotmail.com

R13: 00007ffdd4c49f9f R14: 00007f9bd81c2300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 16783 Comm: syz-executor.4 Not tainted 6.3.0-rc6-next-20230414-syzkaller-12018-gd3f2cd248191 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:folio_get_private include/linux/mm_types.h:419 [inline]
RIP: 0010:ext4_write_begin+0x2e3/0x1020 fs/ext4/inode.c:1186
Code: f0 00 00 00 e8 fe 9f 83 ff 48 85 c0 49 89 c5 0f 84 36 0b 00 00 e8 6d d6 56 ff 49 8d 45 28 48 89 84 24 80 00 00 00 48 c1 e8 03 <42> 80 3c 30 00 0f 85 eb 0c 00 00 49 83 7d 28 00 0f 84 ba 09 00 00
RSP: 0018:ffffc900031cf8c8 EFLAGS: 00010207
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffc90005d1a000
RDX: 0000000000040000 RSI: ffffffff822ca023 RDI: ffffffff8c8f09d0
RBP: ffff888022788380 R08: 0000000000000001 R09: ffffffff8c8f09d3
R10: fffffbfff191e13a R11: 0000000000000000 R12: ffff888022788000
R13: fffffffffffffff4 R14: dffffc0000000000 R15: ffff8880378f20b0
FS:  00007f9bd81c2700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb11b0f6000 CR3: 00000000286bc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_da_write_begin+0x223/0x8b0 fs/ext4/inode.c:2917
 generic_perform_write+0x256/0x570 mm/filemap.c:3921
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 call_write_iter include/linux/fs.h:1854 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0xa1d/0xe40 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9bd748c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9bd81c2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9bd75abf80 RCX: 00007f9bd748c169
RDX: 00000000000101bf RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007f9bd81c21d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdd4c49f9f R14: 00007f9bd81c2300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_get_private include/linux/mm_types.h:419 [inline]
RIP: 0010:ext4_write_begin+0x2e3/0x1020 fs/ext4/inode.c:1186
Code: f0 00 00 00 e8 fe 9f 83 ff 48 85 c0 49 89 c5 0f 84 36 0b 00 00 e8 6d d6 56 ff 49 8d 45 28 48 89 84 24 80 00 00 00 48 c1 e8 03 <42> 80 3c 30 00 0f 85 eb 0c 00 00 49 83 7d 28 00 0f 84 ba 09 00 00
RSP: 0018:ffffc900031cf8c8 EFLAGS: 00010207
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffc90005d1a000
RDX: 0000000000040000 RSI: ffffffff822ca023 RDI: ffffffff8c8f09d0
RBP: ffff888022788380 R08: 0000000000000001 R09: ffffffff8c8f09d3
R10: fffffbfff191e13a R11: 0000000000000000 R12: ffff888022788000
R13: fffffffffffffff4 R14: dffffc0000000000 R15: ffff8880378f20b0
FS:  00007f9bd81c2700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007000 CR3: 00000000286bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	e8 fe 9f 83 ff       	callq  0xff83a005
   7:	48 85 c0             	test   %rax,%rax
   a:	49 89 c5             	mov    %rax,%r13
   d:	0f 84 36 0b 00 00    	je     0xb49
  13:	e8 6d d6 56 ff       	callq  0xff56d685
  18:	49 8d 45 28          	lea    0x28(%r13),%rax
  1c:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  23:	00
  24:	48 c1 e8 03          	shr    $0x3,%rax
* 28:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2d:	0f 85 eb 0c 00 00    	jne    0xd1e
  33:	49 83 7d 28 00       	cmpq   $0x0,0x28(%r13)
  38:	0f 84 ba 09 00 00    	je     0x9f8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
