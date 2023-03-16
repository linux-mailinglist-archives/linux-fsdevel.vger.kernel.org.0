Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53CD6BDAF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCPV3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCPV3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:29:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5827BE503E
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 14:28:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so13041917edb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679002113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZZFvbISuU7Kr5YocwlUzhfQ0l5aMSfz79cHUjUmeKc=;
        b=RM/DAqsOWAj/zxIueQcKaAT7b/EK2lMTEaKAdjsqua7qiTsxOVylyThfsLzZ1UqU6z
         LvVHtbXXp4PK7o/Fzp4FJvft0BdWOP5vGIswCIddc5iZNkxRKR248bn49hPmAViJHTSA
         z5SQqSMWpzyrMwQC1NlINfevbnFR3oqMBew7UicRBwWKpnfaxew4EKZykteMCqYM7Jh6
         51/+FdPFciJS9F8dKQa7n5TPpZmOouo9qZSdFw2LNK4PQVLn9RyGEfpWkxh2Pwqcz8NM
         9wvbX7b8VsgYTn6KY780z5lVoOWrNxDA98aHlEA6804XQdbGgBHWgkwdy+LuwV1XLogE
         VwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679002113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZZFvbISuU7Kr5YocwlUzhfQ0l5aMSfz79cHUjUmeKc=;
        b=0ALxNJ3nIDS1i0mfUTXxgo/m17k92/o9q3iz1PEwLzSD4Ta2Aq4MatwePFKdNq1zzt
         V4za9LZ1EkykH7Nxk35WqUUDQOvMvp/Ud+F5fwHJCue/EZ0a1PrY8S+zMM+oQqjzsfJh
         YBCwThlJJFIv+2bAdSWATkBX2HcdQqjTRd9eGn/KwpkN0zo3++Sz2f2Gd9raEYYfEgAb
         A2Y3bJA+9tbUViGRpE+RFGhkewM3aTDCAkuRxjq4kZSSBq7UmuSjYomm6hLnDNfw5Dsq
         Kb/Oiknzbni/B8Jc5UoNkfp0kU8IYa1RwqkGn3bG3inR5kgOMshXai+r9EjRmPLgwET3
         BQlw==
X-Gm-Message-State: AO0yUKVE4BlC7zVjlgujcZpWGWRJjR1h9HUf6UrRtFAEnIeo8hqh/XqW
        HsNcRHDrRf/yRvcLPMxkq/SZOQDwIpDzK+WrWeje0Q==
X-Google-Smtp-Source: AK7set+1IXe6CyS+omuMTDBc+TM0ZSQ18QgINWOoxCmC8BVZSzV9r2xMBN928A6LqGe6I1PNdQEZl3IFCy5g7h9iilU=
X-Received: by 2002:a17:907:6e9f:b0:920:3bf5:7347 with SMTP id
 sh31-20020a1709076e9f00b009203bf57347mr476944ejc.0.1679002113272; Thu, 16 Mar
 2023 14:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com> <CABb0KFGU-jn4pCgmTK2zw0J-1-AVert4JsWF2CxgZ7LxckmWCA@mail.gmail.com>
 <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com>
