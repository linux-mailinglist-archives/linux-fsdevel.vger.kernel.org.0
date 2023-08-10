Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB524777040
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 08:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjHJGYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjHJGYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:24:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086921704
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 23:24:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so509490276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691648669; x=1692253469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcRSefl3OZZaOz0guv+13e/oWyf4yL2+dUUAXZrxcbs=;
        b=Q3t3fVnAnbjwvs1rSolyQhbmJnfPYm4QBm+7lLywrgD8BaSQDgk4w4RaTRwmlXONqB
         oWkeJhKvJjruyocXII1gaUwsutCG9Yene4sGUmbDazXoHN295cpH9yMQ66b+SDV0HPtJ
         LgHgZB+T5NjxAXgU6Fi3dPiGYImioi7VtSKa3rPoOKjRkBAceBXbxWEZI8f6qIAwcF8t
         e65EilUk3dtZW5LQB+kNlta6MqWW4uwmsNfpyQKZPPdrJ/RCvIzadXP9Kw3SMH4+eECG
         b2tte4iX8hD0Oj699VXXhEghOr6GX9v8ftDETAmP9DyS+fo0LHvMLWy2IG1rnB+dukv0
         c3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691648669; x=1692253469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcRSefl3OZZaOz0guv+13e/oWyf4yL2+dUUAXZrxcbs=;
        b=ajMd07W1yKQe/xcXeYX2cvBkEVKNM5vXvVfiwWrnWeQyzGa95Sk7ouC1CuqoHsA5Rc
         7ZtXXu9R1omxHhHAfGO7U3QfZHoP8VG3JyK5963QLi+pDbse0jqGcZsvSzMAchINOO8c
         nKPJSV9cc2V5ual4LHiYwWCni/rx0s4L72ESw4OfqMcRruMf6rUn7ebLKo5/7Akjkne5
         YflwMSJdSsFMJY6pYAASIUTYRBYS1PgYHOS462NHhvmgKv1DzHJheOeHstyZDJB6uvFl
         T+bJSSB0gV88oc6R3h+i1E9ZFYpHunZGqB7tbEcQoa4kowxId2uw29j0R75XN7k9Gh4u
         xJYQ==
X-Gm-Message-State: AOJu0YxeTDoYVoD/U+YRt3w+4j1Nl4ZvG8ktpJv2dGvL1/Yp5I0NrO30
        XOmyl7KedC/SiXBQghDKd9AfWSW9vjXDYk5Wxa6f3w==
X-Google-Smtp-Source: AGHT+IFOLniwxzWYoJ8fkv7Tcws0en57d877E8g4X26U+1A06Nius1ggOJxrvezVXOQb/C474rT0eFEVM7bBh7DoO6U=
X-Received: by 2002:a25:aaea:0:b0:d43:604f:9de1 with SMTP id
 t97-20020a25aaea000000b00d43604f9de1mr1690683ybi.17.1691648669006; Wed, 09
 Aug 2023 23:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com> <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
In-Reply-To: <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Aug 2023 06:24:15 +0000
Message-ID: <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     David Hildenbrand <david@redhat.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
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

On Wed, Aug 9, 2023 at 10:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 9, 2023 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Aug 9, 2023 at 11:08=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Aug 9, 2023 at 11:04=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> > > >
> > > > >>>> Which ends up being
> > > > >>>>
> > > > >>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > > > >>>>
> > > > >>>> I did not check if this is also the case on mainline, and if t=
his series is responsible.
> > > > >>>
> > > > >>> Thanks for reporting! I'm checking it now.
> > > > >>
> > > > >> Hmm. From the code it's not obvious how lock_mm_and_find_vma() e=
nds up
> > > > >> calling find_vma() without mmap_lock after successfully completi=
ng
> > > > >> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 point=
s to
> > > > >> the first invocation of find_vma(), so this is not even the lock
> > > > >> upgrade path... I'll try to reproduce this issue and dig up more=
 but
