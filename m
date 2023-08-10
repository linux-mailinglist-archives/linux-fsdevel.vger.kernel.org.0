Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C9778206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjHJUUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHJUUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:20:22 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C37B2718
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 13:20:21 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c74961e0cso1056888eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691698821; x=1692303621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H3yyG7XVBmPgpZbRel0dQc6e8lzfwXDnebcZHkrY6I=;
        b=4DziVMSdZ/POSPu0fbZ2zw4SkrSPxT5eMr/Yas7q/11gLiHruaFmAIKQ9ZTemrQ9Yn
         C42Jke3d/CpzK8B8uF8iZM3m6rkpACZbSKuxeX9hQWrrvclyci0tBl9HhBIzMkeC7V4y
         +lIMnzW80Pk+28WdR5JrGh+yqSu8cwSuGPey4kEkP6P/lp46cuxdLPnQePeiAXQ97PP/
         SAQKbd9MP7TeIfVOgfCmUykDJnpg7ggZV/rRfA53nin8lZJ8E8EOgP4ntIDST7GDjwyU
         2LluMDhnyZ9nnTu/ct2Voi72FzsfrLZuX1fxAaQa6youcBJ+UhF8v4h++h3JOi+26aPU
         GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698821; x=1692303621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H3yyG7XVBmPgpZbRel0dQc6e8lzfwXDnebcZHkrY6I=;
        b=jRBJYJ+bRqdZHgSeAJxGKEjnJP4n0JOtzf2BA1Ls5LxY5BedzYLvoOwHHyUMBYJgHh
         abms1bd2yzlxyS2w625SpzraMwxmzfxYYxILHgiaIJB0Ndp4wL4Y5axHJ3x/WuXftx82
         t8sBTTw7Jj60AB1LulnWXOG1UuKrMXuE2vd79nPS290DfEhYswqXuMwshBG6cPr7P8Ws
         9q5+SouYjHnwHZYKHyTLJ1eOzYR9P7KQMzTWAy7f2kkZEVEdVepZj7J1aGid7QROWVpY
         7ThWPrNrH/b+xIaEYOq3j1LRNxTKfZ875OlBjf5d4jZWcMleKzeXUF9TDdfdWaAkTv0h
         rsnQ==
X-Gm-Message-State: AOJu0YxJ5osT4ZM6lmXXLhr574B7KjDVkOQ4Ad2+TUNt7vxjcgwmf4cl
        C6az4BRO/CiZNqVce9OhwlQADHTM3zx00WZJ1DhR7A==
X-Google-Smtp-Source: AGHT+IFDXwBUtyS42J7TYsiABMXZD6fg+qqeJ68pmlEsx5vvajDiUvI0of9X7T5czmR1RA3Byjofr33NYO6HIAzGOQ0=
X-Received: by 2002:a05:6358:7f1a:b0:134:c1e1:3b08 with SMTP id
 p26-20020a0563587f1a00b00134c1e13b08mr14840rwn.25.1691698820530; Thu, 10 Aug
 2023 13:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com> <01e20a4a-35dc-b342-081f-0edaf8780f51@redhat.com>
In-Reply-To: <01e20a4a-35dc-b342-081f-0edaf8780f51@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Aug 2023 13:20:09 -0700
Message-ID: <CAJuCfpGXvGZZtrVscxMd7F1O-u5c9Wm9pqFBbJ5geS2MJo41kw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     David Hildenbrand <david@redhat.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:41=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 10.08.23 08:24, Suren Baghdasaryan wrote:
> > On Wed, Aug 9, 2023 at 10:29=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>>
> >>> On Wed, Aug 9, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> >>>>
> >>>> On Wed, Aug 9, 2023 at 11:04=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>>>>>> Which ends up being
> >>>>>>>>>
> >>>>>>>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >>>>>>>>>
> >>>>>>>>> I did not check if this is also the case on mainline, and if th=
is series is responsible.
> >>>>>>>>
> >>>>>>>> Thanks for reporting! I'm checking it now.
> >>>>>>>
> >>>>>>> Hmm. From the code it's not obvious how lock_mm_and_find_vma() en=
ds up
> >>>>>>> calling find_vma() without mmap_lock after successfully completin=
g
> >>>>>>> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points=
 to
