Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935E7553D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 23:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiFUVTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355818AbiFUVTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:19:02 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180322F659
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:04:35 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so9929919ila.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C+3Mp5eGJJIAr0nNvTRNoEHotNhZy1SzSYyrJ1qhGOM=;
        b=qEFTlILK60hoCJanIvMY36opLc9p7Xx61xD9z39dC7ajTjV0AIaaK+ft9PZmmobUGQ
         BPLiA7rBBJ06zThGh+r9qdtOnLFOqeBbSrhQJ68dH6PPojOU3e60epMiZ5mKnJN3oxrX
         ndsHxVoB6B18/wlAbdgHeuw66pDeTGQJbWjmB17hbW8pHcoEYCdlg/Mmqar/qbaUVNF7
         qGKrZTWKxiyC7muhQsUZrCvjuyv7fpoOFssvjZWWuKDqtUi6SomUVoKlprMrQl4qe+0P
         c3EoOi93uX81XfIubR5/Zwf5E84AoORtNGo44wuKxm8KQ+wm+8GbFMTe2z8ICGrE+zIQ
         COcA==
X-Gm-Message-State: AJIora84FD2A5izw1qrvvCa8Bn9lR+pneJcd71szPScDwWwMxbG0/Bw8
        e75c43BhU9/KFLr2G0icQpdd7xidU2SiOnnROYvppYp34f7Y
X-Google-Smtp-Source: AGRyM1sSwSuEpD8CazXxC+Sjb+PX5IKY/ITJdC4XGJ7MaOqbylO8rX/M02XfpKscvH+Ko7Rjsw61gFt0SfI94zSwPOQcVzbrjudm
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:78a:b0:2d3:af3f:a9e2 with SMTP id
 q10-20020a056e02078a00b002d3af3fa9e2mr115686ils.96.1655845474431; Tue, 21 Jun
 2022 14:04:34 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:04:34 -0700
In-Reply-To: <00000000000073aa8605e1df6ab9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e7a7505e1fb919f@google.com>
Subject: Re: [syzbot] general protection fault in do_mpage_readpage
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    34d1d36073ea Add linux-next specific files for 20220621
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11eeec3ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b24b62d1c051cfc8
dashboard link: https://syzkaller.appspot.com/bug?extid=dbbd022e608bb122cf4e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1216c174080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14362fd8080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbbd022e608bb122cf4e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8191
ntfs3: loop0: Mark volume as dirty due to NTFS errors
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3604 Comm: syz-executor200 Not tainted 5.19.0-rc3-next-20220621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:map_buffer_to_folio fs/mpage.c:107 [inline]
RIP: 0010:do_mpage_readpage+0xfe8/0x19f0 fs/mpage.c:228
Code: 85 ed 0f 84 98 01 00 00 49 be 00 00 00 00 00 fc ff df 4c 89 ed 45 31 e4 eb 2c e8 73 8f 93 ff 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 53 08 00 00 48 8b 6d 08 41 83 c4 01 49 39 ed
RSP: 0018:ffffc90002f9f7c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880206957c0 RSI: ffffffff81e72ddd RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc90002f9f960
FS:  000055555626d300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007e93c000 CR4: 00000000003506f0
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
 read_mapping_page include/linux/pagemap.h:756 [inline]
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
RIP: 0033:0x7f240cf2feaa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefafe8648 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffefafe86a0 RCX: 00007f240cf2feaa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffefafe8660
RBP: 00007ffefafe8660 R08: 00007ffefafe86a0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200034e8
R13: 0000000000000003 R14: 0000000000000004 R15: 000000000000021f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:map_buffer_to_folio fs/mpage.c:107 [inline]
RIP: 0010:do_mpage_readpage+0xfe8/0x19f0 fs/mpage.c:228
Code: 85 ed 0f 84 98 01 00 00 49 be 00 00 00 00 00 fc ff df 4c 89 ed 45 31 e4 eb 2c e8 73 8f 93 ff 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 53 08 00 00 48 8b 6d 08 41 83 c4 01 49 39 ed
RSP: 0018:ffffc90002f9f7c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880206957c0 RSI: ffffffff81e72ddd RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffc90002f9f960
FS:  000055555626d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f240cf1fd20 CR3: 000000007e93c000 CR4: 00000000003506e0
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
  1a:	e8 73 8f 93 ff       	callq  0xff938f92
  1f:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 53 08 00 00    	jne    0x888
  35:	48 8b 6d 08          	mov    0x8(%rbp),%rbp
  39:	41 83 c4 01          	add    $0x1,%r12d
  3d:	49 39 ed             	cmp    %rbp,%r13

