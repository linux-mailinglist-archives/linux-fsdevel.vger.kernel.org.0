Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF662740073
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjF0QKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjF0QKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:10:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136EA2D6A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:10:49 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c13280dfb09so3765026276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687882248; x=1690474248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT+A540FIL0LPOW206f36Kp20pq9QXkqXUfUCRnfMMU=;
        b=w8Em+4absJ0v8xX1ovg58CpeEuyHZayucmjv80kLRXa/GP0CvE/4vDt9kVaWOTU9+T
         GniIaTlnaZTljSq5Dy/Jv3dP+rb5MAC3ufHUsEvC7XGSvWpcGpgycQEeAIJsXMYIcXHc
         KYEGZ433apNJrx2nWNo2Am/Pp4f901nkTukz3IUsBuR1427Kk5KvfRfqd2CBoJSAkcXR
         CULcixm8Koq0d8HscomR+crEYVIdonISMHAv9+aJxRgEsWU5yXU35KIltt7pbFquo7X7
         IQIUEzWsVQmgXV39M0HAVOmOC4u+HurH5mYFTdtiPDKQSz6lHxgwxqlT+uYauLpNncG9
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882248; x=1690474248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT+A540FIL0LPOW206f36Kp20pq9QXkqXUfUCRnfMMU=;
        b=lLmkVsubTdH73LIW+hiAWaAdE1GBJzAJoIdyn3u5hsBWaVvsQtV/TdtzL5xOegExwh
         cjiPIbpLkRX+jEDyaRDRHj4h6yY0d4ePNLd2YMCIxXPkpgZMdX0CE0whODGqFFYIUNEP
         6c0/LM+2mxgJuqwrhXNxxGIVKECN5znlcOAUtyVs/gURT4PTq8rXHsBlRFmUbY+Kmyrp
         AJJFMtVP19NhJ6VfO6zlMB0X6d/scIjpMe48lR6yRDPrgdRWlHGQibWYLT3qK+tMaT9v
         gyjBTDMJxumWsOpQusi3iZibk2hbhIBKJr9WissrtEwYmmwQuhNuaA8ZoIXyzBQvRH5k
         uzBA==
X-Gm-Message-State: AC+VfDxJGP/OYpD0HFYGliR+y6fZE49krIOjcbX1CIr3Tt4nPgRxb3gD
        fZXReZRM19W7NQEUp6AV/DgdcxwBTb3PoPlD/4POkw==
X-Google-Smtp-Source: ACHHUZ4l9NVeoi0sIUUUo7FJIrP9ho8tlMfjYkW/l1TA++fyIAI5JveVV9a7v3p5Ogg8yCYUmuiA/GAOu9//0Kuz0ac=
X-Received: by 2002:a25:608a:0:b0:c16:5bd6:72ff with SMTP id
 u132-20020a25608a000000b00c165bd672ffmr7950186ybb.2.1687882248006; Tue, 27
 Jun 2023 09:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-9-surenb@google.com>
 <ZJsGMDqcYopSW8QL@x1n>
In-Reply-To: <ZJsGMDqcYopSW8QL@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:10:36 -0700
Message-ID: <CAJuCfpFo-4C52sKuaNhfsqpo+Q0pOx5DyVp7RYmr6_R3CVn2jg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm: handle userfaults under VMA lock
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

On Tue, Jun 27, 2023 at 8:54=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:21PM -0700, Suren Baghdasaryan wrote:
> > Enable handle_userfault to operate under VMA lock by releasing VMA lock
> > instead of mmap_lock and retrying.
>
> This mostly good to me (besides the new DROP flag.. of course), thanks.
> Still some nitpicks below.
>
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/userfaultfd.c | 42 ++++++++++++++++++++++--------------------
> >  mm/memory.c      |  9 ---------
> >  2 files changed, 22 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 4e800bb7d2ab..b88632c404b6 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -277,17 +277,17 @@ static inline struct uffd_msg userfault_msg(unsig=
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
> > +     if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> > +             mmap_assert_locked(ctx->mm);
>
> Maybe we can have a helper asserting proper vma protector locks (mmap for
> !VMA_LOCK and vma read lock for VMA_LOCK)?  It basically tells the contex=
t
> the vma is still safe to access.
>
> >
> > -     ptep =3D hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
> > +     ptep =3D hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
> >       if (!ptep)
> >               goto out;
> >
> > @@ -308,10 +308,8 @@ static inline bool userfaultfd_huge_must_wait(stru=
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
> > @@ -325,11 +323,11 @@ static inline bool userfaultfd_huge_must_wait(str=
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
> > @@ -337,7 +335,8 @@ static inline bool userfaultfd_must_wait(struct use=
rfaultfd_ctx *ctx,
> >       pte_t *pte;
> >       bool ret =3D true;
> >
> > -     mmap_assert_locked(mm);
> > +     if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> > +             mmap_assert_locked(mm);
>
> (the assert helper can also be used here)
>
> >
> >       pgd =3D pgd_offset(mm, address);
> >       if (!pgd_present(*pgd))
> > @@ -445,7 +444,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, u=
nsigned long reason)
> >        * Coredumping runs without mmap_lock so we can only check that
> >        * the mmap_lock is held, if PF_DUMPCORE was not set.
> >        */
> > -     mmap_assert_locked(mm);
> > +     if (!(vmf->flags & FAULT_FLAG_VMA_LOCK))
> > +             mmap_assert_locked(mm);
> >
> >       ctx =3D vma->vm_userfaultfd_ctx.ctx;
> >       if (!ctx)
> > @@ -561,15 +561,17 @@ vm_fault_t handle_userfault(struct vm_fault *vmf,=
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
> > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +             /* WARNING: VMA can't be used after this */
> > +             vma_end_read(vma);
> > +     } else
> > +             mmap_read_unlock(mm);
>
> I also think maybe we should have a helper mm_release_fault_lock() just
> release different locks for with/without VMA_LOCK.  It can also be used i=
n
> the other patch of folio_lock_or_retry().

All seem to be good suggestions. I'll try implementing them in the
next version. Thanks!

>
> > +     vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >
> >       if (likely(must_wait && !READ_ONCE(ctx->released))) {
> >               wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index bdf46fdc58d6..923c1576bd14 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5316,15 +5316,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
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
> > 2.41.0.178.g377b9f9a00-goog
> >
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
