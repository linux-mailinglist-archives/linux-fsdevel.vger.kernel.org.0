Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB877817F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjHJT0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJT0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:26:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E790
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 12:26:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2698a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695582; x=1692300382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M2iPr1UJVHGFT8TQdnwZTNArsr1wGryk6ufkfsAkzI=;
        b=NtsWbmNFqBepaBH2DlfxhtQc88rTP6poWfZiNHU7zjNl3M4k9zexE6653xhn3BNt9X
         xAejuvrX5lIegZmwDpkL/RwZt7fUYpeMe8kN52h73ltDzKfFoNJbmWmOsFbdYEppiGlS
         EbghugF5nBRMsTErYdEpJj8VJQpKGT30tyUEJGBKffA62ubxCP1cg3cbJPw+DSIurZGv
         jZgJE+c/Ae8h/kuBGwS02qVludTmupWnD+cKqfZeX48LNl1ZUW7U8QB4+0P9pU0PGOOE
         DnnLio9tP0F2CjHjvJgcIt2nE+V0KVvHlQYXf7b6ts3sW3o7w0RFqC3aS1CHyplP1Yhm
         yCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695582; x=1692300382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M2iPr1UJVHGFT8TQdnwZTNArsr1wGryk6ufkfsAkzI=;
        b=ZLSVbd4yhLsYtGqoZBbFDsxwBBO+36NkwD1qdKjsXV7aKmg5EDth+DJw3ko4CVmwPW
         Q3or71iyW+k+ZkZ4Nr9L5leE0l+SrOfvTYCSnfT3fj3M6DBYhWlDLw7mpmNTTwCH0TYw
         +1TsWq03xpkyZ1wJFLmEnCRPpRYmXtZa3wMwWFVF39n+tCi3hZnWQRQnm3p6aCRbdF8N
         Gj0XoVSxZjVCVfTniUp5TOzN5Zcjs/CWs+lPwtN1vN9SaH8wXTX56804QkA6LsmVsapN
         vKCVDLE4uG/Pv2RjjXs1VuLR9xqinZ9IvVDYv0hx4UnMLS1thU8WKNivnh+VNw2brSbv
         RvAA==
X-Gm-Message-State: AOJu0Yw3gN557LMnByxB36GUYILv0lcw9FUSoQx6cKCBolj69JUP8Agq
        Fuuimze9wkH4rcmTnberJhvWdLS3OFk30Q8Adkab0Q==
X-Google-Smtp-Source: AGHT+IFSthzdZHQWjZGRfN1VqKcrQ3fEjsmcl6BCv8ko21zKpNpfAA0n4Xn5zWlCsMTAGvT81+a4JzhjFClXLpQPxzA=
X-Received: by 2002:a50:cdd8:0:b0:523:bdc9:48a9 with SMTP id
 h24-20020a50cdd8000000b00523bdc948a9mr17482edj.0.1691695581678; Thu, 10 Aug
 2023 12:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230809061603.1969154-1-usama.anjum@collabora.com> <20230809061603.1969154-6-usama.anjum@collabora.com>
