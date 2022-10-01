Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27A85F1C6A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJANmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJANmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:42:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576289ACC
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Oct 2022 06:42:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so4483194ioe.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Oct 2022 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0xJTyD7iFQZTwy/wkUdZQYRzcy4oODVJ1ZQtCb+OhUY=;
        b=yjyuCNf392sL1crYJZB15R2P2RAByuGcBEw0vD0Kdb7cEK0HUL4dIWYyCWZyOnXFCH
         fHqDPhRg2TFmoz55MVvHtODRyNoxXxvEKXarrgcu2Fohu1ptDYqcxuzXtu75i7sZvexA
         wjRnXbLID5iDHlR+yYZpoRTfUg/CRn1On6TvWjGbIuRsEv9zLBOlN2oVNVE/vYpTkAD/
         anj17PI+typD4+ph7BY8xV8NyCy6Fs642UFRAUpjg9tIL7VW5d8jcRTZOOY5oQPByyTt
         AuLp5eet8TmxfW/iGKZ3uM3f353cKu6hTrtS8IRg9Q4J4fyO7XDi9Vgs7K3CHpPRwzZV
         oXqQ==
X-Gm-Message-State: ACrzQf2Gc11yH6PjfoLz8T9ZweAeo0kussHkpWiZonO2tigxinS/IVQ4
        sibrAGVcrYkaGg1e3IIh+cUVzzpMC11a9UtIQfcYjAnuiEHT
X-Google-Smtp-Source: AMsMyM5ZaqXpA8aqgD69BJIGNdJy7Hl6Xr1ndOFlEVsZkXBII+NivIzK5NJxH5fdu84+qJEUnKiNVhDUABiXHCPcEM/nTwlAeH/O
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:2f5:cc0b:fb14 with SMTP id
 j6-20020a056e02218600b002f5cc0bfb14mr6088640ila.315.1664631760281; Sat, 01
 Oct 2022 06:42:40 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:42:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0e5c005e9f94888@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in truncate_inode_pages_final
From:   syzbot <syzbot+3209de1c96568282edc6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119b63ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=3209de1c96568282edc6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0012f6c5db09/disk-3800a713.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c2ba89f2218/vmlinux-3800a713.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3209de1c96568282edc6@syzkaller.appspotmail.com

ntfs3: loop5: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop5: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
BUG: kernel NULL pointer dereference, address: 000000000000002b
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7b94f067 P4D 7b94f067 PUD 21ad8067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15950 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__lock_release kernel/locking/lockdep.c:5350 [inline]
RIP: 0010:lock_release+0x22c/0x780 kernel/locking/lockdep.c:5686
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 a7 04 00 00 <8b> 73 24 85 f6 0f 85 66 04 00 00 48 8d 7b 22 48 b8 00 00 00 00 00
RSP: 0018:ffffc90014787a10 EFLAGS: 00010046
RAX: 0000000000000007 RBX: 0000000000000007 RCX: ffffc90014787a60
RDX: 0000000000000000 RSI: ffff888072fb0518 RDI: ffff888039842ac4
RBP: 1ffff920028f0f44 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888072fb0518
R13: 0000000000000002 R14: ffff888039842a70 R15: ffff888039842000
FS:  00007f7638dfe700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000002b CR3: 00000000281a9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
 _raw_spin_unlock_irq+0x12/0x40 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:399 [inline]
 truncate_inode_pages_final+0x5f/0x80 mm/truncate.c:484
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
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
RIP: 0033:0x7f7639e8bb9a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7638dfdf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000580 RCX: 00007f7639e8bb9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f7638dfdfe0
RBP: 00007f7638dfe020 R08: 00007f7638dfe020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f7638dfdfe0 R15: 0000000020000040
 </TASK>
Modules linked in:
CR2: 000000000000002b
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_release kernel/locking/lockdep.c:5350 [inline]
RIP: 0010:lock_release+0x22c/0x780 kernel/locking/lockdep.c:5686
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 a7 04 00 00 <8b> 73 24 85 f6 0f 85 66 04 00 00 48 8d 7b 22 48 b8 00 00 00 00 00
RSP: 0018:ffffc90014787a10 EFLAGS: 00010046
RAX: 0000000000000007 RBX: 0000000000000007 RCX: ffffc90014787a60
RDX: 0000000000000000 RSI: ffff888072fb0518 RDI: ffff888039842ac4
RBP: 1ffff920028f0f44 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888072fb0518
R13: 0000000000000002 R14: ffff888039842a70 R15: ffff888039842000
FS:  00007f7638dfe700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000002b CR3: 00000000281a9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   7:	fc ff df
   a:	48 89 fa             	mov    %rdi,%rdx
   d:	48 c1 ea 03          	shr    $0x3,%rdx
  11:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
  15:	48 89 f8             	mov    %rdi,%rax
  18:	83 e0 07             	and    $0x7,%eax
  1b:	83 c0 03             	add    $0x3,%eax
  1e:	38 d0                	cmp    %dl,%al
  20:	7c 08                	jl     0x2a
  22:	84 d2                	test   %dl,%dl
  24:	0f 85 a7 04 00 00    	jne    0x4d1
* 2a:	8b 73 24             	mov    0x24(%rbx),%esi <-- trapping instruction
  2d:	85 f6                	test   %esi,%esi
  2f:	0f 85 66 04 00 00    	jne    0x49b
  35:	48 8d 7b 22          	lea    0x22(%rbx),%rdi
  39:	48                   	rex.W
  3a:	b8 00 00 00 00       	mov    $0x0,%eax


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
