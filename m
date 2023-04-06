Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D56D9CC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbjDFPxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjDFPw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:52:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F7A5EB
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 08:52:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 11so2487792ejw.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680796372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf9knPLfZUMdqLMMWRJ4j4xLZDnsk3lC5W8sACtH6iI=;
        b=VabsrehnrJHFSbtYIozH/rISYmd8i0xVFw5rP8YrFwnn85L5dVU2SDqd1QecWhj8CK
         HNuKB7pzRkjJ4RBPwre79dGIh5JlANWo+CP9zPAdW96hzCJZpD3yYSE+5LX2lYH1Br3b
         uXVhLqPz/jM58PgtJ1GA4toogmdgXWyjw1qjSc6YelceLxpnZwJBWraRwLDs+7wh2OAa
         mPjhfbl1PYgxdXEmTrn8OX3HtcEJiZFCRT+fmIanQu1o503bIyyEGvUpYYSqYa6hZCNd
         j2akewJiMLvTV+rHuVj9w/XAtyJygBvlExPIeHljnMj2nXI19wJ2xdES2ODxrvDQaoza
         1VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf9knPLfZUMdqLMMWRJ4j4xLZDnsk3lC5W8sACtH6iI=;
        b=sn5ynB/IjxRDoJky2T1NI06MSSeEawsPJzlF/fOsPMbpVTvc+1ZoMO6M1MF/4i/wPq
         oDIaf6YGF35Vv2fz/Qa095mF8G98eK2JJzqjoW5hKkUTP7TsgUCj8JAv1m+8JEQTUgUE
         p22yA3bEqKimga7EyHNolNfK+4CwNG8QdIV2ydSbY5WOWo/sxJKkyb3KYP/WIVWcqEvu
         qPrIX5JEiujIe0zix1DiPe8JyV7AdqOV8BiXiBGSZUlz6pj6Jn0CYd4e5ioYuWyXx+xG
         QsmH/EcVy1N8kv0EhNviLBmxn/k3qcgK6aAlFhwBWGxlA48jIajp2VJ8KwgnCtqt0K/A
         0BKQ==
X-Gm-Message-State: AAQBX9cRhSo3lsgfaitg5FktR7p1FU1kCA6asPSnIX/fi4hdN9yAabhP
        a0C2udc1U5lP7jJUx+A37NQugEkA0zoq34TosMQGBw==
X-Google-Smtp-Source: AKy350YlsCqEiq7f7OivFYLQI4Ny+sGRtKzxTRCl4LkQnxGjzG9q3Kue6oox0flE/qLwm9jpmiAp5Wd1eN+SMl9awRQ=
X-Received: by 2002:a17:907:c80b:b0:8f5:2e0e:6def with SMTP id
 ub11-20020a170907c80b00b008f52e0e6defmr5093807ejc.0.1680796372098; Thu, 06
 Apr 2023 08:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com> <20230406074005.1784728-3-usama.anjum@collabora.com>
In-Reply-To: <20230406074005.1784728-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 6 Apr 2023 17:52:40 +0200
Message-ID: <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:>
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN)=
,
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Find pages which have been written-to and write protect the pages
>   (atomic PAGE_IS_WRITTEN + PAGEMAP_WP_ENGAGE)
>
> This IOCTL can be extended to get information about more PTE bits.
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +static inline bool is_pte_uffd_wp(pte_t pte)
> +{
> +       return ((pte_present(pte) && pte_uffd_wp(pte)) ||
> +               pte_swp_uffd_wp_any(pte));

Nit: outer parentheses are not needed for `return`ed value -- please
remove. (Same in other places.)

> @@ -1768,11 +1789,416 @@ static int pagemap_release(struct inode *inode, =
struct file *file)
>         return 0;
>  }
>
> +#define PM_SCAN_FOUND_MAX_PAGES        (1)
> +#define PM_SCAN_BITS_ALL       (PAGE_IS_WRITTEN | PAGE_IS_FILE |       \
> +                                PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> +#define PM_SCAN_OPS            (PM_SCAN_OP_GET | PM_SCAN_OP_WP)
> +#define PM_SCAN_OP_IS_WP(a)    (a->flags & PM_SCAN_OP_WP)

