Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8C7B0DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjI0VI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 17:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjI0VI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:08:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E2D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 14:08:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59c04237bf2so155207057b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695848936; x=1696453736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ3RtqlQfpk8UFjpglCqA8/SAQruGYgZhJ0s9qkYTS0=;
        b=GwrisqqwaEQKj5TGkuMzGZVnjvCltMLSvfw+oTFL7+cXmC+bVpXUcFai9LB933/4EN
         k/UxLiheSz1Q5FoHtxaiuNxfAymeYlYlJFEN9AAMWoiHFjptB2FO61ppYOiZdEIPDxrf
         J6DnrE0TTUOR8yRP/v0XMX2w2+DfhhfWV0FWrVoARLVtJy1s0ZBbYcBcoKN+Ga2hqG6R
         B6KZJQrwJX6e9lglBaQzq5t2PJkC+P2ePdVkT8RRFND7o0yoDHQTzMtNORlT3mKehI+H
         ZgeFpQNhmnfIRim0dGoSpD2QOIr0Bki0BrNXrTbTTgodUXywpDfmxJsF7md6Bu1lMcua
         Lm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695848936; x=1696453736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ3RtqlQfpk8UFjpglCqA8/SAQruGYgZhJ0s9qkYTS0=;
        b=r9aPrxb9/KcUbxq9W7ai6NNYa/oCrKZ4Vh92fGTRIaxM76/qPmCONPSywb6pIzcc+C
         O4jeo3PhDBXHNdvG+iyQkJBzGhLXc8xGGjdnmiHaouGPDi/kEzh+SzUBZOZnZl3Wvlsg
         nQ5v9KHhMFeC7Dh9tEvc3bIaEHNbJB3ELMfohfdkawOdJwmXdgOOYTMfT44nzP9t2xqk
         TsUYPMsEz5hHdB9WdEBe5+vUjE1BsLLNAdd2Ex1ko/JMFXV+Ec+PWsNlHwTz9noCczJV
         TDcNnVHjK7mX/00czM8vtVqK7cpvXCwQbCD+rDd75uKJlCTw0pnfx4PGj9Drvz/tdC2M
         qW6g==
X-Gm-Message-State: AOJu0YxvOgrtHzHEdT9D1JYtih5+Xv1wCkyJ4wk4JytcuuNtKHPKuJNt
        zGhfOOzPYQwmMwo1E61kmG53UiKYowPQ6L3C1Hq+mQ==
X-Google-Smtp-Source: AGHT+IFQ3LjVbNrzo1sOTmszvqWNthQMtO/SQnGtyKq1516K2UvzMCwdQ9Au4tmdWUB4WEOlJTGOpoDcgymQ9ZXPCh0=
X-Received: by 2002:a81:9252:0:b0:59b:f744:f158 with SMTP id
 j79-20020a819252000000b0059bf744f158mr3415967ywg.15.1695848935547; Wed, 27
 Sep 2023 14:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
 <CAG48ez2WNOMwPo4OMVUHbS4mirwbqHUY5qUaaZ9DTkXdkzrjiQ@mail.gmail.com> <CAJuCfpGcsBE2XqPJSVo1gdE_O96gzS5=ET=u0uSBSX3Lj56CtA@mail.gmail.com>
In-Reply-To: <CAJuCfpGcsBE2XqPJSVo1gdE_O96gzS5=ET=u0uSBSX3Lj56CtA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Sep 2023 14:08:42 -0700
Message-ID: <CAJuCfpHY5zhkS0OPxOK-twb6pDJg6OpXZnPquw_9wBmbjFiF9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 1:42=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Sep 27, 2023 at 1:04=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Wed, Sep 27, 2023 at 8:08=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Wed, Sep 27, 2023 at 5:47=E2=80=AFAM Jann Horn <jannh@google.com> =
wrote:
> > > > On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > > >
> > > > > This implements the uABI of UFFDIO_REMAP.
> > > > >
> > > > > Notably one mode bitflag is also forwarded (and in turn known) by=
 the
