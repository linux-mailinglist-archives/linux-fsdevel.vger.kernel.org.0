Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D973067F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjFNSAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjFNSAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:00:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE410E9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 11:00:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso1142a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686765630; x=1689357630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgxJlLA8wLn/M0aAHTm/1/LrgoyOzeZsPSKgsschXV8=;
        b=PWFmQmN98IB62twE2ZU+8m/C/KOvlENeQx/4VYYwQSk4EI3Ii4ll5KzI1JKLeJ4Ef4
         qX64TsKn9VfLtprU93X96UtDc7rwUlDkJeChFBv0tiLQQY0Hj9KrSJhLhIyl7NfI+6mM
         9lN3g7xv7vIUXpHMoM0iOkvwU779rc7tjxg8mbTF6HTDUj5oV5O87RP6hVn7QvXm/tD3
         3bEzTb33hGiuNA10HMvsGmWtZAi3ZRjev56jROLxTGZHNOgZT6G1VAbrK4wMHvYP8eC8
         VI3oYYBQqo5V4zk9PYPUleqgiLkKLGvqhivf4S4ONcsjpYyoPFQ0Qyq/bVKL0RnBpdqC
         6EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765630; x=1689357630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgxJlLA8wLn/M0aAHTm/1/LrgoyOzeZsPSKgsschXV8=;
        b=hyyn2ggxeD3M+f0ad1lwAQM4QhjzmoEmScanGEhe1lFwKfrRyUt2erj6PhM4+0f4pG
         +LgmWPKGLe7/iT1YhYZQGpMCrCYkv7DSbhfJlZD8+vEPcGgwFXn3Z+a0oOLvHYQGih8m
         WqjoHU8ua09qIiUR6AfG7bFps/GJm3R5eRowfRfK0TgI+SRSQYKb4sowP4+kwxxBuDVs
         6vcdIsYQbZwhwVR+Od3r0pwryCUYCSKvDh2fQY8PHqhGJQ25i3m0P1PIlLRGZwIaZBQd
         fi6qzzoUeGZbdzDtn5s8ZVGFCYMbPBItlHOQ62p9yyQVXAfddWIIKmUELJBaemeAheJU
         tUaQ==
X-Gm-Message-State: AC+VfDxQWNd2pJU3s21cQMi1Oc/e4v4maGhVg09YdGsBTsMMNNj54NDU
        FjOzCM0v3zBZB9Xky/tEbOkqMrKf4Ld7PqMPK2jOXw==
X-Google-Smtp-Source: ACHHUZ54WuluU7EgpzhjBSJClrf7OTSFZ7FwHmH45AFMEak4zwz7jxM7srJNVGtkYL6NsNcglFQGcHERY54JY8l3kW4=
X-Received: by 2002:a50:9b17:0:b0:51a:1d77:e69d with SMTP id
 o23-20020a509b17000000b0051a1d77e69dmr2540edi.3.1686765630113; Wed, 14 Jun
 2023 11:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com>
In-Reply-To: <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 14 Jun 2023 20:00:18 +0200
Message-ID: <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
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

(A quick reply to answer open questions in case they help the next version.=
)

