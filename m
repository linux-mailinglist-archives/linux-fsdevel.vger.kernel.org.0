Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF22D75FB86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGXQLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGXQLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:11:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5BC10F4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:11:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so14641a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690215061; x=1690819861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3kbNyGxTzgeac58CFsNMUin81+ND8D8Z3uhWh4woO8=;
        b=tigo2h0UJbLSdNBggb8+yka3tLWlOxt9O4d6NIR4mh9iEiIf1en0sl8VXgCF7R+a/t
         tT7LAnPTQCFRJoo0KWqoqyRU9MAHIoPOGygj1DT5qhRnO0ELBnXIh5zBzmwOe5dznmpR
         oK2ugIQjvmAQRczWo4nzF8BFniwOIxp8Ob3QNgni7FEXBDJPkhRsjBlyvf+2pOpfyScy
         U2GCJzaS3tue+rOz+Sz9IInuWpFJ7fOOQw2hFvT1311EWcKQhsxRHWi26As9g75IdYr+
         ayHwpRltXX4GhBn6/blJt9V95VxuAayWW8bx5GgGtHMzMjrA98jhAVUaJyPI8/gpIiuw
         u1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690215061; x=1690819861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3kbNyGxTzgeac58CFsNMUin81+ND8D8Z3uhWh4woO8=;
        b=AsX851KprTH3Oo22+QImFuZ/6rz6joApvBu0ToBzYCXGIzYmX9ErEsQq4XtQncuL2r
         6KHjCZt1+//vUDa0uQRJ8VSQbJMXMY9CPZ70b5Ukhc8yQ/4F1Oax0ljj8uSfeG8wjJMo
         iVF3MQpU9vNghQ2v1n4cuLWKXu94qbmbJ+rfZMSp4YC7Qbs22tdMU83HoMUJRHAuXhmQ
         DfsC2XQnmxG1R0ecT+4PauMJR3MYlmbBmt3SlU+4ln/lB8+Ppl5qTyJOid3F5KVjBtZ/
         bwbm3qscnkS1O0dVm4qk/Z4/6OHVucV5qUVW+CB+9V3fq/n0gxfNCBHar9XJ4UDoLGnF
         SWug==
X-Gm-Message-State: ABy/qLZUlpqcNjsCXhAccgewl8Xx35lfKIZ43JZ4lfcRLCg91ti9nbGF
        iAR34iXPbT+e33nmseIu03jGyUs80OVAfnFh0QWFYw==
X-Google-Smtp-Source: APBJJlF8bHvRHeT2oqat2ATehlhxW6USprsvQrLWXhzWPyCpmacj5+zK0woo1RH6qpDsIl+dtTSAFcyumUKkKtf+1lM=
X-Received: by 2002:a50:d798:0:b0:522:28a1:2095 with SMTP id
 w24-20020a50d798000000b0052228a12095mr116981edi.3.1690215061016; Mon, 24 Jul
 2023 09:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com> <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com> <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com> <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
In-Reply-To: <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Mon, 24 Jul 2023 18:10:49 +0200
Message-ID: <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
Subject: Re: [v2] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Jul 2023 at 17:22, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 7/24/23 7:38=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Mon, 24 Jul 2023 at 16:04, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Fixed found bugs. Testing it further.
> >>
> >> - Split and backoff in case buffer full case as well
> >> - Fix the wrong breaking of loop if page isn't interesting, skip intea=
d
> >> - Untag the address and save them into struct
> >> - Round off the end address to next page
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>  fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++-------------------=
-
> >>  1 file changed, 31 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index add21fdf3c9a..64b326d0ec6d 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -2044,7 +2050,7 @@ static int pagemap_scan_thp_entry(pmd_t *pmd,
> >> unsigned long start,
> >>          * Break huge page into small pages if the WP operation
> >>          * need to be performed is on a portion of the huge page.
> >>          */
> >> -       if (end !=3D start + HPAGE_SIZE) {
> >> +       if (end !=3D start + HPAGE_SIZE || ret =3D=3D -ENOSPC) {
> >
> > Why is it needed? If `end =3D=3D start + HPAGE_SIZE` then we're handlin=
g a
> > full hugepage anyway.
> If we weren't able to add the complete thp in the output buffer and we ne=
ed
> to perform WP on the entire page, we should split and rollback. Otherwise
> we'll WP the entire thp and we'll lose the state on the remaining THP whi=
ch
> wasn't added to output.
>
> Lets say max=3D100
> only 100 pages would be added to output
> we need to split and rollback otherwise other 412 pages would get WP

In this case *end will be truncated by output() to match the number of
pages that fit.

> >> @@ -2066,8 +2072,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> >> unsigned long start,
> >>  {
> >>         struct pagemap_scan_private *p =3D walk->private;
> >>         struct vm_area_struct *vma =3D walk->vma;
> >> +       unsigned long addr, categories, next;
> >>         pte_t *pte, *start_pte;
> >> -       unsigned long addr;
> >>         bool flush =3D false;
> >>         spinlock_t *ptl;
> >>         int ret;
> >> @@ -2088,12 +2094,14 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> >> unsigned long start,
> >>         }
> >>
> >>         for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE_SIZE=
) {
> >> -               unsigned long categories =3D p->cur_vma_category |
> >> -                       pagemap_page_category(vma, addr, ptep_get(pte)=
);
> >> -               unsigned long next =3D addr + PAGE_SIZE;
> >> +               categories =3D p->cur_vma_category |
> >> +                            pagemap_page_category(vma, addr, ptep_get=
(pte));
> >> +               next =3D addr + PAGE_SIZE;
> >
> > Why moving the variable declarations out of the loop?
> Saving spaces inside loop. What are pros of declation of variable in loop=
?

Informing the reader that the variables have scope limited to the loop body=
.

[...]
> >> @@ -2219,22 +2225,24 @@ static int pagemap_scan_get_args(struct pm_sca=
n_arg
> >> *arg,
> >>              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_C=
ATEGORIES)
> >>                 return -EINVAL;
> >>
> >> -       start =3D untagged_addr((unsigned long)arg->start);
> >> -       end =3D untagged_addr((unsigned long)arg->end);
> >> -       vec =3D untagged_addr((unsigned long)arg->vec);
> >> +       arg->start =3D untagged_addr((unsigned long)arg->start);
> >> +       arg->end =3D untagged_addr((unsigned long)arg->end);
> >> +       arg->vec =3D untagged_addr((unsigned long)arg->vec);
> >
> > BTW, We should we keep the tag in args writeback().
> Sorry what?
> After this function, the start, end and vec would be used. We need to mak=
e
> sure that the address are untagged before that.

We do write back the address the walk ended at to arg->start in
userspace. This pointer I think needs the tag reconstructed so that
retrying the ioctl() will be possible.

 Best Regards
Micha=C5=82 Miros=C5=82aw
