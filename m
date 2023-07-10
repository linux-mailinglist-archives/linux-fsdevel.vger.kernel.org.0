Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D092474E0CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGJWAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 18:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGJWAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:00:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51B120
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 15:00:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9891c73e0fbso994977666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689026432; x=1691618432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfZzCSrgvGz9BGtS4wsvtCeE34B7/lj4xCbe4JnIP2Q=;
        b=IELdvlh9d5ofdqTbS2z8RhDc+X1hOJTuBZf0ZbiY48jlt9lPfkJVZe/Wb+ANJ63yBp
         3tbyTl8zoOZLeyBV+rFCAm3x940PyUDWPt8floL10TItqyH+FrB/lAGZJtOMKZtZt+LE
         AXebzx74RigJZLsDEDj+71KrNZ7AIkM3jSIZhPTcrbtV9iT+zovNNmAfibmyJQAcAG3s
         gar9gMyoH8kJeZoRZEbQRzmJOZpL3w6TvRyJ05iXZGAzAKumLDVIkbWrwobqCp/EnIhf
         WQ1hrqXvH6LHXODojzsxf3hq+oeedejJX94Hat/Qve2IHSIsFzVJsuq7ZMf2QnUCPaxw
         LZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689026432; x=1691618432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfZzCSrgvGz9BGtS4wsvtCeE34B7/lj4xCbe4JnIP2Q=;
        b=NtRzRrA6zMCLWWfjtutve3o1ro0ZLYt9yBbdo7iJzDIZ8YKVov5VGdw7RfcpMjOjTb
         R1Gh+3NulxzkgK4kMojGEk6jTAih66CCCDOGkQOTd2502PGEs29rSE4DqUYcy7Rx7SYr
         QYffuWQZMZTd7dSmMNDg93NzZ8ehZU/i53M6ArJ8KUI/QvliryYewl6NtAKf94+ovKap
         yOmg9QZWEqg6BvPf4t5o5lbXm1r4cWU/PoGbRu0OuSySCd7oGl/eX4VJtqHGeGY35/UR
         91Tgd29dB2wQhdGqqQ6yOkWccJMEzfXMRED6og5jJbTBB7EtTr+rHQ2czY8s/PuLpa7N
         YEag==
X-Gm-Message-State: ABy/qLavnId1hJ/TKKJHF5P/MlZ3ewPCY5MvRkh4o3cQ89pgwcnw128O
        gsNhfzDWCi/NpcdmuM4YWi2js3Yh1Lh8DeblakjwSQ==
X-Google-Smtp-Source: APBJJlF6PnMVGMOTSmSf3fdPKR5ba1hPx/zIlHrvaJ4KBennSkMIDBj6INtn7vwYR7M3C9Di2GejevZRUk2uTbDHu9g=
X-Received: by 2002:a17:907:c29:b0:993:e85c:4ad6 with SMTP id
 ga41-20020a1709070c2900b00993e85c4ad6mr13335087ejc.7.1689026431632; Mon, 10
 Jul 2023 15:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-2-axelrasmussen@google.com> <20230708180850.bc938ab49fbfb38b83c367c8@linux-foundation.org>
 <CAJHvVcgfN5RVXJ_f3tN2UinV_kWCMyCY_g5oKm=BtgQJz-e7gA@mail.gmail.com>
In-Reply-To: <CAJHvVcgfN5RVXJ_f3tN2UinV_kWCMyCY_g5oKm=BtgQJz-e7gA@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 10 Jul 2023 14:59:55 -0700
Message-ID: <CAJHvVch5j=J=d-TqC1bgN6bKLrr0N3W7cwSOAqHf8O3axqapwA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:19=E2=80=AFAM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> On Sat, Jul 8, 2023 at 6:08=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Fri,  7 Jul 2023 14:55:33 -0700 Axel Rasmussen <axelrasmussen@google=
.com> wrote:
> >
> > > Future patches will re-use PTE_MARKER_SWAPIN_ERROR to implement
> > > UFFDIO_POISON, so make some various preparations for that:
> > >
> > > First, rename it to just PTE_MARKER_POISONED. The "SWAPIN" can be
> > > confusing since we're going to re-use it for something not really
> > > related to swap. This can be particularly confusing for things like
> > > hugetlbfs, which doesn't support swap whatsoever. Also rename some
> > > various helper functions.
> > >
> > > Next, fix pte marker copying for hugetlbfs. Previously, it would WARN=
 on
