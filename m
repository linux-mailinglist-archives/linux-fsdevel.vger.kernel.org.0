Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1E6F5F55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjECTmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECTmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:42:24 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3607EC6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 12:42:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so5265457276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683142937; x=1685734937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66tG72rxj01tEzIhohJuuSFN+mKdDXWP8TmCLCAdWE=;
        b=a1iLtOUtpMBcudAp+MYHhMRaSRYiAr+weHUc65uhkIL2DNMGQ4IBjRTGTgiuONBiYP
         vVLg4kXeD/y1TobXMImkPRFkLEFDyMkBVj3chwGbyMjyT9KueDI0t4jM83JCb+nZbNpg
         J/yqZcdlmdpM/XRaQRoaLiOpk1HFwAcDjRzKVbq5BFCOAsv/q1gn9XZ0OlwEgx5E1tmU
         fxlkLjvH2QJSr3ZA/JpgsJ2ZaifRyNlvg3Y4opQ8LDqYGzRs1E/gkPa2ITSKhitCTkxP
         RHQTvW0O6XD7HwIA3/vCkni+jxq3ADu+NHijnoNlKzGv0ZxiRdAZ2H1lDLOMmwB7AWW9
         D6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142937; x=1685734937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F66tG72rxj01tEzIhohJuuSFN+mKdDXWP8TmCLCAdWE=;
        b=TPZRec+Wsm41FZ/pHR8Y2djXCQPCxnZckQBObAc8c/MFPO0wAKkvTQDODV9xn/7Pgb
         OvGmVmWgqcL2pH6qZXtROe1++gvMG3MDHVI0tqz1njnaXmkxjzH/nFY6hAQotrzYrp02
         O62vptE6SWg3YbBgUx+KrhOK0A0Na+9rSQJX3qKZAPm8+IWdhvckIWFFz523ykQIGM4Z
         i9HWffIgZlUa/FssvA3M0xDz9ehyPe+6Gt/RyuizZtwDG/Rz+GmLlzJsqdhfvbfwvjIr
         9gNB2xYayvGhSwoF5OMtMtY7vk94NTqifkwUv1k2Y4wq2JRbaMaxEScbk4+h62Y1i7/0
         IX5A==
X-Gm-Message-State: AC+VfDzjtEA5cOArE4Q1bLV5A33mVdvXKqcFxvsPFG3etcfv36R865tz
        yu8ALKt5UYG+ymx27LItF3+HaYSY+gnDgqcns2S//A==
X-Google-Smtp-Source: ACHHUZ7Ugm6qsRSsxxL6fdJKCJyNFCrHQQaJjzCEXBLpYUK3FrDKBJdA46z3aMrfSb8XYxo7SGFzTHbMdrXAHFSGYjM=
X-Received: by 2002:a25:4ac2:0:b0:b3d:5a52:5c6b with SMTP id
 x185-20020a254ac2000000b00b3d5a525c6bmr3354631yba.21.1683142937398; Wed, 03
 May 2023 12:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <20230501175025.36233-2-surenb@google.com>
 <875y9aj23u.fsf@nvidia.com> <CAJuCfpGprqXcjjUmN_Vx7Uqa8aPrSZAq9WLV0W9=sKNBUe3Cvg@mail.gmail.com>
 <87lei5zhsr.fsf@nvidia.com>
