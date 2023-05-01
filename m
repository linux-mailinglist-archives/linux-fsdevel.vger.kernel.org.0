Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29FD6F3544
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEARzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEARzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:55:11 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87EBE43
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 10:55:09 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5529f3b8623so26088177b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682963708; x=1685555708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1weW95EDkyvCe/cwOd0PB4zhkheUJ8J7X9stA1ol6Q=;
        b=lP6cll0z5vbj6X6IJg7KZRDM+XxjC5Ngg8DG7vvrNCivjyJ9kDOBXO1WuWwCXQLHBn
         1E2BcPfZg3mWljCec9RRGGmDeqX0YL+xrRiyufqAyVMDGg5mVTBIxino6+wyW+n3ryxi
         yrKIUOeNmF2b1D7OcQWhZucW46kMKOfOgsrSy92HHWLwiz6f7YjnQcs9EKULAb6y0GRs
         Vb54uSol9NsKc6zWrFK+mvrqu9PnOjW2BqKrfeTE297ljHqs8Dn+hsyJalVG888MMiqo
         50pjicv54BL6AISuVbz8ViY8whn2Ac/9umlOC18eVGvnZyT2xscjWtebXKSHbTHF/n9T
         NTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963708; x=1685555708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1weW95EDkyvCe/cwOd0PB4zhkheUJ8J7X9stA1ol6Q=;
        b=HZfvqru/wmLPK5GylUGFacMJZSU5icY1k0C27orKncV3w8GUEzPDdRx5z99VzBSroE
         08K0D1s/xTQ05Z7xR5XUhx1in3gVhmGJYtb0KErBkUKC1rQEO6EAiwyO8u9wU4EXDEkQ
         MwkMCdkO5PiTVx/4sedNc91Hupqks7b2/cJ1yljE/qmX10XKtEtUIBxnQkPMlapNdX7y
         9WfQ1SM4e5GzYIOMoB8ae5EzYj7wufXr9tgGTxhVKxsEeKvyqk4cUKLwrA7R9yJjMwoj
         uO/26oMpmxDxKhuD4D0fliYx12YAJ+L8BzuUwXDOf94FU/DpiwlvXetUywwhIDlYsyad
         fRDw==
X-Gm-Message-State: AC+VfDy4dTIcfJyWsFjdAmW3mTYYyDGw4srjhw+wEgQG4aF8gIyTnGpm
        D6mWFqi/93vw4bZdwOPagNNtGFKx7bWkLmiZK1yw8g==
X-Google-Smtp-Source: ACHHUZ7hjXzhbIK1lFI88VY95LtZ84gfi8LXLoxdp40GiU3x23472skHcwg4uViuJvkrj1tcHIY697aV+7pvRDqs4eA=
X-Received: by 2002:a81:8787:0:b0:556:1065:e6a8 with SMTP id
 x129-20020a818787000000b005561065e6a8mr12344466ywf.2.1682963708480; Mon, 01
 May 2023 10:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com> <ZDmetaUdmlEz/W8Q@casper.infradead.org>
 <87sfczuxkc.fsf@nvidia.com> <CAJuCfpEV1OiM423bykYQTxDC1=bQAqhAwd5fiKYifsk=seP6yw@mail.gmail.com>
 <877cuaulrm.fsf@nvidia.com> <CAJuCfpFEwdnpTXGRpKtXaZ+F4RW4+DkxaRRTiBVy4jE9cG=TEw@mail.gmail.com>
 <CAJuCfpHpnOevnuQSAK2WwtambXqiaoS8gpSFQsi9=O=szKe8vg@mail.gmail.com>
