Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160BB6BEADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCQOP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQOP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:15:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD336FFE
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 07:15:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so20895088edb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679062552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tBpag1M9/QK3J44nio5y/z0shlcd59R/V5AkvISOo0=;
        b=W4zjRDSR1VwMi34d268bsm/oghzr1RPH1PKphPT5eretqaJvJLC5v2Oppto80nguAm
         CXmyOlupS0vT2fYXp6aHhdMZQBWNoOUK+qj9g8VspYuwvYytNlmF63RfTenZRCv0Ai+1
         CnYRAF63jCEiSXqiOUouDtYZ7TKtEEF4zUEF4fRa9AecrI9Rq5NcwC+M/HuZV0qoOrXc
         lXsDcg/r0c/TxjriLZ0dku0sirbVxAlCKPVLRzDSl18++YjunB/KcM/mKGzv+v6kpThi
         wsC1C6QYWmSs2IOKBiPgpd5I4Mw94bbhddwbLAvet35CcKxC3TfBP4xSxq6p1J/cQTof
         AA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tBpag1M9/QK3J44nio5y/z0shlcd59R/V5AkvISOo0=;
        b=fa7j4/4L5B5cXpkAx1AYtqyRpEDxkhWrZmd2qkYADXb10t4ZPp/A86kKH4tNk0p8Un
         OsV5WGKGAAUTU0BRWN4znlxIQxnAftpt78o6vh7nlUy59VMRXWstYELo1RSJnoAoXxAF
         VAuIKMZ0zdhMQtwXRH0PJMeuajZ/dfxX4XRuWswvHa/RqCNrZLtYZqS3ZujZMGHZ94Ly
         Iz8qeG3zFc/z9ttrrIwyM389QxYH+t8RrIERRSIo0Aqy2tgd6SImBCYAbo5nGRwv0Qzk
         xMG/Iy2k2F8JsiBJY3234F54mZxnEuyiCtTefNyA7zmkm4mR2rPMvN0yVTDPijGTi6wq
         CyDg==
X-Gm-Message-State: AO0yUKWEdZygvKBf2QT60GKsqteS0Pw4p0LQ1l1PYv4P6/eEBN7HjXnC
        uRSd8JJxE9Yn4JesgNiOzPce/19I2QQfGA4+D4LNUA==
X-Google-Smtp-Source: AK7set+DTtXSR9Avk0Jn6IT86sdVUC8+M9HffKHHDzCIBOtRhHD0v7nzpuzVOguMSBd6PF9nH5JdX241VByBNqeyCvk=
X-Received: by 2002:a17:907:8dce:b0:931:99b5:67a4 with SMTP id
 tg14-20020a1709078dce00b0093199b567a4mr1593357ejc.15.1679062551783; Fri, 17
 Mar 2023 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com> <CABb0KFGU-jn4pCgmTK2zw0J-1-AVert4JsWF2CxgZ7LxckmWCA@mail.gmail.com>
 <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com> <CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com>
 <44d3f94e-fb9f-49df-7460-75dcee61802f@collabora.com>
In-Reply-To: <44d3f94e-fb9f-49df-7460-75dcee61802f@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 17 Mar 2023 15:15:40 +0100
Message-ID: <CABb0KFH+Ho+grc5DXT7iWjnQH7T_o4y3BQj8ri5-wxcOvu12Bg@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
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

On Fri, 17 Mar 2023 at 13:44, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 3/17/23 2:28=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 16 Mar 2023 at 18:53, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 3/13/23 9:02=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 9 Mar 2023 at 14:58, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> > [...]
> >>>> --- a/fs/proc/task_mmu.c
> >>>> +++ b/fs/proc/task_mmu.c
> > [...]
> >>>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool =
swap,
> > [...]
> >>> The `cur->len` test seems redundant: is it possible to have
> >>> `cur->start =3D=3D addr` in that case (I guess it would have to get
> >>> `n_pages =3D=3D 0` in an earlier invocation)?
> >> No, both wouldn't work. cur->len =3D=3D 0 means that it has only garba=
ge. It is
> >> essential to check the validity from cur->len before performing other
> >> checks. Also cur->start can never be equal to addr as we are walking o=
ver
> >> page addressing in serial manner. We want to see here if the current
> >> address matches the previous data by finding the ending address of las=
t
> >> stored data (cur->start + cur->len * PAGE_SIZE).
> >
> > If cur->len =3D=3D 0, then it doesn't matter if it gets merged or not -=
 it
