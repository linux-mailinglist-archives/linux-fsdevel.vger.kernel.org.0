Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F6573033B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbjFNPPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbjFNPPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:15:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C81FF9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 08:15:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so8951a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686755704; x=1689347704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsEjz7bbQu30vwz1TB6ECLLLYfjYBJIvlXymlt/vuzg=;
        b=7qo/gi70XMJJrCWyYXk3Z3AgBkKTLGUFq0N5W4KgodH/kR6hrgwwmv3sXbQ/jkEvJH
         ZpbYii1a7qndeQnA8PXKLV+JPNhZDnEJv0oYT+oOMuUoILrb/N5Tp8q+YJyoQtpRlsQG
         ka8V9NIYhKnl+V2+yUujx/AeQj2l/U9i7HyQ8mk7la8P8fjFbiMO5kPtVCMMQC51+K2/
         b3GLmavGNXzpua+K1YpHh/epK1tUUwV/4p1lRIQxpUvBRhKM41CNNoKQBQ//jbb/mmG2
         cvuJ30PBr99k6/AxtP4RejcEQpLjHqOY1Hx68s4sdQ5h8E8hTt+B2NWv4vm62cN7dEPf
         5Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686755704; x=1689347704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsEjz7bbQu30vwz1TB6ECLLLYfjYBJIvlXymlt/vuzg=;
        b=XLLRjYOcnePbLJreom2jCWgU82fc5NvWyZiOpvoOjkyn4qQ1aqlZeAXakxUbb6BJ6Z
         kyUlBrLZL+jagd5uVI+tnEUAZhI0f+ufoisgS+mksEzQlnixTbiT8HeoBPchDYTw79cc
         HdmugW5FYjbj+XorBtiIVc+vmoq24nYTAh6So+WrdY9tM22/+GXxvyVq9mCW+pfnkS4W
         odp3LFQn3Q36fKZ1hCAfdbG66qrOwH9AD7cag5wjR9mhsL+7P4tW+JMsU+zQ02ETs/8/
         EHPLOrRWbKWLRyijrgJcoWiBC1i03zxzAt0iMzTKIqysZOlhaIUDXEChrzQmmtEHxetS
         JRdw==
X-Gm-Message-State: AC+VfDzOVa0g7vuh9BtbjjycpsUWey1vIWtUV1sh/NnTH7hWcAAOJRtu
        MNLsHANr0iVyb0aveJdlm7nrS1HaLJsmsL/773DDzg==
X-Google-Smtp-Source: ACHHUZ6TRKd86tuathV4bwX1FDKBmfv3xar1RD/83KG7IzFWfS31XuiR1ZMEYzFmOxigglYy+6rtq35e1RGFRDskZgA=
X-Received: by 2002:a50:8e59:0:b0:516:6453:1b76 with SMTP id
 25-20020a508e59000000b0051664531b76mr79836edx.5.1686755704173; Wed, 14 Jun
 2023 08:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com>
