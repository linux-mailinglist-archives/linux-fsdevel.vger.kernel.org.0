Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE549202F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgFVFhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 01:37:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36488 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbgFVFhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:37:13 -0400
Received: by mail-il1-f198.google.com with SMTP id p11so11298250iln.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 22:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cpaY6T13Mb4bMtkiV6CeoIG4AgtudaG0i+Oecz1sBW8=;
        b=dbHUem8DYdvfbzTPbW2tpVQohDOw72v9Yg4SJvWMBmq5r7+jGEiiMUbTeMEK74S36R
         b0S/nNbdkR0NsU7riIvMMsQCyJnqaJpQYg3RtiHWXHZo+yEsObLshVuPdnfhDloMikHV
         tx9rzy+CBEHVo323Mxi8jPhANQqJOOMs4pbREqGSLoIPxk04jc06kxM0j5XBIKkwHKCT
         kogMUj2xZm6qjykbBeh7qGA8mXBoA137U3FhEGPCKOj4QBzc/fR6QJF11l+1oIKokpYY
         cNbVsS0acSynsgce83jgfCVNhvTipYuJe06I2l1bewyXfgg5wHSJ14hAfdNpZGQcE/H2
         QXXA==
X-Gm-Message-State: AOAM531kLdwXqF2cmEl310BKc4Y4xHk7SlapGgNncYQtcPjxjUTGg5DF
        VNUQMM4K99nmjbLQqhwa1MjFQb8G7uGphlxIfNbVD6mhp+Kz
X-Google-Smtp-Source: ABdhPJyZLXokxLSD62AaShOk6YnHbK4l4xUIwUqGVGw24FGSnh45gqfFH91qp3WY4cc67bOKz9smqYwH45hdWHtQ1SELa8GcJ3We
MIME-Version: 1.0
X-Received: by 2002:a6b:b984:: with SMTP id j126mr17321213iof.114.1592804230920;
 Sun, 21 Jun 2020 22:37:10 -0700 (PDT)
Date:   Sun, 21 Jun 2020 22:37:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000617f9d05a8a5a2c4@google.com>
Subject: linux-next boot error: WARNING in kmem_cache_free
From:   syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a94f5bc Add linux-next specific files for 20200621
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a02c76100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1788c418b2ddc66
dashboard link: https://syzkaller.appspot.com/bug?extid=95bccd805a4aa06a4b0d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/slab.h:232 kmem_cache_free+0x0/0x200 mm/slab.c:2262
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc1-next-20200621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x2f/0x3a kernel/panic.c:600
 report_bug+0x271/0x2f0 lib/bug.c:198
 exc_invalid_op+0x1b9/0x370 arch/x86/kernel/traps.c:235
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:kmem_cache_debug_flags mm/slab.h:232 [inline]
RIP: 0010:cache_from_obj mm/slab.h:459 [inline]
RIP: 0010:kmem_cache_free+0x0/0x200 mm/slab.c:3678
Code: ff 49 c7 84 24 90 00 00 00 00 00 00 00 83 c3 01 39 1d 2c ec fb 08 77 af 5b 5d 41 5c 41 5d c3 90 66 2e 0f 1f 84 00 00 00 00 00 <0f> 0b 48 85 ff 0f 84 a9 01 00 00 48 83 3d 15 6b 02 08 00 0f 84 9c
RSP: 0000:ffffffff89a07a58 EFLAGS: 00010293
RAX: ffffffff89a86580 RBX: ffff8880aa01f0e8 RCX: ffffffff81a84573
RDX: 0000000000000000 RSI: ffff8880aa01f480 RDI: ffff8880aa00fe00
RBP: ffff8880aa01f4a8 R08: ffffffff89a86580 R09: fffffbfff1340f3f
R10: 0000000000000003 R11: fffffbfff1340f3e R12: ffff8880aa01f4b0
R13: ffff8880aa01f688 R14: ffff8880aa01f480 R15: ffffc90000000000
 adjust_va_to_fit_type mm/vmalloc.c:980 [inline]
 __alloc_vmap_area mm/vmalloc.c:1096 [inline]
 alloc_vmap_area+0x1494/0x1df0 mm/vmalloc.c:1196
 __get_vm_area_node+0x178/0x3b0 mm/vmalloc.c:2060
 __vmalloc_node_range+0x12c/0x910 mm/vmalloc.c:2484
 __vmalloc_node mm/vmalloc.c:2532 [inline]
 __vmalloc_area_node mm/vmalloc.c:2404 [inline]
 __vmalloc_node_range+0x76c/0x910 mm/vmalloc.c:2489
 __vmalloc_node mm/vmalloc.c:2532 [inline]
 __vmalloc+0x69/0x80 mm/vmalloc.c:2546
 alloc_large_system_hash+0x1c9/0x2e2 mm/page_alloc.c:8181
 inode_init+0xab/0xbc fs/inode.c:2099
 vfs_caches_init+0x104/0x11e fs/dcache.c:3231
 start_kernel+0x978/0x9fb init/main.c:1025
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