In-Reply-To: <20230809061603.1969154-6-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 10 Aug 2023 21:26:10 +0200
Message-ID: <CABb0KFGftHi1t3Pt8V3XvsG=+-hvfQMMteW9VXEPrRmfUdZZWA@mail.gmail.com>
Subject: Re: [PATCH v28 5/6] mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> Add some explanation and method to use write-protection and written-to
> on memory range.
[...]
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -227,3 +227,67 @@ Before Linux 3.11 pagemap bits 55-60 were used for "=
page-shift" (which is
>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>  flags unconditionally.
> +
> +Pagemap Scan IOCTL
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``PAGEMAP_SCAN`` IOCTL on the pagemap file can be used to get or opt=
ionally
> +clear the info about page table entries. The following operations are su=
pported
> +in this IOCTL:
> +- Get the information if the pages have Async Write-Protection enabled
> +  (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), f=
ile mapped
> +  (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped (``PAGE_IS_=
SWAPPED``)
> +  or page has pfn zero (``PAGE_IS_PFNZERO``).

A recent addition -- PAGE_IS_HUGE -- is missing.

BTW, it could be easier to understand if the page categories were
separated from the operation description and listed so that each has
its own line and maybe a longer description where needed.

> +- Find pages which have been written to and/or write protect
> +  (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages ato=
mically.
> +  The (``PM_SCAN_WP_MATCHING``) is used to WP the matched pages. The
> +  (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if non-Async-Write-Pr=
otected
> +  pages are found.

The operation the IOCTL does now is: "scan the process page tables and
report memory ranges matching provided criteria '.
Flags extend the operation: "PM_SCAN_WP_MATCHING write protects the
memory reported" (it does it atomically, but this is just an
optimization, isn't it? A process could gather the ranges, WP them,
and then copy.)
"PM_SCAN_CHECK_WPASYNC" aborts the scan early if a non-WP-able
matching page is found.

> +The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
> + 1. The size of the ``struct pm_scan_arg`` must be specified in the ``si=
ze``
> +    field. This field will be helpful in recognizing the structure if ex=
tensions
> +    are done later.
> + 2. The flags can be specified in the ``flags`` field. The ``PM_SCAN_WP_=
MATCHING``
> +    and ``PM_SCAN_CHECK_WPASYNC`` are the only added flags at this time.=
 The get
> +    operation is optionally performed depending upon if the output buffe=
r is
> +    provided or not.
> + 3. The range is specified through ``start`` and ``end``.
> + 4. The output buffer of ``struct page_region`` array and size is specif=
ied in
> +    ``vec`` and ``vec_len``.
> + 5. The optional maximum requested pages are specified in the ``max_page=
s``.
> + 6. The masks are specified in ``category_mask``, ``category_anyof_mask`=
`,
> +    ``category_inverted`` and ``return_mask``.
> +    1.  To find if ``PAGE_IS_WRITTEN`` flag is set for pages which have
> +        ``PAGE_IS_FILE`` set and ``PAGE_IS_SWAPPED`` unset, ``category_m=
ask``
> +        is set to ``PAGE_IS_FILE | PAGE_IS_SWAPPED``, ``category_inverte=
d`` is
> +        set to ``PAGE_IS_SWAPPED`` and ``return_mask`` is set to ``PAGE_=
IS_WRITTEN``.
> +        The output buffer in ``vec`` and length must be specified in ``v=
ec_len``.
> +    2. To find pages which have either ``PAGE_IS_FILE`` or ``PAGE_IS_SWA=
PPED``
> +       set, ``category_anyof_mask`` is set to  ``PAGE_IS_FILE | PAGE_IS_=
SWAPPED``.
> +    3. To find written pages and engage write protect, ``PAGE_IS_WRITTEN=
`` is
> +       specified in ``category_mask`` and ``return_mask``. In addition t=
o
> +       specifying the output buffer in ``vec`` and length in ``vec_len``=
, the
> +       ``PM_SCAN_WP_MATCHING`` is specified in ``flags`` to perform writ=
e protect
> +       on the range as well.

Could this be rewritten as examples? E.g.:

Finding dirty file-backed pages:

struct pm_scan_arg arg =3D {
 .size =3D sizeof(arg),
  .flags =3D 0,
 ...
   .category_mask =3D ...,
   .return_mask =3D ...
};
ssize_t n =3D ioctl(..., &arg);

Find dirty pages and write protect them in the same call:

arg =3D { ... };
do {
  ... ioctl(...)
} while(...);

(The code snippets heavily commented.)

> +The ``PAGE_IS_WRITTEN`` flag can be considered as the better and correct

"as a better-performing alternative"

> +alternative of soft-dirty flag. It doesn't get affected by housekeeping =
chores
> +(VMA merging) of the kernel and hence the user can find the true soft-di=
rty pages
> +only.

This is still an optimization, e.g. in THP case there might be too
many pages reported?

> + This IOCTL adds the atomic way to find which pages have been written an=
d
> +write protect those pages again. This kind of operation is needed to eff=
iciently
> +find out which pages have changed in the memory.

This repeats the description of PM_SCAN_WP_MATCHING -- I suggest
removing this part.

> +To get information about which pages have been written to or optionally =
write
> +protect the pages, following must be performed first in order:

"PAGE_IS_WRITTEN" category is used with uffd write protect-enabled
ranges to implement memory dirty tracking in userspace:

> + 1. The userfaultfd file descriptor is created with ``userfaultfd`` sysc=
all.
> + 2. The ``UFFD_FEATURE_WP_UNPOPULATED`` and ``UFFD_FEATURE_WP_ASYNC`` fe=
atures
> +    are set by ``UFFDIO_API`` IOCTL.
> + 3. The memory range is registered with ``UFFDIO_REGISTER_MODE_WP`` mode
> +    through ``UFFDIO_REGISTER`` IOCTL.
> + 4. Then any part of the registered memory or the whole memory region mu=
st
> +    be write protected using ``PAGEMAP_SCAN`` IOCTL with flag ``PM_SCAN_=
OP_WP``
> +    or the ``UFFDIO_WRITEPROTECT`` IOCTL can be used. Both of these perf=
orm the
> +    same operation. The former is better in terms of performance.

I guess that the UFFD performance could be fixed? But this part refers
to the old PM_SCAN_OP_WP, so an updated example is needed.

> + 5. Now the ``PAGEMAP_SCAN`` IOCTL can be used to either just find pages=
 which
> +    have been written to and/or optionally write protect the pages as we=
ll.

"find the pages written to since they were last write protected", but
this sounds contradicting: we look for pages that were WP but written
anyway. (IOW: marking write-protected is an implementation detail -
the ioctl is to find pages that changed since they were last marked.)
Maybe we should call the operation "marking CLEAN" or alike?

Best Regards
Micha=C5=82 Miros=C5=82aw
