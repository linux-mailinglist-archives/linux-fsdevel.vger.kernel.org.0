Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE16C73209B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFOUHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjFOUHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:07:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5F1FD7
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 13:07:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so2810a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686859654; x=1689451654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcXKgHkINlZtkH6FcAJl31LqrUpiNimJraZYTIfEacY=;
        b=grNeFjMFUEplWpGORmy77WwGAa6tuYg9L3WkV5mckN5vDk/zbhDik+lHM/UNgpP4pd
         hOOm+WnJ7a4iQyAmGfMIEHtYCyEjiOB4fybvLRjQ953HrpODT7pybSJLC9oyrmvc1uAa
         Q5t0iw3S7Cu+ZA/WqgFLv0n3V0z2Iv+BsFTHoBDgXWNu+X4LTbCrMOKZdBHMF2+Gz+9E
         C8mezgnBZ0C8B3l28HKwJtAiDRd/qOx2CFcehRN62EOe8r6f8Izc6DyVxQ48aAB/jfzZ
         Fbunklgz4dlOAoPmDadl7tLsJBvnhxposHcHyBr7ITs8tsH4/taorio4KkE5YTJeEn/y
         +CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686859654; x=1689451654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcXKgHkINlZtkH6FcAJl31LqrUpiNimJraZYTIfEacY=;
        b=bga6SV+Mov4wMPIh+ZWIZ9qVKsiKFGpBNeri0HzoyoFwkG3qccc3VRFm3rLsRtGEOh
         9JU9WPnI0Ms++grHvx+xwRBuWg0QeYcQQyKoFskdl4S5G6DemmZv9MrKzE2a1WGTfzo2
         rRDwnLdADp1GsUROh5kUMlQzSTG9OkQ8yplA+edk9iGSUwX6IEQOMgBP8CNTHI/4Ezng
         2zBoLaaeaE4/Zbi4B6/XxwcioGNJrG2ulvaEPK8JWCUixfcCQchKrjEuGPzNUJkZND83
         bAlM/pf+cnzls3v1ejybipgBOnkh+WL/CYFQCd4RGNUaTya43aXYRPlWJy4gDet6Cy59
         RygQ==
X-Gm-Message-State: AC+VfDxM1P2jUV97eOjZGsIF2dzSOvfBs2bAcs+3fmVoBNzK3IAo+p6s
        H30M0XzagfOf4KBUixd5/OsbKBwYilWWE6U/icQXew==
X-Google-Smtp-Source: ACHHUZ4X+9erQPhmydL6aaFuWi9P+BEB8cvKp3i4+5UPNoYBQtJLxjzSx6pSUJJ8b5JUmvgtrKsHYgvI4lYLFVRURZE=
X-Received: by 2002:a50:a6d3:0:b0:51a:1ffd:10e with SMTP id
 f19-20020a50a6d3000000b0051a1ffd010emr133474edc.3.1686859654409; Thu, 15 Jun
 2023 13:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com> <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
 <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com>
In-Reply-To: <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 15 Jun 2023 22:07:22 +0200
Message-ID: <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
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

