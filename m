Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06B731BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjFOOxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbjFOOxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:53:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FD92972
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:52:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so10788a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686840772; x=1689432772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAtbfG4Aoz6kytomR9wtfMXX6I18hQsyqyJIKoo2vmA=;
        b=fSrJpGcgZ1ZKV9qgO5cMqf4m56iOHhDAXNSThI8B74HnDj6UMjTgbDzZIZyjvQnY1R
         Xx6Tmc+iE/57/HuVGRFuPzB2i0L12QwzPzKCZNA2ciwXSqdQl/qEfZE9YBrWGPyZbsSG
         ygi3lzfzXYwxvRLZHugqOgNwrHLSKy83i+DZrYSeezi22l9n0NFXgc0KZ/iA7Jt3G0KF
         RIVYIOILg36nVZoVgUXU7ykY/lcVDSe+jUG8VB57jbA1yskBDyzbLNLfsFIUWguSHTn+
         kdzFJ9+pj/k2yf/PW6pBgk+D3zHo04G0Uw28QJMadK/qeBo4aHSDyJBeR2fS2rVY0GKt
         yXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840772; x=1689432772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAtbfG4Aoz6kytomR9wtfMXX6I18hQsyqyJIKoo2vmA=;
        b=XCMo/f04SoGHJ76PlL+IyilYBOvYpS26Syh/XYU1RT978Pgi1AkkMoI+ujSKmvCQVT
         9oTsv1Y9ypVAUjmx66rD8VYbazlB251Huv2tuf0h7NkBCZ+kCvtUaWY7m8UYnU2mVpSY
         Bc30D1H6nIjjRHaV8dH0eHvWXLaragqJQz3amj9BC7AHKI4ZNaU5q+fTBSWP+7JS+qQL
         1FlyqSaE8cXqsKXwJoA2NDsuIPu7N7SZwkTOMka5WFEftvkiNhoqAsv8avxOwFfnfs2v
         4nrQWnR/9sgvxu75IYC485VV2tERfdcw5WQboyemFp8ATZxamo5xB0kQS35HowlEs8Vv
         IKNg==
X-Gm-Message-State: AC+VfDyDYLAEKwy114zvsLDWMgsNaTRy8xWlFFpp5y0FabgiUYhbGjY1
        ssW+IdAIDkw7GqEBsAsix1cg7IZ+4pa6IQ8Pju4N+g==
X-Google-Smtp-Source: ACHHUZ67CknraQiNFeWTHQxsI/pD93j9Z/IG8HHMp+oyBmBPrD3SOWlFDPxALG/rqwNKAAJWPgK3+biNNXtJMfLIvgs=
X-Received: by 2002:a50:d681:0:b0:514:95d4:c2bb with SMTP id
 r1-20020a50d681000000b0051495d4c2bbmr114787edi.2.1686840772093; Thu, 15 Jun
 2023 07:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com>
In-Reply-To: <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 15 Jun 2023 16:52:40 +0200
Message-ID: <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
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

