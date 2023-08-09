Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8577639E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHIPXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHIPXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:23:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A7E7C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 08:23:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3176a439606so5338045f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691594593; x=1692199393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELMb6v23f8g+8dGMLdkl9Jyc+EIf9oDO46Nx+EN1fG4=;
        b=7lapMx26WZNlT/xrrIVJt/a2qO2K1qpR+FsL19quyx5ZstB99UIgHHe73v7ck1WWJr
         2E4oOepfMCGcKwfRbCGQkJriZhEg+IjyoX3t1v5+Y62OB4bE9I8KKHtSg6+DglgaPul8
         sSIC15ySQHhffaE4E8EslKNwxo9eK/0sW2oVwPEDcyv2Jg6aErBVISmoLBFHpF1pJvGE
         rCdYYKNTMu3A/Scc945WtkfxzM2fHgu48+2LraEHnTnAHdq09ItUbDdfnhHu6gNhV7Yz
         mwXTZdjCLSri8Di2ikIcjUac2wz5ptgx8UxaVTFGTzT/NOgVWGaeW2ry0w9tHtzEFs1W
         J2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691594593; x=1692199393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELMb6v23f8g+8dGMLdkl9Jyc+EIf9oDO46Nx+EN1fG4=;
        b=EFhSAfgBhJjthMwp15EfvqqBJKt7pBOJ1eDBRfH/SkHVIYG8V9tm2+MFjfdkToWlgS
         gxCBvnavgbHTgY4n4dMRZrqbqyegxmprmZBJBe1zRyWWRarVb3nS9kGOeGZIVsb9GYL8
         VsXiVQZKMzmXm6ARAJz30k7sD9vn9OmvzTlmhqpotlxMmphcv6Pp2hySfhWXwz+UGP8c
         0J3LJwZIEYzQX0+jmR4fBRN7seErl2m9zCv5ZUyd/fU5a0A9eF+/rjSVFX8Z0D79ni94
         sh04DxHre4wSqgWfjp533CgG3bi2cgKopCGgop50lAVeXHCt27jDw4mmBcGsDwHf/KiK
         XWTg==
X-Gm-Message-State: AOJu0YwqBwpnletUqpq3wVE+Mc6rZOgi7D/7Pkwyrt+bxBoIyx+43J5u
        bpAf9rbyZUg6MSpZvs2eKy68LFzK+UuNvZ2CTueKDw==
X-Google-Smtp-Source: AGHT+IHpMssOOannUeS7r2GRzEdsLMy2aZavOMdGJXQWLiw1L0Oj05rPR/9uwk5jaJB+w5wIUunktWb3O8pHZ6inQFk=
X-Received: by 2002:a5d:4dc5:0:b0:309:1532:8287 with SMTP id
 f5-20020a5d4dc5000000b0030915328287mr2059361wru.19.1691594592883; Wed, 09 Aug
 2023 08:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
In-Reply-To: <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Aug 2023 08:22:59 -0700
Message-ID: <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 9, 2023 at 7:28=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Aug 9, 2023 at 12:49=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 30.06.23 23:19, Suren Baghdasaryan wrote:
> > > When per-VMA locks were introduced in [1] several types of page fault=
s
> > > would still fall back to mmap_lock to keep the patchset simple. Among=
 them
