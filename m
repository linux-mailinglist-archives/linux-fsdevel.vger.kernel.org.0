Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B45F973D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJJDsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJJDsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:48:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116833E775;
        Sun,  9 Oct 2022 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IcIYXTLRcwKaMMbRHPLJSn98o6CCKkxx9ceIyhJNs7Q=; b=Q9a+YOI3JrySsIP0kLFRuDT6tp
        VgeY3Mk30/OSUyGsxtM6NkPZRb4mWLm4/ZA8tBj9gABZ3KUtBZ5CL9nXQiqTjj+4Kor+yTgmT3ELv
        YzgVZMDaiPPDQXCJR3ylNHNr5SOlCte0ZvOzfxqGdK0oN71XazNXf4FeI4e/vF9rFyXQ7Psl2Jniu
        VCxaXcr1VsW3cAVVMx0t7LEPV+uf4YGj9eaA5P3KEXlL7Qwu9kxL0lYBzrH2dEqncvkGFKq4X+Jwd
        V/y3YqjNE3ldq5JjEFee9hNKZUNJPSrYdljaBnD5efQy2z4RfY3QxAUDbj7NWLu8Dm4roOuEcX075
        +2FJ5Lmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohjm8-003vCb-EA; Mon, 10 Oct 2022 03:48:20 +0000
Date:   Mon, 10 Oct 2022 04:48:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Subject: Re: [syzbot] BUG: scheduling while atomic in exit_to_user_mode_loop
Message-ID: <Y0OWBChTBr86DdNv@casper.infradead.org>
References: <00000000000006aa2405ea93b166@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000006aa2405ea93b166@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Yet another ntfs bug.  It's getting really noisy.  Maybe stop testing
ntfs until some more bugs get fixed?

On Sat, Oct 08, 2022 at 10:55:34PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b1382a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d323d85b1f8a4ed7
> dashboard link: https://syzkaller.appspot.com/bug?extid=cceb1394467dba9c62d9
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1755e8b2880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c40d70ae7512/disk-0326074f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3603ce065271/vmlinux-0326074f.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/738016e3c6ba/mount_1.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com
> 
> ntfs3: loop2: Different NTFS' sector size (1024) and media sector size (512)
> BUG: scheduling while atomic: syz-executor.2/9901/0x00000002
> 2 locks held by syz-executor.2/9901:
>  #0: ffff888075f880e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
>  #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
>  #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28
> Modules linked in:
> Preemption disabled at:
> [<0000000000000000>] 0x0
> Kernel panic - not syncing: scheduling while atomic
> CPU: 1 PID: 9901 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  panic+0x2d6/0x715 kernel/panic.c:274
>  __schedule_bug+0x1ff/0x250 kernel/sched/core.c:5725
>  schedule_debug+0x1d3/0x3c0 kernel/sched/core.c:5754
>  __schedule+0xfb/0xdf0 kernel/sched/core.c:6389
>  schedule+0xcb/0x190 kernel/sched/core.c:6571
>  exit_to_user_mode_loop+0xe5/0x150 kernel/entry/common.c:157
>  exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
>  irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
>  asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
> RIP: 000f:lock_acquire+0x1e1/0x3c0
> RSP: 0018:ffffc9000563f900 EFLAGS: 00000206
> RAX: 1ffff92000ac7f28 RBX: 0000000000000001 RCX: ffff8880753be2f0
> RDX: dffffc0000000000 RSI: ffffffff8a8d9060 RDI: ffffffff8aecb5e0
> RBP: ffffc9000563fa28 R08: dffffc0000000000 R09: fffffbfff1fc4229
> R10: fffffbfff1fc4229 R11: 1ffffffff1fc4228 R12: dffffc0000000000
> R13: 1ffff92000ac7f24 R14: ffffc9000563f940 R15: 0000000000000246
>  </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
