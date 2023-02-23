Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE546A0408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjBWImO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjBWImN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:42:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1145E4D625
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 00:42:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so14175781eda.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 00:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9SuIbp75g+UlIghsWi+4N5mCZqO2tDPQ4lhx9i41C0=;
        b=Sql1dwoABX35nY3bSJPdFEkz/lY1Wf1brUMaBci/7FtKBzXn/BMxeek+zyRyomMiWY
         5dupSdb3TGw5OO224ZAGfMvyusV7BQdQeO88uNW0NV3NDIaWw+uSogw0k8VAHmQEKMed
         zo86n9U3eXIGSgrxncXPuhKKUjfGnpATX1tvGtK6AMuus63fGGorBVMxhOmT3Ond2XfR
         mHAI9ZH9vObqAwvvnBht2HdGwRfzsMZNXznLZ+j5m0UlujSqxW75Xk/XSOpRiHV1P97q
         ao5BfNXrTeBJZdKNKUDMf5n6sY2o2qsHlmG3VwhhybYJpkEuFpQnQ6gZBJJsQFHtzKwV
         y4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9SuIbp75g+UlIghsWi+4N5mCZqO2tDPQ4lhx9i41C0=;
        b=aD23rY8amvLgqbFQanyI3OBje6Prba4esjHp+fTWsOy4g1xb/TyZgiwUWHk0N/rvwf
         heAjtVs9Hgz6G5JgBWh5GP4mVS+PGY0cUWtK0ttqBuy912SjKKtiZA6USkEzIW1i6p+a
         HjapSadQK1sKPCeW1g9JAjW+L4P3+4qniZl3i/FWBVpU93TFaXjeVD9tCJev4DyGJeqV
         wqMKxMzm61rb9aBzMPnkgHCEPExLazj4g14/qFlu1H0yCH3eLiaeDtXpecuPz0Cs8srS
         DgE/ahXhxokwl7G/yLfteeUFksGyfAq6fKEgr8bF2KWUdBCnVF8NUCEvIzEvnetp04UF
         Cv0w==
X-Gm-Message-State: AO0yUKWZ2/5FQEohELA4Qx4I8VfFDbZ2LBv2jjKDLkIZMWe8VWDg7ps6
        Kra1NCqAS+bTST1NnIxnUU0hYIGA9bcRDf9cz93jDg==
X-Google-Smtp-Source: AK7set+0RrEHvhjbLGutaoQmuwIf40OYH9vAIuKbdgW+AtlRh/s1sKEeENFlG0624jU6i4TLccJorj7cYb6fcTRAwOA=
X-Received: by 2002:a50:8a92:0:b0:4ae:e606:432f with SMTP id
 j18-20020a508a92000000b004aee606432fmr6080742edj.0.1677141729090; Thu, 23 Feb
 2023 00:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com> <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
 <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com> <CABb0KFEBpJTNF7V0XfuvbtaHUiN0Zpx6FqD+BRyXf2gjxiVgTA@mail.gmail.com>
 <473b32fd-24f9-88fd-602f-3ba11d725472@collabora.com>
In-Reply-To: <473b32fd-24f9-88fd-602f-3ba11d725472@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 23 Feb 2023 09:41:57 +0100
Message-ID: <CABb0KFFSUeu76O9K_Q7PTQVEXJaauyOc0yF-T1uubWsYAq8cOg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Danylo Mocherniuk <mdanylo@google.com>
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

On Thu, 23 Feb 2023 at 07:44, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/22/23 4:48=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, 22 Feb 2023 at 12:06, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
[...]
> >>>>> BTW, I think I assumed that both conditions (all flags in
> >>>>> required_flags and at least one in anyof_flags is present) need to =
be
> >>>>> true for the page to be selected - is this your intention?
> >>>> All the masks are optional. If all or any of the 3 masks are specifi=
ed, the
> >>>> page flags must pass these masks to get selected.
> >>>
> >>> This explanation contradicts in part the introductory paragraph, but
> >>> this version seems more useful as you can pass all masks zero to have
> >>> all pages selected.
> >> Sorry, I wrote it wrongly. (All the masks are not optional.) Let me
> >> rephrase. All or at least any 1 of the 3 masks (required, any, exclude=
)
> >> must be specified. The return_mask must always be specified. Error is
> >> returned if all 3 masks (required, anyof, exclude) are zero or return_=
mask
> >> is zero.
> >
> > Why do you need those restrictions? I'd guess it is valid to request a
> > list of all pages with zero return_mask - this will return a compact
> > list of used ranges of the virtual address space.
> At the time, we are supporting 4 flags (PAGE_IS_WRITTEN, PAGE_IS_FILE,
> PAGE_IS_PRESENT and PAGE_IS_SWAPPED). The idea is that user mention his
> flags of interest in the return_mask. If he wants only 1 flag, he'll
> specify it. Definitely if user wants only 1 flag, initially it doesn't ma=
ke
> any sense to mention in the return mask. But we want uniformity. If user
> want, 2 or more flags in returned, return_mask becomes compulsory. So to
> keep things simple and generic for any number of flags of interest
> returned, the return_mask must be specified even if the flag of interest =
is
> only 1.

