Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAE551770
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiFTL3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbiFTL3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:29:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B11658D
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 04:29:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h23-20020a056e021d9700b002d8c9f2533bso7271652ila.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 04:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xKXRJMNzc5wwH4cnZivBAA+dumwpeCzTjiScw/2vxiI=;
        b=p1kIy4nrOSi8HkckLiGVFVl3m6XYR+GVrCwy67p6dSOmzajni7SMKp+f4R9bi+JjR/
         D6DgHPazONMNISlXgjt/7+s8VygmZ1DwAdsIdx1wbIikss/+WP+aEAQ4qz92T8HJ9d0A
         B8myhPQpDEjstAYWVA+8RZIrtee5FNv5TzHCIJkJQEwDsCncACeSBBHXHfJbqmv1sUdx
         suxLd1W2LlWwP0/tbfcpG6MYmqCM2gPUruUhZVV7Js4JJNa0MQKeb224oNySdhuvmu97
         ipB/8kCr9G/a0s91KOnX9YOsC20KWwbE4NwaF46FoNsVKhcmDgDRzIh3CFOb5swDBalr
         Kl7w==
X-Gm-Message-State: AJIora+elj+DzincSSxDQ6SpAldR8Xe+yacM7yOdK7iARRn96JB7gv6l
        SLqQVl0KBNCptHxk8+pWid0+TZsOJSyeHQdmyXHz5mzNUPuJ
X-Google-Smtp-Source: AGRyM1sttVyGqG5Ek/szqEEVbpNqkt1RU1QCZFxnQBHageBQlvZlBveKD8j/PgOHA0k9UzY4L5tLaZbko9VInhCP62/L4Y+6AyTf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b5:b0:331:acf2:1111 with SMTP id
 b21-20020a05663801b500b00331acf21111mr13164415jaq.115.1655724563473; Mon, 20
 Jun 2022 04:29:23 -0700 (PDT)
Date:   Mon, 20 Jun 2022 04:29:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073aa8605e1df6ab9@google.com>
Subject: [syzbot] general protection fault in do_mpage_readpage
From:   syzbot <syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com>
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

HEAD commit:    1e502319853c Add linux-next specific files for 20220620
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1738ba60080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58357279cb2cfd50
dashboard link: https://syzkaller.appspot.com/bug?extid=dbbd022e608bb122cf4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 8191
 loop1:
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 8799 Comm: syz-executor.1 Not tainted 5.19.0-rc3-next-20220620-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:map_buffer_to_folio fs/mpage.c:107 [inline]
RIP: 0010:do_mpage_readpage+0xfe8/0x19f0 fs/mpage.c:228
Code: 85 ed 0f 84 98 01 00 00 49 be 00 00 00 00 00 fc ff df 4c 89 ed 45 31 e4 eb 2c e8 63 79 92 ff 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 53 08 00 00 48 8b 6d 08 41 83 c4 01 49 39 ed
RSP: 0018:ffffc900043c77c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000002 RCX: ffffc90003e61000
RDX: 0000000000040000 RSI: ffffffff81e8340d RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc900043c7960
FS:  00007fa91daa5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555556e708 CR3: 0000000050217000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mpage_read_folio+0xa5/0x140 fs/mpage.c:378
 ntfs_read_folio+0x148/0x1e0 fs/ntfs3/inode.c:706
 filemap_read_folio+0x3c/0x1d0 mm/filemap.c:2396
 do_read_cache_folio+0x251/0x5b0 mm/filemap.c:3521
 do_read_cache_page mm/filemap.c:3563 [inline]
 read_cache_page+0x59/0x2a0 mm/filemap.c:3572
 read_mapping_page include/linux/pagemap.h:758 [inline]
 ntfs_map_page fs/ntfs3/ntfs_fs.h:897 [inline]
 ntfs_fill_super+0x27e9/0x3730 fs/ntfs3/super.c:1145
 get_tree_bdev+0x4a2/0x7e0 fs/super.c:1294
 vfs_get_tree+0x89/0x2f0 fs/super.c:1501
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fa91c88a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa91daa4f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fa91c88a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fa91daa4fe0
RBP: 00007fa91daa5020 R08: 00007fa91daa5020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fa91daa4fe0 R15: 000000002007c8e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:map_buffer_to_folio fs/mpage.c:107 [inline]
RIP: 0010:do_mpage_readpage+0xfe8/0x19f0 fs/mpage.c:228
Code: 85 ed 0f 84 98 01 00 00 49 be 00 00 00 00 00 fc ff df 4c 89 ed 45 31 e4 eb 2c e8 63 79 92 ff 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 53 08 00 00 48 8b 6d 08 41 83 c4 01 49 39 ed
RSP: 0018:ffffc900043c77c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000002 RCX: ffffc90003e61000
RDX: 0000000000040000 RSI: ffffffff81e8340d RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc900043c7960
FS:  00007fa91daa5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555556e708 CR3: 0000000050217000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 ed                	test   %ebp,%ebp
   2:	0f 84 98 01 00 00    	je     0x1a0
   8:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
   f:	fc ff df
  12:	4c 89 ed             	mov    %r13,%rbp
  15:	45 31 e4             	xor    %r12d,%r12d
  18:	eb 2c                	jmp    0x46
  1a:	e8 63 79 92 ff       	callq  0xff927982
  1f:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 53 08 00 00    	jne    0x888
  35:	48 8b 6d 08          	mov    0x8(%rbp),%rbp
  39:	41 83 c4 01          	add    $0x1,%r12d
  3d:	49 39 ed             	cmp    %rbp,%r13


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
