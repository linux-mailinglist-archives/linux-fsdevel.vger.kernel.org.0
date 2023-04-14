Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848376E2BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDNVwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDNVwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:52:13 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415031FDD
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:52:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id by8so4120760ybb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681509130; x=1684101130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Ec7uFiIfmRmN61V1bJw83NzlxVzPRXSYdLuJ40kFQ=;
        b=20XlelL+jChK79ShTU3jIFYMVYsTy4bydr0eghQ0sbN+vYBGl2mvjANHKs+gvvmfNd
         behIfmNJuGLYbs0EZCP3B1qIKL30mKS2+TMMsC+6goZ8ht6B4engzIc7LOewjic8jlcm
         bJBeh2n/L8L4jM4iuQZ1hrB+694ETnuacFgJ+PLl48YhPn8X9Iz+XeWu5Ud2EeCEdHNJ
         4seUQwlqrRZ2XLAwOoH0X9uuj8qKAdU5krgXfhVau1I88bqzByQMo9ntrZuPDwF6bkb9
         sOrFsppnzMHHEuCTAsWkpgx6Hq2VPnrojC2GAbQn7fk1KHNO3i2HjuK1vMZcMz3SFBDL
         GuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509130; x=1684101130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Ec7uFiIfmRmN61V1bJw83NzlxVzPRXSYdLuJ40kFQ=;
        b=hQswADG2qV4toYHe9WdgK+Do/qvyEMDqGqo2SCB4wvlsQjUT+ABYggiukwsW0G3kZy
         BP+UoqMpPRJeg32WFujtOXIiALlF14Zz+VA64ybZIuX45bEkmtCHZKW1t+SVvfMrpoyn
         JoDsyE9K5DeX4s9RVwsQp5OJWass/OcvT7GOPIvkV49qM0BdyTgzGKYWAvtZ3R23nfWx
         CrRIW9KGL0TSxRmWaCZwuXoIgBp3s0VXRc2z5RjCAFPOJL2faSv/jlVgsjAi+aNuOcol
         F8dnl/mTsIzHsKqMzaFP9OgNsKGX8DtdiA2xwrWWrhTZ/B4K+9H6FZz/6mlLtHZVEBfF
         tWJQ==
X-Gm-Message-State: AAQBX9e1m3wpApNPKgcN1DpKgzHCyXXkhqub88t2RKSF79/ZY9euq3+o
        Kofq+gAp5l8Bi7Oke6yoGqB274UZvuZfM7Z/VGBWqg==
X-Google-Smtp-Source: AKy350ab6zATiyZGtaIhEWr8kb6QJ/jqLf1DxG2XPENo2+Qz94wtYQds9/wct2ztRxrJLixMF3T2qCyEYoN2GfJz8Ho=
X-Received: by 2002:a25:308a:0:b0:b8e:e0db:5b9d with SMTP id
 w132-20020a25308a000000b00b8ee0db5b9dmr3918724ybw.12.1681509130246; Fri, 14
 Apr 2023 14:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com> <ZDmetaUdmlEz/W8Q@casper.infradead.org>
 <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com> <ZDm4P37XXyMBOMdZ@casper.infradead.org>
In-Reply-To: <ZDm4P37XXyMBOMdZ@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 14:51:59 -0700
Message-ID: <CAJuCfpF2idZUjON6TZw4NV+himmACMGGE=2jgmt=fgAXv6L5Pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
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

