Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7C75F9FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjGXOiT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGXOiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:38:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F2127
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:38:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15274a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690209493; x=1690814293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SDTe6qOC5PXRB6SyhCG7ZaeHW8gj0AmjKckKwv3io=;
        b=C9Suheke7UQIS/avFEu/JXXrfnObD0Xt0TNh7dM22D9jAawL6KZjL3QqM/z3wqzpm7
         Mm6YMbmLhKk4HT4js0BuYeNzm0Hs5lGiTUonNYK4R1YxlN9UufVYBC7ruD+OUlg74rUR
         46a2ArThiXaiWvRGM9jjZeLnWKh1O9ka7Tkd21FhQTItonpzlPJs1Ww16WWjwRf87RtU
         59vTx2NKqdYe45KK5Y1YFLUDOCStjKyzdM3/kJ9CHWfHj2NuKmfVO4KpV9SaWezw8n2W
         3tSWQhJJs7Y1INcgZ7gb204PsM5UMzzIkApxtp0SU2N09PJkoT5Pi0eXXnhEybhV9Nnv
         tmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690209493; x=1690814293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5SDTe6qOC5PXRB6SyhCG7ZaeHW8gj0AmjKckKwv3io=;
        b=LsQJnqr6o9wG++KmZp8LfOANVnwdpqkC8r7ZgzzVqyaN0b8Mk/H/PIwV0Jg8sSdZy/
         APzgBt9cRawkBlgt8MCiV34+sdQcl/WX8B90Y+7AwyBovsjjCvT6mU9SD+/b0THQyxPH
         vf5N9aEEBydBUm55YIbhxKAzD6M7o6GBWPH9PFMHS8B6OynhfKs+0uOMC8S6zGAX/1zn
         U0kpOZQ2dhWmBafxVDf52FiXWFwzDUess3QP8hgSbKxUOZcvzqE1pK7fxWJNcJvfqkeV
         eVSbq9B3rJcVFcmerws0ImbvQQ9faMCVyn/+5m3QeZ5CQtjqbdmljDKVtuf9mezV/PWX
         532A==
X-Gm-Message-State: ABy/qLZnyKBE9SVnE+QxSERJIJ2OJlhuOuJUZISXPZAzWGG+DVWgQJL9
        VcHr8Un35aGOFSpkgLg1BOfKT2jth83Ac+OR2Kerrw==
X-Google-Smtp-Source: APBJJlFRzqXuIv1qPeWfBAjjHGcqTmgLN2bBdY5Dll/6hSi/V+dFxY9ftxsLNyp7eYXdBv5srMzDm+fP5nEzVgqY6F0=
X-Received: by 2002:a50:d492:0:b0:51a:1ffd:10e with SMTP id
 s18-20020a50d492000000b0051a1ffd010emr178091edi.3.1690209493308; Mon, 24 Jul
 2023 07:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com> <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com> <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
In-Reply-To: <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Mon, 24 Jul 2023 16:38:01 +0200
Message-ID: <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
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

