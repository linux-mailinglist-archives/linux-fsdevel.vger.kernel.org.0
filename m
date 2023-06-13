Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9572EF8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjFMWgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 18:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbjFMWgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:36:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E410F3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 15:36:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so4714a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686695796; x=1689287796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvWX2bD0pqjf2LH9LS1XjF7500hItj0+6/IMn+0hUyQ=;
        b=3Glh+mv9w/hlsr3HtW9bHUVgiWBnoxfzOAwjquvJ1AtpWmAxPHzA/8KB9rQGLI6bPW
         f7qGlGThGtdA47ymx+HgiBOoyHoX8jWor32TAvaO+WmUaWX3Xn1BpcQf2f1XZitWH15J
         MDv06bVTji5Ik3ErHeafLVYLUfoKp++ieuFYgvwKgCKflAvoHh5Ewq6xg9zaJ+jxAdsg
         lyTmXYkYfQvktXvGcfRQcvhxjg6Ujut2b0YJFUIhzfQVJ5PzkiNsrvcO0ZYmSN5sFFLX
         0WJW3uVykV1WNvlLlgmXEDrdroLofKmh8799uzbRJ6beNn6YsvBet8ulVt1JaK5KjEaQ
         NW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686695796; x=1689287796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvWX2bD0pqjf2LH9LS1XjF7500hItj0+6/IMn+0hUyQ=;
        b=FEpVPWsceuuVz6Z/gE/VBa/4UMA0XZRBc+SIDDGrAoOGU40UTiKZNxmH0rvOdLns5e
         FaWd5pZNKRSB/F0kef0xgUOsV3JMuDk/a7VxQ7yfBwm9ydxRIm9MT3PD9+oR0JNUO2+M
         CuCpYFvy3O2AHEwTiCT33ctB/xdJSs2/RxXbunHDzUTRcflmSjmFMXvQzcqXmQLWRpfB
         UDYl3HAe59zJHCC00r6cN0XZ1BS+Yb7qx9GhFJWanDdZKTqUDXCLMn/UD7xrUFm4PPuN
         iOQTbvWU5XRpq07S2BeCLjL9ZoVhmXOSFKtTgDej1xY1WtbcP6QimGVsghwKehikZqDX
         xbaw==
X-Gm-Message-State: AC+VfDx/CylsD4ixdWPJpeVzgSoKeK9HjypXIGopB9kxSg8WTBFV/DOn
        8DbNjqo60yARzGkncKNJZUSMSU1j/ArPeH08/xMGyw==
X-Google-Smtp-Source: ACHHUZ4b9ZmvHIHuVqiKCGkay8zIJtZ17R+nhtVYSufNYgAsmJA4+02HPCuDfftyIn3PNzWLVqxf8ToCsmK0FXHe7fI=
X-Received: by 2002:a50:cc9a:0:b0:506:90c4:b63b with SMTP id
 q26-20020a50cc9a000000b0050690c4b63bmr36356edi.4.1686695795711; Tue, 13 Jun
 2023 15:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com> <20230613102905.2808371-3-usama.anjum@collabora.com>
In-Reply-To: <20230613102905.2808371-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 14 Jun 2023 00:36:24 +0200
Message-ID: <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
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

On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN)=
,
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Find pages which have been written-to and/or write protect the pages
>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>
> This IOCTL can be extended to get information about more PTE bits.
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned int n_pages)
> +{
> +       unsigned long bitmap =3D PM_SCAN_BITMAP(wt, file, pres, swap);
> +       struct page_region *cur_buf =3D &p->cur_buf;

Maybe we can go a step further and say here `cur_buf =3D
&p->vec_buf[p->vec_buf_index];` and remove `p->cur_buf` entirely?

> +
> +       if (!n_pages)
> +               return -EINVAL;
> +
> +       if ((p->required_mask & bitmap) !=3D p->required_mask)
> +               return 0;
> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
> +               return 0;
> +       if (p->excluded_mask & bitmap)
> +               return 0;
> +
> +       bitmap &=3D p->return_mask;
> +       if (!bitmap)
> +               return 0;
> +
> +       if (cur_buf->bitmap =3D=3D bitmap &&
> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D addr) {
> +               cur_buf->len +=3D n_pages;
> +               p->found_pages +=3D n_pages;
> +       } else {
> +               if (cur_buf->len && p->vec_buf_index >=3D p->vec_buf_len)
> +                       return -ENOMEM;

Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
ran out of memory when allocating, not that there is no space in a
user-provided buffer.

BTW, the check could be inside the if() below for easier reading and
less redundancy.

> +               if (cur_buf->len) {
> +                       memcpy(&p->vec_buf[p->vec_buf_index], cur_buf,
> +                              sizeof(*p->vec_buf));
> +                       p->vec_buf_index++;
> +               }
> +
> +               cur_buf->start =3D addr;
> +               cur_buf->len =3D n_pages;
> +               cur_buf->bitmap =3D bitmap;
> +               p->found_pages +=3D n_pages;
> +       }
> +
> +       if (p->max_pages && (p->found_pages =3D=3D p->max_pages))

Since `p->found_pages > 0` holds here, the first check is redundant.
Nit: the parentheses around =3D=3D are not needed.

> +               return PM_SCAN_FOUND_MAX_PAGES;
> +
> +       return 0;
> +}
[...]
> +static inline unsigned long pagemap_scan_check_page_written(struct pagem=
ap_scan_private *p)
> +{
> +       return ((p->required_mask | p->anyof_mask | p->excluded_mask) &
> +               PAGE_IS_WRITTEN) ? PM_SCAN_OP_WRITE : 0;
> +}

