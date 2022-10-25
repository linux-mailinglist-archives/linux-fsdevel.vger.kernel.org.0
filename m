Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F760C484
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 09:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJYHAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 03:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJYHAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:00:20 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC441C113;
        Tue, 25 Oct 2022 00:00:13 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id h4so10053786vsr.11;
        Tue, 25 Oct 2022 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t4PC8LZQfuGWUdG/bF4mkCkIWlp4XaI+wmkoFjwUG0g=;
        b=LjHVq5PhU9jc1rmNouVl2+48a6CrNyl3VZnBmjyS2Id99ZYhzsK4cQjdER0ORRmn4l
         U8G3iF4eCf4CMXBznP/u06eWUIg8aFWSz3eTgfM76HdilsKtBh//bvFHVSqwXenaHQxg
         0E/EWZ+xc+17GtDM0c8wwXJ5jFvWT0YS7LpbzL3L/wc/GC2ORKox97TwaGGP0hoKl4uV
         4ZZW9jqxBLTguGqdsMX+OiBSW4sQc//icSlCTuwLYZCv6NRFJbGtPi5GslZX7xyHXGTA
         TOBwv6aisPhsA0i63Z/2oJXLBrBxkTBaajF2C+Ui80rcHy51jdmKDXB6i5SAbUA+oF3k
         iF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4PC8LZQfuGWUdG/bF4mkCkIWlp4XaI+wmkoFjwUG0g=;
        b=Enl9CWAdfgt1fU33hZsVt7S74oR7BJu0666WeOP4ghJbY/5Ak28ZK3LVxQEB+MVXND
         Q+6l13Pz+zzDNulHRwtrVsA53DKXBZS8K4IAo11vPQPZ68KQZIM8suT+EP12PMuNd8H7
         3pd1NDuypBQiIyBrr+ohWAHWkgNPDdnIBwnT6bJ514mYa6B59Fyd0mZba/LfNuZWeA9o
         pbsAyVqz0up20dMIm3nYWsCt4OmlFb5GYgE8tjvKVufPvIwE43KG1CiNn76nQGwtgdOT
         cw+4BuKdoh3xfQeKNaASjcUCrMFfT+FJqQlnvLHbgL5t6zPtE0+TpSAlI4ATjwqNtXeo
         uFJg==
X-Gm-Message-State: ACrzQf37+TKpT3MRASszzGUcxtX2MfwdeCILG5aq5dN3S+Tbg/LhXGLI
        RYgKrtbojmtgP8xQw5UMq7oh0THnaTTxdnj9y3k=
X-Google-Smtp-Source: AMsMyM5GGZDABLs++VcFrBckMfzP0iKYsxO4+uEgStO1BoAIntCYlmpScBSQjrb/wprABeb/pXW+t+h6qJ0awd0Bmms=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr6338415vsj.26.1666681212604; Tue, 25
 Oct 2022 00:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008e8b8505ebca6cc7@google.com> <Y1bCA416yQ9ZVHVQ@casper.infradead.org>
