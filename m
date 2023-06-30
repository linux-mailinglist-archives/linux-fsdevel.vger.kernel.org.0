Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F6743241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 03:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF3BbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF3BbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:31:00 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54332D69
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:54 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-576a9507a9bso19392537b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688088653; x=1690680653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c9AWfXGh8Y1ARvgQszZg4CRxGzxDn2J0F5H9PZqMGE=;
        b=y6jc0NS2envWLsOefA6GDuk/ScswMh2Kqs861BFMEF8QNNeK6eMXC3VmUsmG5G0vD4
         MpAjkdRN2J7ehhr1S2W4oP/PFLD0ypBZNf8gCi83iiO2WQabf1k3MCbtjuDh8qfdylv4
         GkHKry6IZvJ2nRXxs2iZ0gkJWisxgl5809pSm/gCGksJknKT2GhY0VeRy+9IE4fDvG9W
         0s0E7LXqeLFgS/biU8zjD6LpEtV2/Izf8v0yQhAqG5PG3LKT9wnFOL8y0K+2hNtLcbJi
         7juClPDNk21+oOh4kup+fJi6Oo1XQO9JHNg6qHLbv3EHRnyH4qcca2ktMPmzKZbnB+W4
         ukBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688088653; x=1690680653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c9AWfXGh8Y1ARvgQszZg4CRxGzxDn2J0F5H9PZqMGE=;
        b=hn6PEx0Vq8HOnTLDPKFiOoQ4vPv48/eCtS+4WuWXRx7+6H+tJ16DMV2Qgic/w4wGy1
         BGORkCewD5O+miLyAvzScRkqcxOVXa6SuzCMP5f/7oVZa+6EM1ta5u0VDDRmWstQwQE0
         8XqxOk1CrVANa4funFLZad4SHoViAj6zFmWhNr6r/nfdiiw1qLijfrexeIbhZ8EDtCvg
         v9iL456dShGErw+Nou6TrRh8EEH5NaaRQcIGymbe6hw59Tyz+Tq9G3yw74t3OqyHZTP1
         UsZwRXeJecOVMAZIxnVlw50WMupFipBBMaNaJ9dGGI3F7lr0q3XC2RBODW3keJSln58v
         k5Lg==
X-Gm-Message-State: ABy/qLYeLuvF6rzTb815qiW/ksD7igMVCX/iiErbobaWLEOQvmvwBJjB
        uFqTbOg/FkhDMbK3zfvuSJCXpdqwrN2KSI7Okwi5Yw==
X-Google-Smtp-Source: APBJJlHFb943nAvEHry+lBgUIXa7kvvU79h4DHeIKVAAzsftnQh1PMd7JG3BqbsI2VRy57H833eEh2LKDC0LQBzNoV4=
X-Received: by 2002:a25:f30c:0:b0:c42:2b05:17a5 with SMTP id
 c12-20020a25f30c000000b00c422b0517a5mr35154ybs.11.1688088653284; Thu, 29 Jun
 2023 18:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com> <20230628172529.744839-6-surenb@google.com>
 <877crm246q.fsf@nvdebian.thelocal>
In-Reply-To: <877crm246q.fsf@nvdebian.thelocal>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 18:30:41 -0700
Message-ID: <CAJuCfpEujwtcKUE9cZ-_k3=DJqZ93yPgD+s4rXj88Z3umF_Y2g@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mm: handle swap page faults under per-VMA lock
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:06=E2=80=AFPM Alistair Popple <apopple@nvidia.co=
m> wrote:
>
>
> Looks good and passed the HMM selftests. So:
>
> Tested-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks!

