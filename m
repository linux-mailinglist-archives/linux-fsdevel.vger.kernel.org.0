Return-Path: <linux-fsdevel+bounces-4800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C7804015
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 21:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF721281254
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBE35EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIk10nMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13190FA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 10:45:13 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-dafe04717baso3170476276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701715512; x=1702320312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZOoagNfuYTwGb5c2DFpOJBXe5yhQOWEede9pD77Ig=;
        b=WIk10nMV2BCmk09kq1RcejScfm1H4GbA1WaN6N2hjPGAt9vabcP3+Bw4rn13G2CbPz
         Aei3See4eTMNPB9ZAdQMKVoWY/YDIQvKXtzA800IzF+4iFNQgd27Py95diJiW0vjMhwq
         0MTLMhhqsvoK/ti37T1uPROmisleD5FFumFRbX2W1+ZO0zd0miTXyMBTm91odgTA30fb
         IaiX7ECQ495Sazr2JLn8snsW8e7n/xHNQ6nG7EmSHpB7Mu/w/eULT7+jUGkeGC0oAlGk
         wz/D4U951GyPLJi2YXVHbD0CiwumaW5VGeHtLzxiW+gkqdDYxGtR8yOi6gwDLuJtQin4
         WDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715512; x=1702320312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcZOoagNfuYTwGb5c2DFpOJBXe5yhQOWEede9pD77Ig=;
        b=Akbnx1oBWqFppXV9hTZQsTnOZLWTEEeHoQeqDGYIvt1ktN6CcSqTaTl2oPMInheqbH
         uwwbw+soJmgPSHPocgpmEB2QCTKzp4O4UtF/sQm8YciaoBo9QZYl6/fEH71JoHU+gqXE
         mTVsrKZ+bdvCishkzR//RfMKG0x8A86sH8F/hqPGtYYejCAskrM/5OkqvOhDxqvTYNxo
         PXzBQ/nYPgc8KV2R7xf0lwuQUGOlBTlB0Iq07R/jNiZUtFyg0b7dw5F5osMav0kMEQOG
         Rvg5fYAJ3JYSGjVdj12JDuhsKgdNOerrPi0tE+v8KOM3pDSjRb8Zo6M41AUnLR4KHuU2
         wDSg==
X-Gm-Message-State: AOJu0YyUltJtCdiiNOZqPy39H8kCiIX2Yn8wZbHse4xDmEH53VaGyW5q
	6QElU+/MdIncnzAhwIqKEp7eCzlYUNhzjbHzgdNGjg==
X-Google-Smtp-Source: AGHT+IG53Tprrzwkx2dmHW1+f8sbtKAiaQTT6sp9hmu4pFfnOzhawf2KKqgXFHmoLoh1lXYguEgo9GKmyXRuXChp0oE=
X-Received: by 2002:a5b:b07:0:b0:db7:dacf:6fdf with SMTP id
 z7-20020a5b0b07000000b00db7dacf6fdfmr3544806ybp.103.1701715511977; Mon, 04
 Dec 2023 10:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com> <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com> <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
 <744be4e0-48e0-4c77-825c-711386dd205f@arm.com> <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
 <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com>
In-Reply-To: <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 4 Dec 2023 10:44:59 -0800
Message-ID: <CAJuCfpEbxPksw3WtLWRT9mmGUCSZ431E4vaWMtbu8OrXmMxCdw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:27=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.12.23 17:35, Suren Baghdasaryan wrote:
> > On Mon, Dec 4, 2023 at 1:27=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
> >>> On Sat, Dec 2, 2023 at 2:11=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 02.12.23 09:04, Ryan Roberts wrote:
> >>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
> >>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
> >>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
> >>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move sour=
ce
> >>>>>>>> into destination buffer while checking the contents of both afte=
r
> >>>>>>>> the move. After the operation the content of the destination buf=
fer
> >>>>>>>> should match the original source buffer's content while the sour=
ce
> >>>>>>>> buffer should be zeroed. Separate tests are designed for PMD ali=
gned and
> >>>>>>>> unaligned cases because they utilize different code paths in the=
 kernel.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>>>>>>> ---