> > > > >> from the information I have so far this issue does not seem to b=
e
> > > > >> related to this series.
> > > >
> > > > I just checked on mainline and it does not fail there.
> >
> > Thanks. Just to eliminate the possibility, I'll try reverting my
> > patchset in mm-unstable and will try the test again. Will do that in
> > the evening once I'm home.
> >
> > > >
> > > > >
> > > > > This is really weird. I added mmap_assert_locked(mm) calls into
> > > > > get_mmap_lock_carefully() right after we acquire mmap_lock read l=
ock
> > > > > and one of them triggers right after successful
> > > > > mmap_read_lock_killable(). Here is my modified version of
> > > > > get_mmap_lock_carefully():
> > > > >
> > > > > static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> > > > > struct pt_regs *regs) {
> > > > >       /* Even if this succeeds, make it clear we might have slept=
 */
> > > > >       if (likely(mmap_read_trylock(mm))) {
> > > > >           might_sleep();
> > > > >           mmap_assert_locked(mm);
> > > > >           return true;
> > > > >       }
> > > > >       if (regs && !user_mode(regs)) {
> > > > >           unsigned long ip =3D instruction_pointer(regs);
> > > > >           if (!search_exception_tables(ip))
> > > > >               return false;
> > > > >       }
> > > > >       if (!mmap_read_lock_killable(mm)) {
> > > > >           mmap_assert_locked(mm);                     <---- gener=
ates a BUG
> > > > >           return true;
> > > > >       }
> > > > >       return false;
> > > > > }
> > > >
> > > > Ehm, that's indeed weird.
> > > >
> > > > >
> > > > > AFAIKT conditions for mmap_read_trylock() and
> > > > > mmap_read_lock_killable() are checked correctly. Am I missing
> > > > > something?
> > > >
> > > > Weirdly enough, it only triggers during that specific uffd test, ri=
ght?
> > >
> > > Yes, uffd-unit-tests. I even ran it separately to ensure it's not som=
e
> > > fallback from a previous test and I'm able to reproduce this
> > > consistently.
>
> Yeah, it is somehow related to per-vma locking. Unfortunately I can't
> reproduce the issue on my VM, so I have to use my host and bisection
> is slow. I think I'll get to the bottom of this tomorrow.

Ok, I think I found the issue.  wp_page_shared() ->
fault_dirty_shared_page() can drop mmap_lock (see the comment saying
"Drop the mmap_lock before waiting on IO, if we can...", therefore we
have to ensure we are not doing this under per-VMA lock.
I think what happens is that this path is racing with another page
fault which took mmap_lock for read. fault_dirty_shared_page()
releases this lock which was taken by another page faulting thread and
that thread generates an assertion when it finds out the lock it just
took got released from under it.
The following crude change fixed the issue for me but there might be a
more granular way to deal with this:

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3293,18 +3293,18 @@ static vm_fault_t wp_page_shared(struct
vm_fault *vmf, struct folio *folio)
         struct vm_area_struct *vma =3D vmf->vma;
         vm_fault_t ret =3D 0;

+        if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+                pte_unmap_unlock(vmf->pte, vmf->ptl);
+                vma_end_read(vmf->vma);
+                return VM_FAULT_RETRY;
+        }
+
         folio_get(folio);

         if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
                 vm_fault_t tmp;

                 pte_unmap_unlock(vmf->pte, vmf->ptl);
-                if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-                        folio_put(folio);
-                        vma_end_read(vmf->vma);
-                        return VM_FAULT_RETRY;
-                }
-
                 tmp =3D do_page_mkwrite(vmf, folio);
                 if (unlikely(!tmp || (tmp &
                                       (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))=
) {


Matthew, please check if this fix is valid and if there might be a
better way. I think the issue was introduced by 88e2667632d4 ("mm:
handle faults that merely update the accessed bit under the VMA lock")
Thanks,
Suren.



>
> > >
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >
