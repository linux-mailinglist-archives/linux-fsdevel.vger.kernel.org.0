Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1E59B044
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiHTUDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiHTUCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:02:46 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C032068
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:02:26 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h8-20020a92c268000000b002e95299cff0so2631571ild.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0ti6bdWx7eJyJTMvgibKwHk7j3bL4kbd6UHfX1PdkdM=;
        b=F6JpNBFAx/KBSFYI23CEDLX9DW+6hqHZcHoX4uEKtuZw9ICKEFVVjox1ge56OsfdPB
         C4iroJRhgllYx+1ahIqE1yRKnOCCewiBYV6UJAdMz2cmcFAmpXLfbb6M8j9FeEaRi7PA
         hHSvs7924tOuDRPkWL3KdI0Ek4EJw8u3XGYaXboLadHOo/baulYCquuZKOcIwit9Lxhi
         OC1cpHQwncsDgEZ1cM2AVlAb0GyFMUX+9w41Y63lwj0okVWuND9mrDaGQscoajkt63Qc
         tVEIKCBt31sD2eum5aRSOJIFTdKrXzKOwMY0OSHqEj1tMcnIKhv73D8sndOlWtlHbFRK
         tZNg==
X-Gm-Message-State: ACgBeo0ZwDG5BOt5/OznVLQ4g36HkJ5ZwV/UIRMxNxZB/dA0jLZQBGvK
        zHAwW/ql2MuKYmGeepSjB7F5c4lT6MVcqKhO8msqeFFr+Lxp
X-Google-Smtp-Source: AA6agR40X3ivhOiMhcBs0aGUPcAZswpztm9Xr9dtno5uKWoy5SpuLtlMJqetyRN7ua6t0OOAZDf7kE3d0XvhK471Slok4MGuS4ay
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:2df:21fd:5a6b with SMTP id
 m5-20020a056e021c2500b002df21fd5a6bmr6302990ilh.128.1661025745851; Sat, 20
 Aug 2022 13:02:25 -0700 (PDT)
Date:   Sat, 20 Aug 2022 13:02:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b5c5405e6b1b158@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in getname_kernel
From:   syzbot <syzbot+ef0cb91001b03cc06610@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=179f7647080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=ef0cb91001b03cc06610
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef0cb91001b03cc06610@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 0 PID: 299 Comm: kworker/u4:1 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x15d/0x4a0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 7c 02 00 00 48 85 c0 0f 84 73 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 7b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900017afe50 EFLAGS: 00010246
RAX: ffff000000000000 RBX: 000000000000000e RCX: 0000000000000800
RDX: 00000000000007f0 RSI: 0000000000000cc0 RDI: 000000000003e6c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810016e500
R13: 0000000000000cc0 R14: ffffffff8183a35e R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 getname_kernel+0x4e/0x370 fs/namei.c:227
 kernel_execve+0x7a/0x500 fs/exec.c:1970
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x15d/0x4a0 mm/slub.c:3268
Code: 51 08 48 8b 01 48 83 79 10 00 48 89 04 24 0f 84 7c 02 00 00 48 85 c0 0f 84 73 02 00 00 49 8b 3c 24 41 8b 4c 24 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 7b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900017afe50 EFLAGS: 00010246

RAX: ffff000000000000 RBX: 000000000000000e RCX: 0000000000000800
RDX: 00000000000007f0 RSI: 0000000000000cc0 RDI: 000000000003e6c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810016e500
R13: 0000000000000cc0 R14: ffffffff8183a35e R15: 0000000000000cc0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	51                   	push   %rcx
   1:	08 48 8b             	or     %cl,-0x75(%rax)
   4:	01 48 83             	add    %ecx,-0x7d(%rax)
   7:	79 10                	jns    0x19
   9:	00 48 89             	add    %cl,-0x77(%rax)
   c:	04 24                	add    $0x24,%al
   e:	0f 84 7c 02 00 00    	je     0x290
  14:	48 85 c0             	test   %rax,%rax
  17:	0f 84 73 02 00 00    	je     0x290
  1d:	49 8b 3c 24          	mov    (%r12),%rdi
  21:	41 8b 4c 24 28       	mov    0x28(%r12),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 7b 02 00 00    	jne    0x2af
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