On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> I'll send next revision now.
> On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > (A quick reply to answer open questions in case they help the next vers=
ion.)
> >
> > On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 6/14/23 8:14=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>>
> >>>> On 6/14/23 3:36=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> > [...]
> >>>>>> +       if (cur_buf->bitmap =3D=3D bitmap &&
> >>>>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D addr)=
 {
> >>>>>> +               cur_buf->len +=3D n_pages;
> >>>>>> +               p->found_pages +=3D n_pages;
> >>>>>> +       } else {
> >>>>>> +               if (cur_buf->len && p->vec_buf_index >=3D p->vec_b=
uf_len)
> >>>>>> +                       return -ENOMEM;
> >>>>>
> >>>>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the kerne=
l
> >>>>> ran out of memory when allocating, not that there is no space in a
> >>>>> user-provided buffer.
> >>>> There are 3 kinds of return values here:
> >>>> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abort =
the
> >>>> page walk from next entry
> >>>> * 0 ---> continue the page walk
> >>>> * -ENOMEM --> Abort the page walk from current entry, user buffer is=
 full
> >>>> which is not error, but only a stop signal. This -ENOMEM is just
> >>>> differentiater from (1). This -ENOMEM is for internal use and isn't
> >>>> returned to user.
> >>>
> >>> But why ENOSPC is not good here? I was used before, I think.
> >> -ENOSPC is being returned in form of true error from
> >> pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as it
> >> wasn't true error here, it was only a way to abort the walk immediatel=
y.
> >> I'm liking the following erturn code from here now:
> >>
> >> #define PM_SCAN_BUFFER_FULL     (-256)
> >
> > I guess this will be reworked anyway, but I'd prefer this didn't need
> > custom errors etc. If we agree to decoupling the selection and GET
> > output, it could be:
> >
> > bool is_interesting_page(p, flags); // this one does the
> > required/anyof/excluded match
> > size_t output_range(p, start, len, flags); // this one fills the
> > output vector and returns how many pages were fit
> >
> > In this setup, `is_interesting_page() && (n_out =3D output_range()) <
> > n_pages` means this is the final range, no more will fit. And if
> > `n_out =3D=3D 0` then no pages fit and no WP is needed (no other specia=
l
> > cases).
> Right now, pagemap_scan_output() performs the work of both of these two
> functions. The part can be broken into is_interesting_pages() and we can
> leave the remaining part as it is.
>
> Saying that n_out < n_pages tells us the buffer is full covers one case.
> But there is case of maximum pages have been found and walk needs to be
> aborted.

This case is exactly what `n_out < n_pages` will cover (if scan_output
uses max_pages properly to limit n_out).
Isn't it that when the buffer is full we want to abort the scan always
(with WP if `n_out > 0`)?

> >>>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
> >>>>> Or Is it intended to be checked only if doing WP (as the current na=
me
> >>>>> suggests) and so it would be redundant as WP currently requires
> >>>>> `p->required_mask =3D PAGE_IS_WRITTEN`?
> >>>> This is intended to indicate that if userfaultfd is needed. If
> >>>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
> >>>> userfaultfd has been initialized for this memory. I'll rename to
> >>>> PM_SCAN_REQUIRE_UFFD.
> >>>
> >>> Why do we need that check? Wouldn't `is_written =3D false` work for v=
mas
> >>> not registered via uffd?
> >> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory re=
gion
> >> for it to report correct written values on the memory region. Without =
UFFD
> >> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP s=
tate
> >> undefined. If user hasn't initialized memory with UFFD, he has no righ=
t to
> >> set is_written =3D false.
> >
> > How about calculating `is_written =3D is_uffd_registered() &&
> > is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
> > address space of a process regardless of whether all of it is
> > registered.
> I wouldn't want to check if uffd is registered again and again. This is w=
hy
> we are doing it only once every walk in pagemap_scan_test_walk().

There is no need to do the checks repeatedly. If I understand the code
correctly, uffd registration is per-vma, so it can be communicated
from test_walk to entry/hole callbacks via a field in
pagemap_scan_private.

> >>> While here, I wonder if we really need to fail the call if there are
> >>> unknown bits in those masks set: if this bit set is expanded with
> >>> another category flags, a newer userspace run on older kernel would
> >>> get EINVAL even if the "treat unknown as 0" be what it requires.
> >>> There is no simple way in the API to discover what bits the kernel
> >>> supports. We could allow a no-op (no WP nor GET) call to help with
> >>> that and then rejecting unknown bits would make sense.
> >> I've not seen any examples of this. But I've seen examples of returnin=
g
> >> error if kernel doesn't support a feature. Each new feature comes with=
 a
> >> kernel version, greater than this version support this feature. If use=
r is
> >> trying to use advanced feature which isn't present in a kernel, we sho=
uld
> >> return error and not proceed to confuse the user/kernel. In fact if we=
 look
> >> at userfaultfd_api(), we return error immediately if feature has some =
bit
> >> set which kernel doesn't support.
> >
> > I think we should have a way of detecting the supported flags if we
> > don't want a forward compatibility policy for flags here. Maybe it
> > would be enough to allow all the no-op combinations for this purpose?
> Again I don't think UFFD is doing anything like this.

If it's cheap and easy to provide a user with a way to detect the
supported features - why not do it?

Best Regards
Micha=C5=82 Miros=C5=82aw