In-Reply-To: <CAJuCfpHpnOevnuQSAK2WwtambXqiaoS8gpSFQsi9=O=szKe8vg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 May 2023 10:54:57 -0700
Message-ID: <CAJuCfpEMKv5Twk=V49cpCTpT5+-6bEP5gH=hk8VQKXi_OVPsng@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 6:07=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Apr 17, 2023 at 4:50=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Mon, Apr 17, 2023 at 4:33=E2=80=AFPM Alistair Popple <apopple@nvidia=
.com> wrote:
> > >
> > >
> > > Suren Baghdasaryan <surenb@google.com> writes:
> > >
> > > > On Sun, Apr 16, 2023 at 6:06=E2=80=AFPM Alistair Popple <apopple@nv=
idia.com> wrote:
> > > >>
> > > >>
> > > >> Matthew Wilcox <willy@infradead.org> writes:
> > > >>
> > > >> > On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wro=
te:
> > > >> >> When page fault is handled under VMA lock protection, all swap =
page
> > > >> >> faults are retried with mmap_lock because folio_lock_or_retry
> > > >> >> implementation has to drop and reacquire mmap_lock if folio cou=
ld
> > > >> >> not be immediately locked.
> > > >> >> Instead of retrying all swapped page faults, retry only when fo=
lio
> > > >> >> locking fails.
> > > >> >
> > > >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > >> >
> > > >> > Let's just review what can now be handled under the VMA lock ins=
tead of
> > > >> > the mmap_lock, in case somebody knows better than me that it's n=
ot safe.
> > > >> >
> > > >> >  - We can call migration_entry_wait().  This will wait for PG_lo=
cked to
> > > >> >    become clear (in migration_entry_wait_on_locked()).  As previ=
ously
> > > >> >    discussed offline, I think this is safe to do while holding t=
he VMA
> > > >> >    locked.
> > > >>
> > > >> Do we even need to be holding the VMA locked while in
> > > >> migration_entry_wait()? My understanding is we're just waiting for
> > > >> PG_locked to be cleared so we can return with a reasonable chance =
the
> > > >> migration entry is gone. If for example it has been unmapped or
> > > >> protections downgraded we will simply refault.
> > > >
> > > > If we drop VMA lock before migration_entry_wait() then we would nee=
d
> > > > to lock_vma_under_rcu again after the wait. In which case it might =
be
> > > > simpler to retry the fault with some special return code to indicat=
e
> > > > that VMA lock is not held anymore and we want to retry without taki=
ng
> > > > mmap_lock. I think it's similar to the last options Matthew suggest=
ed
> > > > earlier. In which case we can reuse the same retry mechanism for bo=
th
> > > > cases, here and in __folio_lock_or_retry.
> > >
> > > Good point. Agree there is no reason to re-take the VMA lock after th=
e
> > > wait, although in this case we shouldn't need to retry the fault
> > > (ie. return VM_FAULT_RETRY). Just skip calling vma_end_read() on the =
way
> > > out to userspace.
> >
> > Actually, __collapse_huge_page_swapin() which calls do_swap_page() can
> > use VMA reference again inside its loop unless we return
> > VM_FAULT_RETRY or VM_FAULT_ERROR. That is not safe since we dropped
> > the VMA lock and stability of the VMA is not guaranteed at that point.
> > So, we do need to return VM_FAULT_RETRY maybe with another bit
> > indicating that retry does not need to fallback to mmap_lock. Smth
> > like "return VM_FAULT_RETRY | VM_FAULT_USE_VMA_LOCK".
>
> False alarm. __collapse_huge_page_swapin is always called under
> mmap_lock protection. I'll go over the code once more to make sure
> nothing else would use VMA after we drop the VMA lock in page fault
> path.

I posted a new series at
https://lore.kernel.org/all/20230501175025.36233-1-surenb@google.com/
It implements suggestions discussed in this thread. Feedback is
appreciated! Thanks!

>
>
> >
> > >
> > > >>
> > > >> >  - We can call remove_device_exclusive_entry().  That calls
> > > >> >    folio_lock_or_retry(), which will fail if it can't get the VM=
A lock.
> > > >>
> > > >> Looks ok to me.
> > > >>
> > > >> >  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody f=
amiliar
> > > >> >    with Nouveau and amdkfd could comment on how safe this is?
> > > >>
> > > >> Currently this won't work because drives assume mmap_lock is held =
during
> > > >> pgmap->ops->migrate_to_ram(). Primarily this is because
> > > >> migrate_vma_setup()/migrate_vma_pages() is used to handle the faul=
t and
> > > >> that asserts mmap_lock is taken in walk_page_range() and also
> > > >> migrate_vma_insert_page().
> > > >>
> > > >> So I don't think we can call that case without mmap_lock.
> > > >>
> > > >> At a glance it seems it should be relatively easy to move to using
> > > >> lock_vma_under_rcu(). Drivers will need updating as well though be=
cause
> > > >> migrate_vma_setup() is called outside of fault handling paths so d=
rivers
> > > >> will currently take mmap_lock rather than vma lock when looking up=
 the
> > > >> vma. See for example nouveau_svmm_bind().
> > > >
> > > > Thanks for the pointers, Alistair! It does look like we need to be
> > > > more careful with the migrate_to_ram() path. For now I can fallback=
 to
> > > > retrying with mmap_lock for this case, like with do with all cases
> > > > today. Afterwards this path can be made ready for working under VMA
> > > > lock and we can remove that retry. Does that sound good?
> > >
> > > Sounds good to me. Fixing that shouldn't be too difficult but will ne=
ed
> > > changes to at least Nouveau and amdkfd (and hmm-tests obviously). Hap=
py
> > > to look at doing that if/when this change makes it in. Thanks.
> > >
> > > >>
> > > >> >  - I believe we can't call handle_pte_marker() because we exclud=
e UFFD
> > > >> >    VMAs earlier.
> > > >> >  - We can call swap_readpage() if we allocate a new folio.  I ha=
ven't
> > > >> >    traced through all this code to tell if it's OK.
> > > >> >
> > > >> > So ... I believe this is all OK, but we're definitely now willin=
g to
> > > >> > wait for I/O from the swap device while holding the VMA lock whe=
n we
> > > >> > weren't before.  And maybe we should make a bigger deal of it in=
 the
> > > >> > changelog.
> > > >> >
> > > >> > And maybe we shouldn't just be failing the folio_lock_or_retry()=
,
> > > >> > maybe we should be waiting for the folio lock with the VMA locke=
d.
> > > >>
> > >