In-Reply-To: <87lei5zhsr.fsf@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 3 May 2023 12:42:06 -0700
Message-ID: <CAJuCfpEy9DBAEQw9H3CvF8MaX0NZTvY_+uCPiZqW+k0KjktECw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: drop VMA lock before waiting for migration
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Wed, May 3, 2023 at 6:05=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > On Tue, May 2, 2023 at 6:26=E2=80=AFAM 'Alistair Popple' via kernel-tea=
m
> > <kernel-team@android.com> wrote:
> >>
> >>
> >> Suren Baghdasaryan <surenb@google.com> writes:
> >>
> >> [...]
> >>
> >> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >> > index 306a3d1a0fa6..b3b57c6da0e1 100644
> >> > --- a/include/linux/mm_types.h
> >> > +++ b/include/linux/mm_types.h
> >> > @@ -1030,6 +1030,7 @@ typedef __bitwise unsigned int vm_fault_t;
> >> >   *                           fsync() to complete (for synchronous p=
age faults
> >> >   *                           in DAX)
> >> >   * @VM_FAULT_COMPLETED:              ->fault completed, meanwhile m=
map lock released
> >> > + * @VM_FAULT_VMA_UNLOCKED:   VMA lock was released
> >>
> >> A note here saying vmf->vma should no longer be accessed would be nice=
.
> >
> > Good idea. Will add in the next version. Thanks!
> >
> >>
> >> >   * @VM_FAULT_HINDEX_MASK:    mask HINDEX value
> >> >   *
> >> >   */
> >> > @@ -1047,6 +1048,7 @@ enum vm_fault_reason {
> >> >       VM_FAULT_DONE_COW       =3D (__force vm_fault_t)0x001000,
> >> >       VM_FAULT_NEEDDSYNC      =3D (__force vm_fault_t)0x002000,
> >> >       VM_FAULT_COMPLETED      =3D (__force vm_fault_t)0x004000,
> >> > +     VM_FAULT_VMA_UNLOCKED   =3D (__force vm_fault_t)0x008000,
> >> >       VM_FAULT_HINDEX_MASK    =3D (__force vm_fault_t)0x0f0000,
> >> >  };
> >> >
> >> > @@ -1070,7 +1072,9 @@ enum vm_fault_reason {
> >> >       { VM_FAULT_RETRY,               "RETRY" },      \
> >> >       { VM_FAULT_FALLBACK,            "FALLBACK" },   \
> >> >       { VM_FAULT_DONE_COW,            "DONE_COW" },   \
> >> > -     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> >> > +     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
> >> > +     { VM_FAULT_COMPLETED,           "COMPLETED" },  \
> >>
> >> VM_FAULT_COMPLETED isn't used in this patch, guessing that's snuck in
> >> from one of the other patches in the series?
> >
> > I noticed that an entry for VM_FAULT_COMPLETED was missing and wanted
> > to fix that... Should I drop that?
>
> Oh ok. It would certainly be good to add but really it should be it's
> own patch.

Ack. Will split in the next version. Thanks!

>
> >>
> >> > +     { VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
> >> >
> >> >  struct vm_special_mapping {
> >> >       const char *name;       /* The name, e.g. "[vdso]". */
> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > index 41f45819a923..8222acf74fd3 100644
> >> > --- a/mm/memory.c
> >> > +++ b/mm/memory.c
> >> > @@ -3714,8 +3714,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >> >       if (unlikely(non_swap_entry(entry))) {
> >> >               if (is_migration_entry(entry)) {
> >> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
> >> > -                                          vmf->address);
> >> > +                     /* Save mm in case VMA lock is dropped */
> >> > +                     struct mm_struct *mm =3D vma->vm_mm;
> >> > +
> >> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> >> > +                             /* No need to hold VMA lock for migrat=
ion */
> >> > +                             vma_end_read(vma);
> >> > +                             /* CAUTION! VMA can't be used after th=
is */
> >> > +                             ret |=3D VM_FAULT_VMA_UNLOCKED;
> >> > +                     }
> >> > +                     migration_entry_wait(mm, vmf->pmd, vmf->addres=
s);
> >> >               } else if (is_device_exclusive_entry(entry)) {
> >> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >> >                       ret =3D remove_device_exclusive_entry(vmf);
> >>
> >> --
> >> To unsubscribe from this group and stop receiving emails from it, send=
 an email to kernel-team+unsubscribe@android.com.
> >>
>
