Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B1456050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhKRQVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 11:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhKRQVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:21:30 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA0C061574;
        Thu, 18 Nov 2021 08:18:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id t26so28461674lfk.9;
        Thu, 18 Nov 2021 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxLsOUDWYk88aKEpbiTevjrSQXURKGh6epUonZ9cK9c=;
        b=P1SOfE9clr5KmKMxsiApitRVV1e+aQZVfQ2qx14TUQP0Ti2fkkrHtcwNqP7dQwDV3I
         lQmK1rPAL1f1vAzfCbBZ/xbhQfuCHy6cVW491fq4T7OBszQf982Q/HA5r3LNBjAZSZh/
         Vff4jPszmrxUdkIj4oGRwpXmt6i+9lFvBxB4MjZqvpfNBlmqpnhMHnIic1ssMwD2yand
         plcuOQq3Qy2fvC76y7ZSStZczOaJ6zejG+vOKKaDyooaM/VL/Ikgf20yIrLGlk9sMRo5
         fxQipIf9hZGYmArWXnqIbiS64pvD1Wow0pYmDXechvKCTZe8Fj8Tp0vVr2l+6EfsyFA3
         KJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxLsOUDWYk88aKEpbiTevjrSQXURKGh6epUonZ9cK9c=;
        b=jXGE8S1Uyh4UWrTl5s5t95D9LouLghOsqVaq96sa7eN1/4xpsHeHVRg4n5QsEvesX5
         8AFzv/Hc6miz09lcLKHM0ajXa7T6Xn4sqDjM28bmiZSdc37GJ6ymQ8vblCJV5D7wlI0m
         ehvp1BM9w5w4vaWwDD5yv87Jkxp8LMZjsRBvwDecWs4v40XMlVE+2Douql+ICqNOZvhx
         lSKxMq0mmmdfi8k2HjUxQqqN6yaHlnucoaPnuGWIyImkHb2vt8S7mlb9Q2WcQCbFa1W5
         F5dwprk2mjgcCPgDPvdy44M9Ugfoh4NTxPOFmjNEhPyui/B++fLuoMtpHY5IydEiqnoZ
         M7NA==
X-Gm-Message-State: AOAM530q6sq9hh83qsuuH846F/LA3/WHXx67eB135/hSYzCfHYYlb5xY
        8UIVm2hrcec6njBUjrFzFft/WvcDoGWrJwe8puk=
X-Google-Smtp-Source: ABdhPJw/IOWwLUfaqpesZJR+qBD1nZV2iXr45vqB9DQpmrqGxaQVZj2IRE6wZFsHV+G2RW+t9C72/RnT8P52MqLdgdU=
X-Received: by 2002:a05:6512:3fa4:: with SMTP id x36mr25092073lfa.320.1637252306928;
 Thu, 18 Nov 2021 08:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20211118042914.wnffm3ytzmxjdubn@xzhoux.usersys.redhat.com>
In-Reply-To: <20211118042914.wnffm3ytzmxjdubn@xzhoux.usersys.redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 18 Nov 2021 10:18:16 -0600
Message-ID: <CAH2r5mtW35HzmNDNxPXj1cKiEsyaz45_mcsQmWkTa_orOkS7ug@mail.gmail.com>
Subject: Re: [regression] mm, cifs panic
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton had posted Matthew Wilcox's patch (to fix the recent
regression in mm/swap.c) in email (on the 9th) to fs-devel titled:

       "+ hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch"

The patch was reviewed and verified (tested) to fix the problem but
has not been merged into mainline.  Various xfstests break without
this patch.