Nit: PM_SCAN_DO_UFFD_WP()? It would shift the hint in the name from
what op is executed to what behaviour is requested.

> +#define PM_SCAN_BITMAP(wt, file, present, swap)        \
> +       (wt | file << 1 | present << 2 | swap << 3)

Please parenthesize macro arguments ("(wt)", "(file)", etc.) to not
have to worry about operator precedence when passed a complex
expression.

I

[...]
> +static inline bool pagemap_scan_is_written_set(struct pagemap_scan_priva=
te *p)

pagemap_scan_checks_page_written? or similar 'scan is written' doesn't
seem to convey the expected intention.
The function is used only once in ..._test_walk(), so maybe just
inline, possibly using a temporary `bool` to make the condition easier
to read?

[...]

> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,

Could you try out how the code would look when passing the bitmap
instead of separate booleans?

> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned int n_pages)
> +{
[...]
> +       if ((cur->start + cur->len * PAGE_SIZE =3D=3D addr) &&
> +           (cur->bitmap =3D=3D bitmap)) {

Nit: bitmap check is cheaper, so I'd put it first. BTW, inner
parentheses are not needed here.

> +               cur->len +=3D n_pages;
> +               p->found_pages +=3D n_pages;
> +
> +               if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> +                       return PM_SCAN_FOUND_MAX_PAGES;
> +
> +               return 0;
> +       }
> +
> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {

It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
have vec_len =3D=3D 0 here, then we'd not fit the entry in the userspace
buffer anyway. Am I missing something?

> +
> +               if (cur->len) {
> +                       memcpy(&p->vec[p->vec_index], cur,
> +                              sizeof(struct page_region));
> +                       p->vec_index++;
> +               }
> +               cur->start =3D addr;
> +               cur->len =3D n_pages;
> +               cur->bitmap =3D bitmap;
> +               p->found_pages +=3D n_pages;
> +
> +               if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> +                       return PM_SCAN_FOUND_MAX_PAGES;
> +
> +               return 0;
> +       }
> +
> +       return -ENOSPC;
> +}
> +
> +static inline int pagemap_scan_deposit(struct pagemap_scan_private *p,
> +                                      struct page_region __user *vec,
> +                                      unsigned long *vec_index)

..._deposit() is used only in single place - please inline.

[...]
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       bool is_written, is_file, is_present, is_swap;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long addr =3D end;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +       pte_t *pte;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> +       if (ptl) {

Nit: `page_lock` or `pt_lock` to make it easier to guess the purpose?

> +               unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> +
> +               is_written =3D !is_pmd_uffd_wp(*pmd);
> +               is_file =3D vma->vm_file;
> +               is_present =3D pmd_present(*pmd);
> +               is_swap =3D is_swap_pmd(*pmd);
> +
> +               spin_unlock(ptl);
> +
> +               /*
> +                * Break huge page into small pages if the WP operation n=
eed to
> +                * be performed is on a portion of the huge page or if ma=
x_pages
> +                * pages limit would exceed.

BTW, could the `max_pages` limit be relaxed a bit (in that it would be
possible to return more pages if they all merge into the last vector
entry) so that it would not need to split otherwise-matching huge
page? It would remove the need for this special handling in the kernel
and splitting the page by this read-only-appearing ioctl?

> +                */
> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
> +                   ((end - start < HPAGE_SIZE) ||
> +                    (p->max_pages &&
> +                     (p->max_pages - p->found_pages) < n_pages))) {
> +
> +                       split_huge_pmd(vma, pmd, start);
> +                       goto process_smaller_pages;
> +               }
> +
> +               if (p->max_pages &&
> +                   p->found_pages + n_pages > p->max_pages)
> +                       n_pages =3D p->max_pages - p->found_pages;
> +
> +               ret =3D pagemap_scan_output(is_written, is_file, is_prese=
nt,
> +                                         is_swap, p, start, n_pages);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
> +                   uffd_wp_range(vma, start, HPAGE_SIZE, true) < 0)
> +                       ret =3D -EINVAL;

Why not propagate the error from uffd_wp_range()?

[...]
> +static long do_pagemap_cmd(struct mm_struct *mm,
> +                          struct pm_scan_arg __user *uarg)

