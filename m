Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F617B252F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjI1SYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI1SYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:24:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572F11F
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 11:24:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso15191095276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695925450; x=1696530250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vhyBKeJnmBSwRLvoT4DeJoFEAXgBsUcR1SJ8WjemY0=;
        b=rAEqR7o5XM6BHFjY1AvZTytxI3xHdu+nj95vSbWTrpleM3bNzK+YRC0rBtIOdAzJNt
         T2xSaTwi5WhRxjPIRku515BgD2IN0tjnGvdGyjs58TMvJG6Hwdp1F1e5GQiBtJFnWPew
         EJyXjmVUnSPM41wio2WQBuiqA5XK0PecTfS7QBYbGtb+Ytz6Gdamcsjuv6G2v2ubMJzW
         bnk3mcK46F+cKoDGvOycuZ510GaJcEHXh+RUWVQTleysigjGzfcOKvIaXn331K2tiUbf
         CpMBMPvsozx0MvKdFaGhpAEfDC98VtWrC62fm+c30ucViZoGMV/IXthuXwoXOclcnpfg
         9oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925450; x=1696530250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vhyBKeJnmBSwRLvoT4DeJoFEAXgBsUcR1SJ8WjemY0=;
        b=QBBArkFicY+aUer4dzdrwGdiss+jexXMAp1J5/cL076uFqa/sedjXwMpbBk8BnXVba
         7WXH4hxDQJwpzFDCit5S8GmuJy5zZrvIvCZuLYK/TNn/0mf13oUCQlE2w1sDtRREMi3m
         HDrnXGnYezE3Jc2gB69dRDzj9q3XBxl5bYxvs+vp6FyBCM/r4jZbF2Ai/OVm8/UmbegD
         qa/ELf9FvtygB/v8xAd/1VO5ELloDSYr8EAIhRMKieaQDNSnunTPktKF26nyspmm9hkY
         UuG7u6qpJ82KyhbP3F61LAeC33wiwu9e42zfMtySFhQ0ymV+l03P9h979xggojRKM39t
         b7Hg==
X-Gm-Message-State: AOJu0Yx2FFiGTD0YUikBcgsCA43ayXXeMnKj9wDX/vHazzVNvVPrxN3F
        HYll/SFku6yK7/EjxjM1WcOqZwEPTvtmCWy7+o1ZtQ==
X-Google-Smtp-Source: AGHT+IGv7/JnHP+g4RMvNlkcVUMhLnaH6kkWzhnUyy+ImLvupMiRLcMeDIlTtElq7EXDBPYVG7DRDhahUfxYDLd4hv0=
X-Received: by 2002:a5b:783:0:b0:d63:1d3b:9416 with SMTP id
 b3-20020a5b0783000000b00d631d3b9416mr1684086ybq.2.1695925449438; Thu, 28 Sep
 2023 11:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <ZRWzLC5yCypoPNk2@x1n>
In-Reply-To: <ZRWzLC5yCypoPNk2@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 11:23:55 -0700
Message-ID: <CAJuCfpEMNCYt4O7EppO4STGLboKaSxpDwnxF+a_SMdOonUY38g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Fri, Sep 22, 2023 at 06:31:45PM -0700, Suren Baghdasaryan wrote:
> > @@ -72,6 +73,7 @@
> >  #define _UFFDIO_WAKE                 (0x02)
> >  #define _UFFDIO_COPY                 (0x03)
> >  #define _UFFDIO_ZEROPAGE             (0x04)
> > +#define _UFFDIO_REMAP                        (0x05)
> >  #define _UFFDIO_WRITEPROTECT         (0x06)
> >  #define _UFFDIO_CONTINUE             (0x07)
> >  #define _UFFDIO_POISON                       (0x08)
>
> Might be good to add a feature bit (UFFD_FEATURE_REMAP) for userspace to
> probe?

Ack.

