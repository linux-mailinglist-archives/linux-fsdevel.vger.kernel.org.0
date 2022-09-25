Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5C5E90D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIYDRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 23:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIYDRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 23:17:33 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975473F1D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 20:17:32 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id d24-20020a05660225d800b006a466ec7746so1056139iop.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 20:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qKoAOWYX6Kkc9a/Rwca5y14AYUPxP/bsj0b5491IKYc=;
        b=C6Hgg9OYy15JsA0Tyzu8EBLKeBnQpoabwX/8Nv1bLjTRxLL+FEXRR0sODv+f1sQGyQ
         khJOxa4zTWeuaaat/3H+7PEVqVUJgYJbiSbcZExwMy3wgrhZAvuArf4RGUEEMxkEL2mD
         5mlgJqlOqLoPqpkuj0pcnzFDqbbPnwf6WDI7k3ZzOE7LV3wZmOIROeQprkpo5EKvfiAT
         aEJrYy9wIStfVHQ0iPz7NjiM5J+kMlTQLw+l2wZ8pfnRD8ef9aAnrsYzO/jdfm6RErP0
         XQkmWIpEwJ5tPKxODrydUq4qlMTyGmb9obkBe0C9bB+t+Srb824bNbsuH/2FEAUKKH1B
         klAQ==
X-Gm-Message-State: ACrzQf28N4Jd5OjN2U3X4DElsLsA1yqIv2x6QGjmfSJAm0+I6BdzfS0a
        GNV7TogQdb/dTHcgK8xXIuj/6r4FbF/o1KqDTFEbPrMd4CR8
X-Google-Smtp-Source: AMsMyM4jCZZd0v0+LIf90aVUeTKPBrANEiU1QQ/xUOEjoYh6+XBEqDqZTuGz1ffk7j4PJ2dHAN/isdP5VozX7DFPCyeMwXwTDN4x
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c3:b0:68b:b670:2bbb with SMTP id
 l3-20020a05660227c300b0068bb6702bbbmr6721700ios.201.1664075851971; Sat, 24
 Sep 2022 20:17:31 -0700 (PDT)
Date:   Sat, 24 Sep 2022 20:17:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009408f05e977da5d@google.com>
Subject: [syzbot] general protection fault in d_flags_for_inode
From:   syzbot <syzbot+2f012b85ac8ce9be92e5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    1a61b828566f Merge tag 'char-misc-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125f60d4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=2f012b85ac8ce9be92e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13153c4c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156e2650880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367e34e7ff83/disk-1a61b828.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91a2819fe451/vmlinux-1a61b828.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f012b85ac8ce9be92e5@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS' sector size (2048) and media sector size (512)
ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
ntfs3: loop0: Failed to load $Extend.
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 3605 Comm: syz-executor204 Not tainted 6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:d_flags_for_inode+0x21b/0x2a0 fs/dcache.c:1980
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 69 49 83 7c 24 08 00 75 34 e8 82 95 9f ff 41 83 cd
RSP: 0018:ffffc900039afb40 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff888072cad370 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81dc7352 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8880700a0000 R15: ffff888020d02088
FS:  0000555556e83300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd13507000 CR3: 000000007498a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __d_instantiate+0x21/0x450 fs/dcache.c:1998
 d_instantiate fs/dcache.c:2036 [inline]
 d_instantiate fs/dcache.c:2030 [inline]
 d_make_root+0xae/0x110 fs/dcache.c:2071
 ntfs_fill_super+0x31eb/0x37f0 fs/ntfs3/super.c:1269
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa9945b147a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd13506ac8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd13506b20 RCX: 00007fa9945b147a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd13506ae0
RBP: 00007ffd13506ae0 R08: 00007ffd13506b20 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000320
R13: 0000000000000003 R14: 0000000000000004 R15: 000000000000000c
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:d_flags_for_inode+0x21b/0x2a0 fs/dcache.c:1980
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 69 49 83 7c 24 08 00 75 34 e8 82 95 9f ff 41 83 cd
RSP: 0018:ffffc900039afb40 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff888072cad370 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff81dc7352 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8880700a0000 R15: ffff888020d02088
FS:  0000555556e83300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd13507000 CR3: 000000007498a000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	89 fa                	mov    %edi,%edx
   2:	48 c1 ea 03          	shr    $0x3,%rdx
   6:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   a:	0f 85 90 00 00 00    	jne    0xa0
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	4c 8b 63 20          	mov    0x20(%rbx),%r12
  1e:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 69                	jne    0x99
  30:	49 83 7c 24 08 00    	cmpq   $0x0,0x8(%r12)
  36:	75 34                	jne    0x6c
  38:	e8 82 95 9f ff       	callq  0xff9f95bf
  3d:	41                   	rex.B
  3e:	83                   	.byte 0x83
  3f:	cd                   	.byte 0xcd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
