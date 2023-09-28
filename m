Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFB7B264F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjI1ULd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjI1ULb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:11:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADA1AC
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 13:11:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8afe543712so786495276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695931886; x=1696536686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij2wWnpIU9fE1J8oKziqGhNF7yeojp6FxZY+hdmzkd4=;
        b=oXkJ+/kOisvvFWmZn+U3UvSMyyMNBILn6rB3C0WyZ183u3DX9oVJAyRPMe8J8pylDo
         XPoju93xXtJXkMo3MS2e1pnlMvlid46PDOBAgHYVPQtQytwCnD1QXAPu9lxxo+MbdzwP
         3YEKHtQqyhCoi+6Rhu/ubgVSNJIt06kFzIYNH6jIjQj8frJk7ZE24+q/qKRV/Ke2i6WA
         hlQPJXr28RGMrGrReUyM2PdbDwmoRGql0bKbSnl/WadalGc0HvaiSlfPjH2xwjtFdxQB
         ejOusjf2d/FKTGT4d+n26jCb+b297wgb2UuJxcqnpGMzsL/9264r8u3rDzFhxrHxkg+X
         BKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695931886; x=1696536686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij2wWnpIU9fE1J8oKziqGhNF7yeojp6FxZY+hdmzkd4=;
        b=jOCbq1OM6GtHdsBwu9f0NdJOmyozQ/ODc8ENTxh+xZLfyJrtLvQvc2rpUXEZxgYBcb
         axm2X7pxcDdacky6doZYQHajqhen37kPtMOD/popiaAUtZCRN9OY+HQmLb+/dy9ObAK3
         AA/pSpSm0r5+8URi1J8Sv4TJcfrkJo2ZCEJKc1vv44HzNpoZIOlbkAn5aNSLUI0x/dLU
         xk370SjzXO/mXKMQdcikntr5/kVE0vyTRXJIXp7h4A3wPl4Slypi5LbTvU4B5JzosBkJ
         iXTKEC9lvcLyWlxD1jwWOZ9uaMxJdmKMuM5b5wBMRzkAMV1Ea1ZjrH6fm88eYP/JLZTv
         pWBg==
X-Gm-Message-State: AOJu0Yzttg4uX9dtuqdPIwtaxYpgkL6yIsMKjblnPGSBaeWFTptaY7Zo
        MwGNXXM32MNP+sZ8B3BcgCckZQjRpGwwVO0St3cyVA==
X-Google-Smtp-Source: AGHT+IE8HAlEvC4nz0JFJXaFuxRDxZuz3GRpHHCV662b5okO+TtRLx+M3iPAd1C8qEkuoWljckYFsN28Ojjnz7MS5II=
X-Received: by 2002:a25:a144:0:b0:d78:1502:9330 with SMTP id
 z62-20020a25a144000000b00d7815029330mr2066119ybh.7.1695931886285; Thu, 28 Sep
 2023 13:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
 <9101f70c-0c0a-845b-4ab7-82edf71c7bac@redhat.com> <CAJuCfpFUVO_8OkEAiiqAD5J_MbNXnSEX2TKv+nz8SYCFMa6j-w@mail.gmail.com>
In-Reply-To: <CAJuCfpFUVO_8OkEAiiqAD5J_MbNXnSEX2TKv+nz8SYCFMa6j-w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Sep 2023 13:11:12 -0700
Message-ID: <CAJuCfpG9amtwFREDeP42DcKXt-i4vab4DxrcEyN94rF2Muz9zQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
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

On Thu, Sep 28, 2023 at 11:32=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Sep 28, 2023 at 10:15=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >
> > On 27.09.23 20:25, Suren Baghdasaryan wrote:
> > >>
> > >> I have some cleanups pending for page_move_anon_rmap(), that moves t=
he
> > >> SetPageAnonExclusive hunk out. Here we should be using
> > >> page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my cl=
eanups]
> > >>
> > >> I'll send them out soonish.
> > >
> > > Should I keep this as is in my next version until you post the
> > > cleanups? I can add a TODO comment to convert it to
> > > folio_move_anon_rmap() once it's ready.
> >
> > You should just be able to use page_move_anon_rmap() and whatever gets
> > in first cleans it up :)
>
> Ack.
>
> >
> > >
> > >>
> > >>>> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
> > >>>> +                                                     dst_addr)); =
>> +
> > >>>> +       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_p=
te);
> > >>>> +       orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page=
_prot);
> > >>>> +       orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte),
> > >>>> +                                    dst_vma);
> > >>>
> > >>> I think there's still a theoretical issue here that you could fix b=
y
> > >>> checking for the AnonExclusive flag, similar to the huge page case.
> > >>>
> > >>> Consider the following scenario:
> > >>>
> > >>> 1. process P1 does a write fault in a private anonymous VMA, creati=
ng
> > >>> and mapping a new anonymous page A1
> > >>> 2. process P1 forks and creates two children P2 and P3. afterwards,=
 A1
> > >>> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> > >>> 3. process P1 removes its mapping of A1, dropping its mapcount to 2=
.
> > >>> 4. process P2 uses vmsplice() to grab a reference to A1 with get_us=
er_pages()
> > >>> 5. process P2 removes its mapping of A1, dropping its mapcount to 1=
.
> > >>>
> > >>> If at this point P3 does a write fault on its mapping of A1, it wil=
l
> > >>> still trigger copy-on-write thanks to the AnonExclusive mechanism; =
and
> > >>> this is necessary to avoid P3 mapping A1 as writable and writing da=
ta
> > >>> into it that will become visible to P2, if P2 and P3 are in differe=
nt
> > >>> security contexts.
> > >>>
> > >>> But if P3 instead moves its mapping of A1 to another address with
> > >>> remap_anon_pte() which only does a page mapcount check, the
> > >>> maybe_mkwrite() will directly make the mapping writable, circumvent=
ing
> > >>> the AnonExclusive mechanism.
> > >>>
> > >>
> > >> Yes, can_change_pte_writable() contains the exact logic when we can =
turn
> > >> something easily writable even if it wasn't writable before. which
> > >> includes that PageAnonExclusive is set. (but with uffd-wp or softdir=
ty
> > >> tracking, there is more to consider)
> > >
> > > For uffd_remap can_change_pte_writable() would fail it VM_WRITE is no=
t
> > > set, but we want remapping to work for RO memory as well. Are you
> >
> > In a VMA without VM_WRITE you certainly wouldn't want to make PTEs
> > writable :) That's why that function just does a sanity check that it i=
s
> > not called in strange context. So one would only call it if VM_WRITE is=
 set.
> >
> > > saying that a PageAnonExclusive() check alone would not be enough
> > > here?
> >
> > There are some interesting questions to ask here:
> >
> > 1) What happens if the old VMA has VM_SOFTDIRTY set but the new one not=
?
> > You most probably have to mark the PTE softdirty and not make it writab=
le.
> >
> > 2) VM_UFFD_WP requires similar care I assume? Peter might know.
>
> Let me look closer into these cases.
> I'll also double-check if we need to support uffd_remap for R/O vmas.
> I assumed we do but I actually never checked.

Ok, I confirmed that we don't need remapping or R/O areas. So, I can
use can_change_pte_writable() and keep things simple. Does that sound
good?

> Thanks!
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