>
> IIUC the whole remap feature was proposed at the birth of uffd even befor=
e
> COPY, but now we have tons of old kernels who will not support it.
>
> [...]
>
> > +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *s=
rc_mm,
> > +                      pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval=
,
> > +                      struct vm_area_struct *dst_vma,
> > +                      struct vm_area_struct *src_vma,
> > +                      unsigned long dst_addr, unsigned long src_addr)
> > +{
> > +     pmd_t _dst_pmd, src_pmdval;
> > +     struct page *src_page;
> > +     struct folio *src_folio;
> > +     struct anon_vma *src_anon_vma, *dst_anon_vma;
> > +     spinlock_t *src_ptl, *dst_ptl;
> > +     pgtable_t src_pgtable, dst_pgtable;
> > +     struct mmu_notifier_range range;
> > +     int err =3D 0;
> > +
> > +     src_pmdval =3D *src_pmd;
> > +     src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > +
> > +     BUG_ON(!spin_is_locked(src_ptl));
> > +     mmap_assert_locked(src_mm);
> > +     mmap_assert_locked(dst_mm);
> > +
> > +     BUG_ON(!pmd_trans_huge(src_pmdval));
> > +     BUG_ON(!pmd_none(dst_pmdval));
> > +     BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> > +     BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> > +
> > +     src_page =3D pmd_page(src_pmdval);
> > +     if (unlikely(!PageAnonExclusive(src_page))) {
> > +             spin_unlock(src_ptl);
> > +             return -EBUSY;
> > +     }
> > +
> > +     src_folio =3D page_folio(src_page);
> > +     folio_get(src_folio);
> > +     spin_unlock(src_ptl);
> > +
> > +     /* preallocate dst_pgtable if needed */
> > +     if (dst_mm !=3D src_mm) {
> > +             dst_pgtable =3D pte_alloc_one(dst_mm);
> > +             if (unlikely(!dst_pgtable)) {
> > +                     err =3D -ENOMEM;
> > +                     goto put_folio;
> > +             }
> > +     } else {
> > +             dst_pgtable =3D NULL;
> > +     }
> > +
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, src_=
addr,
> > +                             src_addr + HPAGE_PMD_SIZE);
> > +     mmu_notifier_invalidate_range_start(&range);
> > +
> > +     /* block all concurrent rmap walks */
>
> This is not accurate either I think.  Maybe we can do "s/all/most/", or
> just drop it (assuming the detailed and accurate version of documentation
> lies above remap_pages() regarding to REMAP locking)?

Yes, comments from the original patch need to be rechecked and I'm
sure I missed some new rules. Thanks for pointing this one out! I'll
drop it.

>
> > +     folio_lock(src_folio);
>
> [...]
>
>
> > +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct *=
src_mm,
> > +                       struct vm_area_struct *dst_vma,
> > +                       struct vm_area_struct *src_vma,
> > +                       unsigned long dst_addr, unsigned long src_addr,
> > +                       pte_t *dst_pte, pte_t *src_pte,
> > +                       pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                       spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                       struct folio *src_folio)
>
> remap_present_pte?

Sounds good.

