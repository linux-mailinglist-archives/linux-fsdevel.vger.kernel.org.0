Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E2741642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjF1QWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjF1QWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:22:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7502123
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:22:36 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso4431829276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687969355; x=1690561355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coAlCBDwBad1PcdB7ZeOiPMCqqbtBTETcXG8fdky4dU=;
        b=oZ+RVs6yYI6qZTJvkzfnTrvanL6/+0H2TGOChie0Nu//HaNIGehxeem1FzSer5XncX
         7aFwLEiuLhUl6eY+pJg3RjKyYldwKSJkW5m3r5bs+tGpE8zmRiUmkd6muhX8xAuFRax3
         WtxDIygwQaJ/0J+/hRvzSz0o9kS6J1e4N3l+vKxmLh8qn5gbbg7YTDZBTMjC4tMjP1/P
         Wo6/XeLH3+xegMLcw5cb2jxX/gJIeH6C+Dinqgojq4bbeXR3T/AG9jkYJgdqwwxEqxDp
         Jvdrn3ke73ta64PfjgtZE0WJP/njAgw4g5vki934jv/8vQfzFQajnnfDPD/DaF3ZtRcI
         22Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969355; x=1690561355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coAlCBDwBad1PcdB7ZeOiPMCqqbtBTETcXG8fdky4dU=;
        b=C2DEkYsiHS0+6q3Ki7afyal21Bdo3zvd1UTTrejn4MgoDSe2pH3RP/F5UpEIi9P7Mm
         oVykeTz44FV/kBhTEVudTgvJtiOja2F8StMWaO3m6tjUqOZCMFczOgbpGCBi0Vsgda2y
         ozcEtSF7YGaaJ6YRADH93p20Qbqo2PmhIxnyX4Wbi/lu2kObKHbsDj9had+4shLw7DPI
         9YoUJ1wVzRhntvhjuJOZqn3KgfjDJruE+XHj6HIO6Oakl8grlkjdCbXpMCe8DJP0K9SO
         4UrCFPGHCK9t74JsrFugJiwibZ7XM9sTQ8P7SggNS97ve0lIcm7OlS+pP1huEWJpd6kf
         vCbA==
X-Gm-Message-State: AC+VfDzZTldUehqM4wlISvFuarnrPo7g3QkxAa760UBuofgFnt2UOizl
        t1k1mndwam0wBnjKd6oUd+QohJQyExBP7/5tU5FHaA==
X-Google-Smtp-Source: ACHHUZ7+KEVfGiV0yc+Cuk2Gjs7uLcMzKgQN74u947OIe1u5KEmq3+iwieLvBbKQn+DZDak5VZ/FF71xjMFkCuyOswE=
X-Received: by 2002:a25:db49:0:b0:bcd:9c9a:a257 with SMTP id
 g70-20020a25db49000000b00bcd9c9aa257mr2452929ybf.57.1687969355346; Wed, 28
 Jun 2023 09:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com> <20230628071800.544800-7-surenb@google.com>
 <ZJw8Z3E3d4dHPDuZ@x1n>