On Fri, Apr 14, 2023 at 1:32=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 14, 2023 at 12:48:54PM -0700, Suren Baghdasaryan wrote:
> > >  - We can call migration_entry_wait().  This will wait for PG_locked =
to
> > >    become clear (in migration_entry_wait_on_locked()).  As previously
> > >    discussed offline, I think this is safe to do while holding the VM=
A
> > >    locked.
>
> Just to be clear, this particular use of PG_locked is not during I/O,
> it's during page migration.  This is a few orders of magnitude
> different.
>
> > >  - We can call swap_readpage() if we allocate a new folio.  I haven't
> > >    traced through all this code to tell if it's OK.
>
> ... whereas this will wait for I/O.  If we decide that's not OK, we'll
> need to test for FAULT_FLAG_VMA_LOCK and bail out of this path.
>
> > > So ... I believe this is all OK, but we're definitely now willing to
> > > wait for I/O from the swap device while holding the VMA lock when we
> > > weren't before.  And maybe we should make a bigger deal of it in the
> > > changelog.
> > >
> > > And maybe we shouldn't just be failing the folio_lock_or_retry(),
> > > maybe we should be waiting for the folio lock with the VMA locked.
> >
> > Wouldn't that cause holding the VMA lock for the duration of swap I/O
> > (something you said we want to avoid in the previous paragraph) and
> > effectively undo d065bd810b6d ("mm: retry page fault when blocking on
> > disk transfer") for VMA locks?
>
> I'm not certain we want to avoid holding the VMA lock for the duration
> of an I/O.  Here's how I understand the rationale for avoiding holding
> the mmap_lock while we perform I/O (before the existence of the VMA lock)=
:
>
>  - If everybody is doing page faults, there is no specific problem;
>    we all hold the lock for read and multiple page faults can be handled
>    in parallel.
>  - As soon as one thread attempts to manipulate the tree (eg calls
>    mmap()), all new readers must wait (as the rwsem is fair), and the
>    writer must wait for all existing readers to finish.  That's
>    potentially milliseconds for an I/O during which time all page faults
>    stop.
>
> Now we have the per-VMA lock, faults which can be handled without taking
> the mmap_lock can still be satisfied, as long as that VMA is not being
> modified.  It is rare for a real application to take a page fault on a
> VMA which is being modified.
>
> So modifications to the tree will generally not take VMA locks on VMAs
> which are currently handling faults, and new faults will generally not
> find a VMA which is write-locked.
>
> When we find a locked folio (presumably for I/O, although folios are
> locked for other reasons), if we fall back to taking the mmap_lock
> for read, we increase contention on the mmap_lock and make the page
> fault wait on any mmap() operation.

Do you mean we increase mmap_lock contention by holding the mmap_lock
between the start of pagefault retry and until we drop it in
__folio_lock_or_retry?

> If we simply sleep waiting for the
> I/O, we make any mmap() operation _which touches this VMA_ wait for
> the I/O to complete.  But I think that's OK, because new page faults
> can continue to be serviced ... as long as they don't need to take
> the mmap_lock.

Ok, so we will potentially block VMA writers for the duration of the I/O...
Stupid question: why was this a bigger problem for mmap_lock?
Potentially our address space can consist of only one anon VMA, so
locking that VMA vs mmap_lock should be the same from swap pagefault
POV. Maybe mmap_lock is taken for write in some other important cases
when VMA lock is not needed?

>
> So ... I think what we _really_ want here is ...
>
> +++ b/mm/filemap.c
> @@ -1690,7 +1690,8 @@ static int __folio_lock_async(struct folio *folio, =
struct wait_page_queue *wait)
>  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>                          unsigned int flags)
>  {
> -       if (fault_flag_allow_retry_first(flags)) {
> +       if (!(flags & FAULT_FLAG_VMA_LOCK) &&
> +           fault_flag_allow_retry_first(flags)) {
>                 /*
>                  * CAUTION! In this case, mmap_lock is not released
>                  * even though return 0.
> @@ -1710,7 +1711,8 @@ bool __folio_lock_or_retry(struct folio *folio, str=
uct mm_struct *mm,
>
>                 ret =3D __folio_lock_killable(folio);
>                 if (ret) {
> -                       mmap_read_unlock(mm);
> +                       if (!(flags & FAULT_FLAG_VMA_LOCK))
> +                               mmap_read_unlock(mm);
>                         return false;
>                 }
>         } else {
>
