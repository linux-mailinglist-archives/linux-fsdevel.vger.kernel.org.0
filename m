Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD777415F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjF1QB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjF1QBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:01:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC710D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:01:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b5cf23b9fcso5479986a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687968112; x=1690560112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0YtgDozjdii90yu/P/cvvY8NjkTnOoYyTNr0H+ehnc=;
        b=Fdk3eQgW6M4y2vRA9A5DVQT9z64In+YjUwgVmEuQ1bNUhFL+r3D55kRCRuruEZinWg
         D5+TWSi2+LWwRTXlSxpM20BP311Zv6bWV8ESN6gfxRu/zk8opD0LPkkdRY+MXILsF0jZ
         Fj61gqbdAH4ZGARRIeRegAgeyruL8HgwA7QF0lTv7o1WjxYDnQgEgu4UM6rxCcytvWWt
         /zwbBBqzpTGoPqmE4HLM02thiyJi59c/ETrQP5BCCGjDShnxZUVBhefkUtVyeCPA63/G
         /P4aotyrxc5FoXWpjStBd+N288MNsMZ/qrZg/1+CezQvt1JLaAWzE/LewI16t8EW0Hdn
         Hoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968112; x=1690560112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0YtgDozjdii90yu/P/cvvY8NjkTnOoYyTNr0H+ehnc=;
        b=CY9JoXccCvV38SmLCVm23l6/PFLK1l80p+gbJmbHETWBx5oyh4WZXO+3FFqy62gkBg
         BAxWmOrU3n8ML9oK29eTW0vnLRVON+L+9NQsy2A8CMug8KyxQ6lpqOJbdcWfCB02+1dK
         NYJyf8RXcqPOlY9I9dzb7bAYQt2CKaJxrEc+mLgj93Z9pYeIBEzL9EpxrMznRSO60RKO
         VQsykrBS8WH3oK5xfLZACEenc16XYMO4GiC4tCSPwlttuH4lCgpxqyq8LJxmcEfjofZA
         lmyicxybe7Z1NEwyMPn2LvlxIRrkt77oMhQ+BMdOMhyUPSx2Ol143tJ9A/G0BbsK5cDD
         bsqg==
X-Gm-Message-State: AC+VfDye9jUbMo4ula3sipNshHLSe9TgRXUfgFcsQ8Kg5PWZSVLIb+0i
        8oe8XYlAErm4H7CdcXswUAEQiRszHXPrrqLKEhsTEA==
X-Google-Smtp-Source: ACHHUZ7533wXBnWktmSSRPByYw1TMWtZVhlLHUc2Pf5Hqf9s+lboc9cxCz7TLF5IKMCdplVDaD5dyRIixkG2oXuTlGs=
X-Received: by 2002:a9d:6447:0:b0:6b0:cde0:d9b with SMTP id
 m7-20020a9d6447000000b006b0cde00d9bmr30594492otl.2.1687968111920; Wed, 28 Jun
 2023 09:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com> <20230628071800.544800-6-surenb@google.com>
 <ZJw5AcazkbA5u+wO@x1n>
In-Reply-To: <ZJw5AcazkbA5u+wO@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 09:01:40 -0700
Message-ID: <CAJuCfpHjJedDdWVVh_mQZQrubKiQC=wTZS-QC8BeGJutnkKCiQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: handle swap page faults under per-VMA lock
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 12:17:59AM -0700, Suren Baghdasaryan wrote:
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
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> One nit below:
>
> > ---
> >  mm/filemap.c | 25 ++++++++++++++++---------
> >  mm/memory.c  | 16 ++++++++++------
> >  2 files changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 52bcf12dcdbf..7ee078e1a0d2 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1699,31 +1699,38 @@ static int __folio_lock_async(struct folio *fol=
io, struct wait_page_queue *wait)
> >       return ret;
> >  }
> >
> > +static void release_fault_lock(struct vm_fault *vmf)
> > +{
> > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +             vma_end_read(vmf->vma);
> > +     else
> > +             mmap_read_unlock(vmf->vma->vm_mm);
> > +}
> > +
> >  /*
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
> > @@ -1735,7 +1742,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *fo=
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
> > index 345080052003..76c7907e7286 100644
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
> > +                             ret |=3D VM_FAULT_RETRY;
>
> Here IIUC ret=3D=3D0 is guaranteed, so maybe "ret =3D VM_FAULT_RETRY" is =
slightly
> clearer.

Ack.

>
> > +                             goto out;
> > +                     }
> > +
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf-=
>pmd,
> >                                       vmf->address, &vmf->ptl);
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
