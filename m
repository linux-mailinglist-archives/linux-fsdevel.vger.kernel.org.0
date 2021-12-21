Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C347C679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhLUSYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbhLUSYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:24:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755DC061574;
        Tue, 21 Dec 2021 10:24:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so55587975edv.1;
        Tue, 21 Dec 2021 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Hq3RnoiEcvsan7k4kj7uVUUhz/68iMva3y9mC4g9r4=;
        b=Ybw0cZ1JFCzgBmFoMH/eDNFmW/OePKcv8QQxFv9GfMzP/5czSPytZK25bULpvKc8fd
         lsV7uykSq9M3UChWpWNq1QEash3+BA5THLEYk0kTjfWBPZkP+dzh3H0u1QMiYZEiCyg/
         g9ncntDZG0Zfj25OmuRKOT7718h9YKuw7rCC9cKilxkMqwFgrQa9Dgis9anXJdP2PuqQ
         aqBPXBd0I/aDnnk2Y7hmNDku/ucJS/j26KkpEJm3O0IHc8EXkK32vAUD3gJIHjrPEFXo
         n2TvdM9+YgzLqDxdmNgmOUTnR5uL91et0+kOUsVl9uOamaCeeNs0FSgdVGzUcaIA2hGd
         FG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hq3RnoiEcvsan7k4kj7uVUUhz/68iMva3y9mC4g9r4=;
        b=O3pddCfQKxBfayhxu8PoajrFGk4fgiwo0ZAepW+YUvL2Y0R2xI79uyJTIanbkCBCbt
         B59u4FKY3rLJGqAAccJnzl7RUqaWCUfIa1DKpU/+9HUL2poOPu27e0TRmtHeaWFPXp0H
         TazvWaAbE0t9WWQy+Tw4Q9JmAfFcWubW/jtzzakkCtYf4h/KJIuXWSHlAWHX+apdhCMJ
         mzOHn2BONTGZiuLHJtkQQKIOb/rnK8VyTuA2KqPwmbzhsJgt7NposrXfUb1Jmo1KeXbr
         lQEmterLqbZ8vOpwtPv2os0ke/23RVBIneQ5Lff+bzBbPG2qQ18aeBdiXGTKwDEBQbE9
         EEhg==
X-Gm-Message-State: AOAM533CkWAs9qJdx2vnpR/93aZrSGFax60nkakud7OPURqRCXdK2gng
        ngcxVmQTl/USJp/PagMnHJSao5o/V5lt3S3u0d4=
X-Google-Smtp-Source: ABdhPJxtKe2UvpiwF9LTZHjaKfr64yPN7TlecVJLgQzxmyesSlzRK//2jzWoSFX7uRR/b083Z+63tcso5zVOkKebZ4Q=
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr3726701ejj.612.1640111079503;
 Tue, 21 Dec 2021 10:24:39 -0800 (PST)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com> <0000000000009411bb05d3ab468f@google.com>
In-Reply-To: <0000000000009411bb05d3ab468f@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Dec 2021 10:24:27 -0800
Message-ID: <CAHbLzkoU_giAFiOyhHZvxLT9Vie2-8TmQv_XLDpRxbec5r5weg@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __page_mapcount
To:     syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        chinwen.chang@mediatek.com, fgheet255t@gmail.com,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        Vlastimil Babka <vbabka@suse.cz>, walken@google.com,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 9:24 AM syzbot
<syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    6e0567b73052 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c192b3b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae22d1ee4fbca18
> dashboard link: https://syzkaller.appspot.com/bug?extid=1f52b3a18d5633fa7f82
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133200fdb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c3102db00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com
>
>  __mmput+0x122/0x4b0 kernel/fork.c:1113
>  mmput+0x56/0x60 kernel/fork.c:1134
>  exit_mm kernel/exit.c:507 [inline]
>  do_exit+0xb27/0x2b40 kernel/exit.c:819
>  do_group_exit+0x125/0x310 kernel/exit.c:929
>  get_signal+0x47d/0x2220 kernel/signal.c:2852
>  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
>  handle_signal_work kernel/entry/common.c:148 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:785!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 4392 Comm: syz-executor560 Not tainted 5.16.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
> RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744