On Thu, Nov 18, 2021 at 12:13 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Hi Matthew,
>
> Since this commit
>         [988c69f1bc23fe632ea5e6eb3c26a9e103c3ed41] mm: optimise put_pages_list()
>
> Always, xfstests[1] sub-testcase generic/340 on CIFS v3.11 can trigger
> kernel panic like this:
>
> [ 2001.250571] run fstests generic/340 at 2021-11-14 20:23:26
> [ 2001.392289] cifs_smb3_do_mount: 12 callbacks suppressed
> [ 2001.392295] CIFS: Attempting to mount \\dell-per730-01.dell2.lab.eng.bos.redhat.com\SCRATCH_dev
> [ 2001.420684] CIFS: Attempting to mount \\dell-per730-01.dell2.lab.eng.bos.redhat.com\SCRATCH_dev
> [ 2001.438960] Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
> [ 2001.451621] ------------[ cut here ]------------
> [ 2001.456796] kernel BUG at mm/readahead.c:151!
> [ 2001.461664] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [ 2001.467301] CPU: 6 PID: 531974 Comm: holetest Kdump: loaded Not tainted 5.16.0-rc1 #1
> [ 2001.476038] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 2.11.0 11/02/2019
> [ 2001.484483] RIP: 0010:read_pages+0x228/0x240
> [ 2001.489250] Code: eb 87 48 8b 07 48 c1 e8 33 83 e0 07 83 f8 04 75 e4 48 8b 47 08 8b 40 68 83 e8 01 83 f8 01 77 d5 e8 1d 19 00 00 e9 5f ff ff ff <0f> 0b 0f 0b e8 2f 42 81 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> [ 2001.510203] RSP: 0000:ffffb79227757bd8 EFLAGS: 00010293
> [ 2001.516033] RAX: ffffea3310273dc8 RBX: ffffb79227757cc0 RCX: ffffb79227757bf0
> [ 2001.523993] RDX: ffffb79227757c70 RSI: 0000000000000000 RDI: ffffb79227757bd8
> [ 2001.531953] RBP: ffffb79227757c70 R08: ffffea330d3a0888 R09: ffffea330d3a0888
> [ 2001.539913] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ 2001.547873] R13: ffffffffc0ca3560 R14: ffffea3310273dc0 R15: ffffea3310273dc8
> [ 2001.555834] FS:  00007f2e20c13640(0000) GS:ffff8d7567cc0000(0000) knlGS:0000000000000000
> [ 2001.564862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2001.571272] CR2: 00007f2e20c14c00 CR3: 000000037a0fa006 CR4: 00000000001706e0
> [ 2001.579233] Call Trace:
> [ 2001.581959]  <TASK>
> [ 2001.584298]  page_cache_ra_unbounded+0x1d9/0x260
> [ 2001.589450]  do_sync_mmap_readahead+0x115/0x1a0
> [ 2001.594506]  filemap_fault+0x416/0x7b0
> [ 2001.598688]  __do_fault+0x36/0x110
> [ 2001.602483]  do_fault+0x130/0x2b0
> [ 2001.606178]  __handle_mm_fault+0x396/0x6f0
> [ 2001.610747]  handle_mm_fault+0xc5/0x290
> [ 2001.615025]  do_user_addr_fault+0x1c3/0x680
> [ 2001.619694]  exc_page_fault+0x62/0x140
> [ 2001.623867]  ? asm_exc_page_fault+0x8/0x30
> [ 2001.628437]  asm_exc_page_fault+0x1e/0x30
> [ 2001.632908] RIP: 0033:0x40192f
> [ 2001.636311] Code: ff 48 89 c3 48 8b 05 50 28 00 00 48 85 ed 7e 23 31 d2 4b 8d 0c 2f eb 0a 0f 1f 00 48 8b 05 39 28 00 00 48 0f af c2 48 83 c2 01 <48> 89 1c 01 48 39 d5 7f e8 8b 0d f2 27 00 00 31 c0 85 c9 74 0e 8b
> [ 2001.657265] RSP: 002b:00007f2e20c12e10 EFLAGS: 00010202
> [ 2001.663093] RAX: 0000000000000000 RBX: 00007f2e20c13640 RCX: 00007f2e20c14c00
> [ 2001.671053] RDX: 0000000000000001 RSI: 00007f2e20c13f30 RDI: 00007ffea1e626f0
> [ 2001.679014] RBP: 0000000000000100 R08: 0000000000000000 R09: 00007ffea1e6256f
> [ 2001.686975] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffea1e626f0
> [ 2001.694935] R13: 0000000000000c00 R14: 00007f2e20dae860 R15: 00007f2e20c14000
> [ 2001.702898]  </TASK>
>
>
> It's a mmap writing race testcase.
>
> Bisect log is attached. Reverting this commit makes the panic go away.
>
>
> Thanks,
> Murphy
>
> [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> [2] git bisect log
> git bisect start
> # good: [a602285ac11b019e9ce7c3907328e9f95f4967f0] Merge branch 'per_signal_struct_coredumps-for-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> git bisect good a602285ac11b019e9ce7c3907328e9f95f4967f0
> # bad: [00f178e15095fbcf04db00486378a6fa416a125e] Merge tag 'xtensa-20211105' of git://github.com/jcmvbkbc/linux-xtensa
> git bisect bad 00f178e15095fbcf04db00486378a6fa416a125e
> # good: [5cd4dc44b8a0f656100e3b6916cf73b1623299eb] Merge tag 'staging-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good 5cd4dc44b8a0f656100e3b6916cf73b1623299eb
> # good: [5a1bcbd965341537c354e3682f939a7274ac3f5d] Merge tag 'pinctrl-v5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect good 5a1bcbd965341537c354e3682f939a7274ac3f5d
> # good: [fe91c4725aeed35023ba4f7a1e1adfebb6878c23] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good fe91c4725aeed35023ba4f7a1e1adfebb6878c23
> # bad: [a460a36034bad4403c2c62e04a521bc6987ae5db] mm/damon: remove unnecessary variable initialization
> git bisect bad a460a36034bad4403c2c62e04a521bc6987ae5db
> # bad: [9871e2ded6c1ff61a59988d7a0e975f012105d52] mm/cma: add cma_pages_valid to determine if pages are in CMA
> git bisect bad 9871e2ded6c1ff61a59988d7a0e975f012105d52
> # bad: [642688681133a501d149349ba1a824204f3540e1] mm: memcontrol: remove kmemcg_id reparenting
> git bisect bad 642688681133a501d149349ba1a824204f3540e1
> # good: [d73dad4eb5ad8c31ac9cf358eb5a55825bafe706] kasan: test: bypass __alloc_size checks
> git bisect good d73dad4eb5ad8c31ac9cf358eb5a55825bafe706
> # good: [efee17134ca464639a2f5b4d036ce40caf1b247a] mm: simplify bdi refcounting
> git bisect good efee17134ca464639a2f5b4d036ce40caf1b247a
> # bad: [48384b0b76f3662dfa6153c1072c2b936fc14627] mm/memcg: drop swp_entry_t* in mc_handle_file_pte()
> git bisect bad 48384b0b76f3662dfa6153c1072c2b936fc14627
> # good: [20b7fee738d65e50ca00e325ae27ee3efaa819f6] mm/gup: further simplify __gup_device_huge()
> git bisect good 20b7fee738d65e50ca00e325ae27ee3efaa819f6
> # good: [642929a2ded029aac13b8cb91bc9b7c088ddb57f] mm/swapfile: fix an integer overflow in swap_show()
> git bisect good 642929a2ded029aac13b8cb91bc9b7c088ddb57f
> # bad: [988c69f1bc23fe632ea5e6eb3c26a9e103c3ed41] mm: optimise put_pages_list()
> git bisect bad 988c69f1bc23fe632ea5e6eb3c26a9e103c3ed41
> # first bad commit: [988c69f1bc23fe632ea5e6eb3c26a9e103c3ed41] mm: optimise put_pages_list()



-- 
Thanks,

Steve