> > > seeing a PTE_MARKER_SWAPIN_ERROR, since hugetlbfs doesn't support swa=
p.
> > > But, since we're going to re-use it, we want it to go ahead and copy =
it
> > > just like non-hugetlbfs memory does today. Since the code to do this =
is
> > > more complicated now, pull it out into a helper which can be re-used =
in
> > > both places. While we're at it, also make it slightly more explicit i=
n
> > > its handling of e.g. uffd wp markers.
> > >
> > > For non-hugetlbfs page faults, instead of returning VM_FAULT_SIGBUS f=
or
> > > an error entry, return VM_FAULT_HWPOISON. For most cases this change
> > > doesn't matter, e.g. a userspace program would receive a SIGBUS eithe=
r
> > > way. But for UFFDIO_POISON, this change will let KVM guests get an MC=
E
> > > out of the box, instead of giving a SIGBUS to the hypervisor and
> > > requiring it to somehow inject an MCE.
> > >
> > > Finally, for hugetlbfs faults, handle PTE_MARKER_POISONED, and return
> > > VM_FAULT_HWPOISON_LARGE in such cases. Note that this can't happen to=
day
> > > because the lack of swap support means we'll never end up with such a
> > > PTE anyway, but this behavior will be needed once such entries *can*
> > > show up via UFFDIO_POISON.
> > >
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -523,6 +523,25 @@ static inline bool mm_tlb_flush_nested(struct mm=
_struct *mm)
> > >       return atomic_read(&mm->tlb_flush_pending) > 1;
> > >  }
> > >
> > > +/*
> > > + * Computes the pte marker to copy from the given source entry into =
dst_vma.
> > > + * If no marker should be copied, returns 0.
> > > + * The caller should insert a new pte created with make_pte_marker()=
.
> > > + */
> > > +static inline pte_marker copy_pte_marker(
> > > +             swp_entry_t entry, struct vm_area_struct *dst_vma)
> > > +{
> > > +     pte_marker srcm =3D pte_marker_get(entry);
> > > +     /* Always copy error entries. */
> > > +     pte_marker dstm =3D srcm & PTE_MARKER_POISONED;
> > > +
> > > +     /* Only copy PTE markers if UFFD register matches. */
> > > +     if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
> > > +             dstm |=3D PTE_MARKER_UFFD_WP;
> > > +
> > > +     return dstm;
> > > +}
> >
> > Breaks the build with CONFIG_MMU=3Dn (arm allnoconfig).  pte_marker isn=
't
> > defined.
> >
> > I'll slap #ifdef CONFIG_MMU around this function, but probably somethng=
 more
> > fine-grained could be used, like CONFIG_PTE_MARKER_UFFD_WP.  Please
> > consider.
>
> Whoops, sorry about this. This function "ought" to be in
> include/linux/swapops.h where it would be inside a #ifdef CONFIG_MMU
> anyway, but it can't be because it uses userfaultfd_wp() so there'd be
> a circular include. I think just wrapping it in CONFIG_MMU is the
> right way.
>
> But, this has also made me realize we need to not advertise
> UFFDIO_POISON as supported unless we have CONFIG_MMU. I don't want
> HAVE_ARCH_USERFAULTFD_WP for that, because it's only enabled on
> x86_64, whereas I want to support at least arm64 as well. I don't see
> a strong reason not to just use CONFIG_MMU for this too; this feature
> depends on the API in swapops.h, which uses that ifdef, so I don't see
> a lot of value out of creating a new but equivalent config option.

Actually, I'm being silly. CONFIG_USERFAULTFD depends on CONFIG_MMU,
so we don't need to worry about most of this.

Andrew's fix to just wrap the helper in CONFIG_MMU is enough.

>
> I'll make the needed changes (and also address Peter's comment above)
> and send out a v5.
>
> >
> > btw, both copy_pte_marker() and pte_install_uffd_wp_if_needed() look
> > far too large to justify inlining.  Please review the desirability of
> > this.

As far as inlining goes, I'm not opposed to un-inlining this, I was
mainly copying that pattern from existing helpers in swapops.h.

One question is, if it weren't inline, where should it go? There is no
mm/swapops.c which I would say is otherwise the proper place for it. I
don't see any other good place for the functions to go. The one I'm
introducing isn't userfaultfd-specific so userfaultfd.c seems wrong.

> >
> >