In-Reply-To: <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 14 Jun 2023 17:14:52 +0200
Message-ID: <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
Subject: Re: [PATCH v18 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/14/23 3:36=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or cle=
ar
> >> the info about page table entries. The following operations are suppor=
ted
> >> in this ioctl:
> >> - Get the information if the pages have been written-to (PAGE_IS_WRITT=
EN),
> >>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
> >>   (PAGE_IS_SWAPPED).
> >> - Find pages which have been written-to and/or write protect the pages
> >>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
> >>
> >> This IOCTL can be extended to get information about more PTE bits.
> > [...]
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> > [...]
> >> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool sw=
ap,
> >> +                              struct pagemap_scan_private *p,
> >> +                              unsigned long addr, unsigned int n_page=
s)
> >> +{
> >> +       unsigned long bitmap =3D PM_SCAN_BITMAP(wt, file, pres, swap);
> >> +       struct page_region *cur_buf =3D &p->cur_buf;
> >
> > Maybe we can go a step further and say here `cur_buf =3D
> > &p->vec_buf[p->vec_buf_index];` and remove `p->cur_buf` entirely?
> No, this cannot be done. vec_buf_index represents overall index in vec_bu=
f
> which is a user buffer. We cannot access it conveniently. This is why I'd
> added cur_buf in the fisrt place.

Wasn't this the case only before the intermediate p->vec_buf array was
added? It is now a kmalloc()ed temporary and it isn't copied to
userspace until the walk iteration finishes.

[...]
> >> +       if (cur_buf->bitmap =3D=3D bitmap &&
> >> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D addr) {
> >> +               cur_buf->len +=3D n_pages;
> >> +               p->found_pages +=3D n_pages;
> >> +       } else {
> >> +               if (cur_buf->len && p->vec_buf_index >=3D p->vec_buf_l=
en)
> >> +                       return -ENOMEM;
> >
> > Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
> > ran out of memory when allocating, not that there is no space in a
> > user-provided buffer.
> There are 3 kinds of return values here:
> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort the
> page walk from next entry
> * 0 ---> continue the page walk
> * -ENOMEM --> Abort the page walk from current entry, user buffer is full
> which is not error, but only a stop signal. This -ENOMEM is just
> differentiater from (1). This -ENOMEM is for internal use and isn't
> returned to user.

But why ENOSPC is not good here? I was used before, I think.

> >> +               if (cur_buf->len) {
> >> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
> >> +                              sizeof(*p->vec_buf));
> >> +                       p->vec_buf_index++;
> >> +               }
> >> +
> >> +               cur_buf->start =3D addr;
> >> +               cur_buf->len =3D n_pages;
> >> +               cur_buf->bitmap =3D bitmap;
> >> +               p->found_pages +=3D n_pages;
> >> +       }
> >> +
> >> +       if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> >
> > Since `p->found_pages > 0` holds here, the first check is redundant.
> I didn't get it. As the max_pages is optional, its validity needs to be
> checked first.

I mean that `p->max_pages`, if 0, will never compare equal to
`p->found_pages` here.

> > For flags name: PM_REQUIRE_WRITE_ACCESS?
> > Or Is it intended to be checked only if doing WP (as the current name
> > suggests) and so it would be redundant as WP currently requires
> > `p->required_mask =3D PAGE_IS_WRITTEN`?
> This is intended to indicate that if userfaultfd is needed. If
> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
> userfaultfd has been initialized for this memory. I'll rename to
> PM_SCAN_REQUIRE_UFFD.

Why do we need that check? Wouldn't `is_written =3D false` work for vmas
not registered via uffd?