Please rename the function to `do_pagemap_scan` as it implements just
this single ioctl now.

> +{
[...]
> +       start =3D (unsigned long)untagged_addr(arg.start);
> +       vec =3D (struct page_region *)(unsigned long)untagged_addr(arg.ve=
c);

Is the inner cast needed?

> +       ret =3D pagemap_scan_args_valid(&arg, start, vec);
> +       if (ret)
> +               return ret;
> +
> +       end =3D start + arg.len;
> +       p.max_pages =3D arg.max_pages;
> +       p.found_pages =3D 0;
> +       p.flags =3D arg.flags;
> +       p.required_mask =3D arg.required_mask;
> +       p.anyof_mask =3D arg.anyof_mask;
> +       p.excluded_mask =3D arg.excluded_mask;
> +       p.return_mask =3D arg.return_mask;
> +       p.cur.len =3D 0;
> +       p.cur.start =3D 0;
> +       p.vec =3D NULL;
> +       p.vec_len =3D (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);

Nit: parentheses are not needed here, please remove.

> +
> +       /*
> +        * Allocate smaller buffer to get output from inside the page wal=
k
> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks=
. As
> +        * we want to return output to user in compact form where no two
> +        * consecutive regions should be continuous and have the same fla=
gs.
> +        * So store the latest element in p.cur between different walks a=
nd
> +        * store the p.cur at the end of the walk to the user buffer.
> +        */
> +       p.vec =3D kmalloc_array(p.vec_len, sizeof(struct page_region),
> +                             GFP_KERNEL);
> +       if (!p.vec)
> +               return -ENOMEM;
> +
> +       walk_start =3D walk_end =3D start;
> +       while (walk_end < end && !ret) {

The loop will stop if a previous iteration returned ENOSPC (and the
error will be lost) - is it intended?

> +               p.vec_index =3D 0;
> +
> +               empty_slots =3D arg.vec_len - vec_index;
> +               p.vec_len =3D min(p.vec_len, empty_slots);
> +
> +               walk_end =3D (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_W=
ALK_MASK;
> +               if (walk_end > end)
> +                       walk_end =3D end;
> +
> +               mmap_read_lock(mm);
> +               ret =3D walk_page_range(mm, walk_start, walk_end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               if (ret && ret !=3D -ENOSPC && ret !=3D PM_SCAN_FOUND_MAX=
_PAGES)
> +                       goto free_data;
> +
> +               walk_start =3D walk_end;
> +               if (p.vec_index) {
> +                       if (copy_to_user(&vec[vec_index], p.vec,
> +                                        p.vec_index *
> +                                        sizeof(struct page_region))) {

sizeof(*p.vec) ?

> +                               ret =3D -EFAULT;
> +                               goto free_data;
> +                       }
> +                       vec_index +=3D p.vec_index;
> +               }
> +       }
> +       ret =3D pagemap_scan_deposit(&p, vec, &vec_index);
> +       if (!ret)
> +               ret =3D vec_index;
> +free_data:
> +       kfree(p.vec);
> +
> +       return ret;
> +}
> +
> +static long pagemap_scan_ioctl(struct file *file, unsigned int cmd,
> +                              unsigned long arg)
> +{
> +       struct pm_scan_arg __user *uarg =3D (struct pm_scan_arg __user *)=
arg;

This is specific to PAGEMAP_SCAN ioctl, so should go into do_pagemap_cmd().

> +       struct mm_struct *mm =3D file->private_data;
> +
> +       switch (cmd) {
> +       case PAGEMAP_SCAN:
> +               return do_pagemap_cmd(mm, uarg);
[...]
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -210,6 +210,14 @@ extern bool userfaultfd_wp_async(struct vm_area_stru=
ct *vma);
>
>  #else /* CONFIG_USERFAULTFD */
>
> +static inline long uffd_wp_range(struct mm_struct *dst_mm,
> +                                struct vm_area_struct *vma,
> +                                unsigned long start, unsigned long len,
> +                                bool enable_wp)
> +{
> +       return 0;
> +}
> +
>  /* mm helpers */
>  static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
>                                 unsigned long reason)

Shouldn't this part be in the patch introducing uffd_wp_range()?

Best Regards
Micha=C5=82 Miros=C5=82aw
