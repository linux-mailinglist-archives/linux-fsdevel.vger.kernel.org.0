Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A359598C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiHPLLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiHPLLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:11:01 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7111209B
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id c9-20020a05660221c900b00688a5a621afso1170730ioc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=LIRrM9Er52tS0cvVvdY5Sbdd6KgSVNZLH72A832Pq5s=;
        b=NI0R54iNaBupGZx01z+S3GiF7dFN2eM1HGtGPJmMSAZIDz0BCvA1ygrVRlcNiPjUmP
         xu9OGPtmZ15idWul03WLvY0Z1CGDQq0w6k9OGOyRFzG1/JMFSPYNqqaEO6B47Dgikfbx
         f1bAQyJHwZZxO9qtpoOA64JYnuU+CCGuRbs/d/AHvuvRnGjs6nwkeXuEVtmr4nxZSl/8
         +U9GdrMiqLc24aElmZuKZ8x9YXnfaSO+vn7yRFCHjq5xiEgiHMeeXK5rU3+wyHLb9VRm
         fcGbLe9wuDoCR77W83hOo2oSa6ZTmJjitqBn0Kp2kEFLRc07wIQ8xhl2GpxqhOkecS5z
         XExQ==
X-Gm-Message-State: ACgBeo1/5SdJIW9ggpMqDKfkEaLzdF5U9S4e8cwGr1WClbarZM9B8cx9
        sIfELXoAoWOApmtscDYawA78Mg5tMeJw8BzR1PcRgG5vKkZ+
X-Google-Smtp-Source: AA6agR5shgoxwqRTco3PC25nkmTsDzI/3TYQ1SSIQwdJv+o5Pi+qaVILR1CWQMOqYebZ9T+1kkGpssIkklEp2o1Uoir5WMFP/4j+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ca:b0:346:a62f:cc9f with SMTP id
 l10-20020a05663814ca00b00346a62fcc9fmr1436694jak.163.1660639162312; Tue, 16
 Aug 2022 01:39:22 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005eae9a05e657afc9@google.com>
Subject: [syzbot] upstream boot error: general protection fault in dup_fd
From:   syzbot <syzbot+0bd8bc660debfdbd190d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a9350597aff Merge tag 'sound-fix-6.0-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169a15dd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4757943c2b26daff
dashboard link: https://syzkaller.appspot.com/bug?extid=0bd8bc660debfdbd190d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bd8bc660debfdbd190d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff0000000001a0: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000000d00-0xfff8200000000d07]
CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 5.19.0-syzkaller-14090-g4a9350597aff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events_unbound call_usermodehelper_exec_work

RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
RIP: 0010:kmem_cache_alloc+0x12d/0x310 mm/slub.c:3268
Code: 84 1c 01 00 00 48 83 78 10 00 0f 84 11 01 00 00 49 8b 3f 40 f6 c7 0f 0f 85 e3 01 00 00 45 84 c0 0f 84 dc 01 00 00 41 8b 47 28 <49> 8b 5c 05 00 48 8d 4a 08 4c 89 e8 65 48 0f c7 0f 0f 94 c0 a8 01
RSP: 0000:ffffc90000b775c8 EFLAGS: 00010202
RAX: 00000000000001a0 RBX: 0000000000000cc0 RCX: 0000000000000000
RDX: 0000000000000b51 RSI: 0000000000000cc0 RDI: 0000000000040a00
RBP: ffffffff81f3d035 R08: dffffc0000000001 R09: fffffbfff1c4ad5e
R10: fffffbfff1c4ad5e R11: 1ffffffff1c4ad5d R12: ffffc90000b77720
R13: ffff000000000000 R14: ffffffff81f3d035 R15: ffff888140006640
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dup_fd+0x75/0xb90 fs/file.c:324
 copy_files+0xe6/0x200 kernel/fork.c:1623
 copy_process+0x18b6/0x4010 kernel/fork.c:2244
 kernel_clone+0x22f/0x7a0 kernel/fork.c:2673
 user_mode_thread+0x12d/0x190 kernel/fork.c:2742
 call_usermodehelper_exec_work+0x57/0x220 kernel/umh.c:174
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	84 1c 01             	test   %bl,(%rcx,%rax,1)
   3:	00 00                	add    %al,(%rax)
   5:	48 83 78 10 00       	cmpq   $0x0,0x10(%rax)
   a:	0f 84 11 01 00 00    	je     0x121
  10:	49 8b 3f             	mov    (%r15),%rdi
  13:	40 f6 c7 0f          	test   $0xf,%dil
  17:	0f 85 e3 01 00 00    	jne    0x200
  1d:	45 84 c0             	test   %r8b,%r8b
  20:	0f 84 dc 01 00 00    	je     0x202
  26:	41 8b 47 28          	mov    0x28(%r15),%eax
* 2a:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx <-- trapping instruction
  2f:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  33:	4c 89 e8             	mov    %r13,%rax
  36:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3b:	0f 94 c0             	sete   %al
  3e:	a8 01                	test   $0x1,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
