Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58F65CE60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjADIdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 03:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjADIct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:32:49 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545C1A050
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 00:32:44 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso2927802ioj.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 00:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSkahVvsZRBcROIks7EB2xw2wtudP/Y4o1gq5YY7s6U=;
        b=yVdyjmeaD9MrHjECqcp8BdM1gea6S/oYSV5+8OSiiJfpoVtLJb8iB4/Uda4BEfixD3
         l7uwI9Qdw3/bSv3YrYtY2NWpZFqpyFxhSJoXR4cCblvft9CNeQvxTqvPZkSIt1NKRDO3
         nkOzE1eG4Uxqxb7f9OKP1Y8aZ/lfwkIcPRosZzIIRgPKa2jc5rbH6Xt440U0OcLMnm2A
         cr9cDbvnTv3meY4I9Q6MraDb5imeOYy7XZ2yOVbJhYOD0hNDsiFGY9d/pblxuj8+2L97
         tA94Sukb6Nit5YC2B8+Of9TWTHL99ZGoE/cyrFy4SqBLElMv26ql7cI6uTs1CCy9RoGO
         VDzw==
X-Gm-Message-State: AFqh2kqecvMO1NGpRrtBsOE+d6AADZ2NeNUy0936v8ZgPxaRAEq50QYG
        dniebkUszWwkXFQK62L/ZM120VTccIi3ZB+d8wLWXu7B0KRL
X-Google-Smtp-Source: AMrXdXtDRr97kUF2j/fbhG0KhegAO9e4L0gJ+1BjTm7gykvGulfEWCM4JqlJI1CbeRTtJqPdCsiTb73H1FEPV3cHGnmhxBme5Hx0
MIME-Version: 1.0
X-Received: by 2002:a92:a007:0:b0:30c:1ec6:23d0 with SMTP id
 e7-20020a92a007000000b0030c1ec623d0mr1985774ili.134.1672821164142; Wed, 04
 Jan 2023 00:32:44 -0800 (PST)
Date:   Wed, 04 Jan 2023 00:32:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f98c05f16c0792@google.com>
Subject: [syzbot] [ntfs?] BUG: unable to handle kernel paging request in step_into
From:   syzbot <syzbot+0994679b6f098bb3da6d@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10341ca2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=0994679b6f098bb3da6d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11307974480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c567f2480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1982d688f97/disk-bff687b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7c5609f900d/vmlinux-bff687b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4e79832281/bzImage-bff687b3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ad10dc248cd4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0994679b6f098bb3da6d@syzkaller.appspotmail.com

ntfs: (device loop0): check_windows_hibernation_status(): Failed to find inode number for hiberfil.sys.
ntfs: (device loop0): load_system_files(): Failed to determine if Windows is hibernated.  Will not be able to remount read-write.  Run chkdsk.
ntfs: (device loop0): ntfs_lookup(): ntfs_lookup_ino_by_name() failed with error code 83886016.
BUG: unable to handle page fault for address: fffffbffff600008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5067 Comm: syz-executor133 Not tainted 6.2.0-rc1-syzkaller-00068-gbff687b3dad6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:traverse_mounts fs/namei.c:1428 [inline]
RIP: 0010:handle_mounts fs/namei.c:1540 [inline]
RIP: 0010:step_into+0x197/0x10f0 fs/namei.c:1831
Code: 38 00 49 89 c7 74 0a 48 8b 7c 24 38 e8 b2 60 ec ff 48 8b 9c 24 d8 00 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <8a> 04 08 84 c0 0f 85 4f 0c 00 00 8b 1b 89 de 81 e6 00 00 07 00 31
RSP: 0018:ffffc90003b8f680 EFLAGS: 00010a02
RAX: 1fffffffff600008 RBX: fffffffffb000040 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b8f7e0 R08: ffffffff81f52253 R09: ffffed100e6185a9
R10: ffffed100e6185a9 R11: 1ffff1100e6185a8 R12: ffffc90003b8f750
R13: ffffc90003b8fba0 R14: 0000000000000000 R15: 1ffff92000771eeb
FS:  0000555555c7b300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbffff600008 CR3: 0000000071d1d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x17d/0x450 fs/namei.c:2474
 do_o_path+0x84/0x240 fs/namei.c:3685
 path_openat+0x27cd/0x2dd0 fs/namei.c:3707
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51b212dc49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3c84b5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f51b212dc49
RDX: 0000000000000000 RSI: 0000000001ee0000 RDI: 0000000020000340
RBP: 00007f51b20ed250 R08: 00007ffe3c84b4b0 R09: 0000000000000000
R10: 00007ffe3c84b4a0 R11: 0000000000000246 R12: 00007f51b20ed2e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: fffffbffff600008
---[ end trace 0000000000000000 ]---
RIP: 0010:traverse_mounts fs/namei.c:1428 [inline]
RIP: 0010:handle_mounts fs/namei.c:1540 [inline]
RIP: 0010:step_into+0x197/0x10f0 fs/namei.c:1831
Code: 38 00 49 89 c7 74 0a 48 8b 7c 24 38 e8 b2 60 ec ff 48 8b 9c 24 d8 00 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <8a> 04 08 84 c0 0f 85 4f 0c 00 00 8b 1b 89 de 81 e6 00 00 07 00 31
RSP: 0018:ffffc90003b8f680 EFLAGS: 00010a02
RAX: 1fffffffff600008 RBX: fffffffffb000040 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b8f7e0 R08: ffffffff81f52253 R09: ffffed100e6185a9
R10: ffffed100e6185a9 R11: 1ffff1100e6185a8 R12: ffffc90003b8f750
R13: ffffc90003b8fba0 R14: 0000000000000000 R15: 1ffff92000771eeb
FS:  0000555555c7b300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbffff600008 CR3: 0000000071d1d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	38 00                	cmp    %al,(%rax)
   2:	49 89 c7             	mov    %rax,%r15
   5:	74 0a                	je     0x11
   7:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
   c:	e8 b2 60 ec ff       	callq  0xffec60c3
  11:	48 8b 9c 24 d8 00 00 	mov    0xd8(%rsp),%rbx
  18:	00
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	8a 04 08             	mov    (%rax,%rcx,1),%al <-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 4f 0c 00 00    	jne    0xc84
  35:	8b 1b                	mov    (%rbx),%ebx
  37:	89 de                	mov    %ebx,%esi
  39:	81 e6 00 00 07 00    	and    $0x70000,%esi
  3f:	31                   	.byte 0x31


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