Please inline at the single callsite.

For flags name: PM_REQUIRE_WRITE_ACCESS?
Or Is it intended to be checked only if doing WP (as the current name
suggests) and so it would be redundant as WP currently requires
`p->required_mask =3D PAGE_IS_WRITTEN`?

> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned lon=
g start,
> +                                  struct page_region __user *vec)
> +{
> +       /* Detect illegal size, flags, len and masks */
> +       if (arg->size !=3D sizeof(struct pm_scan_arg))
> +               return -EINVAL;
> +       if (arg->flags & ~PM_SCAN_OPS)
> +               return -EINVAL;
> +       if (!arg->len)
> +               return -EINVAL;
> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask |
> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
> +               return -EINVAL;
> +       if (!arg->required_mask && !arg->anyof_mask &&
> +           !arg->excluded_mask)
> +               return -EINVAL;
> +       if (!arg->return_mask)
> +               return -EINVAL;

I just noticed that `!arg->return_mask =3D=3D !IS_PM_SCAN_GET()`. So the
OP_GET is redundant and can be removed from the `flags` if checking
`return_mask` instead. That way there won't be a "flags-encoded ops"
thing as it would be a 'scan' with optional 'write-protect'.

> +
> +       /* Validate memory range */
> +       if (!IS_ALIGNED(start, PAGE_SIZE))
> +               return -EINVAL;
> +       if (!access_ok((void __user *)start, arg->len))
> +               return -EFAULT;
> +
> +       if (IS_PM_SCAN_GET(arg->flags)) {
> +               if (!arg->vec)
> +                       return -EINVAL;

access_ok() -> -EFAULT (an early fail-check) (the vec_len should be
checked first then, failing with -EINVAL if 0)

> +               if (arg->vec_len =3D=3D 0)
> +                       return -EINVAL;
> +       }
> +
> +       if (IS_PM_SCAN_WP(arg->flags)) {
> +               if (!IS_PM_SCAN_GET(arg->flags) && arg->max_pages)
> +                       return -EINVAL;
> +
> +               if ((arg->required_mask | arg->anyof_mask | arg->excluded=
_mask) &
> +                   ~PAGE_IS_WRITTEN)

Is `excluded_mask =3D PAGE_IS_WRITTEN` intended to be allowed? It would
make WP do nothing, unless the required/anyof/excluded masks are not
supposed to limit WP?


> +                       return -EINVAL;
> +       }

If `flags =3D=3D 0` (and `return_mask =3D=3D 0` in case my earlier comment =
is
applied) it should fail with -EINVAL.

[...]
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> +/*
> + * struct page_region - Page region with bitmap flags
> + * @start:     Start of the region
> + * @len:       Length of the region in pages
> + * bitmap:     Bits sets for the region

'@' is missing for the third field. BTW, maybe we can call it
something like `flags` or `category` (something that hints at the
meaning of the value instead of its data representation).

> +/*
> + * struct pm_scan_arg - Pagemap ioctl argument
> + * @size:              Size of the structure
> + * @flags:             Flags for the IOCTL
> + * @start:             Starting address of the region
> + * @len:               Length of the region (All the pages in this lengt=
h are included)

Maybe `scan_start`, `scan_len` - so that there is a better distinction
from the structure's `size` field?

> + * @vec:               Address of page_region struct array for output
> + * @vec_len:           Length of the page_region struct array
> + * @max_pages:         Optional max return pages
> + * @required_mask:     Required mask - All of these bits have to be set =
in the PTE
> + * @anyof_mask:                Any mask - Any of these bits are set in t=
he PTE
> + * @excluded_mask:     Exclude mask - None of these bits are set in the =
PTE
> + * @return_mask:       Bits that are to be reported in page_region
> + */

I skipped most of the page walk implementation as maybe the comments
above could make it simpler. Reading this patch and the documentation
I still feel confused about how the filtering/limiting parameters
should affect GET, WP and WP+GET. Should they limit the pages walked
(and WP-ed)? Or only the GET's output? How about GET+WP case?

Best Regards

Micha=C5=82 Miros=C5=82aw