> > > are swap and userfault pages. The main reason for skipping those case=
s was
> > > the fact that mmap_lock could be dropped while handling these faults =
and
> > > that required additional logic to be implemented.
> > > Implement the mechanism to allow per-VMA locks to be dropped for thes=
e
> > > cases.
> > > First, change handle_mm_fault to drop per-VMA locks when returning
> > > VM_FAULT_RETRY or VM_FAULT_COMPLETED to be consistent with the way
> > > mmap_lock is handled. Then change folio_lock_or_retry to accept vm_fa=
ult
> > > and return vm_fault_t which simplifies later patches. Finally allow s=
wap
> > > and uffd page faults to be handled under per-VMA locks by dropping pe=
r-VMA
> > > and retrying, the same way it's done under mmap_lock.
> > > Naturally, once VMA lock is dropped that VMA should be assumed unstab=
le
> > > and can't be used.
> > >
> > > Changes since v6 posted at [2]
> > > - 4/6 replaced the ternary operation in folio_lock_or_retry,
> > > per Matthew Wilcox
> > > - 4/6 changed return code description for __folio_lock_or_retry
> > > per Matthew Wilcox
> > >
> > > Note: patch 3/6 will cause a trivial merge conflict in arch/arm64/mm/=
fault.c
> > > when applied over mm-unstable branch due to a patch from ARM64 tree [=
3]
> > > which is missing in mm-unstable.
> > >
> > > [1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@googl=
e.com/
> > > [2] https://lore.kernel.org/all/20230630020436.1066016-1-surenb@googl=
e.com/
> > > [3] https://lore.kernel.org/all/20230524131305.2808-1-jszhang@kernel.=
org/
> > >
> > > Suren Baghdasaryan (6):
> > >    swap: remove remnants of polling from read_swap_cache_async
> > >    mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
> > >    mm: drop per-VMA lock when returning VM_FAULT_RETRY or
> > >      VM_FAULT_COMPLETED
> > >    mm: change folio_lock_or_retry to use vm_fault directly
> > >    mm: handle swap page faults under per-VMA lock
> > >    mm: handle userfaults under VMA lock
> >
> > On mm/mm-unstable I get running the selftests:
> >
> > Testing sigbus-wp on shmem... [  383.215804] mm ffff9666078e5280 task_s=
ize 140737488351232
> > [  383.215804] get_unmapped_area ffffffffad03b980
> > [  383.215804] mmap_base 140378441285632 mmap_legacy_base 4725435388313=
6
> > [  383.215804] pgd ffff966608960000 mm_users 1 mm_count 6 pgtables_byte=
s 126976 map_count 28
> > [  383.215804] hiwater_rss 6183 hiwater_vm 8aa7 total_vm 8aa7 locked_vm=
 0
> > [  383.215804] pinned_vm 0 data_vm 844 exec_vm 1a4 stack_vm 21
> > [  383.215804] start_code 402000 end_code 408f09 start_data 40ce10 end_=
data 40d500
> > [  383.215804] start_brk 17fe000 brk 1830000 start_stack 7ffecbbe08e0
> > [  383.215804] arg_start 7ffecbbe1c6f arg_end 7ffecbbe1c81 env_start 7f=
fecbbe1c81 env_end 7ffecbbe1fe6
> > [  383.215804] binfmt ffffffffaf3efe40 flags 80000cd
> > [  383.215804] ioctx_table 0000000000000000
> > [  383.215804] owner ffff96660d4a4000 exe_file ffff966285501a00
> > [  383.215804] notifier_subscriptions 0000000000000000
> > [  383.215804] numa_next_scan 4295050919 numa_scan_offset 0 numa_scan_s=
eq 0
> > [  383.215804] tlb_flush_pending 0
> > [  383.215804] def_flags: 0x0()
> > [  383.236255] ------------[ cut here ]------------
> > [  383.237537] kernel BUG at include/linux/mmap_lock.h:66!
> > [  383.238897] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [  383.240114] CPU: 37 PID: 1482 Comm: uffd-unit-tests Not tainted 6.5.=
0-rc4+ #68
> > [  383.242513] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-1.fc38 04/01/2014
> > [  383.244936] RIP: 0010:find_vma+0x3a/0x40
> > [  383.246200] Code: 48 89 34 24 48 85 c0 74 1c 48 83 c7 40 48 c7 c2 ff=
 ff ff ff 48 89 e6 e8 a4 29 ba 00
> > [  383.251084] RSP: 0000:ffffae3745b6beb0 EFLAGS: 00010282
> > [  383.252781] RAX: 0000000000000314 RBX: ffff9666078e5280 RCX: 0000000=
000000000
> > [  383.255073] RDX: 0000000000000001 RSI: ffffffffae8f69c3 RDI: 0000000=
0ffffffff
> > [  383.257352] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffae3=
745b6bc48
> > [  383.259369] R10: 0000000000000003 R11: ffff9669fff46fe8 R12: 0000000=
044401028
> > [  383.261570] R13: ffff9666078e5338 R14: ffffae3745b6bf58 R15: 0000000=
000000400
> > [  383.263499] FS:  00007fac671c5740(0000) GS:ffff9669efbc0000(0000) kn=
lGS:0000000000000000
> > [  383.265483] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  383.266847] CR2: 0000000044401028 CR3: 0000000488960006 CR4: 0000000=
000770ee0
> > [  383.268532] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  383.270206] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  383.271905] PKRU: 55555554
> > [  383.272593] Call Trace:
> > [  383.273215]  <TASK>
> > [  383.273774]  ? die+0x32/0x80
> > [  383.274510]  ? do_trap+0xd6/0x100
> > [  383.275326]  ? find_vma+0x3a/0x40
> > [  383.276152]  ? do_error_trap+0x6a/0x90
> > [  383.277072]  ? find_vma+0x3a/0x40
> > [  383.277899]  ? exc_invalid_op+0x4c/0x60
> > [  383.278846]  ? find_vma+0x3a/0x40
> > [  383.279675]  ? asm_exc_invalid_op+0x16/0x20
> > [  383.280698]  ? find_vma+0x3a/0x40
> > [  383.281527]  lock_mm_and_find_vma+0x3f/0x270
> > [  383.282570]  do_user_addr_fault+0x1e4/0x660
> > [  383.283591]  exc_page_fault+0x73/0x170
> > [  383.284509]  asm_exc_page_fault+0x22/0x30
> > [  383.285486] RIP: 0033:0x404428
> > [  383.286265] Code: 48 89 85 18 ff ff ff e9 dc 00 00 00 48 8b 15 9f 92=
 00 00 48 8b 05 80 92 00 00 48 03
