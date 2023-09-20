Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465F7A894B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjITQMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjITQMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:12:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CBC9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 09:11:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4051039701eso108225e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695226318; x=1695831118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAzaV/SRyN9p4hGa3qLm9e9pe4b6sS/pBR+spEyhDRk=;
        b=ykRO6/aQLekA98nOaQvIq7FB1HNsM73wcdJHn/clyUtUifdQGDM3cSRQBOtgI5EkJ6
         /geqgE6ZR/dpIdFX7TGZanL5UsqE0wSRgrdBkMYXVSvbNpDaVWMF7qzSB4OEorvrKNfi
         p42EJrrRawOyugxca/Qv+WytRtnImmV3Eoz+KQm9Sk70rd/aD8ZgBcsBc/rJ/mgVpVGe
         Ujh2TRQm8wzzekKlTcvF40pPt5DH+fCkDZEEuN0dPbg+p6IMjYVLdY9Xim7ovl7sgtgB
         CeaUyU2bEtODc3/tlamxnffS7S5N0YmvwZR/y/grAslsZieiAEv+fPy7fjVXkBXdWBx6
         iRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695226318; x=1695831118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAzaV/SRyN9p4hGa3qLm9e9pe4b6sS/pBR+spEyhDRk=;
        b=XbwOxZhk/uAGAMojpGAgqwOhgVq5NtY/hxgQC29vKjmGm1aJrJIL/U5fmPyHvD3ywS
         CukpSKzFYUNzW+VCErJdQ9dcR2Ptap5nx+z7e9VrJhb2KJwJjUrknX8Fji8CNOvERQF5
         uanvV7WiXmgUVPS4bhvZXimFnluYIJ1k/iz7qi80QjhCZmy9L6GoeBnl7WLRgDsQeHz3
         siVV1LqXa1v1wMTH3oltMe+qZcgFPiO7efXz+LY7/P5GwFENAnHgjFsyuzMw1iAzTgHG
         PB+eKMAJRUZCOi63Zp2/NGjYhDvrNqEQTBChBL4c4C2FJJuZ70pGKc+xWXVFL8PiwdUh
         vqcg==
X-Gm-Message-State: AOJu0YzVGgi9t0FqylZjaftWU7wH4mZlCPNJF/kPZJsR64yPiRrZN5Fp
        ITINvwTXgicjttO2HseOiikm3hCKhtjEULd9TwsGWA==
X-Google-Smtp-Source: AGHT+IHy0hvFkvPj2pc9M2fqH7uFFxdkVHYrAu/hwKzERNMYWLTY0Kzs43mFyS5OI/qFiRhyWmIsIIv0zWuuaq9PecI=
X-Received: by 2002:a05:600c:3217:b0:3f7:3e85:36a with SMTP id
 r23-20020a05600c321700b003f73e85036amr88893wmp.7.1695226317753; Wed, 20 Sep
 2023 09:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com>
 <CAJuCfpGdbc70aZPu=cNgemK1EFUyvLfZU8ELSjseZtfpSF+EEg@mail.gmail.com>
 <CAG48ez212+UjQMB94vKvyV4YAEgg=jBhdzg_1b4BRe6=SO09fA@mail.gmail.com> <CAJuCfpGEPPmEW6GqCjQXB5g04PA=BwhNgLVooM+DcroQj8RjyA@mail.gmail.com>
In-Reply-To: <CAJuCfpGEPPmEW6GqCjQXB5g04PA=BwhNgLVooM+DcroQj8RjyA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Sep 2023 18:11:19 +0200
Message-ID: <CAG48ez0WQiZvBzYBHXVP8ZVFXJEfRsHxNuXvMTFL+ietgyB9yQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Tue, Sep 19, 2023 at 4:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Wed, Sep 20, 2023 at 1:08=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Thu, Sep 14, 2023 at 7:28=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > > On Thu, Sep 14, 2023 at 5:26=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > > >
> > > > > This implements the uABI of UFFDIO_REMAP.
> > > > >
> > > > > Notably one mode bitflag is also forwarded (and in turn known) by=
 the
> > > > > lowlevel remap_pages method.
> > [...]
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > [...]
> > > > > +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> > > > > +                        struct mm_struct *src_mm,
> > > > > +                        pmd_t *dst_pmd, pmd_t *src_pmd,
> > > > > +                        pmd_t dst_pmdval,
> > > > > +                        struct vm_area_struct *dst_vma,
> > > > > +                        struct vm_area_struct *src_vma,
> > > > > +                        unsigned long dst_addr,
> > > > > +                        unsigned long src_addr)
> > > > > +{
> > > > > +       pmd_t _dst_pmd, src_pmdval;
> > > > > +       struct page *src_page;
> > > > > +       struct anon_vma *src_anon_vma, *dst_anon_vma;
> > > > > +       spinlock_t *src_ptl, *dst_ptl;
> > > > > +       pgtable_t pgtable;
> > > > > +       struct mmu_notifier_range range;
> > > > > +
> > > > > +       src_pmdval =3D *src_pmd;
> > > > > +       src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > > > > +
> > > > > +       BUG_ON(!pmd_trans_huge(src_pmdval));
> > > > > +       BUG_ON(!pmd_none(dst_pmdval));
> > > >
> > > > Why can we assert that pmd_none(dst_pmdval) is true here? Can we no=
t
> > > > have concurrent faults (or userfaultfd operations) populating that
> > > > PMD?
> > >
> > > IIUC dst_pmdval is a copy of the value from dst_pmd, so that local
> > > copy should not change even if some concurrent operation changes
> > > dst_pmd. We can assert that it's pmd_none because we checked for that
> > > before calling remap_pages_huge_pmd. Later on we check if dst_pmd
> > > changed from under us (see pmd_same(*dst_pmd, dst_pmdval) check) and
> > > retry if that happened.
> >
> > Oh, right, I don't know what I was thinking when I typed that.
> >
> > But now I wonder about the check directly above that: What does this
> > code do for swap PMDs? It looks like that might splat on the
> > BUG_ON(!pmd_trans_huge(src_pmdval)). All we've checked on the path to
> > here is that the virtual memory area is aligned, that the destination
> > PMD is empty, and that pmd_trans_huge_lock() succeeded; but
> > pmd_trans_huge_lock() explicitly permits swap PMDs (which is the
> > swapped-out version of transhuge PMDs):
> >
> > static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
> >                 struct vm_area_struct *vma)
> > {
> >         if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pm=
d))
> >                 return __pmd_trans_huge_lock(pmd, vma);
> >         else
> >                 return NULL;
> > }
>
> Yeah... Ok, I think I'm missing a check for  pmd_trans_huge(*src_pmd)
> after we lock it with pmd_trans_huge_lock(src_pmd, src_vma). And we
> can remove the above BUG_ON(). Would that address your concern?

Sounds good. It'll end up splitting huge swap entries but I guess the
extra code for moving huge swap entries might not be worth it.