> >>>>>>>>     tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >>>>>>>>     tools/testing/selftests/mm/uffd-common.h     |   1 +
> >>>>>>>>     tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++=
++++++++++
> >>>>>>>>     3 files changed, 214 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
> >>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
> >>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset=
, bool wp)
> >>>>>>>>         return __copy_page(ufd, offset, false, wp);
> >>>>>>>>     }
> >>>>>>>>     +int move_page(int ufd, unsigned long offset, unsigned long =
len)
> >>>>>>>> +{
> >>>>>>>> +    struct uffdio_move uffdio_move;
> >>>>>>>> +
> >>>>>>>> +    if (offset + len > nr_pages * page_size)
> >>>>>>>> +        err("unexpected offset %lu and length %lu\n", offset, l=
en);
> >>>>>>>> +    uffdio_move.dst =3D (unsigned long) area_dst + offset;
> >>>>>>>> +    uffdio_move.src =3D (unsigned long) area_src + offset;
> >>>>>>>> +    uffdio_move.len =3D len;
> >>>>>>>> +    uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >>>>>>>> +    uffdio_move.move =3D 0;
> >>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >>>>>>>> +        /* real retval in uffdio_move.move */
> >>>>>>>> +        if (uffdio_move.move !=3D -EEXIST)
> >>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
> >>>>>>>> +                (int64_t)uffdio_move.move);
> >>>>>>>
> >>>>>>> Hi Suren,
> >>>>>>>
> >>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
> >>>>>>>
> >>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=
=3D16,
> >>>>>>> @uffd-common.c:648)
> >>>>>>>
> >>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any f=
urther, but
> >>>>>>> happy to go deeper if you can direct.
> >>>>>>
> >>>>>> Does it trigger reliably? Which pagesize is that kernel using?
> >>>>>
> >>>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; se=
e other email
> >>>>> for full config.
> >>>>>
> >>>>>>
> >>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() =
uses
> >>>>>> default_huge_page_size(), which reads the default hugetlb size.
> >>>>>
> >>>>> My kernel command line is explicitly seting the default huge page s=
ize to 2M.
> >>>>>
> >>>>
> >>>> Okay, so that likely won't affect it.
> >>>>
> >>>> I can only guess that it has to do with the alignment of the virtual
> >>>> area we are testing with, and that we do seem to get more odd patter=
ns
> >>>> on arm64.
> >>>>
> >>>> uffd_move_test_common() is a bit more elaborate, but if we aligned t=
he
> >>>> src+start area up, surely "step_count" cannot be left unmodified?
> >>>>
> >>>> So assuming we get either an unaligned source or an unaligned dst fr=
om
> >>>> mmap(), I am not convinced that we won't be moving areas that are no=
t
> >>>> necessarily fully backed by PMDs and maybe don't even fall into the =
VMA
> >>>> of interest?
> >>>>
> >>>> Not sure if that could trigger the THP splitting issue, though.
> >>>>
> >>>> But I just quickly scanned that test setup, could be I am missing
> >>>> something. It might make sense to just print the mmap'ed range and t=
he
> >>>> actual ranges we are trying to move. Maybe something "obvious" can b=
e
> >>>> observed.
> >>>
> >>> I was able to reproduce the issue on an Android device and after
> >>> implementing David's suggestions to split the large folio and after
> >>> replacing default_huge_page_size() with read_pmd_pagesize(), the
> >>> move-pmd test started working for me. Ryan, could you please apply
> >>> attached patches (over mm-unstable) and try the test again?
> >>
> >> Yep, all fixed with those patches!
> >
> > Great! Thanks for testing and confirming. I'll post an updated
> > patchset later today and will ask Andrew to replace the current one
> > with it.
> > I'll also look into the reasons we need to split PMD on ARM64 in this
> > test. It's good that this happened and we were able to test the PMD
> > split path but I'm curious about the reason. It's possible my address
> > alignment calculations are  somehow incorrect.
>
> I only skimmed the diff briefly, but likely you also want to try
> splitting in move_pages_pte(), if you encounter an already-pte-mapped THP=
.

Huh, good point. I might be able to move the folio splitting code into
pte-mapped case and do a retry after splitting. That should minimize
the additional code required. Will do and post a new set shortly.
Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