I'm not sure why do we want uniformity in the case of 1 flag? If a
user specifies a single required flag, I'd expect he doesn't need to
look at the flags returned as those will duplicate the information
from mere presence of a page. A user might also require a single flag,
but want all of them returned. Both requests - return 1 flag and
return 0 flags would give meaningful output, so why force one way or
the other? Allowing two will also enable users to express the intent:
they need either just a list of pages, or they need a list with
per-page flags - the need would follow from the code structure or
other factors.

> >>>> After taking a while to understand this and compare with already pre=
sent
> >>>> flag system, `negated flags` is comparatively difficult to understan=
d while
> >>>> already present flags seem easier.
> >>>
> >>> Maybe replacing negated_flags in the API with matched_values =3D
> >>> ~negated_flags would make this better?
> >>>
> >>> We compare having to understand XOR vs having to understand ordering
> >>> of required_flags and excluded_flags.
> >> There is no ordering in current masks scheme. No mask is preferable. F=
or a
> >> page to get selected, all the definitions of the masks must be fulfill=
ed.
> >> You have come up with good example that what if required_mask =3D
> >> exclude_mask. In this case, no page will fulfill the criterion and hen=
ce no
> >> page would be selected. It is user's fault that he isn't understanding=
 the
> >> definitions of these masks correctly.
> >>
> >> Now thinking about it, I can add a error check which would return erro=
r if
> >> a bit in required and excluded masks matches. Would you like it? Lets =
put
> >> this check in place.
> >> (Previously I'd left it for user's wisdom not to do this. If he'll spe=
cify
> >> same masks in them, he'll get no addresses out of the syscall.)
> >
> > This error case is (one of) the problems I propose avoiding. You also
> > need much more text to describe the requred/excluded flags
> > interactions and edge cases than saying that a flag must have a value
> > equal to corresponding bit in ~negated_flags to be matched by
> > requried/anyof masks.
> I've found excluded_mask very intuitive as compared to negated_mask which
> is so difficult to understand that I don't know how to use it correctly.
> Lets take an example, I want pages which are PAGE_IS_WRITTEN and are not
> PAGE_IS_FILE. In addition, the pages must be PAGE_IS_PRESENT or
> PAGE_IS_SWAPPED. This can be specified as:
>
> required_mask =3D PAGE_IS_WRITTEN
> excluded_mask =3D PAGE_IS_FILE
> anyof_mask =3D PAGE_IS_PRESETNT | PAGE_IS_SWAP
>
> (a) assume page_flags =3D 0b1111
> skip page as 0b1111 & 0b0010 =3D true
>
> (b) assume page_flags =3D 0b1001
> select page as 0b1001 & 0b0010 =3D false
>
> It seemed intuitive. Right? How would you achieve same thing with negated=
_mask?
>
> required_mask =3D PAGE_IS_WRITTEN
> negated_mask =3D PAGE_IS_FILE
> anyof_mask =3D PAGE_IS_PRESETNT | PAGE_IS_SWAP
>
> (1) assume page_flags =3D 0b1111
> tested_flags =3D 0b1111 ^ 0b0010 =3D 0b1101
>
> (2) assume page_flags =3D 0b1001
> tested_flags =3D 0b1001 ^ 0b0010 =3D 0b1011
>
> In (1), we wanted to skip pages which have PAGE_IS_FILE set. But
> negated_mask has just masked it and page is still getting tested if it
> should be selected and it would get selected. It is wrong.
>
> In (2), the PAGE_IS_FILE bit of page_flags was 0 and got updated to 1 or
> PAGE_IS_FILE in tested_flags.

I require flags PAGE_IS_WRITTEN=3D1, PAGE_IS_FILE=3D0, so:

required_mask =3D PAGE_IS_WRITTEN | PAGE_IS_FILE;
negated_flags =3D PAGE_IS_FILE; // flags I want zero

I also require one of PAGE_IS_PRESENT=3D1 or PAGE_IS_SWAP=3D1, so:

anyof_mask =3D PAGE_IS_PRESENT | PAGE_IS_SWAP;

Another case: I want to analyse a process' working set:

required_mask =3D 0;
negated_flags =3D PAGE_IS_FILE;
anyof_mask =3D PAGE_IS_FILE | PAGE_IS_WRITTEN;

-> gathering pages modified [WRITTEN=3D1] or not backed by a file [FILE=3D0=
].

To clarify a bit: negated_flags doesn't mask anything: the field
inverts values of the flags (marks some "active low", if you consider
electronic signal analogy).

Best Regards
Micha=C5=82 Miros=C5=82aw
