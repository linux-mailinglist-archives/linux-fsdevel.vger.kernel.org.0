Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860D7B2170
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjI1Pgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1Pgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:36:45 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44198B7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 08:36:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a229ac185aso7947077b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695915402; x=1696520202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e7z54uATHSSGDjwccq5t2JrfgU8sx45IO2zPYWKTu4=;
        b=y8sNghs5WMsnE7q6gtrMdqawiQAkTO1W5wa6oeNCXaAnuO5coljUYTKHQIIfk2EMz2
         O25kuKl7THw2USeCRD4TNJVsZHVtZ1giiId7FZ0JqmdU8ZVSd9+kN47fAiKLStgbEb5e
         usE/N6m4Y0cwIdXKW/u6KHbCvCTczaAfx6pF2X0UF37Pq1+fMjvdpI14KJbH1zDBDIl/
         juh4k3DFjFMvD9wNeCDGpfw5WWXogmG6cItwx4IfXa2Cfau+P2POuvxTuixFc80Nthod
         UaUhXr0/TzzolcftVars+LAO0gPugAto8XVIVPAGnG+4SWS5OlQWIBrONT8wGIJMwPGd
         Q6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915402; x=1696520202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e7z54uATHSSGDjwccq5t2JrfgU8sx45IO2zPYWKTu4=;
        b=VwLxMj50pyJ2CbfimjjLAkXTdEGV27Rez/gydAp7tzT82RfVnNBP4VvrG+7K3KrgTb
         Jaqx3lXYHeWHhoz4QtY+OIf4IzWkf5CGy5C30eVu3y5gHS8DZkPQLecpr9QvciMB0SKs
         oWy1jEsUeERPt8NTf5aminrgTbKNKPgcTPlSHWEMrE+1dDPm/Kkc/BOcHE9Ae25hYpWn
         LduDddRseDJ1W1m15+ulhc8XKZdMk/p8Eh5TxXXaBH7w7L9B9IkUplEVWVdOf++v+VJb
         F1mPihVp8QZiZDBkGNj56y58TQlPHWPrdyMcReee5rSrgM0X6S89syx3+y+K5awsxYv3
         KHGQ==
X-Gm-Message-State: AOJu0YzkmNNx4CxNDJO5Futz5/IRebu28bj53kdjme70fzszQLr7Y4Lz
        WgIEg6ob15nMIpPbr6rY/o0pMivkhlPwggwUCvClgA==
X-Google-Smtp-Source: AGHT+IFjUIiq8zXa/6i3Gd2mLTZVRJSM762ThmYuOrNiwbXezL93NXanoc8htBlyr6ZC4BGKzu/lDhUW4vJYOzuiSDk=
X-Received: by 2002:a81:4e85:0:b0:569:479f:6d7f with SMTP id
 c127-20020a814e85000000b00569479f6d7fmr1392570ywb.43.1695915402166; Thu, 28
 Sep 2023 08:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
 <CAG48ez2WNOMwPo4OMVUHbS4mirwbqHUY5qUaaZ9DTkXdkzrjiQ@mail.gmail.com>
 <CAJuCfpGcsBE2XqPJSVo1gdE_O96gzS5=ET=u0uSBSX3Lj56CtA@mail.gmail.com>
 <CAJuCfpHY5zhkS0OPxOK-twb6pDJg6OpXZnPquw_9wBmbjFiF9Q@mail.gmail.com> <CAG48ez3w7kbetfhEd7trLhOKJYPw4jSVBeOC+psZZR84d-hJaw@mail.gmail.com>
In-Reply-To: <CAG48ez3w7kbetfhEd7trLhOKJYPw4jSVBeOC+psZZR84d-hJaw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 08:36:31 -0700
Message-ID: <CAJuCfpHrmgdoJaN0P4FGzRFbu-o+c5+H6-r=5A=xrVd2GU2QyQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 3:49=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 11:08=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > On Wed, Sep 27, 2023 at 1:42=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Sep 27, 2023 at 1:04=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On Wed, Sep 27, 2023 at 8:08=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > On Wed, Sep 27, 2023 at 5:47=E2=80=AFAM Jann Horn <jannh@google.c=
om> wrote:
> > > > > > On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > > > > > > +               /*
> > > > > > > +                * If the dst_pmd is mapped as THP don't over=
ride it and just
> > > > > > > +                * be strict. If dst_pmd changes into TPH aft=
er this check, the
> > > > > > > +                * remap_pages_huge_pmd() will detect the cha=
nge and retry
> > > > > > > +                * while remap_pages_pte() will detect the ch=
ange and fail.
> > > > > > > +                */
> > > > > > > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > > > > > > +                       err =3D -EEXIST;
> > > > > > > +                       break;
> > > > > > > +               }
> > > > > > > +
> > > > > > > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma)=
;
> > > > > > > +               if (ptl && !pmd_trans_huge(*src_pmd)) {
> > > > > > > +                       spin_unlock(ptl);
> > > > > > > +                       ptl =3D NULL;
> > > > > > > +               }
> > > > > >
> > > > > > This still looks wrong - we do still have to split_huge_pmd()
> > > > > > somewhere so that remap_pages_pte() works.
> > > > >
> > > > > Hmm, I guess this extra check is not even needed...
> > > >
> > > > Hm, and instead we'd bail at the pte_offset_map_nolock() in
> > > > remap_pages_pte()? I guess that's unusual but works...
> > >
> > > Yes, that's what I was thinking but I agree, that seems fragile. Mayb=
e
> > > just bail out early if (ptl && !pmd_trans_huge())?
> >
> > No, actually we can still handle is_swap_pmd() case by splitting it
> > and remapping the individual ptes. So, I can bail out only in case of
> > pmd_devmap().
>
> FWIW I only learned today that "real" swap PMDs don't actually exist -
> only migration entries, which are encoded as swap PMDs, exist. You can
> see that when you look through the cases that something like
> __split_huge_pmd() or zap_pmd_range() actually handles.

Ah, good point.

>
> So I think if you wanted to handle all the PMD types properly here
> without splitting, you could do that without _too_ much extra code.
> But idk if it's worth it.

Yeah, I guess I can call pmd_migration_entry_wait() and retry by
returning EAGAIN, similar to how remap_pages_pte() handles PTE
migration. Looks simple enough.

Thanks for all the pointers! I'll start cooking the next version.