>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > When page fault is handled under per-VMA lock protection, all swap page
> > faults are retried with mmap_lock because folio_lock_or_retry has to dr=
op
> > and reacquire mmap_lock if folio could not be immediately locked.
> > Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
> > for folio and retrying once folio is available.
> > With this obstacle removed, enable do_swap_page to operate under
> > per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
> > still rely on mmap_lock, therefore we have to fall back to mmap_lock in
> > that particular case.
> > Note that the only time do_swap_page calls synchronous swap_readpage
> > is when SWP_SYNCHRONOUS_IO is set, which is only set for
> > QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> > pmem). Therefore we don't sleep in this path, and there's no need to
> > drop the mmap or per-VMA lock.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h | 13 +++++++++++++
> >  mm/filemap.c       | 17 ++++++++---------
> >  mm/memory.c        | 16 ++++++++++------
> >  3 files changed, 31 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fec149585985..bbaec479bf98 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -723,6 +723,14 @@ static inline void vma_mark_detached(struct vm_are=
a_struct *vma, bool detached)
> >  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >                                         unsigned long address);
> >
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
> > @@ -736,6 +744,11 @@ static inline void vma_assert_write_locked(struct =
vm_area_struct *vma) {}
> >  static inline void vma_mark_detached(struct vm_area_struct *vma,
> >                                    bool detached) {}
> >
> > +static inline void release_fault_lock(struct vm_fault *vmf)
> > +{
> > +     mmap_read_unlock(vmf->vma->vm_mm);
> > +}
> > +
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  /*
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 52bcf12dcdbf..d4d8f474e0c5 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1703,27 +1703,26 @@ static int __folio_lock_async(struct folio *fol=
io, struct wait_page_queue *wait)
> >   * Return values:
> >   * 0 - folio is locked.
> >   * VM_FAULT_RETRY - folio is not locked.
> > - *     mmap_lock has been released (mmap_read_unlock(), unless flags h=
ad both
> > - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> > - *     which case mmap_lock is still held.
> > + *     mmap_lock or per-VMA lock has been released (mmap_read_unlock()=
 or
> > + *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY a=
nd
> > + *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still he=
ld.
> >   *
> >   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
> > - * with the folio locked and the mmap_lock unperturbed.
> > + * with the folio locked and the mmap_lock/per-VMA lock is left unpert=
urbed.
> >   */
> >  vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault =
*vmf)
> >  {
> > -     struct mm_struct *mm =3D vmf->vma->vm_mm;
> >       unsigned int flags =3D vmf->flags;
> >
> >       if (fault_flag_allow_retry_first(flags)) {
> >               /*
> > -              * CAUTION! In this case, mmap_lock is not released
> > -              * even though return VM_FAULT_RETRY.
> > +              * CAUTION! In this case, mmap_lock/per-VMA lock is not
> > +              * released even though returning VM_FAULT_RETRY.
> >                */
> >               if (flags & FAULT_FLAG_RETRY_NOWAIT)
> >                       return VM_FAULT_RETRY;
> >
> > -             mmap_read_unlock(mm);
> > +             release_fault_lock(vmf);
> >               if (flags & FAULT_FLAG_KILLABLE)
> >                       folio_wait_locked_killable(folio);
> >               else
> > @@ -1735,7 +1734,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *fo=
lio, struct vm_fault *vmf)
> >
> >               ret =3D __folio_lock_killable(folio);
> >               if (ret) {
> > -                     mmap_read_unlock(mm);
> > +                     release_fault_lock(vmf);
> >                       return VM_FAULT_RETRY;
> >               }
> >       } else {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 345080052003..4fb8ecfc6d13 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3712,12 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> >
> > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > -             ret =3D VM_FAULT_RETRY;
> > -             vma_end_read(vma);
> > -             goto out;
> > -     }
> > -
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
> > @@ -3727,6 +3721,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       ret =3D remove_device_exclusive_entry(vmf);
> >               } else if (is_device_private_entry(entry)) {
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                             /*
> > +                              * migrate_to_ram is not yet ready to ope=
rate
> > +                              * under VMA lock.
> > +                              */
> > +                             vma_end_read(vma);
> > +                             ret =3D VM_FAULT_RETRY;
> > +                             goto out;
> > +                     }
> > +
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf-=
>pmd,
> >                                       vmf->address, &vmf->ptl);
>
