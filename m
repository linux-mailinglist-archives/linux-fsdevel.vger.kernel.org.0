Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95BF6DA216
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjDFUAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjDFUAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:00:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAF83D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 13:00:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-93071f06be3so154205566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680811231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd8CdG3tEyTpIem9NcMLhqsCDudYGnSaMV+QuQk/dn4=;
        b=X4NUYQQ8tCMLj8AsQ8A5D4O8WA+9or8X/KsR9JSOcXURexcxASRc1DPuMazArWdvdL
         lUzUodCfxZvgm5B+QFxLSw4orBW/OEc/RN4ERtKalF5HQMavPlwYQo5Q/9DzJZNUpCVM
         K00Wqe0Ul4ceSlAjKKHwmpP6SdKfH4QI9Z5BJkZaK1io4pl/W48EXr8EmoplS/pe9duQ
         YQaYhBejj95Vdp/MwjPg+4+aXcOkS8LSYNOJwphruff0KlwSE3bNar6tN5p7UpqB7T2k
         Dsat8SCV9mzgVh5HaOVfWDb2gvq/bVgDJ7vfIKoqyTd8xTDwGYeFhcgcQkiF11tcLUPe
         O9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd8CdG3tEyTpIem9NcMLhqsCDudYGnSaMV+QuQk/dn4=;
        b=E3Y5+mjw9dkKAvRhlds2kYu6pjzzGsFrc0mGwG4I0TseHKd98j2tm1gsmkJ4FGs9zZ
         FK46SZzmmDrqET08BuoXD2hoZayRALiRPg5caEuj8aKspOhCJECAJeei3Le2vV4rBj1u
         8HzOPr1Cs69pI1xREXH1B8n/KXFf8DTcD0eJRYjOCmiDe5D46KFLF5o5uOM5piY4MzbA
         2nkrhHEW9/52IzPMy6g19ZMDMJEgFq4fyc2SrAMynmnMUtSftSr+5Kqg7+oTsGHUUCbp
         pE6IoedkYMzqVntLJpY2foJVsRQ779BUySoiVKFtUIbFp7KW3VkW+OdhlnDCdvbotxGY
         lfjQ==
X-Gm-Message-State: AAQBX9cEY4r/znQaGXdv6Cn/NyFdXq+K5v3/AzWyXUO5zyoplMycoddC
        XLn8BMxe+5vArB6iTILaYAUI/neEegwNxgeg9dMQQQ==
X-Google-Smtp-Source: AKy350YxLmM7o7NofjNZI1FB3oHxtUqQdNjHp/dOLN89IbILs8acbig6vzBtiMi0F7gjm5VWa5NlgYP2dj9nUNUL3so=
X-Received: by 2002:a50:9987:0:b0:504:7094:2b59 with SMTP id
 m7-20020a509987000000b0050470942b59mr373316edb.7.1680811231205; Thu, 06 Apr
 2023 13:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com>
In-Reply-To: <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 6 Apr 2023 22:00:19 +0200
Message-ID: <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
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

On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> Hello,
>
> Thank you so much for the review. Do you have any thoughts on the build
> error on arc architecture?
> https://lore.kernel.org/all/e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabor=
a.com

Maybe copy HPAGE_* defines from x86 and key on CONFIG_PGTABLE_LEVELS >
2? I don't know much about arc arch, though.

> On 4/6/23 8:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:>
[...]
> >> +#define PM_SCAN_BITMAP(wt, file, present, swap)        \
> >> +       (wt | file << 1 | present << 2 | swap << 3)
> > Please parenthesize macro arguments ("(wt)", "(file)", etc.) to not
> > have to worry about operator precedence when passed a complex
> > expression.
> Like this?
> #define PM_SCAN_BITMAP(wt, file, present, swap) \
>         ((wt) | (file << 1) | (present << 2) | (swap << 3))

The value would be:
 ( (wt) | ((file) << 1) | ... )
IOW, each parameter should have parentheses around its name.