> >>>>>>> the first invocation of find_vma(), so this is not even the lock
> >>>>>>> upgrade path... I'll try to reproduce this issue and dig up more =
but
> >>>>>>> from the information I have so far this issue does not seem to be
> >>>>>>> related to this series.
> >>>>>
> >>>>> I just checked on mainline and it does not fail there.
> >>>
> >>> Thanks. Just to eliminate the possibility, I'll try reverting my
> >>> patchset in mm-unstable and will try the test again. Will do that in
> >>> the evening once I'm home.
> >>>
> >>>>>
> >>>>>>
> >>>>>> This is really weird. I added mmap_assert_locked(mm) calls into
> >>>>>> get_mmap_lock_carefully() right after we acquire mmap_lock read lo=
ck
> >>>>>> and one of them triggers right after successful
> >>>>>> mmap_read_lock_killable(). Here is my modified version of
> >>>>>> get_mmap_lock_carefully():
> >>>>>>
> >>>>>> static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> >>>>>> struct pt_regs *regs) {
> >>>>>>        /* Even if this succeeds, make it clear we might have slept=
 */
> >>>>>>        if (likely(mmap_read_trylock(mm))) {
> >>>>>>            might_sleep();
> >>>>>>            mmap_assert_locked(mm);
> >>>>>>            return true;
> >>>>>>        }
> >>>>>>        if (regs && !user_mode(regs)) {
> >>>>>>            unsigned long ip =3D instruction_pointer(regs);
> >>>>>>            if (!search_exception_tables(ip))
> >>>>>>                return false;
> >>>>>>        }
> >>>>>>        if (!mmap_read_lock_killable(mm)) {
> >>>>>>            mmap_assert_locked(mm);                     <---- gener=
ates a BUG
> >>>>>>            return true;
> >>>>>>        }
> >>>>>>        return false;
> >>>>>> }
> >>>>>
> >>>>> Ehm, that's indeed weird.
> >>>>>
> >>>>>>
> >>>>>> AFAIKT conditions for mmap_read_trylock() and
> >>>>>> mmap_read_lock_killable() are checked correctly. Am I missing
> >>>>>> something?
> >>>>>
> >>>>> Weirdly enough, it only triggers during that specific uffd test, ri=
ght?
> >>>>
> >>>> Yes, uffd-unit-tests. I even ran it separately to ensure it's not so=
me
> >>>> fallback from a previous test and I'm able to reproduce this
> >>>> consistently.
> >>
> >> Yeah, it is somehow related to per-vma locking. Unfortunately I can't
> >> reproduce the issue on my VM, so I have to use my host and bisection
> >> is slow. I think I'll get to the bottom of this tomorrow.
> >
> > Ok, I think I found the issue.
>
> Nice!
>
> > wp_page_shared() ->
> > fault_dirty_shared_page() can drop mmap_lock (see the comment saying
> > "Drop the mmap_lock before waiting on IO, if we can...", therefore we
> > have to ensure we are not doing this under per-VMA lock.
> > I think what happens is that this path is racing with another page
> > fault which took mmap_lock for read. fault_dirty_shared_page()
> > releases this lock which was taken by another page faulting thread and
> > that thread generates an assertion when it finds out the lock it just
> > took got released from under it.
>
> I wonder if we could detect that someone releases the mmap lock that was
> not taken by that person, to bail out early at the right place when
> debugging such issues. Only with certain config knobs enabled, of course.

I think that's doable. If we add tags_struct.mmap_locked =3D RDLOCK |
WRLOCK | NONE that could set when a task takes the mmap_lock and
reset+checked when it's released. Lockdep would also catch this if the
release code did not race with another page faulting task (this would
be seen as releasing the lock which was never locked).

>
> > The following crude change fixed the issue for me but there might be a
> > more granular way to deal with this:
> >
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3293,18 +3293,18 @@ static vm_fault_t wp_page_shared(struct
> > vm_fault *vmf, struct folio *folio)
> >           struct vm_area_struct *vma =3D vmf->vma;
> >           vm_fault_t ret =3D 0;
> >
> > +        if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > +                pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +                vma_end_read(vmf->vma);
> > +                return VM_FAULT_RETRY;
> > +        }
> > +
>
> I won't lie: all of these locking checks are a bit hard to get and
> possibly even harder to maintain.
>
> Maybe better mmap unlock sanity checks as spelled out above might help
> improve part of the situation.
>
>
> And maybe some comments regarding the placement might help as well ;)

I think comments with explanations why we bail out would help. I had
them in some but probably not all the places. Once the code stabilizes
I'll review the results and will add more comments with explanations.
Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