In-Reply-To: <ZJw8Z3E3d4dHPDuZ@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 09:22:24 -0700
Message-ID: <CAJuCfpGRresZRacCSDU=E+CNDkGfMwO2u-oTB_H30cASzFgNtA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: handle userfaults under VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:58=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 12:18:00AM -0700, Suren Baghdasaryan wrote:
> > Enable handle_userfault to operate under VMA lock by releasing VMA lock
> > instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> > should never be used when handling faults under per-VMA lock protection
> > because that would break the assumption that lock is dropped on retry.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Besides the NOWAIT typo all look sane.  Since there seems to need at leas=
t
> one more version I'll still comment on a few things..
>
> > ---
> >  fs/userfaultfd.c   | 39 ++++++++++++++++++---------------------
> >  include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
> >  mm/filemap.c       |  8 --------
> >  mm/memory.c        |  9 ---------
> >  4 files changed, 57 insertions(+), 38 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 4e800bb7d2ab..d019e7df6f15 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -277,17 +277,16 @@ static inline struct uffd_msg userfault_msg(unsig=
ned long address,
> >   * hugepmd ranges.
> >   */
> >  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *=
ctx,
> > -                                      struct vm_area_struct *vma,
> > -                                      unsigned long address,
> > -                                      unsigned long flags,
> > -                                      unsigned long reason)
> > +                                           struct vm_fault *vmf,
> > +                                           unsigned long reason)
> >  {
> > +     struct vm_area_struct *vma =3D vmf->vma;
> >       pte_t *ptep, pte;
> >       bool ret =3D true;
> >
> > -     mmap_assert_locked(ctx->mm);
> > +     assert_fault_locked(ctx->mm, vmf);
>
> AFAIU ctx->mm must be the same as vma->vm_mm here, so maybe we can also
> drop *ctx here altogether if we've already dropped plenty.

Ack. I was not sure if the ctx->mm would always be the same as vmf->mm.

>
> >
> > -     ptep =3D hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
> > +     ptep =3D hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
> >       if (!ptep)
> >               goto out;
> >
> > @@ -308,10 +307,8 @@ static inline bool userfaultfd_huge_must_wait(stru=
ct userfaultfd_ctx *ctx,
> >  }
> >  #else
> >  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *=
ctx,
> > -                                      struct vm_area_struct *vma,
> > -                                      unsigned long address,
> > -                                      unsigned long flags,
> > -                                      unsigned long reason)
> > +                                           struct vm_fault *vmf,
> > +                                           unsigned long reason)
> >  {
> >       return false;   /* should never get here */
> >  }
> > @@ -325,11 +322,11 @@ static inline bool userfaultfd_huge_must_wait(str=
uct userfaultfd_ctx *ctx,
> >   * threads.
> >   */
> >  static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> > -                                      unsigned long address,
> > -                                      unsigned long flags,
> > +                                      struct vm_fault *vmf,
> >                                        unsigned long reason)
> >  {
> >       struct mm_struct *mm =3D ctx->mm;
> > +     unsigned long address =3D vmf->address;
> >       pgd_t *pgd;
> >       p4d_t *p4d;
> >       pud_t *pud;
> > @@ -337,7 +334,7 @@ static inline bool userfaultfd_must_wait(struct use=
rfaultfd_ctx *ctx,
> >       pte_t *pte;
> >       bool ret =3D true;
> >
> > -     mmap_assert_locked(mm);
> > +     assert_fault_locked(mm, vmf);
> >
> >       pgd =3D pgd_offset(mm, address);
> >       if (!pgd_present(*pgd))
> > @@ -445,7 +442,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, u=
nsigned long reason)
> >        * Coredumping runs without mmap_lock so we can only check that
> >        * the mmap_lock is held, if PF_DUMPCORE was not set.
> >        */
> > -     mmap_assert_locked(mm);
> > +     assert_fault_locked(mm, vmf);
> >
> >       ctx =3D vma->vm_userfaultfd_ctx.ctx;
> >       if (!ctx)
> > @@ -522,8 +519,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, =
unsigned long reason)
> >        * and wait.
> >        */
> >       ret =3D VM_FAULT_RETRY;
> > -     if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> > +     if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
> > +             /* Per-VMA lock is expected to be dropped on VM_FAULT_RET=
RY */
> > +             BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
>
> Here is not the only place that we can have FAULT_FLAG_RETRY_NOWAIT.
> E.g. folio_lock_or_retry() can also get it, so check here may or may not
> help much.
>
> The other thing is please consider not using BUG_ON if possible.
> WARN_ON_ONCE() is IMHO always more preferred if the kernel can still try =
to
> run even if it triggers.

Ack.

>
> I'd rather drop this change, leaving space for future when vma lock may b=
e
> supported in gup paths with NOWAIT, then here it'll work naturally, afaiu=
.
> If we really want a sanity check, maybe the best place is when entering
> handle_mm_fault(), to be explicit, sanitize_fault_flags().

That sounds like a good idea. Thanks!

>
> >               goto out;
> > +     }
> >
> >       /* take the reference before dropping the mmap_lock */
> >       userfaultfd_ctx_get(ctx);
> > @@ -561,15 +561,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf,=
 unsigned long reason)
