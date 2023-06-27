Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2651B73FFCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF0Pfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjF0Pfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:35:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA4D2D53
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:35:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso4676811276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687880147; x=1690472147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhNxLFGpu4iF1+tBl9GUqQA+nvSIsmhRHaz0sstddl4=;
        b=Z+dXs+eoUJpPLQpLki49VLgu/9v3VfZFLuMBbqLgYFgFxGVThgpVF86ZJwnl7Ut7cn
         JZuq/uE0kHAPz2ZpN/yjwi3iSAz7tW4K5rofSml+DOyr6LJm1su+NMLkyladOA/97nkp
         RF24r8XAXIueBDJdl1f9Xs7DG38o7MVTYNyu2z40azPwik/de+ViP4gdVQmH8XJCPeZf
         4ZhmLCMrPc5zITSTq/sFhJkB0m+TZ0EGEzoSUkOHVgKp+JQwEzZpUuGDdMvyZgVPUeYc
         sg8NFtpkYEc72Ghdy4er+vytTMzrAISl8zIwY1gvGCh3PynxREVHWzKpj7VrC8dNi4JC
         KFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687880147; x=1690472147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhNxLFGpu4iF1+tBl9GUqQA+nvSIsmhRHaz0sstddl4=;
        b=NK5cstMAzNr+d4qaRNZDd+YXP2Ffz788U/WosGRKUrQl06SuHyfL4j4Wp+FpU1BtDg
         BKtxWInc7sLFRxVzxesUEm9CUYf7FmpquMp2zKfa+BQBrTElXFfCxpb0FUHHjXnTQiq6
         H/ZllgryJrlGTwBdSKbfWxMrZKq/VYHYcrqNTgxzVaJurQjN46/DI8vCypun491Vg980
         xzgVOCtzdbewi7o3pEVzwjhxKPy9J5Cpm6AgRZIleVWgvA9t+QTPb3FBwWvGJ8139zHD
         ZxGjTEDbKR+45T3GEgLxsjgAarwpqY6vE4pfR39mYlnfPa8QE9Jy9ZTpc8wo1nXoUxCB
         qg1Q==
X-Gm-Message-State: AC+VfDz6E5QATM3J8//awiandGX5Qt1FL+wLro49pMuoey40Nw46haJO
        kfP4ryQmG5ImyKilTPNf+fAfIyMEuX2B1QfpY/XzKQ==
X-Google-Smtp-Source: ACHHUZ45C84F8vXdusgYm2ISHNmBkm7kQEA2MlZgv/6RCllE4EV196ruC3PfGHK8PoauQ0Z+TeaJmhdhbmHMYIcuuhg=
X-Received: by 2002:a25:2513:0:b0:c12:d2b:5428 with SMTP id
 l19-20020a252513000000b00c120d2b5428mr8693622ybl.29.1687880146789; Tue, 27
 Jun 2023 08:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-8-surenb@google.com>
 <875y792uu7.fsf@nvdebian.thelocal>
In-Reply-To: <875y792uu7.fsf@nvdebian.thelocal>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 08:35:35 -0700
Message-ID: <CAJuCfpHSe8+h+wG6RxepiqxZiGDoyQJcMnZ7kkSeNbAzgEYROQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 1:06=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > migration_entry_wait does not need VMA lock, therefore it can be
> > dropped before waiting.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/memory.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 5caaa4c66ea2..bdf46fdc58d6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       if (unlikely(non_swap_entry(entry))) {
> >               if (is_migration_entry(entry)) {
> > -                     migration_entry_wait(vma->vm_mm, vmf->pmd,
> > -                                          vmf->address);
> > +                     /* Save mm in case VMA lock is dropped */
> > +                     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +                     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                             /*
> > +                              * No need to hold VMA lock for migration=
.
> > +                              * WARNING: vma can't be used after this!
> > +                              */
> > +                             vma_end_read(vma);
> > +                             ret |=3D VM_FAULT_COMPLETED;
>
> Doesn't this need to also set FAULT_FLAG_LOCK_DROPPED to ensure we don't
> call vma_end_read() again in __handle_mm_fault()?

Uh, right. Got lost during the last refactoring. Thanks for flagging!

>
> > +                     }
> > +                     migration_entry_wait(mm, vmf->pmd, vmf->address);
> >               } else if (is_device_exclusive_entry(entry)) {
> >                       vmf->page =3D pfn_swap_entry_to_page(entry);
> >                       ret =3D remove_device_exclusive_entry(vmf);
>