In-Reply-To: <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 16 Mar 2023 22:28:21 +0100
Message-ID: <CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Mar 2023 at 18:53, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi,
>
> Thank you so much for reviewing.
>
> On 3/13/23 9:02=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 9 Mar 2023 at 14:58, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
[...]
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
[...]
> >> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool sw=
ap,
> >> +                              struct pagemap_scan_private *p,
> >> +                              unsigned long addr, unsigned int n_page=
s)
> >> +{
> >> +       unsigned long bitmap =3D PM_SCAN_BITMAP(wt, file, pres, swap);
> >> +       struct page_region *cur =3D &p->cur;
> >> +       bool cpy =3D true;
> >> +
> >> +       if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> >> +               return -ENOSPC;
> >> +
> >> +       if (!n_pages)
> >> +               return -EINVAL;
> >> +
> >> +       if (p->required_mask)
> >> +               cpy =3D ((p->required_mask & bitmap) =3D=3D p->require=
d_mask);
> >> +       if (cpy && p->anyof_mask)
> >> +               cpy =3D (p->anyof_mask & bitmap);
> >> +       if (cpy && p->excluded_mask)
> >> +               cpy =3D !(p->excluded_mask & bitmap);
> >
> > Since the rest of the code is executed only when `cpy` is true, this
> > could just return early for easier understanding.
> Hmm... I'll do the following:
>         if (!cpy || !bitmap)
>                 return 0;
> > BTW, some of the tests are redundant. Eg: if required_mask =3D=3D 0, th=
en
> > `required_mask & x =3D=3D required_mask` will always hold. Same for
> > `excluded_mask & x =3D=3D 0`.
> Correct. This is why I'm checking if required_mask is set and then
> comparing bitmap with it. required_mask may be 0 if not set. This if will
> ignore the subsequent check.
>
>         if (p->required_mask)
>                 cpy =3D ((p->required_mask & bitmap) =3D=3D p->required_m=
ask);
>
> I don't see any redundancy here. Please let me know otherwise?
[...]
> >> +       if (cpy && bitmap) {
> >
> > Assuming early returns on `!cpy` are done earlier:
> >
> > if (!bitmap)
> >   return 0;
> I've posted condition above which would better suit here.
[...]

Since the `cpy` condition is updated and passed to each new branch
(IOW: after setting cpy =3D 0 for whatever reason all the further code
is skipped) you can drop the variable and do early returns everywhere.
E.g.:

if ((bitmap & p->required_mask) !=3D p->required_mask)
  return 0;
if (p->anyof_mask && !(bitmap & p->anyof_mask))
  return 0;
if (bitmap & p->excluded_mask)
  return 0;
if (!bitmap)
  return 0;

Also you can take the "special" effect of masking with zero to be
always zero (and in C - false) to avoid testing for an empty mask
separately in most cases.

> Just for my knowledge, what does "Nit" signify if a comment is marked wit=
h it?

A low priority / cosmetic item that you might consider ignoring if a
fix is too expensive or controversial.

>> +               if ((cur->len) && (cur->bitmap =3D=3D bitmap) &&
>> +                   (cur->start + cur->len * PAGE_SIZE =3D=3D addr)) {
>
> I'd recommend removing the extra parentheses as they make the code
> less readable for me (too many parentheses to match visually).
I'll remove parenthesis.

[...]
>> The `cur->len` test seems redundant: is it possible to have
>> `cur->start =3D=3D addr` in that case (I guess it would have to get
>> `n_pages =3D=3D 0` in an earlier invocation)?
> No, both wouldn't work. cur->len =3D=3D 0 means that it has only garbage.=
 It is
> essential to check the validity from cur->len before performing other
> checks. Also cur->start can never be equal to addr as we are walking over
> page addressing in serial manner. We want to see here if the current
> address matches the previous data by finding the ending address of last
> stored data (cur->start + cur->len * PAGE_SIZE).

If cur->len =3D=3D 0, then it doesn't matter if it gets merged or not - it
can be filtered out during the flush (see below).

[...]
> >> +               } else if ((!p->vec_index) ||
> >> +                          ((p->vec_index + 1) < p->vec_len)) {
> >
> > Can you explain this test? Why not just `p->vec_index < p->vec_len`? Or=
 better:
> >
> > if (vec_index >=3D p->vec_len)
> >     return -ENOSPC;
>
> No, it'll not work. Lets leave it as it is. :)
>
> It has gotten somewhat complex, but I don't have any other way to make it
> simpler which works. First note the following points:
> 1) We walk over 512 page or 1 thp at a time to not over allocate memory i=
n
> kernel (p->vec).
> 2) We also want to merge the consecutive pages with the same flags into o=
ne
> struct page_region. p->vec of current walk may merge with next walk. So w=
e
> cannot write to user memory until we find the results of the next walk.
>
> So most recent data is put into p->cur. When non-intersecting or mergeabl=
e
> data is found, we move p->cur to p->vec[p->index] inside the page walk.
> After the page walk, p->vec[0 to p->index] is moved to arg->vec. After al=
l
> the walks are over. We move the p->cur to arg->vec. It completes the data
> transfer to user buffer.
[...]
> I'm so sorry that it has gotten this much complex. It was way simpler whe=
n
> we were walking over all the memory in one go. But then we needed an
> unbounded memory from the kernel which we don't want.
[...]

I've gone through and hopefully understood the code. I'm not sure this
needs to be so complicated: when traversing a single PMD you can
always copy p->cur to p->vec[p->vec_index++] because you can have at
most pages_per_PMD non-merges (in the worst case the last page always
is left in p->cur and whole p->vec is used). After each PMD p->vec
needs a flush if p->vec_index > 0, skipping the dummy entry at front
(len =3D=3D 0; if present). (This is mostly how it is implemented now, but
I propose to remove the "overflow" check and do the starting guard
removal only every PMD.)

BTW, the pagemap_scan_deposit() got me a bit confused: it seems that
it is just a copy of the p->vec flush to userspace. Please either use
it for both p->vec and p->cur flushing or inline.

BTW#2, I think the ENOSPC return in pagemap_scan_output() should
happen later - only if the pages would match and that caused the count
to exceed the limit. For THP n_pages should be truncated to the limit
(and ENOSPC returned right away) only after the pages were verified to
match.

[...]
> >> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >> +                                 unsigned long end, struct mm_walk *w=
alk)
> >> +{
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +       bool is_writ, is_file, is_pres, is_swap;
> >> +       unsigned long addr =3D end;
> >> +       spinlock_t *ptl;
> >> +       int ret =3D 0;
> >> +       pte_t *pte;
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >
> > Is the `#ifdef` needed? `pmd_trans_huge_lock()` will always return
> > NULL if transparent hugepages are not compiled in. OTOH I see
> > BUILD_BUG() is possible in HPAGE_SIZE definition (irrelevant in this
> > case), so that would need to be worked around first.
> I'd got the build error [1]. So I'd added these. I've tested it again wit=
h
> the same config. We don't need these #ifdef now. I'll remove these.

I mean that there are cases like [1] that actually need the #ifdef at
least to wrap HPAGE_SIZE usage. But maybe just this constant can be
wrapped so that we keep the code always compile-tested?

[1] https://elixir.bootlin.com/linux/v6.3-rc2/source/arch/mips/include/asm/=
page.h#L66

[...]
> >> +       if (!arg->required_mask && !arg->anyof_mask &&
> >> +           !arg->excluded_mask)
> >> +               return false;
> >
> > Is there an assumption in the code that those checks are needed? I'd
> > expect that no selection criteria makes a valid page set?
> In my view, selection criterion must be specified for the ioctl to work. =
If
> there is no criterio, user should go and read pagemap file directly. So t=
he
> assumption is that at least one selection criterion must be specified.

Yes. I'm not sure we need to prevent multiple ways of doing the same
thing. But doesn't pagemap reading lack the range aggregation feature?

[...]
> >> +       if (!access_ok((void __user *)vec,
> >> +                      arg->vec_len * sizeof(struct page_region)))
> >> +               return false;
> >
> > Is there a provision that userspace threads are all blocked from
> > manipulating mmaps during this ioctl()? If not, this is a TOCTOU bug
> > and the writes should be checked each time as another userspace thread
> > could remap the memory while the ioctl() is working.
> mincore() syscall is doing in the same way. It checks the validity in the
> start only. What provision should I add? Isn't it obvious that the user
> should not remap such memory?

On the second look, I think the code already checks that while doing
copy_to_user(), so this check is redundant and can be removed.

> >
> >> +       if (!IS_ALIGNED(start, PAGE_SIZE))
> >> +               return false;
> >> +       if (!access_ok((void __user *)start, arg->len))
> >> +               return false;
> >
> > This I guess wants to check if the range to be scanned is mapped -
> > but isn't this what the ioctl() should do during the scan? (But, also
> > see above.)
> No, start represents the memory which the user wants to watch. User must
> allocate this memory first and then pass the address to this ioctl to fin=
d
> out the flags per page.