On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/14/23 8:14=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 6/14/23 3:36=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
[...]
> >>>> +       if (cur_buf->bitmap =3D=3D bitmap &&
> >>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D addr) {
> >>>> +               cur_buf->len +=3D n_pages;
> >>>> +               p->found_pages +=3D n_pages;
> >>>> +       } else {
> >>>> +               if (cur_buf->len && p->vec_buf_index >=3D p->vec_buf=
_len)
> >>>> +                       return -ENOMEM;
> >>>
> >>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kernel
> >>> ran out of memory when allocating, not that there is no space in a
> >>> user-provided buffer.
> >> There are 3 kinds of return values here:
> >> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort th=
e
> >> page walk from next entry
> >> * 0 ---> continue the page walk
> >> * -ENOMEM --> Abort the page walk from current entry, user buffer is f=
ull
> >> which is not error, but only a stop signal. This -ENOMEM is just
> >> differentiater from (1). This -ENOMEM is for internal use and isn't
> >> returned to user.
> >
> > But why ENOSPC is not good here? I was used before, I think.
> -ENOSPC is being returned in form of true error from
> pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as it
> wasn't true error here, it was only a way to abort the walk immediately.
> I'm liking the following erturn code from here now:
>
> #define PM_SCAN_BUFFER_FULL     (-256)

I guess this will be reworked anyway, but I'd prefer this didn't need
custom errors etc. If we agree to decoupling the selection and GET
output, it could be:

bool is_interesting_page(p, flags); // this one does the
required/anyof/excluded match
size_t output_range(p, start, len, flags); // this one fills the
output vector and returns how many pages were fit

In this setup, `is_interesting_page() && (n_out =3D output_range()) <
n_pages` means this is the final range, no more will fit. And if
`n_out =3D=3D 0` then no pages fit and no WP is needed (no other special
cases).

> >>> For flags name: PM_REQUIRE_WRITE_ACCESS?
> >>> Or Is it intended to be checked only if doing WP (as the current name
> >>> suggests) and so it would be redundant as WP currently requires
> >>> `p->required_mask =3D PAGE_IS_WRITTEN`?
> >> This is intended to indicate that if userfaultfd is needed. If
> >> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
> >> userfaultfd has been initialized for this memory. I'll rename to
> >> PM_SCAN_REQUIRE_UFFD.
> >
> > Why do we need that check? Wouldn't `is_written =3D false` work for vma=
s
> > not registered via uffd?
> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory regio=
n
> for it to report correct written values on the memory region. Without UFF=
D
> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP stat=
e
> undefined. If user hasn't initialized memory with UFFD, he has no right t=
o
> set is_written =3D false.

How about calculating `is_written =3D is_uffd_registered() &&
is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
address space of a process regardless of whether all of it is
registered.

> > While here, I wonder if we really need to fail the call if there are
> > unknown bits in those masks set: if this bit set is expanded with
> > another category flags, a newer userspace run on older kernel would
> > get EINVAL even if the "treat unknown as 0" be what it requires.
> > There is no simple way in the API to discover what bits the kernel
> > supports. We could allow a no-op (no WP nor GET) call to help with
> > that and then rejecting unknown bits would make sense.
> I've not seen any examples of this. But I've seen examples of returning
> error if kernel doesn't support a feature. Each new feature comes with a
> kernel version, greater than this version support this feature. If user i=
s
> trying to use advanced feature which isn't present in a kernel, we should
> return error and not proceed to confuse the user/kernel. In fact if we lo=
ok
> at userfaultfd_api(), we return error immediately if feature has some bit
> set which kernel doesn't support.

I think we should have a way of detecting the supported flags if we
don't want a forward compatibility policy for flags here. Maybe it
would be enough to allow all the no-op combinations for this purpose?

> >>> [...]
> >>>> --- a/include/uapi/linux/fs.h
> >>>> +++ b/include/uapi/linux/fs.h
> >>>> +/*
> >>>> + * struct page_region - Page region with bitmap flags
> >>>> + * @start:     Start of the region
> >>>> + * @len:       Length of the region in pages
> >>>> + * bitmap:     Bits sets for the region
> >>>
> >>> '@' is missing for the third field. BTW, maybe we can call it
> >>> something like `flags` or `category` (something that hints at the
> >>> meaning of the value instead of its data representation).
> >> The deification of this struct says, "with bitmap flags". Bitmap was a
> >> different name. I'll update it to flags.
> >
> > From the implementation and our discussions I guess the
> > `bitmap`/`flags` field is holding a set of matching categories: a bit
> > value 1 =3D pages are in this category, value 0 =3D pages are not in th=
is
> > category.
> >
> >>>> +/*
> >>>> + * struct pm_scan_arg - Pagemap ioctl argument
> >>>> + * @size:              Size of the structure
> >>>> + * @flags:             Flags for the IOCTL
> >>>> + * @start:             Starting address of the region
> >>>> + * @len:               Length of the region (All the pages in this =
length are included)
> >>>
> >>> Maybe `scan_start`, `scan_len` - so that there is a better distinctio=
n
> >>> from the structure's `size` field?
> >> As start and len already communicate the meaning. We are making things=
 more
> >> verbose.
> >
> > We are describing (in the name) only that it is a range, but not of
> > what or what purpose. That information is only in the docstring, but
> > it is harder to get by someone just reading the code.
> Agreed. But I'm using same names, start and len which mincore (a historic
> syscall) is using. I've followed mincore here.

mincore() doesn't take parameters as a struct, but as three positional
arguments (whose names don't matter nor appear at call point) - I
wouldn't take it as a precedent for structure field naming.

> >>>> + * @vec:               Address of page_region struct array for outp=
ut
> >>>> + * @vec_len:           Length of the page_region struct array
> >>>> + * @max_pages:         Optional max return pages
> >>>> + * @required_mask:     Required mask - All of these bits have to be=
 set in the PTE
> >>>> + * @anyof_mask:                Any mask - Any of these bits are set=
 in the PTE
> >>>> + * @excluded_mask:     Exclude mask - None of these bits are set in=
 the PTE
> >>>> + * @return_mask:       Bits that are to be reported in page_region
> >>>> + */
> >>>
> >>> I skipped most of the page walk implementation as maybe the comments
> >>> above could make it simpler. Reading this patch and the documentation
> >>> I still feel confused about how the filtering/limiting parameters
> >> I'm really sad to hear this. I've been working on making this series f=
rom
> >> so many revisions. I was hopping that it would make complete sense to
> >> reviewers and later to users.
> >>
> >> What do you think is missing which is restricting these patches gettin=
g
> >> accepted to upstream?
> >>
> >>> should affect GET, WP and WP+GET. Should they limit the pages walked
> >>> (and WP-ed)? Or only the GET's output? How about GET+WP case?
> >> The address range needs to be walked until max pages pages are found, =
user
> >> buffer is full or whole range is walked. If the page will be added to =
user
> >> buffer or not depends on the selection criteria (*masks). There is no
> >> difference in case of walk for GET, WP and GET+WP. Only that WP doesn'=
t
> >> take any user buffer and just WPs the whole region.
> >
> > Ok, then this intent (if I understand correctly) does not entirely
> > match the implementation. Let's split up the conditions:
> >
> > 1. The address range needs to be walked until max pages pages are found
> >
> > current implementation: the address range is walked until max pages
> > matching masks (incl. return_mask) are reported by GET (or until end
> > of range if GET is not requested).
> > Maybe we need to describe what "found" means here?
> Found means all the pages which are found to be fulfilling the masks and =
we
> have added it to the user buffer. I can add the comment on top of
> pagemap_scan_private struct? But I don't think that it is difficult to
> understand the meaning of found_pages and also we compare it with max_pag=
es
> which makes things very easy to understand.

After fixing `return_mask` and the selection/action split I think
"pages found" might work - as now the count will be exactly what pages
match the required/anyof/excluded criteria.

> > 2. user buffer is full
> > Matches implementation except in GET+WP edge cases.
> I'm not sure which edge case you are referring to? Probably for hugetlb
> error return case?

Yes, that one.

Best Regards
Micha=C5=82 Miros=C5=82aw