>
> [...]
>
> > +/**
> > + * remap_pages - remap arbitrary anonymous pages of an existing vma
> > + * @dst_start: start of the destination virtual memory range
> > + * @src_start: start of the source virtual memory range
> > + * @len: length of the virtual memory range
> > + *
> > + * remap_pages() remaps arbitrary anonymous pages atomically in zero
> > + * copy. It only works on non shared anonymous pages because those can
> > + * be relocated without generating non linear anon_vmas in the rmap
> > + * code.
> > + *
> > + * It provides a zero copy mechanism to handle userspace page faults.
> > + * The source vma pages should have mapcount =3D=3D 1, which can be
> > + * enforced by using madvise(MADV_DONTFORK) on src vma.
> > + *
> > + * The thread receiving the page during the userland page fault
> > + * will receive the faulting page in the source vma through the networ=
k,
> > + * storage or any other I/O device (MADV_DONTFORK in the source vma
> > + * avoids remap_pages() to fail with -EBUSY if the process forks befor=
e
> > + * remap_pages() is called), then it will call remap_pages() to map th=
e
> > + * page in the faulting address in the destination vma.
> > + *
> > + * This userfaultfd command works purely via pagetables, so it's the
> > + * most efficient way to move physical non shared anonymous pages
> > + * across different virtual addresses. Unlike mremap()/mmap()/munmap()
> > + * it does not create any new vmas. The mapping in the destination
> > + * address is atomic.
> > + *
> > + * It only works if the vma protection bits are identical from the
> > + * source and destination vma.
> > + *
> > + * It can remap non shared anonymous pages within the same vma too.
> > + *
> > + * If the source virtual memory range has any unmapped holes, or if
> > + * the destination virtual memory range is not a whole unmapped hole,
> > + * remap_pages() will fail respectively with -ENOENT or -EEXIST. This
> > + * provides a very strict behavior to avoid any chance of memory
> > + * corruption going unnoticed if there are userland race conditions.
> > + * Only one thread should resolve the userland page fault at any given
> > + * time for any given faulting address. This means that if two threads
> > + * try to both call remap_pages() on the same destination address at t=
he
> > + * same time, the second thread will get an explicit error from this
> > + * command.
> > + *
> > + * The command retval will return "len" is successful. The command
> > + * however can be interrupted by fatal signals or errors. If
> > + * interrupted it will return the number of bytes successfully
> > + * remapped before the interruption if any, or the negative error if
> > + * none. It will never return zero. Either it will return an error or
> > + * an amount of bytes successfully moved. If the retval reports a
> > + * "short" remap, the remap_pages() command should be repeated by
> > + * userland with src+retval, dst+reval, len-retval if it wants to know
> > + * about the error that interrupted it.
> > + *
> > + * The UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES flag can be specified to
> > + * prevent -ENOENT errors to materialize if there are holes in the
> > + * source virtual range that is being remapped. The holes will be
> > + * accounted as successfully remapped in the retval of the
> > + * command. This is mostly useful to remap hugepage naturally aligned
> > + * virtual regions without knowing if there are transparent hugepage
> > + * in the regions or not, but preventing the risk of having to split
> > + * the hugepmd during the remap.
> > + *
> > + * If there's any rmap walk that is taking the anon_vma locks without
> > + * first obtaining the folio lock (for example split_huge_page and
> > + * folio_referenced), they will have to verify if the folio->mapping
>
> Hmm, this sentence seems to be not 100% accurate, perhaps not anymore?
>
> As split_huge_page() should need the folio lock and it'll serialize with
> REMAP with the folio lock too.  It seems to me only folio_referenced() is
> the outlier so far, and that's covered by patch 1.
>
> I did also check other users of folio_get_anon_vma() (similar to use case
> of split_huge_page()) and they're all with the folio lock held, so we
> should be good.
>
> In summary, perhaps:
>
>   - Drop split_huge_page() example here?
>
>   - Should we document above folio_get_anon_vma() about this specialty du=
e
>     to UFFDIO_REMAP?  I'm thiking something like:
>
> + *
> + * NOTE: the caller should normally hold folio lock when calling this.  =
If
> + * not, the caller needs to double check the anon_vma didn't change afte=
r
> + * taking the anon_vma lock for either read or write (UFFDIO_REMAP can
> + * modify it concurrently without folio lock protection).  See
> + * folio_lock_anon_vma_read() which has already covered that, and commen=
t
> + * above remap_pages().
>   */
>  struct anon_vma *folio_get_anon_vma(struct folio *folio)
>  {
>  ...
>  }

Ack. Will fix the remap_pages description and add the comment for
folio_get_anon_vma.

>
> > + * has changed after taking the anon_vma lock. If it changed they
> > + * should release the lock and retry obtaining a new anon_vma, because
> > + * it means the anon_vma was changed by remap_pages() before the lock
> > + * could be obtained. This is the only additional complexity added to
> > + * the rmap code to provide this anonymous page remapping functionalit=
y.
> > + */
> > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm=
,
> > +                 unsigned long dst_start, unsigned long src_start,
> > +                 unsigned long len, __u64 mode)
> > +{
>
> [...]
>
> > +             if (!err) {
> > +                     dst_addr +=3D step_size;
> > +                     src_addr +=3D step_size;
> > +                     moved +=3D step_size;
> > +             }
> > +
> > +             if ((!err || err =3D=3D -EAGAIN) &&
> > +                 fatal_signal_pending(current))
> > +                     err =3D -EINTR;
> > +
> > +             if (err && err !=3D -EAGAIN)
> > +                     break;
>
> The err handling is slightly harder to read.  I tried to rewrite it like
> this:
>
> switch (err) {
>        case 0:
>                 dst_addr +=3D step_size;
>                 src_addr +=3D step_size;
>                 moved +=3D step_size;
>                 /* fall through */
>        case -EAGAIN:
>                 if (fatal_signal_pending(current)) {
>                         err =3D -EINTR;
>                         goto out;
>                 }
>                 /* Continue with the loop */
>                 break;
>        default:
>                 goto out;
> }
>
> Not super good but maybe slightly better?  No strong opinions, but if you
> agree that looks better we can use it.

Agree that this should be improved. Let me see if I can find a cleaner
way to handle these errors.

>
> > +     }
> > +
> > +out:
> > +     mmap_read_unlock(dst_mm);
> > +     if (dst_mm !=3D src_mm)
> > +             mmap_read_unlock(src_mm);
> > +     BUG_ON(moved < 0);
> > +     BUG_ON(err > 0);
> > +     BUG_ON(!moved && !err);
> > +     return moved ? moved : err;
> > +}
>
> I think for the rest I'll read the new version (e.g. I saw discussion on
> proper handling of pmd swap entries, which is not yet addressed, but
> probably will in the next one).

Appreciate your feedback!
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