From:
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:              Size of the structure
+ * @flags:             Flags for the IOCTL
+ * @start:             Starting address of the region
+ * @len:               Length of the region (All the pages in this
length are included)
...

I'd expect the `start` field to just be a virtual address to start
scanning from. Does it need to be mapped? For CRIU usecase I'd start
with "start =3D 0" to find out all mappings, but 0 is (always) not
mapped. Is this supposed to only work on already discovered page
ranges? Anyway, I'd expect the code should be tolerant of another
thread changing the mappings while this ioctl() is walking the page
tables - is it so? If yes, then this check serves at most as an
optimization used only for an invalid call.

> >>  const struct file_operations proc_pagemap_operations =3D {
> >>         .llseek         =3D mem_lseek, /* borrow this */
> >>         .read           =3D pagemap_read,
> >>         .open           =3D pagemap_open,
> >>         .release        =3D pagemap_release,
> >> +       .unlocked_ioctl =3D pagemap_scan_ioctl,
> >> +       .compat_ioctl   =3D pagemap_scan_ioctl,
> >
> > Is this correct? Would the code need a different userspace pointer
> > handling for 32-bit userspace on 64-bit kernel?
> Yeah, it is needed for 32-bit application to run on 64-bit kernel.

I mean is using the same function for both entry points correct? Don't
the pointers to userspace memory (e.g. arg->vec) need to be mapped for
32-bit process?

Best Regards

Micha=C5=82 Miros=C5=82aw
