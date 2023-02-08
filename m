Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609FC68E4ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 01:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBHAWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 19:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBHAWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:22:02 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B1B442
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 16:21:58 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l5-20020a056e020e4500b00313cbbd4729so5083916ilk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 16:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxLYic0BDZ9IraDnBU1xwnuc80rQL3cz5kVMZkz8uuE=;
        b=DyTvfYTYFF9GHPa28KsYJeP959cKiyu5JpjwaKACYfqCMno3H24kVbd0SQtibYLQrN
         ak5BFHlGzhDSstS/lxRx4prppezVGN6nvSQtSPBwqc4PhRWaEh2tuSoHioP2fPXXkqhk
         aJ+YwMpwvVqbilzWXELf1Q70CLNXb/lLZ0+XLwaZo+cpLry8RHF53bX51FzwigIDPuM8
         s9CUuzO6S97fnaFFPQ9R6t3/u1WbUpdZYKiWTK7e0lYnmKlyW5CCwjgSryS1E/nNqc6T
         F/GVgRh96dlzMumCmacwH+TB/PmL9oIVIBWbtVHDlbxo0JAe8k2sMQYn3mla37REZPym
         nl3A==
X-Gm-Message-State: AO0yUKXsMXyQzRE51FAcfK5ATDtUlSZCRhF8LJCecJ44xtlZZ8eUT3ya
        bt0e+fBwQnbov2nTC306fliwZA2tNRywLhM+GNgH08i2EoFW
X-Google-Smtp-Source: AK7set+oO5hy66du0UrS3qGtCPu4blh+Uqk1ZOoAh6DKIzsCMWUaVQ5eNLgTlht6TV5RMN2jzK7Uuxxm9JX3nHh3GUFxXr8n8iG9
MIME-Version: 1.0
X-Received: by 2002:a02:bb12:0:b0:39d:234a:8f18 with SMTP id
 y18-20020a02bb12000000b0039d234a8f18mr3535423jan.123.1675815718138; Tue, 07
 Feb 2023 16:21:58 -0800 (PST)
Date:   Tue, 07 Feb 2023 16:21:58 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096b80c05f4254067@google.com>
Subject: [syzbot] general protection fault in iomap_dio_bio_iter
From:   syzbot <syzbot+a4f579527ea6394140a5@syzkaller.appspotmail.com>
To:     djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=148cef45480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=a4f579527ea6394140a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1245a3c3480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132bfad9480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4f579527ea6394140a5@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 5141 Comm: syz-executor393 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:iov_iter_reexpand include/linux/uio.h:299 [inline]
RIP: 0010:iomap_dio_bio_iter+0xa44/0x1440 fs/iomap/direct-io.c:373
Code: 6c 24 38 48 c1 ea 03 80 3c 02 00 0f 85 5b 08 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 40 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f9 07 00 00 4c 8b 7c 24 38 31 ff 48 89 6b 10 4c
RSP: 0018:ffffc90003eaf638 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff820211f4 RDI: 0000000000000010
RBP: 000000000000ee00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801ccc0640
R13: ffff888029cea000 R14: ffffc90003eaf828 R15: ffffc90003eaf828
FS:  00007f0424eb1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0424e90718 CR3: 000000007ab39000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_dio_iter fs/iomap/direct-io.c:436 [inline]
 __iomap_dio_rw+0xd81/0x1d80 fs/iomap/direct-io.c:594
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0424f212a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0424eb12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0424faa4d0 RCX: 00007f0424f212a9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
RBP: 00007f0424f7727c R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffff04 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007f0424f77078 R14: 0000000020000600 R15: 00007f0424faa4d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iov_iter_reexpand include/linux/uio.h:299 [inline]
RIP: 0010:iomap_dio_bio_iter+0xa44/0x1440 fs/iomap/direct-io.c:373
Code: 6c 24 38 48 c1 ea 03 80 3c 02 00 0f 85 5b 08 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5d 40 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f9 07 00 00 4c 8b 7c 24 38 31 ff 48 89 6b 10 4c
RSP: 0018:ffffc90003eaf638 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff820211f4 RDI: 0000000000000010
RBP: 000000000000ee00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801ccc0640
R13: ffff888029cea000 R14: ffffc90003eaf828 R15: ffffc90003eaf828
FS:  00007f0424eb1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0424f46d30 CR3: 000000007ab39000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	6c                   	insb   (%dx),%es:(%rdi)
   1:	24 38                	and    $0x38,%al
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 5b 08 00 00    	jne    0x86c
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	49 8b 5d 40          	mov    0x40(%r13),%rbx
  1f:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 f9 07 00 00    	jne    0x82d
  34:	4c 8b 7c 24 38       	mov    0x38(%rsp),%r15
  39:	31 ff                	xor    %edi,%edi
  3b:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
  3f:	4c                   	rex.WR


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
