Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B060B725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiJXTU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiJXTUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:20:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631184C2D8;
        Mon, 24 Oct 2022 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GAA+twGNDeaPAzEOVLEHkS7mFrAV7A+aL5F5kQnQ4PU=; b=LKdhPmq7UGavg1rKa4gDzIfhHy
        S2Hh+D4esuS/0ECE6dSboiimpFZhw+TYQPXD0V0o+GAFAJgRZ5PQXjI8qvUDQSIzCz6PDNDm5XRnQ
        YtGu9lwFKFKquGp2hSqQTwE+R3AMUhfgzUvpxlxc9Bng6NyGUTn01pg/pUSO5vvVLOjuBUpYbEg9Z
        2mjjm1PkTmWKQNQUAFAPNUAE0Xih+q9LZamKdUf2QhlFC58lEohFhKfEFSgHfP8UJ9MamnBM+WxUM
        Z25qZw9De/n5ngD4Z94ee7Ye5JDQXflXuH8L5SFT/qDAJx9fCSCaI3H+t9NvduGfuBVLYlfFNRFN7
        7ALuZkEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on0dP-00FaWA-Nb; Mon, 24 Oct 2022 16:49:07 +0000
Date:   Mon, 24 Oct 2022 17:49:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference
 in filemap_free_folio
Message-ID: <Y1bCA416yQ9ZVHVQ@casper.infradead.org>
References: <0000000000008e8b8505ebca6cc7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008e8b8505ebca6cc7@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding the nilfs maintainers ...

On Mon, Oct 24, 2022 at 09:38:40AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=15788ec2880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=f1eb7f33bbf683a5e1e1
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005
>   CM = 0, WnR = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000014a8d0000
> [0000000000000050] pgd=08000001532c9003, p4d=08000001532c9003, pud=0000000000000000
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 3066 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : filemap_free_folio+0x20/0x288 mm/filemap.c:231
> lr : filemap_free_folio+0x1c/0x288 mm/filemap.c:227
> sp : ffff80001280b990
> x29: ffff80001280b990 x28: ffff000117b4ea00 x27: 0000000000000000
> x26: 0000000000000001 x25: ffff80000cb6fd9e x24: fffffffffffffffe
> x23: 0000000000000000 x22: fffffc0004cfa8c0 x21: 0000000000000001
> x20: ffff0001127af450 x19: fffffc0004cfa8c0 x18: 00000000000003b8
> x17: ffff80000bffd6bc x16: 0000000000000002 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000003 x12: ffff80000d5f02b0
> x11: ff808000083c31e8 x10: 0000000000000000 x9 : ffff8000083c31e8
> x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000006 x1 : fffffc0004cfa8c0 x0 : ffff0001127af450
> Call trace:
>  filemap_free_folio+0x20/0x288 mm/filemap.c:231
>  delete_from_page_cache_batch+0x148/0x184 mm/filemap.c:341
>  truncate_inode_pages_range+0x174/0xb94 mm/truncate.c:370
>  truncate_inode_pages mm/truncate.c:452 [inline]
>  truncate_inode_pages_final+0x8c/0x9c mm/truncate.c:487
>  nilfs_evict_inode+0x58/0x1cc fs/nilfs2/inode.c:906
>  evict+0xec/0x334 fs/inode.c:665
>  dispose_list fs/inode.c:698 [inline]
>  evict_inodes+0x2e0/0x354 fs/inode.c:748
>  generic_shutdown_super+0x50/0x190 fs/super.c:480
>  kill_block_super+0x30/0x78 fs/super.c:1427
>  deactivate_locked_super+0x70/0xe8 fs/super.c:332
>  deactivate_super+0xd0/0xd4 fs/super.c:363
>  cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
>  __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
>  task_work_run+0xc4/0x14c kernel/task_work.c:177
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
>  prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
>  el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> Code: aa0103f3 aa0003f4 97fb728c f940de88 (f9402914) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	aa0103f3 	mov	x19, x1
>    4:	aa0003f4 	mov	x20, x0
>    8:	97fb728c 	bl	0xffffffffffedca38
>    c:	f940de88 	ldr	x8, [x20, #440]
> * 10:	f9402914 	ldr	x20, [x8, #80] <-- trapping instruction

As far as I can tell, this is:

        free_folio = mapping->a_ops->free_folio;

and the first dereference (mapping->a_ops) is offset 440 from mapping,
which works fine, but is NULL.  So loading aops->free_folio is the
NULL pointer dereference.

So does nilfs have an address_space with a NULL a_ops?  That doesn't
seem to be allowed; at least I don't see any checks of a_ops for
being NULL in the rest of the VFS or MM.