[...]
> >> +               cur->len +=3D n_pages;
> >> +               p->found_pages +=3D n_pages;
> >> +
> >> +               if (p->max_pages && (p->found_pages =3D=3D p->max_page=
s))
> >> +                       return PM_SCAN_FOUND_MAX_PAGES;
> >> +
> >> +               return 0;
> >> +       }
> >> +
> >> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {
> >
> > It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
> > have vec_len =3D=3D 0 here, then we'd not fit the entry in the userspac=
e
> > buffer anyway. Am I missing something?
> No. I'd explained it with diagram last time:
> https://lore.kernel.org/all/3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabor=
a.com
>
> I'll add a concise comment here.

So it seems, but I think the code changed a bit and maybe could be
simplified now? Since p->vec_len =3D=3D 0 is currently not valid, the
field could count only the entries available in p->vec[] -- IOW: not
include p->cur in the count.

BTW, `if (no space) return -ENOSPC` will avoid additional indentation
for the non-merging case.

[...]
> >> +static inline int pagemap_scan_deposit(struct pagemap_scan_private *p=
,
> >> +                                      struct page_region __user *vec,
> >> +                                      unsigned long *vec_index)
> >
> > ..._deposit() is used only in single place - please inline.
> It is already inline.

Sorry. I mean: please paste the code in place of the single call.

[...]
> >> +               /*
> >> +                * Break huge page into small pages if the WP operatio=
n need to
> >> +                * be performed is on a portion of the huge page or if=
 max_pages
> >> +                * pages limit would exceed.
> >
> > BTW, could the `max_pages` limit be relaxed a bit (in that it would be
> > possible to return more pages if they all merge into the last vector
> > entry) so that it would not need to split otherwise-matching huge
> > page? It would remove the need for this special handling in the kernel
> > and splitting the page by this read-only-appearing ioctl?
> No, this cannot be done. Otherwise we'll not be able to emulate Windows
> syscall GetWriteWatch() which specifies the exact number of pages. Usuall=
y
> in most of cases, either user will not use THP or not perform the operati=
on
> on partial huge page. So this part is only there to keep things correct f=
or
> those users who do use THP and partial pagemap_scan operations.

I see that `GetWriteWatch` returns a list of pages not ranges of
pages. That makes sense (more or less). (BTW, It could be emulated in
userspace by caching the last not-fully-consumed range.)

> >> +                */
> >> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
> >> +                   ((end - start < HPAGE_SIZE) ||
> >> +                    (p->max_pages &&
> >> +                     (p->max_pages - p->found_pages) < n_pages))) {
> >> +
> >> +                       split_huge_pmd(vma, pmd, start);
> >> +                       goto process_smaller_pages;
> >> +               }
> >> +
> >> +               if (p->max_pages &&
> >> +                   p->found_pages + n_pages > p->max_pages)
> >> +                       n_pages =3D p->max_pages - p->found_pages;
> >> +
> >> +               ret =3D pagemap_scan_output(is_written, is_file, is_pr=
esent,
> >> +                                         is_swap, p, start, n_pages);
> >> +               if (ret < 0)
> >> +                       return ret;

So let's simplify this:

if (p->max_pages && n_pages > max_pages - found_pages)
  n_pages =3D max_pages - found_pages;

if (is_written && DO_WP && n_pages !=3D HPAGE_SIZE / PAGE_SIZE) {
  split_thp();
  goto process_smaller_pages;
}

BTW, THP handling could be extracted to a function that would return
-EAGAIN if it has split the page or it wasn't a THP -- and that would
mean `goto process_smaller_pages`.

> > Why not propagate the error from uffd_wp_range()?
> uffd_wp_range() returns status in long variable. We cannot return long in
> this function. So intead of type casting long to int and then return I've
> used -EINVAL. Would following be more suitable?
>
> long ret2 =3D uffd_wp_range(vma, start, HPAGE_SIZE, true);
> if (ret2 < 0)
>         return (int)ret2;

