Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D336061AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJTNbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTNbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:31:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C61918BA;
        Thu, 20 Oct 2022 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ub1/BqWnc+u3S6gZuqlIRI6PL3Nk/sdK2+QXvb0/fQU=; b=RN5JK4lTNkV7unSEKrdF+0s9/3
        cAJwWtWZWcVCoR1k83daYisqZj0q+OX25fIvm0RQko13gvAImNqVuHFIcq4RGlj4GCNZyocIbo58m
        DjU9444DUyGtC/X4QMzvfdl6SmXjYAvDk6EX/slC2TjYSnmYZKfYCme/5FgRN5p15pfWskTRAPCO+
        JrDtRGG1lHvNI7eIe12Y3zewqUgvvx8wBHzS+PiPGICEbXMbEeZI997mTacqnYJ8uus7tjmJOaQHz
        NH+LEqZtVhB11qij3EOkGj9+e5++8799XHfFLyvy0Vfts2zq9vS/KMfuzBwwtLqxjoayZBSVDnEN1
        1okF8/vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olVe7-00CPQP-8e; Thu, 20 Oct 2022 13:31:39 +0000
Date:   Thu, 20 Oct 2022 14:31:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+e33c2a7e25ff31df5297@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference
 in filemap_read_folio
Message-ID: <Y1FNu60vwt7oJRSu@casper.infradead.org>
References: <00000000000020f00f05eb774338@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020f00f05eb774338@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:25:43AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

NTFS.  Ignored.

> HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=108783e6880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
> dashboard link: https://syzkaller.appspot.com/bug?extid=e33c2a7e25ff31df5297
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e33c2a7e25ff31df5297@syzkaller.appspotmail.com
> 
> ntfs: volume version 3.1.
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD a5bf9067 P4D a5bf9067 PUD 37d2e067 PMD 0 
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 11041 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc9001504f618 EFLAGS: 00010287
> RAX: ffffffff81b64c0e RBX: ffffc9001504f680 RCX: 0000000000040000
> RDX: ffffc9000ae14000 RSI: ffffea0002a61580 RDI: 0000000000000000
> RBP: ffffc9001504f6f8 R08: dffffc0000000000 R09: fffff9400054c2b1
> R10: fffff9400054c2b1 R11: 1ffffd400054c2b0 R12: ffffea0002a61580
> R13: 1ffffd400054c2b1 R14: 0000000000000000 R15: ffffea0002a61588
> FS:  00007f0f425d5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000000a32e1000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  filemap_read_folio+0x1ba/0x7f0 mm/filemap.c:2399
>  do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3526
>  do_read_cache_page mm/filemap.c:3568 [inline]
>  read_cache_page+0x57/0x250 mm/filemap.c:3577
>  read_mapping_page include/linux/pagemap.h:756 [inline]
>  ntfs_map_page fs/ntfs/aops.h:75 [inline]
>  ntfs_check_logfile+0x3f1/0x2a50 fs/ntfs/logfile.c:532
>  load_and_check_logfile+0x6f/0xd0 fs/ntfs/super.c:1215
>  load_system_files+0x3376/0x48d0 fs/ntfs/super.c:1941
>  ntfs_fill_super+0x19a9/0x2bf0 fs/ntfs/super.c:2892
>  mount_bdev+0x26c/0x3a0 fs/super.c:1400
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>  vfs_get_tree+0x88/0x270 fs/super.c:1530
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0f4148cada
> Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0f425d4f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0f4148cada
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0f425d4fe0
> RBP: 00007f0f425d5020 R08: 00007f0f425d5020 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f0f425d4fe0 R15: 00000000200026c0
>  </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc9001504f618 EFLAGS: 00010287
> RAX: ffffffff81b64c0e RBX: ffffc9001504f680 RCX: 0000000000040000
> RDX: ffffc9000ae14000 RSI: ffffea0002a61580 RDI: 0000000000000000
> RBP: ffffc9001504f6f8 R08: dffffc0000000000 R09: fffff9400054c2b1
> R10: fffff9400054c2b1 R11: 1ffffd400054c2b0 R12: ffffea0002a61580
> R13: 1ffffd400054c2b1 R14: 0000000000000000 R15: ffffea0002a61588
> FS:  00007f0f425d5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000000a32e1000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