On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/15/23 7:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> I'll send next revision now.
> >> On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> (A quick reply to answer open questions in case they help the next ve=
rsion.)
> >>>
> >>> On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> On 6/14/23 8:14=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> >>>>>>
> >>>>>> On 6/14/23 3:36=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> >>>>>>> <usama.anjum@collabora.com> wrote:
> >>> [...]
> >>>>>>>> +       if (cur_buf->bitmap =3D=3D bitmap &&
> >>>>>>>> +           cur_buf->start + cur_buf->len * PAGE_SIZE =3D=3D add=
r) {
> >>>>>>>> +               cur_buf->len +=3D n_pages;
> >>>>>>>> +               p->found_pages +=3D n_pages;
> >>>>>>>> +       } else {
> >>>>>>>> +               if (cur_buf->len && p->vec_buf_index >=3D p->vec=
_buf_len)
> >>>>>>>> +                       return -ENOMEM;
> >>>>>>>
> >>>>>>> Shouldn't this be -ENOSPC? -ENOMEM usually signifies that the ker=
nel
> >>>>>>> ran out of memory when allocating, not that there is no space in =
a
> >>>>>>> user-provided buffer.
> >>>>>> There are 3 kinds of return values here:
> >>>>>> * PM_SCAN_FOUND_MAX_PAGES (1) ---> max_pages have been found. Abor=
t the
> >>>>>> page walk from next entry
> >>>>>> * 0 ---> continue the page walk
> >>>>>> * -ENOMEM --> Abort the page walk from current entry, user buffer =
is full
> >>>>>> which is not error, but only a stop signal. This -ENOMEM is just
> >>>>>> differentiater from (1). This -ENOMEM is for internal use and isn'=
t
> >>>>>> returned to user.
> >>>>>
> >>>>> But why ENOSPC is not good here? I was used before, I think.
> >>>> -ENOSPC is being returned in form of true error from
> >>>> pagemap_scan_hugetlb_entry(). So I'd to remove -ENOSPC from here as =
it
> >>>> wasn't true error here, it was only a way to abort the walk immediat=
ely.
> >>>> I'm liking the following erturn code from here now:
> >>>>
> >>>> #define PM_SCAN_BUFFER_FULL     (-256)
> >>>
> >>> I guess this will be reworked anyway, but I'd prefer this didn't need
> >>> custom errors etc. If we agree to decoupling the selection and GET
> >>> output, it could be:
> >>>
> >>> bool is_interesting_page(p, flags); // this one does the
> >>> required/anyof/excluded match
> >>> size_t output_range(p, start, len, flags); // this one fills the
> >>> output vector and returns how many pages were fit
> >>>
> >>> In this setup, `is_interesting_page() && (n_out =3D output_range()) <
> >>> n_pages` means this is the final range, no more will fit. And if
> >>> `n_out =3D=3D 0` then no pages fit and no WP is needed (no other spec=
ial
> >>> cases).
> >> Right now, pagemap_scan_output() performs the work of both of these tw=
o
> >> functions. The part can be broken into is_interesting_pages() and we c=
an
> >> leave the remaining part as it is.
> >>
> >> Saying that n_out < n_pages tells us the buffer is full covers one cas=
e.
> >> But there is case of maximum pages have been found and walk needs to b=
e
> >> aborted.
> >
> > This case is exactly what `n_out < n_pages` will cover (if scan_output
> > uses max_pages properly to limit n_out).
> > Isn't it that when the buffer is full we want to abort the scan always
> > (with WP if `n_out > 0`)?
> Wouldn't it be duplication of condition if buffer is full inside
> pagemap_scan_output() and just outside it. Inside pagemap_scan_output() w=
e
> check if we have space before putting data inside it. I'm using this same
> condition to indicate that buffer is full.

I'm not sure what do you mean? The buffer-full conditions would be
checked in ..scan_output() and communicated to the caller by returning
N less than `n_pages` passed in. This is exactly how e.g. read()
works: if you get less than requested you've hit the end of the file.
If the file happens to have size that is equal to the provided buffer
length, the next read() will return 0.

> >>>>> While here, I wonder if we really need to fail the call if there ar=
e
> >>>>> unknown bits in those masks set: if this bit set is expanded with
> >>>>> another category flags, a newer userspace run on older kernel would
> >>>>> get EINVAL even if the "treat unknown as 0" be what it requires.
> >>>>> There is no simple way in the API to discover what bits the kernel
> >>>>> supports. We could allow a no-op (no WP nor GET) call to help with
> >>>>> that and then rejecting unknown bits would make sense.
> >>>> I've not seen any examples of this. But I've seen examples of return=
ing
> >>>> error if kernel doesn't support a feature. Each new feature comes wi=
th a
> >>>> kernel version, greater than this version support this feature. If u=
ser is
> >>>> trying to use advanced feature which isn't present in a kernel, we s=
hould
> >>>> return error and not proceed to confuse the user/kernel. In fact if =
we look
> >>>> at userfaultfd_api(), we return error immediately if feature has som=
e bit
> >>>> set which kernel doesn't support.
> >>>
> >>> I think we should have a way of detecting the supported flags if we
> >>> don't want a forward compatibility policy for flags here. Maybe it
> >>> would be enough to allow all the no-op combinations for this purpose?
> >> Again I don't think UFFD is doing anything like this.
> >
> > If it's cheap and easy to provide a user with a way to detect the
> > supported features - why not do it?
> I'm sorry. But it would bring up something new and iterations will be
> needed to just play around. I like the UFFD way.

Let's then first agree on what would have to be changed. I guess we
could leverage that `scan_len =3D 0` doesn't make much sense otherwise
and let it be used to check the other fields for support.

Best Regards
Micha=C5=82 Miros=C5=82aw