I think it's ok, since negative values are expected to be error codes.
And since you can't overflow int with HPAGE_SIZE pages, then I
wouldn't use `ret2` but cast the return and add a comment why it's
safe.

[...]
> >> +       start =3D (unsigned long)untagged_addr(arg.start);
> >> +       vec =3D (struct page_region *)(unsigned long)untagged_addr(arg=
.vec);
> >
> > Is the inner cast needed?
> arg.vec remains 64-bit on 32-bit systems. So casting 64bit value directly
> to struct page_region pointer errors out. So I've added specific casting =
to
> unsigned long first before casting to pointers.

I see. So to convey the intention, the `arg.start` and `arg.vec`
should be casted to unsigned long, not the `untagged_addr()` return
values.

> >> +       ret =3D pagemap_scan_args_valid(&arg, start, vec);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       end =3D start + arg.len;
> >> +       p.max_pages =3D arg.max_pages;
> >> +       p.found_pages =3D 0;
> >> +       p.flags =3D arg.flags;
> >> +       p.required_mask =3D arg.required_mask;
> >> +       p.anyof_mask =3D arg.anyof_mask;
> >> +       p.excluded_mask =3D arg.excluded_mask;
> >> +       p.return_mask =3D arg.return_mask;
> >> +       p.cur.len =3D 0;
> >> +       p.cur.start =3D 0;
> >> +       p.vec =3D NULL;
> >> +       p.vec_len =3D (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
> >
> > Nit: parentheses are not needed here, please remove.
> Will do.
>
> >
> >> +
> >> +       /*
> >> +        * Allocate smaller buffer to get output from inside the page =
walk
> >> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chu=
nks. As
> >> +        * we want to return output to user in compact form where no t=
wo
> >> +        * consecutive regions should be continuous and have the same =
flags.
> >> +        * So store the latest element in p.cur between different walk=
s and
> >> +        * store the p.cur at the end of the walk to the user buffer.
> >> +        */
> >> +       p.vec =3D kmalloc_array(p.vec_len, sizeof(struct page_region),
> >> +                             GFP_KERNEL);
> >> +       if (!p.vec)
> >> +               return -ENOMEM;
> >> +
> >> +       walk_start =3D walk_end =3D start;
> >> +       while (walk_end < end && !ret) {
> >
> > The loop will stop if a previous iteration returned ENOSPC (and the
> > error will be lost) - is it intended?
> It is intentional. -ENOSPC means that the user buffer is full even though
> there was more memory to walk over. We don't treat this error. So when
> buffer gets full, we stop walking over further as user buffer has gotten
> full and return as success.

Thanks. What's the difference between -ENOSPC and
PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
flow).

[...]
> >> --- a/include/linux/userfaultfd_k.h
> >> +++ b/include/linux/userfaultfd_k.h
> >> @@ -210,6 +210,14 @@ extern bool userfaultfd_wp_async(struct vm_area_s=
truct *vma);
> >>
> >>  #else /* CONFIG_USERFAULTFD */
> >>
> >> +static inline long uffd_wp_range(struct mm_struct *dst_mm,
> >> +                                struct vm_area_struct *vma,
> >> +                                unsigned long start, unsigned long le=
n,
> >> +                                bool enable_wp)
> >> +{
> >> +       return 0;
> >> +}
[...]
> > Shouldn't this part be in the patch introducing uffd_wp_range()?
> We have not added uffd_wp_range() in previous patches. We just need this
> stub for this patch for the case when CONFIG_USERFAULTFD isn't enabled.
>
> I'd this as separate patch before this patch. Mike asked me to merge it
> with this patch in order not to break bisectability.
>[1] https://lore.kernel.org/all/ZBK+86eMMazwfhdx@kernel.org

I would understand the reply [1] to mean that the uffd_wp_range() stub
should go in the same patch where uffd_wp_range() is implemented. But
uffd_wp_range() is already in (since f369b07c86140) so I don't see how
having the stub in a separate commit sequenced before this one could
break bisect?

Best Regards
Micha=C5=82 Miros=C5=82aw