> >> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned =
long start,
> >> +                                  struct page_region __user *vec)
> >> +{
> >> +       /* Detect illegal size, flags, len and masks */
> >> +       if (arg->size !=3D sizeof(struct pm_scan_arg))
> >> +               return -EINVAL;
> >> +       if (arg->flags & ~PM_SCAN_OPS)
> >> +               return -EINVAL;
> >> +       if (!arg->len)
> >> +               return -EINVAL;
> >> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask=
 |
> >> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
> >> +               return -EINVAL;
> >> +       if (!arg->required_mask && !arg->anyof_mask &&
> >> +           !arg->excluded_mask)
> >> +               return -EINVAL;
> >> +       if (!arg->return_mask)
> >> +               return -EINVAL;
> >
> > I just noticed that `!arg->return_mask =3D=3D !IS_PM_SCAN_GET()`. So th=
e
> > OP_GET is redundant and can be removed from the `flags` if checking
> > `return_mask` instead. That way there won't be a "flags-encoded ops"
> > thing as it would be a 'scan' with optional 'write-protect'.
> I know it makes flags checking easier if we remove PM_SCAN_OP_GET. But
> it'll created complications later if more OPs are added to the IOCTL. Let=
s
> not remove it.
>
> Some history:
> I'd PM_SCAN_OP_GET. Then someone asked me to remove it. Then someone aske=
d
> me to add it back.
>
> >
> >> +
> >> +       /* Validate memory range */
> >> +       if (!IS_ALIGNED(start, PAGE_SIZE))
> >> +               return -EINVAL;
> >> +       if (!access_ok((void __user *)start, arg->len))
> >> +               return -EFAULT;
> >> +
> >> +       if (IS_PM_SCAN_GET(arg->flags)) {
> >> +               if (!arg->vec)
> >> +                       return -EINVAL;
> >
> > access_ok() -> -EFAULT (an early fail-check) (the vec_len should be
> > checked first then, failing with -EINVAL if 0)
> I'd access_ok() for vec. But I removed it after discussion with you. Now =
I
> only check that vec shouldn't be NULL:
> https://lore.kernel.org/all/CABb0KFGru9xFCxyVHBcE+dkXe58=3D5wiCbvZGSWhuTf=
r4gn=3DMRQ@mail.gmail.com

Oh, indeed. It seems I then misunderstood what `access_ok()` does. It
is only doing a sanity check on the pointer (range) and not actually
verifying memory mapping validity. So as a early-fail check it's ok.

[...]
> >> +               if (arg->vec_len =3D=3D 0)
> >> +                       return -EINVAL;
> >> +       }
> >> +
> >> +       if (IS_PM_SCAN_WP(arg->flags)) {
> >> +               if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
> >> +                       return -EINVAL;
> >> +
> >> +               if ((arg->required_mask | arg->anyof_mask | arg->exclu=
ded_mask) &
> >> +                   ~PAGE_IS_WRITTEN)
> >
> > Is `excluded_mask =3D PAGE_IS_WRITTEN` intended to be allowed? It would
> > make WP do nothing, unless the required/anyof/excluded masks are not
> > supposed to limit WP?
> My intention is that no other flag than PAGE_IS_WRITTEN must be specified
> in all masks if WP op is specified.
>
> If exluded_mask =3D PAGE_IS_WRITTEN,
> * the page would be rejected if page is written. No need to WP these.
> * Only those pages would be allowed which aren't written. Then would also
> not write protected.
>
> So write protect operation wouldn't happen logically. It is on user for n=
ot
> comprehending the combined meaning of WP op and excluded mask.
>
> Do you agree or do you want me to reject WP op if excluded =3D PAGE_IS_WR=
ITTEN?

I see a bit of inconsistency here in that in some parts of the API we
disallow nonsensical (no-op) parameters (like output_mask =3D=3D 0 or
required_mask =3D=3D excluded_mask), but in others do not. I'd prefer to
have it one way and if I had to choose I'd allow trivial no-ops to
reduce the kernel-side code overhead.

The other topic is whether we should limit the page selection to
PAGE_IS_WRITTEN for WP op. I don't see any benefit from that.

Maybe we should go back to the drawing board for a quick review: Can
we decouple the responsibilities of the page selection from WP
operation? I'd think yes - are there downsides to having the
required/any/excluded masks limit the pages presented to GET and/or WP
and have GET use returned_mask, max_pages, vec_buf+len and stop the
scan after the limit is hit? WP would just act on whatever pages were
accepted by the walk filter and (if enabled) GET output buffer.

Nit: I'd prefer the excluded_mask be replaced by inverted_mask, but we
already discussed that so feel free to ignore. This would remove a bit
of logic from the filtering code, and userspace could always wrap the
ioctl in a function that converts from required+excluded into
required+inverted.

While here, I wonder if we really need to fail the call if there are
unknown bits in those masks set: if this bit set is expanded with
another category flags, a newer userspace run on older kernel would
get EINVAL even if the "treat unknown as 0" be what it requires.
There is no simple way in the API to discover what bits the kernel
supports. We could allow a no-op (no WP nor GET) call to help with
that and then rejecting unknown bits would make sense.

> > [...]
> >> --- a/include/uapi/linux/fs.h
> >> +++ b/include/uapi/linux/fs.h
> >> +/*
> >> + * struct page_region - Page region with bitmap flags
> >> + * @start:     Start of the region
> >> + * @len:       Length of the region in pages
> >> + * bitmap:     Bits sets for the region
> >
> > '@' is missing for the third field. BTW, maybe we can call it
> > something like `flags` or `category` (something that hints at the
> > meaning of the value instead of its data representation).
> The deification of this struct says, "with bitmap flags". Bitmap was a
> different name. I'll update it to flags.

From the implementation and our discussions I guess the
`bitmap`/`flags` field is holding a set of matching categories: a bit
value 1 =3D pages are in this category, value 0 =3D pages are not in this
category.

> >> +/*
> >> + * struct pm_scan_arg - Pagemap ioctl argument
> >> + * @size:              Size of the structure
> >> + * @flags:             Flags for the IOCTL
> >> + * @start:             Starting address of the region
> >> + * @len:               Length of the region (All the pages in this le=
ngth are included)
> >
> > Maybe `scan_start`, `scan_len` - so that there is a better distinction
> > from the structure's `size` field?
> As start and len already communicate the meaning. We are making things mo=
re
> verbose.

We are describing (in the name) only that it is a range, but not of
what or what purpose. That information is only in the docstring, but
it is harder to get by someone just reading the code.

> >> + * @vec:               Address of page_region struct array for output
> >> + * @vec_len:           Length of the page_region struct array
> >> + * @max_pages:         Optional max return pages
> >> + * @required_mask:     Required mask - All of these bits have to be s=
et in the PTE
> >> + * @anyof_mask:                Any mask - Any of these bits are set i=
n the PTE
> >> + * @excluded_mask:     Exclude mask - None of these bits are set in t=
he PTE
> >> + * @return_mask:       Bits that are to be reported in page_region
> >> + */
> >
> > I skipped most of the page walk implementation as maybe the comments
> > above could make it simpler. Reading this patch and the documentation
> > I still feel confused about how the filtering/limiting parameters
> I'm really sad to hear this. I've been working on making this series from
> so many revisions. I was hopping that it would make complete sense to
> reviewers and later to users.
>
> What do you think is missing which is restricting these patches getting
> accepted to upstream?
>
> > should affect GET, WP and WP+GET. Should they limit the pages walked
> > (and WP-ed)? Or only the GET's output? How about GET+WP case?
> The address range needs to be walked until max pages pages are found, use=
r
> buffer is full or whole range is walked. If the page will be added to use=
r
> buffer or not depends on the selection criteria (*masks). There is no
> difference in case of walk for GET, WP and GET+WP. Only that WP doesn't
> take any user buffer and just WPs the whole region.

Ok, then this intent (if I understand correctly) does not entirely
match the implementation. Let's split up the conditions:

1. The address range needs to be walked until max pages pages are found

current implementation: the address range is walked until max pages
matching masks (incl. return_mask) are reported by GET (or until end
of range if GET is not requested).
Maybe we need to describe what "found" means here?

2. user buffer is full

Matches implementation except in GET+WP edge cases.

3. or whole range is walked

Matches implementation.

4.  If the page will be added to user buffer or not depends on the
selection criteria (*masks).

Is `return_mask` a selection criterion? The implementation does skip
(counting and outputting) pages where (category_mask & return_mask) =3D=3D
0.

5. There is no difference in case of walk for GET, WP and GET+WP.

I'm not sure I understand this condition: Is it that the sequence of
pages walked does not depend on the operations? If so, then I think
the implementation matches (not entirely sure, though).

6. Only that WP doesn't take any user buffer

Matches implementation (trivial).

7. ... and just WPs the whole region.

Follows from current implementation for #1.

But there is an additional restriction:
- if using WP, masks can only contain IS_WRITTEN.

Summing this up: I think the number of interactions between various
parameters can be reduced:
a. required/anyof/excluded masks apply to the operation as a whole
(selecting pages to act on); and
b. returned_mask, max_pages, vec_buf+len apply to GET and stop the
walk early if limits are hit (checked before WP is done)

That way we can conceptually decouple WP from the selection of pages
and don't need to restrict the page masks to IS_WRITTEN. This makes
the operation basically a GET (SCAN as the ioctl name suggests) with
an auxiliary and optional WP (IOW: pages walked don't depend on WP
operation being requested or not). This also matches the current
implementation, where plain WP can be done via UFFD-specific call.
(BTW, why the UFFD one has to be slower?)

(Note: my intent in this discussion is to minimise the effort needed
to understand how to use and what are the restrictions of the API -
and doing this by minimizing the number and size of rules that one has
to apply. Nb. this is proportional to number of rules in
...args_validate().)

Best Regards
Micha=C5=82 Miros=C5=82aw