It seems the THP is split during smaps walk. The reproducer does call
MADV_FREE on partial THP which may split the huge page.

The below fix (untested) should be able to fix it.

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad667dbc96f5..97feb15a2448 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -433,6 +433,7 @@ static void smaps_account(struct mem_size_stats
*mss, struct page *page,
 {
        int i, nr = compound ? compound_nr(page) : 1;
        unsigned long size = nr * PAGE_SIZE;
+       struct page *head = compound_head(page);

        /*
         * First accumulate quantities that depend only on |size| and the type
@@ -462,6 +463,11 @@ static void smaps_account(struct mem_size_stats
*mss, struct page *page,
                        locked, true);
                return;
        }
+
+       /* Lost the race with THP split */
+       if (!get_page_unless_zero(head))
+               return;
+
        for (i = 0; i < nr; i++, page++) {
                int mapcount = page_mapcount(page);
                unsigned long pss = PAGE_SIZE << PSS_SHIFT;
@@ -470,6 +476,8 @@ static void smaps_account(struct mem_size_stats
*mss, struct page *page,
                smaps_page_accumulate(mss, page, PAGE_SIZE, pss, dirty, locked,
                                      mapcount < 2);
        }
+
+       put_page(head);
 }


> Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
> RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
> RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
> R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
> R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
> FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  page_mapcount include/linux/mm.h:837 [inline]
>  smaps_account+0x470/0xb10 fs/proc/task_mmu.c:466
>  smaps_pte_entry fs/proc/task_mmu.c:538 [inline]
>  smaps_pte_range+0x611/0x1250 fs/proc/task_mmu.c:601
>  walk_pmd_range mm/pagewalk.c:128 [inline]
>  walk_pud_range mm/pagewalk.c:205 [inline]
>  walk_p4d_range mm/pagewalk.c:240 [inline]
>  walk_pgd_range mm/pagewalk.c:277 [inline]
>  __walk_page_range+0xe23/0x1ea0 mm/pagewalk.c:379
>  walk_page_vma+0x277/0x350 mm/pagewalk.c:530
>  smap_gather_stats.part.0+0x148/0x260 fs/proc/task_mmu.c:768
>  smap_gather_stats fs/proc/task_mmu.c:741 [inline]
>  show_smap+0xc6/0x440 fs/proc/task_mmu.c:822
>  seq_read_iter+0xbb0/0x1240 fs/seq_file.c:272
>  seq_read+0x3e0/0x5b0 fs/seq_file.c:162
>  vfs_read+0x1b5/0x600 fs/read_write.c:479
>  ksys_read+0x12d/0x250 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7faa2af6c969
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007faa2aefd288 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007faa2aff4418 RCX: 00007faa2af6c969
> RDX: 0000000000002025 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007faa2aff4410 R08: 00007faa2aefd700 R09: 0000000000000000
> R10: 00007faa2aefd700 R11: 0000000000000246 R12: 00007faa2afc20ac
> R13: 00007fff7e6632bf R14: 00007faa2aefd400 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 24ec93ff95e4ac3d ]---
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
> RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
> Code: e8 d3 16 d1 ff 48 c7 c6 c0 00 b6 89 48 89 ef e8 94 4e 04 00 0f 0b e8 bd 16 d1 ff 48 c7 c6 60 01 b6 89 48 89 ef e8 7e 4e 04 00 <0f> 0b e8 a7 16 d1 ff 48 c7 c6 a0 01 b6 89 4c 89 f7 e8 68 4e 04 00
> RSP: 0018:ffffc90002b6f7b8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888019619d00 RSI: ffffffff81a68c12 RDI: 0000000000000003
> RBP: ffffea0001bdc2c0 R08: 0000000000000029 R09: 00000000ffffffff
> R10: ffffffff8903e29f R11: 00000000ffffffff R12: 00000000ffffffff
> R13: 00000000ffffea00 R14: ffffc90002b6fb30 R15: ffffea0001bd8001
> FS:  00007faa2aefd700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff7e663318 CR3: 0000000018c6e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