On Mon, 24 Jul 2023 at 16:04, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Fixed found bugs. Testing it further.
>
> - Split and backoff in case buffer full case as well
> - Fix the wrong breaking of loop if page isn't interesting, skip intead
> - Untag the address and save them into struct
> - Round off the end address to next page
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/proc/task_mmu.c | 54 ++++++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index add21fdf3c9a..64b326d0ec6d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1985,18 +1989,19 @@ static int pagemap_scan_output(unsigned long
> categories,
>         unsigned long n_pages, total_pages;
>         int ret =3D 0;
>
> +       if (!p->vec_buf)
> +               return 0;
> +
>         if (!pagemap_scan_is_interesting_page(categories, p)) {
>                 *end =3D addr;
>                 return 0;
>         }
>
> -       if (!p->vec_buf)
> -               return 0;
> -
>         categories &=3D p->arg.return_mask;

This is wrong - is_interesting() check must happen before output as
the `*end =3D addr` means the range should be skipped, but return 0
requests continuing of the walk.

> @@ -2044,7 +2050,7 @@ static int pagemap_scan_thp_entry(pmd_t *pmd,
> unsigned long start,
>          * Break huge page into small pages if the WP operation
>          * need to be performed is on a portion of the huge page.
>          */
> -       if (end !=3D start + HPAGE_SIZE) {
> +       if (end !=3D start + HPAGE_SIZE || ret =3D=3D -ENOSPC) {

Why is it needed? If `end =3D=3D start + HPAGE_SIZE` then we're handling a
full hugepage anyway.

> @@ -2066,8 +2072,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> unsigned long start,
>  {
>         struct pagemap_scan_private *p =3D walk->private;
>         struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long addr, categories, next;
>         pte_t *pte, *start_pte;
> -       unsigned long addr;
>         bool flush =3D false;
>         spinlock_t *ptl;
>         int ret;
> @@ -2088,12 +2094,14 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd,
> unsigned long start,
>         }
>
>         for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> -               unsigned long categories =3D p->cur_vma_category |
> -                       pagemap_page_category(vma, addr, ptep_get(pte));
> -               unsigned long next =3D addr + PAGE_SIZE;
> +               categories =3D p->cur_vma_category |
> +                            pagemap_page_category(vma, addr, ptep_get(pt=
e));
> +               next =3D addr + PAGE_SIZE;

Why moving the variable declarations out of the loop?

>
>                 ret =3D pagemap_scan_output(categories, p, addr, &next);
> -               if (next =3D=3D addr)
> +               if (ret =3D=3D 0 && next =3D=3D addr)
> +                       continue;
> +               else if (next =3D=3D addr)
>                         break;

Ah, this indeed was a bug. Nit:

if (next =3D=3D addr) { if (!ret) continue; break; }

> @@ -2204,8 +2212,6 @@ static const struct mm_walk_ops pagemap_scan_ops =
=3D {
>  static int pagemap_scan_get_args(struct pm_scan_arg *arg,
>                                  unsigned long uarg)
>  {
> -       unsigned long start, end, vec;
> -
>         if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))
>                 return -EFAULT;
>
> @@ -2219,22 +2225,24 @@ static int pagemap_scan_get_args(struct pm_scan_a=
rg
> *arg,
>              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATE=
GORIES)
>                 return -EINVAL;
>
> -       start =3D untagged_addr((unsigned long)arg->start);
> -       end =3D untagged_addr((unsigned long)arg->end);
> -       vec =3D untagged_addr((unsigned long)arg->vec);
> +       arg->start =3D untagged_addr((unsigned long)arg->start);
> +       arg->end =3D untagged_addr((unsigned long)arg->end);
> +       arg->vec =3D untagged_addr((unsigned long)arg->vec);

BTW, We should we keep the tag in args writeback().

>         /* Validate memory pointers */
> -       if (!IS_ALIGNED(start, PAGE_SIZE))
> +       if (!IS_ALIGNED(arg->start, PAGE_SIZE))
>                 return -EINVAL;
> -       if (!access_ok((void __user *)start, end - start))
> +       if (!access_ok((void __user *)arg->start, arg->end - arg->start))
>                 return -EFAULT;
> -       if (!vec && arg->vec_len)
> +       if (!arg->vec && arg->vec_len)
>                 return -EFAULT;
> -       if (vec && !access_ok((void __user *)vec,
> +       if (arg->vec && !access_ok((void __user *)arg->vec,
>                               arg->vec_len * sizeof(struct page_region)))
>                 return -EFAULT;
>
>         /* Fixup default values */
> +       arg->end =3D (arg->end & ~PAGE_MASK) ?
> +                  ((arg->end & PAGE_MASK) + PAGE_SIZE) : (arg->end);

arg->end =3D ALIGN(arg->end, PAGE_SIZE);

>         if (!arg->max_pages)
>                 arg->max_pages =3D ULONG_MAX;
>

Best Regards
Micha=C5=82 Miros=C5=82aw
