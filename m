Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE89593469
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiHOSBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiHOSBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:01:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF629C96
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:01:31 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e2-20020a056e020b2200b002e1a5b67e29so5559038ilu.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=3sgGWROvpPX7osNJCRx6Ia34nyM6KYC3TuaOx+aet5U=;
        b=33gFM+jaR4rl6DVcFHEsEoFotW1TnH4xcyqWS8nl0vfIed5OHV0mXGUsmUfCq2kxWD
         gT/dd3Fia7TpmE3Zbc8HfepO1/oQJvnYUYeqe4CWJcylejwYKgKV8m7IQApQERMfb43q
         K4tqfB2YGLk6MOj4bnd5t1NKAz4/CMA34OR3kbOGfFWZ0C5q3lX7h7pJnK3ExOCdyiLt
         f4hlBCdVIq2ZXdi79qXrj2/Y9KMLghH9PAiv7sZcbdjJTPwQ+UGgE0smfK7V2wQmvkdo
         vJsi/Q/Uk0//2pyeIwXgYd1clsKYpfRfo9zrb3dRWtLK3tMdYBDf4aXSXn9/iWpXvFDe
         O8lg==
X-Gm-Message-State: ACgBeo2o0f4cXoj5zrECdu3EYtdc5lu37Qrf1Q7+YUjSwS1zoFhUhHuO
        gqbKAvCX5169WjgribAiMlwEjt3EsDaHab0oqZ2Fjyp4MScH
X-Google-Smtp-Source: AA6agR7X9OHh7mHsHq41mRM3kiBs7wuQrw+u6LlWbTaTrFtd/giExCoZ1ZCKzGFyCEGq/lohbm2/ARg4+ZlEhItnUWeGwfGdY5QL
MIME-Version: 1.0
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id
 9-20020a021d09000000b0033ba8cc17d3mr7400845jaj.25.1660586490872; Mon, 15 Aug
 2022 11:01:30 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e84b3305e64b6b92@google.com>
Subject: [syzbot] usb-testing boot error: kernel BUG in __phys_addr
From:   syzbot <syzbot+005efde5e97744047fe4@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10049fc3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=005efde5e97744047fe4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005efde5e97744047fe4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1183 Comm: udevd Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__phys_addr+0xd3/0x140 arch/x86/mm/physaddr.c:28
Code: e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 66 85 33 00 48 85 db 75 0f e8 7c 88 33 00 4c 89 e0 5b 5d 41 5c 41 5d c3 e8 6d 88 33 00 <0f> 0b e8 66 88 33 00 48 c7 c0 10 c0 84 87 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900005a7c48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff000000000000 RCX: 0000000000000000
RDX: ffff888116509c80 RSI: ffffffff81128083 RDI: 0000000000000006
RBP: ffff000080000000 R08: 0000000000000006 R09: ffff000080000000
R10: ffff778000000000 R11: 0000000000000000 R12: ffff778000000000
R13: ffffc900005a7cb0 R14: ffff000000000000 R15: 0000000000000000
FS:  00007f178556a840(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb659f080 CR3: 00000001165bd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:856 [inline]
 virt_to_slab mm/kasan/../slab.h:175 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x86/0x170 mm/kasan/quarantine.c:184
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x78/0x80 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x354/0x4a0 mm/slub.c:3268
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags include/linux/audit.h:320 [inline]
 getname+0x8e/0xd0 fs/namei.c:218
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1305
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f17856c1697
Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
RSP: 002b:00007ffc93f6eed0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055d283d25ae0 RCX: 00007f17856c1697
RDX: 0000000000080000 RSI: 00007ffc93f6f008 RDI: 00000000ffffff9c
RBP: 00007ffc93f6f008 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055d283d25ae0 R14: 0000000000000001 R15: 000055d2833eb160
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0xd3/0x140 arch/x86/mm/physaddr.c:28
Code: e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 66 85 33 00 48 85 db 75 0f e8 7c 88 33 00 4c 89 e0 5b 5d 41 5c 41 5d c3 e8 6d 88 33 00 <0f> 0b e8 66 88 33 00 48 c7 c0 10 c0 84 87 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900005a7c48 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff000000000000 RCX: 0000000000000000
RDX: ffff888116509c80 RSI: ffffffff81128083 RDI: 0000000000000006
RBP: ffff000080000000 R08: 0000000000000006 R09: ffff000080000000
R10: ffff778000000000 R11: 0000000000000000 R12: ffff778000000000
R13: ffffc900005a7cb0 R14: ffff000000000000 R15: 0000000000000000
FS:  00007f178556a840(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb659f080 CR3: 00000001165bd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
