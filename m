Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1E6F487D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjEBQjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBQji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 12:39:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A32199B
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:39:37 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a829411b5so16735417b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683045576; x=1685637576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xybmk5oF5XocRF6QnLbR3pBBz0bUKcHYBYP//hI96cQ=;
        b=GTSVUcwhPEO39Bjh0O+Iip5o3vix9tgpChzNaeKGCEiZeo0gAKVfc2Tbli5kDK8g7M
         jJHSLcS2baq+YBgFaR8Jh/5BCajwe5SkfWs1rZ6qYvgNxULjHTyCTkxPDdz+FhRgQTDg
         Aw/LFghVIk1HcCjHSEj0KJR+s+TrMTrlokwdwJhTKn4rTLlPOSWpqBZxo8SnDMb55sQj
         SIstusMyNgdNqoyNF0LxbZnIdugnpHibteuPBT2ajMr9BxSA5ougt5Uvok0qzZsf3Zg8
         OiOJDrBkH8uclwQ/MdtpI+bYdXgclxagg7dzr5Se1jiH7ihMuFQCSqycoP50vEIoNhYp
         Yv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045576; x=1685637576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xybmk5oF5XocRF6QnLbR3pBBz0bUKcHYBYP//hI96cQ=;
        b=O/O/RC4qiz7K+AmBNk6qOyt3VhmJsgSZcrqp6bxG1eOZ9jsf+iyh9xVJOUqV8VF+lh
         a2VvQsF9H9vaH543N7hUAnWmT3wNI99G4/lzmgCGfXilpcB4qQNFTx5xdzhLUrW3TkEV
         LVN+joeVYA7Tqk6tBIkXBK+//1dGZyILVc7Qu2UylhXdQ8fGQMM9IFhhdYEfzhny4t+I
         rejevujjr+FNQswEAfxphps9AOBjDQjPV5cOzox3ACubyfRnKHtx0hGt70eH7NOaKbL0
         8TPPXvUS9gQyfa4AQoSC+AmteStwK+dBYIByLg+p+5L4ii9LB5um4qfaeDhet4CPxIll
         W5iw==
X-Gm-Message-State: AC+VfDx1/qmK0CQAuCv9bJ9qbmlCJaXv3fOyAIo/23fSdAV0rvoNUp2J
        sByT0sTl+58XMZoCfFio2S6Nn9C0xiD2BpKS2iLJww==
X-Google-Smtp-Source: ACHHUZ6GnKZoybKtbHHgEzVHkcPoWyY6uU6keVqf7KvO7SxSmOSkgyovhuXcqypho2DbAqdEVNEcWILdM5C14quYFis=
X-Received: by 2002:a81:7c03:0:b0:55a:aeb7:2b0a with SMTP id
 x3-20020a817c03000000b0055aaeb72b0amr906878ywc.23.1683045575833; Tue, 02 May
 2023 09:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <20230501175025.36233-2-surenb@google.com>
 <875y9aj23u.fsf@nvidia.com>
In-Reply-To: <875y9aj23u.fsf@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 09:39:24 -0700
Message-ID: <CAJuCfpGprqXcjjUmN_Vx7Uqa8aPrSZAq9WLV0W9=sKNBUe3Cvg@mail.gmail.com>
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

On Tue, May 2, 2023 at 6:26=E2=80=AFAM 'Alistair Popple' via kernel-team
<kernel-team@android.com> wrote:
>
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> [...]
>
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 306a3d1a0fa6..b3b57c6da0e1 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1030,6 +1030,7 @@ typedef __bitwise unsigned int vm_fault_t;
> >   *                           fsync() to complete (for synchronous page=
 faults
> >   *                           in DAX)
> >   * @VM_FAULT_COMPLETED:              ->fault completed, meanwhile mmap=
 lock released
> > + * @VM_FAULT_VMA_UNLOCKED:   VMA lock was released
>
> A note here saying vmf->vma should no longer be accessed would be nice.

Good idea. Will add in the next version. Thanks!

>
> >   * @VM_FAULT_HINDEX_MASK:    mask HINDEX value
> >   *
> >   */
> > @@ -1047,6 +1048,7 @@ enum vm_fault_reason {
> >       VM_FAULT_DONE_COW       =3D (__force vm_fault_t)0x001000,
> >       VM_FAULT_NEEDDSYNC      =3D (__force vm_fault_t)0x002000,
> >       VM_FAULT_COMPLETED      =3D (__force vm_fault_t)0x004000,
> > +     VM_FAULT_VMA_UNLOCKED   =3D (__force vm_fault_t)0x008000,
> >       VM_FAULT_HINDEX_MASK    =3D (__force vm_fault_t)0x0f0000,
> >  };
> >
> > @@ -1070,7 +1072,9 @@ enum vm_fault_reason {
> >       { VM_FAULT_RETRY,               "RETRY" },      \
> >       { VM_FAULT_FALLBACK,            "FALLBACK" },   \
> >       { VM_FAULT_DONE_COW,            "DONE_COW" },   \
> > -     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> > +     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
> > +     { VM_FAULT_COMPLETED,           "COMPLETED" },  \
>
> VM_FAULT_COMPLETED isn't used in this patch, guessing that's snuck in
> from one of the other patches in the series?

I noticed that an entry for VM_FAULT_COMPLETED was missing and wanted
to fix that... Should I drop that?

>
> > +     { VM_FAULT_VMA_UNLOCKED,        "VMA_UNLOCKED" }
> >
> >  struct vm_special_mapping {
> >       const char *name;       /* The name, e.g. "[vdso]". */
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 41f45819a923..8222acf74fd3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3714,8 +3714,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
> > -                                          vmf->address);
> > +                     /* Save mm in case VMA lock is dropped */
> > +                     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                             /* No need to hold VMA lock for migration=
 */
> > +                             vma_end_read(vma);
> > +                             /* CAUTION! VMA can't be used after this =
*/
> > +                             ret |=3D VM_FAULT_VMA_UNLOCKED;
> > +                     }
> > +                     migration_entry_wait(mm, vmf->pmd, vmf->address);
> >               } else if (is_device_exclusive_entry(entry)) {
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       ret =3D remove_device_exclusive_entry(vmf);
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
