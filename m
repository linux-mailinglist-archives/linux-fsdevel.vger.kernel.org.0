Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B895E8BE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiIXLrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIXLrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:47:39 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3070B6011
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 04:47:35 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so1991832ilu.17
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 04:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kz7VThonCNmrsVgT4nn/20It5uuYNl8qH1kr/c0Ij7Q=;
        b=7lNglPcSWOpK2NgIV18TNYuK7JEHJ/qYn8NPj20XO0ubhVQ+3Mkbk/M5HamcCTn/e1
         GSL2drwuNtMoQg6PIU6TPYwQu7ghfbJYSj15bP/B12jwuzEjagTfRCT0Ii7nDFnWHh5F
         04cSa5QbWA57LvM3ZrkqngwuNHrD4EmA6iNpJFtSI3FjGhghTFOW5CaU3X4AZvULhbVy
         Mq452cF3PjzJ7nkUQ69PwOquyCYFqtb8QZ/avozxMh3q7znazTWIYzn/sKhGHXaOyKA+
         fnfSWOI5swEk9yZbod5LykVFAsX3gftNDfuZf6meZT/FKzO5AjTcI1q+mC2Kf9UIAYM5
         q+qw==
X-Gm-Message-State: ACrzQf3+HNPjEhv8jCTDjw1XXOPLerEfn3H23nm+i2m83sFUaOTPr0cC
        vqUFsJywsHTC3/XQh6hjYJjDuWaqfA4KkptGlNQBxfchLlN5
X-Google-Smtp-Source: AMsMyM63X95a0if4uNdqRk5vJz48MHzaxm39aiviajGVQEBuOh9yOJqTNgdf4B8oK/XvK5PzE8VGhbQuo6vSWzW72f2zO/7Q0jMU
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2112:b0:6a4:71a4:ad2c with SMTP id
 x18-20020a056602211200b006a471a4ad2cmr366133iox.43.1664020054546; Sat, 24 Sep
 2022 04:47:34 -0700 (PDT)
Date:   Sat, 24 Sep 2022 04:47:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040201f05e96adc81@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in eventfd_ctx_put
From:   syzbot <syzbot+6f0c896c5a9449a10ded@syzkaller.appspotmail.com>
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

HEAD commit:    521a547ced64 Linux 6.0-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=134ea35f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=6f0c896c5a9449a10ded
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149bfdd8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104808b0880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f0c896c5a9449a10ded@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
BUG: unable to handle page fault for address: ffffffffffffffea
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD bc8f067 P4D bc8f067 PUD bc91067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3606 Comm: syz-executor343 Not tainted 6.0.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:kref_put include/linux/kref.h:64 [inline]
RIP: 0010:eventfd_ctx_put+0x1e/0x110 fs/eventfd.c:112
Code: ff ff e8 65 7e dc ff e9 b5 fb ff ff 41 54 55 48 89 fd 53 bb ff ff ff ff e8 ef 1d 90 ff be 04 00 00 00 48 89 ef e8 72 80 dc ff <f0> 0f c1 5d 00 bf 01 00 00 00 89 de e8 91 1a 90 ff 83 fb 01 74 35
RSP: 0018:ffffc9000365f748 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff81ebeb3e
RDX: fffffbfffffffffe RSI: 0000000000000004 RDI: ffffffffffffffea
RBP: ffffffffffffffea R08: 0000000000000001 R09: ffffffffffffffed
R10: fffffbfffffffffd R11: 0000000000000000 R12: 0000000000000003
R13: ffffffffffffffea R14: ffffc900037b1000 R15: 00000000ffffffea
FS:  0000555556297300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffea CR3: 0000000072461000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_xen_eventfd_assign arch/x86/kvm/xen.c:1721 [inline]
 kvm_xen_setattr_evtchn arch/x86/kvm/xen.c:1780 [inline]
 kvm_xen_hvm_set_attr+0x563/0x1610 arch/x86/kvm/xen.c:486
 kvm_arch_vm_ioctl+0xe39/0x18b0 arch/x86/kvm/x86.c:6790
 kvm_vm_ioctl+0x15df/0x2380 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4811
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd65dc84b69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc633540b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd65dc84b69
RDX: 0000000020000040 RSI: 000000004048aec9 RDI: 0000000000000004
RBP: 00007fd65dc48d10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd65dc48da0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffffffffea
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:kref_put include/linux/kref.h:64 [inline]
RIP: 0010:eventfd_ctx_put+0x1e/0x110 fs/eventfd.c:112
Code: ff ff e8 65 7e dc ff e9 b5 fb ff ff 41 54 55 48 89 fd 53 bb ff ff ff ff e8 ef 1d 90 ff be 04 00 00 00 48 89 ef e8 72 80 dc ff <f0> 0f c1 5d 00 bf 01 00 00 00 89 de e8 91 1a 90 ff 83 fb 01 74 35
RSP: 0018:ffffc9000365f748 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff81ebeb3e
RDX: fffffbfffffffffe RSI: 0000000000000004 RDI: ffffffffffffffea
RBP: ffffffffffffffea R08: 0000000000000001 R09: ffffffffffffffed
R10: fffffbfffffffffd R11: 0000000000000000 R12: 0000000000000003
R13: ffffffffffffffea R14: ffffc900037b1000 R15: 00000000ffffffea
FS:  0000555556297300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffea CR3: 0000000072461000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	e8 65 7e dc ff       	callq  0xffdc7e6a
   5:	e9 b5 fb ff ff       	jmpq   0xfffffbbf
   a:	41 54                	push   %r12
   c:	55                   	push   %rbp
   d:	48 89 fd             	mov    %rdi,%rbp
  10:	53                   	push   %rbx
  11:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  16:	e8 ef 1d 90 ff       	callq  0xff901e0a
  1b:	be 04 00 00 00       	mov    $0x4,%esi
  20:	48 89 ef             	mov    %rbp,%rdi
  23:	e8 72 80 dc ff       	callq  0xffdc809a
* 28:	f0 0f c1 5d 00       	lock xadd %ebx,0x0(%rbp) <-- trapping instruction
  2d:	bf 01 00 00 00       	mov    $0x1,%edi
  32:	89 de                	mov    %ebx,%esi
  34:	e8 91 1a 90 ff       	callq  0xff901aca
  39:	83 fb 01             	cmp    $0x1,%ebx
  3c:	74 35                	je     0x73


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