In-Reply-To: <Y1bCA416yQ9ZVHVQ@casper.infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 25 Oct 2022 15:59:55 +0900
Message-ID: <CAKFNMo=Xfzxz=+aTEQQKSu7uQyJWTyKL05P24FSbOLrCrbvKVg@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in filemap_free_folio
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:49 AM Matthew Wilcox wrote:
>
> Adding the nilfs maintainers ...
>
> On Mon, Oct 24, 2022 at 09:38:40AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15788ec2880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f1eb7f33bbf683a5e1e1
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f1eb7f33bbf683a5e1e1@syzkaller.appspotmail.com
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
> > Mem abort info:
> >   ESR = 0x0000000096000005
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> >   FSC = 0x05: level 1 translation fault
> > Data abort info:
> >   ISV = 0, ISS = 0x00000005
> >   CM = 0, WnR = 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=000000014a8d0000
> > [0000000000000050] pgd=08000001532c9003, p4d=08000001532c9003, pud=0000000000000000
> > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 0 PID: 3066 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : filemap_free_folio+0x20/0x288 mm/filemap.c:231
> > lr : filemap_free_folio+0x1c/0x288 mm/filemap.c:227
> > sp : ffff80001280b990
> > x29: ffff80001280b990 x28: ffff000117b4ea00 x27: 0000000000000000
> > x26: 0000000000000001 x25: ffff80000cb6fd9e x24: fffffffffffffffe
> > x23: 0000000000000000 x22: fffffc0004cfa8c0 x21: 0000000000000001
> > x20: ffff0001127af450 x19: fffffc0004cfa8c0 x18: 00000000000003b8
> > x17: ffff80000bffd6bc x16: 0000000000000002 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000003 x12: ffff80000d5f02b0
> > x11: ff808000083c31e8 x10: 0000000000000000 x9 : ffff8000083c31e8
> > x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> > x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> > x2 : 0000000000000006 x1 : fffffc0004cfa8c0 x0 : ffff0001127af450
> > Call trace:
> >  filemap_free_folio+0x20/0x288 mm/filemap.c:231
> >  delete_from_page_cache_batch+0x148/0x184 mm/filemap.c:341
> >  truncate_inode_pages_range+0x174/0xb94 mm/truncate.c:370
> >  truncate_inode_pages mm/truncate.c:452 [inline]
> >  truncate_inode_pages_final+0x8c/0x9c mm/truncate.c:487
> >  nilfs_evict_inode+0x58/0x1cc fs/nilfs2/inode.c:906
> >  evict+0xec/0x334 fs/inode.c:665
> >  dispose_list fs/inode.c:698 [inline]
> >  evict_inodes+0x2e0/0x354 fs/inode.c:748
> >  generic_shutdown_super+0x50/0x190 fs/super.c:480
> >  kill_block_super+0x30/0x78 fs/super.c:1427
> >  deactivate_locked_super+0x70/0xe8 fs/super.c:332
> >  deactivate_super+0xd0/0xd4 fs/super.c:363
> >  cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
> >  __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
> >  task_work_run+0xc4/0x14c kernel/task_work.c:177
> >  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> >  do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
> >  prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
> >  exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
> >  el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
> >  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
> >  el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> > Code: aa0103f3 aa0003f4 97fb728c f940de88 (f9402914)
> > ---[ end trace 0000000000000000 ]---
> > ----------------
> > Code disassembly (best guess):
> >    0: aa0103f3        mov     x19, x1
> >    4: aa0003f4        mov     x20, x0
> >    8: 97fb728c        bl      0xffffffffffedca38
> >    c: f940de88        ldr     x8, [x20, #440]
> > * 10: f9402914        ldr     x20, [x8, #80] <-- trapping instruction
>
> As far as I can tell, this is:
>
>         free_folio = mapping->a_ops->free_folio;
>
> and the first dereference (mapping->a_ops) is offset 440 from mapping,
> which works fine, but is NULL.  So loading aops->free_folio is the
> NULL pointer dereference.
>
> So does nilfs have an address_space with a NULL a_ops?  That doesn't
> seem to be allowed; at least I don't see any checks of a_ops for
> being NULL in the rest of the VFS or MM.

There is no place where a NULL is set to a_ops in NILFS.
All inodes used by NILFS are allocated by either iget5_locked() or
new_inode(), and both of them at least initialize a_ops to &empty_aops
with inode_init_always().  So, I suspect this is caused by UAF or,
less likely, a memory corruption on inode->i_data.

I'm tracking these possibilities, but haven't been able to identify the cause.
One possibility is that this is a variant of the report bug [1], which
can cause an inode UAF:

[1] https://syzkaller.appspot.com/bug?extid=b8c672b0e22615c80fe0

If so, this is fixed in 6.1-rc1, but not enough evidence yet if it's
the same bug.

Regards,
Ryusuke Konishi