> > [  383.290566] RSP: 002b:00007ffecbbe05c0 EFLAGS: 00010206
> > [  383.291814] RAX: 0000000044401028 RBX: 00007ffecbbe08e8 RCX: 00007fa=
c66e93c18
> > [  383.293502] RDX: 0000000044400000 RSI: 0000000000000001 RDI: 0000000=
000000000
> > [  383.295175] RBP: 00007ffecbbe06c0 R08: 00007ffecbbe05c0 R09: 00007ff=
ecbbe06c0
> > [  383.296857] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000=
000000000
> > [  383.298533] R13: 00007ffecbbe08f8 R14: 000000000040ce18 R15: 00007fa=
c67206000
> > [  383.300203]  </TASK>
> > [  383.300775] Modules linked in: rfkill intel_rapl_msr intel_rapl_comm=
on intel_uncore_frequency_commong
> > [  383.309661] ---[ end trace 0000000000000000 ]---
> > [  383.310795] RIP: 0010:find_vma+0x3a/0x40
> > [  383.311771] Code: 48 89 34 24 48 85 c0 74 1c 48 83 c7 40 48 c7 c2 ff=
 ff ff ff 48 89 e6 e8 a4 29 ba 00
> > [  383.316081] RSP: 0000:ffffae3745b6beb0 EFLAGS: 00010282
> > [  383.317346] RAX: 0000000000000314 RBX: ffff9666078e5280 RCX: 0000000=
000000000
> > [  383.319050] RDX: 0000000000000001 RSI: ffffffffae8f69c3 RDI: 0000000=
0ffffffff
> > [  383.320767] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffae3=
745b6bc48
> > [  383.322468] R10: 0000000000000003 R11: ffff9669fff46fe8 R12: 0000000=
044401028
> > [  383.324164] R13: ffff9666078e5338 R14: ffffae3745b6bf58 R15: 0000000=
000000400
> > [  383.325870] FS:  00007fac671c5740(0000) GS:ffff9669efbc0000(0000) kn=
lGS:0000000000000000
> > [  383.327795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  383.329177] CR2: 0000000044401028 CR3: 0000000488960006 CR4: 0000000=
000770ee0
> > [  383.330885] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  383.332592] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  383.334287] PKRU: 55555554
> >
> >
> > Which ends up being
> >
> > VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >
> > I did not check if this is also the case on mainline, and if this serie=
s is responsible.
>
> Thanks for reporting! I'm checking it now.

Hmm. From the code it's not obvious how lock_mm_and_find_vma() ends up
calling find_vma() without mmap_lock after successfully completing
get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points to
the first invocation of find_vma(), so this is not even the lock
upgrade path... I'll try to reproduce this issue and dig up more but
from the information I have so far this issue does not seem to be
related to this series.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