> >       spin_unlock_irq(&ctx->fault_pending_wqh.lock);
> >
> >       if (!is_vm_hugetlb_page(vma))
> > -             must_wait =3D userfaultfd_must_wait(ctx, vmf->address, vm=
f->flags,
> > -                                               reason);
> > +             must_wait =3D userfaultfd_must_wait(ctx, vmf, reason);
> >       else
> > -             must_wait =3D userfaultfd_huge_must_wait(ctx, vma,
> > -                                                    vmf->address,
> > -                                                    vmf->flags, reason=
);
> > +             must_wait =3D userfaultfd_huge_must_wait(ctx, vmf, reason=
);
> >       if (is_vm_hugetlb_page(vma))
> >               hugetlb_vma_unlock_read(vma);
> > -     mmap_read_unlock(mm);
> > +     release_fault_lock(vmf);
> >
> >       if (likely(must_wait && !READ_ONCE(ctx->released))) {
> >               wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fec149585985..70bb2f923e33 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -705,6 +705,17 @@ static inline bool vma_try_start_write(struct vm_a=
rea_struct *vma)
> >       return true;
> >  }
> >
> > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > +{
> > +     int mm_lock_seq;
> > +
> > +     if (__is_vma_write_locked(vma, &mm_lock_seq))
> > +             return;
> > +
> > +     lockdep_assert_held(&vma->vm_lock->lock);
> > +     VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_lock->lock), vma);
> > +}
> > +
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >  {
> >       int mm_lock_seq;
> > @@ -723,6 +734,23 @@ static inline void vma_mark_detached(struct vm_are=
a_struct *vma, bool detached)
> >  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >                                         unsigned long address);
> >
> > +static inline
> > +void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
> > +{
> > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +             vma_assert_locked(vmf->vma);
> > +     else
> > +             mmap_assert_locked(mm);
> > +}
> > +
> > +static inline void release_fault_lock(struct vm_fault *vmf)
> > +{
> > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +             vma_end_read(vmf->vma);
> > +     else
> > +             mmap_read_unlock(vmf->vma->vm_mm);
> > +}
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > @@ -736,6 +764,17 @@ static inline void vma_assert_write_locked(struct =
vm_area_struct *vma) {}
> >  static inline void vma_mark_detached(struct vm_area_struct *vma,
> >                                    bool detached) {}
> >
> > +static inline
> > +void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
> > +{
> > +     mmap_assert_locked(mm);
> > +}
> > +
> > +static inline void release_fault_lock(struct vm_fault *vmf)
> > +{
> > +     mmap_read_unlock(vmf->vma->vm_mm);
> > +}
> > +
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  /*
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 7ee078e1a0d2..d4d8f474e0c5 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1699,14 +1699,6 @@ static int __folio_lock_async(struct folio *foli=
o, struct wait_page_queue *wait)
> >       return ret;
> >  }
> >
> > -static void release_fault_lock(struct vm_fault *vmf)
> > -{
> > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > -             vma_end_read(vmf->vma);
> > -     else
> > -             mmap_read_unlock(vmf->vma->vm_mm);
> > -}
>
> The movement is fine but may not be the cleanest.  It'll be nicer to me i=
f
> it's put at the right place when introduced - after all in the same serie=
s.

Ack.

Thanks for the review!

>
> Thanks,
>
> > -
> >  /*
> >   * Return values:
> >   * 0 - folio is locked.
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 76c7907e7286..c6c759922f39 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5294,15 +5294,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
 mm_struct *mm,
> >       if (!vma_start_read(vma))
> >               goto inval;
> >
> > -     /*
> > -      * Due to the possibility of userfault handler dropping mmap_lock=
, avoid
> > -      * it for now and fall back to page fault handling under mmap_loc=
k.
> > -      */
> > -     if (userfaultfd_armed(vma)) {
> > -             vma_end_read(vma);
> > -             goto inval;
> > -     }
> > -
> >       /* Check since vm_start/vm_end might change before we lock the VM=
A */
> >       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
) {
> >               vma_end_read(vma);
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> --
> Peter Xu
>