> > can be filtered out during the flush (see below).
> > [...]
> >>>> +               } else if ((!p->vec_index) ||
> >>>> +                          ((p->vec_index + 1) < p->vec_len)) {
> >>>
> >>> Can you explain this test? Why not just `p->vec_index < p->vec_len`? =
Or better:
> >>>
> >>> if (vec_index >=3D p->vec_len)
> >>>     return -ENOSPC;
> >>
> >> No, it'll not work. Lets leave it as it is. :)
> >>
> >> It has gotten somewhat complex, but I don't have any other way to make=
 it
> >> simpler which works. First note the following points:
> >> 1) We walk over 512 page or 1 thp at a time to not over allocate memor=
y in
> >> kernel (p->vec).
> >> 2) We also want to merge the consecutive pages with the same flags int=
o one
> >> struct page_region. p->vec of current walk may merge with next walk. S=
o we
> >> cannot write to user memory until we find the results of the next walk=
.
> >>
> >> So most recent data is put into p->cur. When non-intersecting or merge=
able
> >> data is found, we move p->cur to p->vec[p->index] inside the page walk=
.
> >> After the page walk, p->vec[0 to p->index] is moved to arg->vec. After=
 all
> >> the walks are over. We move the p->cur to arg->vec. It completes the d=
ata
> >> transfer to user buffer.
> > [...]
> >> I'm so sorry that it has gotten this much complex. It was way simpler =
when
> >> we were walking over all the memory in one go. But then we needed an
> >> unbounded memory from the kernel which we don't want.
> > [...]
> >
> > I've gone through and hopefully understood the code. I'm not sure this
> > needs to be so complicated: when traversing a single PMD you can
> > always copy p->cur to p->vec[p->vec_index++] because you can have at
> > most pages_per_PMD non-merges (in the worst case the last page always
> > is left in p->cur and whole p->vec is used). After each PMD p->vec
> > needs a flush if p->vec_index > 0, skipping the dummy entry at front
> > (len =3D=3D 0; if present). (This is mostly how it is implemented now, =
but
> > I propose to remove the "overflow" check and do the starting guard
> > removal only every PMD.)
> Sorry, unable to understand where to remove the guard?

Instead of checking for it in pagemap_scan_output() for each page you
can skip it in do_pagemap_cmd() when doing the flush.

> > BTW#2, I think the ENOSPC return in pagemap_scan_output() should
> > happen later - only if the pages would match and that caused the count
> > to exceed the limit. For THP n_pages should be truncated to the limit
> > (and ENOSPC returned right away) only after the pages were verified to
> > match.
> We have 2 counters here:
> * the p->max_pages optionally can be set to find out only N pages of
> interest. So p->found_pages is counting this. We need to return early if
> the page limit is complete.
> * the p->vec_index keeps track of output buffer array size

I think I get how the limits are supposed to work, but I also think
the implementation is not optimal. An example (assuming max_pages =3D 1
and vec_len =3D 1):
 - a matching page has been found
 - a second - non-matching - is tried but results in immediate -ENOSPC.
-> In this case I'd expect the early return to happen just after the
first page is found so that non
A similar problem occurs for hugepage: when the limit is hit (we found
>=3D max_pages, n_pages is possibly truncated), but the scan continues
until next page / PMD.

[...]
> >>>> +       if (!arg->required_mask && !arg->anyof_mask &&
> >>>> +           !arg->excluded_mask)
> >>>> +               return false;
> >>>
> >>> Is there an assumption in the code that those checks are needed? I'd
> >>> expect that no selection criteria makes a valid page set?
> >> In my view, selection criterion must be specified for the ioctl to wor=
k. If
> >> there is no criterio, user should go and read pagemap file directly. S=
o the
> >> assumption is that at least one selection criterion must be specified.
> >
> > Yes. I'm not sure we need to prevent multiple ways of doing the same
> > thing. But doesn't pagemap reading lack the range aggregation feature?
> Yeah, correct. But note that we are supporting only selective 4 flags in
> this ioctl, not all pagemap flags. So it is useful for only those users w=
ho
> depend only on these 4 flags. Out pagemap_ioctl interface is not so much
> generic that we can cater anyone. Its interface is specific and we are
> adding only those cases which are of our interest. So if someone wants
> range aggregation from pagemap_ioctl, he'll need to add that flag in the
> IOCTL first. When IOCTL support is added, he can specify the selection
> criterion etc.

The available flag set is not a problem. An example usecase: dumping
the memory state for debugging: ioctl(return_mask=3DALL) returns a
conveniently compact vector of ranges of pages that are actually used
by the process (not only having reserved the virtual space). This is
actually something that helps dumping processes with using tools like
AddressSanitizer that create huge sparse mappings.

Best Regards
Micha=C5=82 Miros=C5=82aw