> > > > > lowlevel remap_pages method.
> > > > >
> > > > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > [...]
> > > > > +                       /*
> > > > > +                        * folio_referenced walks the anon_vma ch=
ain
> > > > > +                        * without the folio lock. Serialize agai=
nst it with
> > > > > +                        * the anon_vma lock, the folio lock is n=
ot enough.
> > > > > +                        */
> > > > > +                       src_anon_vma =3D folio_get_anon_vma(src_f=
olio);
> > > > > +                       if (!src_anon_vma) {
> > > > > +                               /* page was unmapped from under u=
s */
> > > > > +                               err =3D -EAGAIN;
> > > > > +                               goto out;
> > > > > +                       }
> > > > > +                       if (!anon_vma_trylock_write(src_anon_vma)=
) {
> > > > > +                               pte_unmap(&orig_src_pte);
> > > > > +                               pte_unmap(&orig_dst_pte);
> > > > > +                               src_pte =3D dst_pte =3D NULL;
> > > > > +                               /* now we can block and wait */
> > > > > +                               anon_vma_lock_write(src_anon_vma)=
;
> > > > > +                               goto retry;
> > > > > +                       }
> > > > > +               }
> > > >
> > > > So at this point we have:
> > > >
> > > >  - the current src_pte
> > > >  - some referenced+locked src_folio that used to be mapped exclusiv=
ely
> > > > at src_addr
> > > >  - (the anon_vma associated with the src_folio)
> > > >
> > > > > +               err =3D remap_anon_pte(dst_mm, src_mm,  dst_vma, =
src_vma,
> > > > > +                                    dst_addr, src_addr, dst_pte,=
 src_pte,
> > > > > +                                    orig_dst_pte, orig_src_pte,
> > > > > +                                    dst_ptl, src_ptl, src_folio)=
;
> > > >
> > > > And then this will, without touching folio mapcounts/refcounts, del=
ete
> > > > the current PTE at src_addr, and create a PTE at dst_addr pointing =
to
> > > > the old src_folio, leading to incorrect refcounts/mapcounts?
> > >
> > > I assume this still points to the missing previous_src_pte check
> > > discussed in the previous comments. Is that correct or is there yet
> > > another issue?
> >
> > This is still referring to the missing previous_src_pte check.
> >
> > > >
> > > > > +       } else {
> > > > [...]
> > > > > +       }
> > > > > +
> > > > > +out:
> > > > > +       if (src_anon_vma) {
> > > > > +               anon_vma_unlock_write(src_anon_vma);
> > > > > +               put_anon_vma(src_anon_vma);
> > > > > +       }
> > > > > +       if (src_folio) {
> > > > > +               folio_unlock(src_folio);
> > > > > +               folio_put(src_folio);
> > > > > +       }
> > > > > +       if (dst_pte)
> > > > > +               pte_unmap(dst_pte);
> > > > > +       if (src_pte)
> > > > > +               pte_unmap(src_pte);
> > > > > +       mmu_notifier_invalidate_range_end(&range);
> > > > > +
> > > > > +       return err;
> > > > > +}
> > > > [...]
> > > > > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *=
src_mm,
> > > > > +                   unsigned long dst_start, unsigned long src_st=
art,
> > > > > +                   unsigned long len, __u64 mode)
> > > > > +{
> > > > > +       struct vm_area_struct *src_vma, *dst_vma;
> > > > > +       unsigned long src_addr, dst_addr;
> > > > > +       pmd_t *src_pmd, *dst_pmd;
> > > > > +       long err =3D -EINVAL;
> > > > > +       ssize_t moved =3D 0;
> > > > > +
> > > > > +       /*
> > > > > +        * Sanitize the command parameters:
> > > > > +        */
> > > > > +       BUG_ON(src_start & ~PAGE_MASK);
> > > > > +       BUG_ON(dst_start & ~PAGE_MASK);
> > > > > +       BUG_ON(len & ~PAGE_MASK);
> > > > > +
> > > > > +       /* Does the address range wrap, or is the span zero-sized=
? */
> > > > > +       BUG_ON(src_start + len <=3D src_start);
> > > > > +       BUG_ON(dst_start + len <=3D dst_start);
> > > > > +
> > > > > +       /*
> > > > > +        * Because these are read sempahores there's no risk of l=
ock
> > > > > +        * inversion.
> > > > > +        */
> > > > > +       mmap_read_lock(dst_mm);
> > > > > +       if (dst_mm !=3D src_mm)
> > > > > +               mmap_read_lock(src_mm);
> > > > > +
> > > > > +       /*
> > > > > +        * Make sure the vma is not shared, that the src and dst =
remap
> > > > > +        * ranges are both valid and fully within a single existi=
ng
> > > > > +        * vma.
> > > > > +        */
> > > > > +       src_vma =3D find_vma(src_mm, src_start);
> > > > > +       if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > > > > +               goto out;
> > > > > +       if (src_start < src_vma->vm_start ||
> > > > > +           src_start + len > src_vma->vm_end)
> > > > > +               goto out;
> > > > > +
> > > > > +       dst_vma =3D find_vma(dst_mm, dst_start);
> > > > > +       if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > > > > +               goto out;
> > > > > +       if (dst_start < dst_vma->vm_start ||
> > > > > +           dst_start + len > dst_vma->vm_end)
> > > > > +               goto out;
> > > > > +
> > > > > +       err =3D validate_remap_areas(src_vma, dst_vma);
> > > > > +       if (err)
> > > > > +               goto out;
> > > > > +
> > > > > +       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > > > +            src_addr < src_start + len;) {
> > > > > +               spinlock_t *ptl;
> > > > > +               pmd_t dst_pmdval;
> > > > > +               unsigned long step_size;
> > > > > +
> > > > > +               BUG_ON(dst_addr >=3D dst_start + len);
> > > > > +               /*
> > > > > +                * Below works because anonymous area would not h=
ave a
> > > > > +                * transparent huge PUD. If file-backed support i=
s added,
> > > > > +                * that case would need to be handled here.
> > > > > +                */
> > > > > +               src_pmd =3D mm_find_pmd(src_mm, src_addr);
> > > > > +               if (unlikely(!src_pmd)) {
> > > > > +                       if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_=
HOLES)) {
> > > > > +                               err =3D -ENOENT;
> > > > > +                               break;
> > > > > +                       }
> > > > > +                       src_pmd =3D mm_alloc_pmd(src_mm, src_addr=
);
> > > > > +                       if (unlikely(!src_pmd)) {
> > > > > +                               err =3D -ENOMEM;
> > > > > +                               break;
> > > > > +                       }
> > > > > +               }
> > > > > +               dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
> > > > > +               if (unlikely(!dst_pmd)) {
> > > > > +                       err =3D -ENOMEM;
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > > > > +               /*
> > > > > +                * If the dst_pmd is mapped as THP don't override=
 it and just
> > > > > +                * be strict. If dst_pmd changes into TPH after t=
his check, the
> > > > > +                * remap_pages_huge_pmd() will detect the change =
and retry
> > > > > +                * while remap_pages_pte() will detect the change=
 and fail.
> > > > > +                */
> > > > > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > > > > +                       err =3D -EEXIST;
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > +               if (ptl && !pmd_trans_huge(*src_pmd)) {
> > > > > +                       spin_unlock(ptl);
> > > > > +                       ptl =3D NULL;
> > > > > +               }
> > > >
> > > > This still looks wrong - we do still have to split_huge_pmd()
> > > > somewhere so that remap_pages_pte() works.
> > >
> > > Hmm, I guess this extra check is not even needed...
> >
> > Hm, and instead we'd bail at the pte_offset_map_nolock() in
> > remap_pages_pte()? I guess that's unusual but works...
>
> Yes, that's what I was thinking but I agree, that seems fragile. Maybe
> just bail out early if (ptl && !pmd_trans_huge())?

No, actually we can still handle is_swap_pmd() case by splitting it
and remapping the individual ptes. So, I can bail out only in case of
pmd_devmap().


>
> >
> > (It would be a thing to look out for if anyone tried to backport this,
> > since the checks in pte_offset_map_nolock() were only introduced in
> > 6.5, but idk if anyone's doing that)
