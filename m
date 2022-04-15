Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9B502367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349791AbiDOFJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiDOFGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:40 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B995E142
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:01:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id s7-20020a5ec647000000b00652f6c18b62so31706ioo.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 22:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ni5AtDp+T7iui1KdKfLMn+bmCrXjxGB6n+GUU8WNh/A=;
        b=KB27F5Q7W5/WNSS0U6enZdMVK6Jzt+4VYYsxopeyibZfKEmolz/k9vVYSZWQUgDKkk
         CP1O1jx6/hbN4U7YjlA1bxFRIw5ZoE3/XddFA3R8pYr0ZaN9T3G6ftYxD2squZogO2uF
         r7mgNZp/Dey4pfBy2ulGeVULwPXcd1nXDJE8Jce8cPWy2HeXgCVOCmurVdDHvh9Crt26
         GCT1GdVIngZLccfb4518pSCz720hVgBQw5UIzCjvQjtZhjdAyrjo+WeLu4ZrKcWUeu1N
         XZK7l/6JMm3uCZspvjzfnEm/+x2FVeY0I8YsaIDWxihmYrrcGSmMSUAkfBUGUu8XITQz
         dffg==
X-Gm-Message-State: AOAM531ZgTg2hMnu3wswDaZNPJtCn1Xxk+E934qPzhDjWVZlDCoNy4bd
        EEcBxLl7kqhYDUg9RjkVBnY+vtrt/1XDwHM9jXwsmbyrbBFB
X-Google-Smtp-Source: ABdhPJzXyz13wQlKrcYp2dUDjnAyGWsH0ud/S2YFWKrrUSHXjVcQNgmcM0NOwMN5WvYupic0tQQOLwD9LQ+gdTjNdntXnkbLw2Z6
MIME-Version: 1.0
X-Received: by 2002:a02:2410:0:b0:323:fb30:183c with SMTP id
 f16-20020a022410000000b00323fb30183cmr2893332jaa.2.1649998881301; Thu, 14 Apr
 2022 22:01:21 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:01:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000332b2105dcaa4d7a@google.com>
Subject: [syzbot] general protection fault in __dentry_path (2)
From:   syzbot <syzbot+5c550b7ec6a56f70c32d@syzkaller.appspotmail.com>
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

HEAD commit:    d12d7e1cfe38 Add linux-next specific files for 20220411
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120d568f700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58fcaf7d8df169a6
dashboard link: https://syzkaller.appspot.com/bug?extid=5c550b7ec6a56f70c32d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17903a8f700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f03688f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c550b7ec6a56f70c32d@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 1 PID: 3586 Comm: syz-executor395 Not tainted 5.18.0-rc1-next-20220411-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__dentry_path+0x215/0x740 fs/d_path.c:342
Code: be 09 31 ff 41 89 ed 41 83 e5 01 44 89 ee e8 22 fe 96 ff 45 85 ed 75 ce e8 f8 fb 96 ff 48 8b 44 24 20 89 6c 24 18 48 c1 e8 03 <42> 80 3c 30 00 0f 85 d2 04 00 00 48 8b 44 24 10 83 e5 01 89 6c 24
RSP: 0018:ffffc9000376fc30 EFLAGS: 00010206
RAX: 000000000000000a RBX: ffffffff8ba14680 RCX: 0000000000000000
RDX: ffff888025001d40 RSI: ffffffff81e30a28 RDI: 0000000000000003
RBP: 0000000000000a8c R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81e309e5 R11: 0000000000000001 R12: 0000000000000fff
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88805610cfff
FS:  000055555682c300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561836ba9d20 CR3: 000000001d922000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dentry_path_raw+0xc2/0x110 fs/d_path.c:367
 kvm_uevent_notify_change.part.0+0x215/0x450 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5492
 kvm_uevent_notify_change arch/x86/kvm/../../../virt/kvm/kvm_main.c:5459 [inline]
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1198 [inline]
 kvm_put_kvm+0xf7/0xb70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1264
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4795 [inline]
 kvm_dev_ioctl+0x85d/0x1c70 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4811
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8a6670d009
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffded420398 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8a6670d009
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00007f8a666d0ff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8a666d1080
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__dentry_path+0x215/0x740 fs/d_path.c:342
Code: be 09 31 ff 41 89 ed 41 83 e5 01 44 89 ee e8 22 fe 96 ff 45 85 ed 75 ce e8 f8 fb 96 ff 48 8b 44 24 20 89 6c 24 18 48 c1 e8 03 <42> 80 3c 30 00 0f 85 d2 04 00 00 48 8b 44 24 10 83 e5 01 89 6c 24
RSP: 0018:ffffc9000376fc30 EFLAGS: 00010206
RAX: 000000000000000a RBX: ffffffff8ba14680 RCX: 0000000000000000
RDX: ffff888025001d40 RSI: ffffffff81e30a28 RDI: 0000000000000003
RBP: 0000000000000a8c R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81e309e5 R11: 0000000000000001 R12: 0000000000000fff
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88805610cfff
FS:  000055555682c300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561836ba0d90 CR3: 000000001d922000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	be 09 31 ff 41       	mov    $0x41ff3109,%esi
   5:	89 ed                	mov    %ebp,%ebp
   7:	41 83 e5 01          	and    $0x1,%r13d
   b:	44 89 ee             	mov    %r13d,%esi
   e:	e8 22 fe 96 ff       	callq  0xff96fe35
  13:	45 85 ed             	test   %r13d,%r13d
  16:	75 ce                	jne    0xffffffe6
  18:	e8 f8 fb 96 ff       	callq  0xff96fc15
  1d:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  22:	89 6c 24 18          	mov    %ebp,0x18(%rsp)
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 d2 04 00 00    	jne    0x507
  35:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  3a:	83 e5 01             	and    $0x1,%ebp
  3d:	89                   	.byte 0x89
  3e:	6c                   	insb   (%dx),%es:(%rdi)
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
