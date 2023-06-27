Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25A7400E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjF0Q0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjF0QZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:25:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7113A94
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:25:33 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso3256667276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687883133; x=1690475133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDkDtON3xA4+F8vtKwdyt0Cb+vC6O2XyaPx6nYDr30w=;
        b=X6snxaNMmFdmrlwXA1r+rWEnPpxhXBOdUXB32SinFWGecalIuvydZgA4uCeL6IUz7d
         Eq5zXGAACQbSVivY8YD1kyq1LSsuF3iLxcsUpAo/FnKcrh7aF4Ya4ABpSyK5S+cNEWHr
         DOjGe+cb2ct444qTHSI3zpiIIJpwOCkz95+2Ig4A9mg+xXYmo6ERWbZBylZ5+mlKGKcA
         g40+Q6LUyowuGPZrDvGFCfAMDv18Ag7c/E1dXqEy0CNiweCj6atSqKVlguSJlRDfLnlZ
         VbwLP3fgmzSOHWm7lvW2glLATbcPjgS/AWTO7/ifqk5VpUnccC7OInb6uS/kVup1A/Xw
         RXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883133; x=1690475133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDkDtON3xA4+F8vtKwdyt0Cb+vC6O2XyaPx6nYDr30w=;
        b=epHp+a20E6LWk5L3UVDTHT7RCiLLOLHI8nphdll3b/nQgDHpRxBWxJmQW7R5w+vMis
         N+Ma4lrVUZ7S3Q+5C9N+7q2d/sqPT3sxCatbXAeguon2ZcHLxr3HA66JKmrXEs/B/mHt
         HOt6vh0Mi1yQaPo0fOIWEPQOgmybGcl01K1qaEJ6751E5+mr3h0sLkfLVSNTU3s0KG56
         PcWEIgUYdnOivpJyfMRLg3zLO9mnD92QCxbKZeGOgk9bJJ0G7oHzzJG5VjIXcR9RRqLT
         ThfSFF3mP6hM8k00lFAo85x3kkhHr6TyZpLmUdBIoLo/DU/n1FfbuIL9etciLYHcAMW2
         cVfA==
X-Gm-Message-State: AC+VfDz+iGcbvh1TbwmALWXTb8DFJYZgYQInhy+R8azsR1Es5NZB/xKC
        Vu1rP5Tz0vKJ2aP/dXnAzHhsKyd/R9YLSg4JQAlznQ==
X-Google-Smtp-Source: ACHHUZ4Y0wXppiTElvuAQyrvaw1Rt5xvz0WJCqHc4E1s6TkXzbVBuroEcRXXEB76wbwOGiqFOyDa1NiwB8I46kUAQyI=
X-Received: by 2002:a25:dc82:0:b0:c11:38e5:a00f with SMTP id
 y124-20020a25dc82000000b00c1138e5a00fmr7200954ybe.58.1687883132876; Tue, 27
 Jun 2023 09:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-4-surenb@google.com>
 <ZJr/+83t9ndwHCd6@x1n>
In-Reply-To: <ZJr/+83t9ndwHCd6@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:25:21 -0700
Message-ID: <CAJuCfpFpMiPrGfj1ndsgPDOqEs_mZ_iH0P_JnyjMGBzMPCS7TA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm: drop per-VMA lock in handle_mm_fault if
 retrying or when finished
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

On Tue, Jun 27, 2023 at 8:28=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 26, 2023 at 09:23:16PM -0700, Suren Baghdasaryan wrote:
> > handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
> > mmap_lock has been released. However with per-VMA locks behavior is
> > different and the caller should still release it. To make the
> > rules consistent for the caller, drop the per-VMA lock before returning
> > from handle_mm_fault when page fault should be retried or is completed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/arm64/mm/fault.c   |  3 ++-
> >  arch/powerpc/mm/fault.c |  3 ++-
> >  arch/s390/mm/fault.c    |  3 ++-
> >  arch/x86/mm/fault.c     |  3 ++-
> >  mm/memory.c             | 12 +++++++++++-
> >  5 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 6045a5117ac1..89f84e9ea1ff 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -601,7 +601,8 @@ static int __kprobes do_page_fault(unsigned long fa=
r, unsigned long esr,
> >               goto lock_mmap;
> >       }
> >       fault =3D handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LO=
CK, regs);
> > -     vma_end_read(vma);
> > +     if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +             vma_end_read(vma);
> >
> >       if (!(fault & VM_FAULT_RETRY)) {
> >               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 531177a4ee08..4697c5dca31c 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -494,7 +494,8 @@ static int ___do_page_fault(struct pt_regs *regs, u=
nsigned long address,
> >       }
> >
> >       fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> > -     vma_end_read(vma);
> > +     if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +             vma_end_read(vma);
> >
> >       if (!(fault & VM_FAULT_RETRY)) {
> >               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index b65144c392b0..cccefe41038b 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -418,7 +418,8 @@ static inline vm_fault_t do_exception(struct pt_reg=
s *regs, int access)
> >               goto lock_mmap;
> >       }
> >       fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> > -     vma_end_read(vma);
> > +     if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +             vma_end_read(vma);
> >       if (!(fault & VM_FAULT_RETRY)) {
> >               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> >               goto out;
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index e4399983c50c..d69c85c1c04e 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1347,7 +1347,8 @@ void do_user_addr_fault(struct pt_regs *regs,
> >               goto lock_mmap;
> >       }
> >       fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> > -     vma_end_read(vma);
> > +     if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > +             vma_end_read(vma);
> >
> >       if (!(fault & VM_FAULT_RETRY)) {
> >               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f69fbc251198..9011ad63c41b 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5086,7 +5086,17 @@ static vm_fault_t __handle_mm_fault(struct vm_ar=
ea_struct *vma,
> >               }
> >       }
> >
> > -     return handle_pte_fault(&vmf);
> > +     ret =3D handle_pte_fault(&vmf);
> > +     if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
> > +             /*
> > +              * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we mig=
ht
> > +              * be still holding per-VMA lock to keep the vma stable a=
s long
> > +              * as possible. Drop it before returning.
> > +              */
> > +             if (vmf.flags & FAULT_FLAG_VMA_LOCK)
> > +                     vma_end_read(vma);
> > +     }
>
> This smells hackish.. I'd think better we just release the lock at the
> place where we'll return RETRY, and AFAIU swap is the only place vma lock
> returns a RETRY with current code base?
>
> do_swap_page():
>         if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vma);
>                 ret =3D VM_FAULT_RETRY;
>                 goto out;
>         }
>
> I.e., I don't think VM_FAULT_COMPLETED can even be returned with vma lock
> paths yet as it doesn't yet support VM_SHARED.

Ack.

>
> --
> Peter Xu
>
