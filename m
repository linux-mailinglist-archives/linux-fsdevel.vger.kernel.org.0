Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D57384EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjFUNZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjFUNYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:24:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5921985
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9b4b286aaso126615e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687353885; x=1689945885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6OJlvihTdu/SdNfuqNeAnU4YSYkZQL9ZXTp7Fb/ZPI=;
        b=MWwh+xsH+RhAc4rloZAcukZaevHxJ0XrZj7zoSmeqaEFu7F4Q9r4Jc2CUsTGPkHP5u
         /SGw7u0/eXSaxA6sXam0vyvjg8zN2GFQdpVqkWZb59LnXxEQ+awxRzaDJtSZkFsjBAHc
         a+gWwQ5lM/PqXQK7D0POQh4LZ57r/s209FXcUJJniolflfJ3aTWiOkd4tjRyCxfHMa9v
         c2a+kGNtFWKtxjV0Jx0g3zUL8nZdtlF/8KuSUujQ8lTBQrTHkwJCtjmwbcVlTpl494L7
         CLm5Asn0vcpUJpryyMwYBdPrfY/DoGWkyTK8WYKUmFOSMyaNpNvmQB4O7XUSlh0AVCnI
         kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353885; x=1689945885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6OJlvihTdu/SdNfuqNeAnU4YSYkZQL9ZXTp7Fb/ZPI=;
        b=lmrsSOSSWccPEy6cHAZKubcdSNGHopi1+skNTFmX3hzGfWPoRGacKkyAySRdPwcmHD
         Wgj+uLGkaCci2BIVjKO080JsPl8vC+Ydc6oIc2RSANSL/JFEFn2+V3iowonx8QMtzAYD
         mqP9X3b6WCmOHsL/GGO8RpYe0ClEk483bFMyhLEnXA0YNbt+YKvuleqfJx1EDF5ea1D6
         cAD3mltiRXzSTVZXu6ax+nxzbg28VYxTTwuvqngFufm1MIR0OCVdbX/hGRzTMtpZ+u5P
         IX2eBoERGH9BgTj2I1TW8ourWoVtuUTtEm1FbtBvaxiP9mffuQ2XGMBU40sKM3TprUIx
         90ig==
X-Gm-Message-State: AC+VfDxh24j0/Og5BkNLunU9WmHbd/E1dQdBrtJJwvKZq0kD+GtQn+YC
        bGFOpPpyI/aoug+/GC9BzYf3r5y4t6o6+GsXprlClQ==
X-Google-Smtp-Source: ACHHUZ7cCuOESPo/cKbciN4iRBmfV03uDZkex3iULJ2eeXruwtKzJY+NvZby1DF9X/fEjXmoFxCZGYsMSXoaU68CHfs=
X-Received: by 2002:a05:600c:1d9f:b0:3f7:ba55:d038 with SMTP id
 p31-20020a05600c1d9f00b003f7ba55d038mr619210wms.6.1687353885487; Wed, 21 Jun
 2023 06:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com> <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
 <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com> <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
 <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com> <CABb0KFGOx69Sz6w9JenYUwSTFmW-Cmcns3X-oDyWsC+H57vkvg@mail.gmail.com>
 <444ed144-a2ee-cb16-880a-128383c83a08@collabora.com> <CABb0KFEqJasf9nM3wL1oaK9ObcYzwzjtrRBcWRc3wGqdZRUpXg@mail.gmail.com>
 <9b6d55e3-1f5f-04e1-d68f-0591a0f4f60c@collabora.com>
In-Reply-To: <9b6d55e3-1f5f-04e1-d68f-0591a0f4f60c@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 15:24:33 +0200
Message-ID: <CABb0KFFwe_cRUjV5K1-J5TTWP69X78XZvTr2jw=0ZYGjYoxvqw@mail.gmail.com>
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

On Wed, 21 Jun 2023 at 06:44, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/21/23 3:05=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 20 Jun 2023 at 13:16, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 6/19/23 1:16=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Fri, 16 Jun 2023 at 08:57, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>>
> >>>> On 6/16/23 1:07=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> >>>>>> On 6/15/23 7:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> >>>>>>> <usama.anjum@collabora.com> wrote:
> >>>>>>>> I'll send next revision now.
> >>>>>>>> On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>>>>>> (A quick reply to answer open questions in case they help the n=
ext version.)
> >>> [...]
> >>>>>>>>> I guess this will be reworked anyway, but I'd prefer this didn'=
t need
> >>>>>>>>> custom errors etc. If we agree to decoupling the selection and =
GET
> >>>>>>>>> output, it could be:
> >>>>>>>>>
> >>>>>>>>> bool is_interesting_page(p, flags); // this one does the
> >>>>>>>>> required/anyof/excluded match
> >>>>>>>>> size_t output_range(p, start, len, flags); // this one fills th=
e
> >>>>>>>>> output vector and returns how many pages were fit
> >>>>>>>>>
> >>>>>>>>> In this setup, `is_interesting_page() && (n_out =3D output_rang=
e()) <
> >>>>>>>>> n_pages` means this is the final range, no more will fit. And i=
f
> >>>>>>>>> `n_out =3D=3D 0` then no pages fit and no WP is needed (no othe=
r special
> >>>>>>>>> cases).
> >>>>>>>> Right now, pagemap_scan_output() performs the work of both of th=
ese two
> >>>>>>>> functions. The part can be broken into is_interesting_pages() an=
d we can
> >>>>>>>> leave the remaining part as it is.
> >>>>>>>>
> >>>>>>>> Saying that n_out < n_pages tells us the buffer is full covers o=
ne case.
> >>>>>>>> But there is case of maximum pages have been found and walk need=
s to be
> >>>>>>>> aborted.
> >>>>>>>
> >>>>>>> This case is exactly what `n_out < n_pages` will cover (if scan_o=
utput
> >>>>>>> uses max_pages properly to limit n_out).
> >>>>>>> Isn't it that when the buffer is full we want to abort the scan a=
lways
> >>>>>>> (with WP if `n_out > 0`)?
> >>>>>> Wouldn't it be duplication of condition if buffer is full inside
> >>>>>> pagemap_scan_output() and just outside it. Inside pagemap_scan_out=
put() we
> >>>>>> check if we have space before putting data inside it. I'm using th=
is same
> >>>>>> condition to indicate that buffer is full.
> >>>>>
> >>>>> I'm not sure what do you mean? The buffer-full conditions would be
> >>>>> checked in ..scan_output() and communicated to the caller by return=
ing
> >>>>> N less than `n_pages` passed in. This is exactly how e.g. read()
> >>>>> works: if you get less than requested you've hit the end of the fil=
e.
> >>>>> If the file happens to have size that is equal to the provided buff=
er
> >>>>> length, the next read() will return 0.
> >>>> Right now we have:
> >>>>
> >>>> pagemap_scan_output():
> >>>>         if (p->vec_buf_index >=3D p->vec_buf_len)
> >>>>                 return PM_SCAN_BUFFER_FULL;
> >>>>         if (p->found_pages =3D=3D p->max_pages)
> >>>>                 return PM_SCAN_FOUND_MAX_PAGES;
> >>>
> >>> Why do you need to differentiate between those cases?
> >>>
> >>>> pagemap_scan_pmd_entry():
> >>>>         ret =3D pagemap_scan_output(bitmap, p, start, n_pages);
> >>>>         if (ret >=3D 0) // success
> >>>>                 make_UFFD_WP and flush
> >>>>         else
> >>>>                 buffer_error
> >>>>
> >>>> You are asking me to do:
> >>>>
> >>>> pagemap_scan_output():
> >>>>         if (p->vec_buf_index >=3D p->vec_buf_len)
> >>>>                 return 0;
> >>>
> >>>>         if (p->found_pages =3D=3D p->max_pages)
> >>>>                 return PM_SCAN_FOUND_MAX_PAGES;
> >>>
> >>> This should be instead:
> >>>
> >>> n_pages =3D min(p->max_pags - p_found_pages, n_pages)
> >>> ...
> >>> return n_pages;
> >> You are missing the optimization here that we check for full buffer ev=
ery
> >> time adding to user buffer. This was added to remove extra iteration o=
f
> >> page walk if buffer is full already. The way you are suggesting will r=
emove it.
> >>
> >> So you are returning remaining pages to be found now. This doesn't see=
m
> >> right. If max_pages is 520, found_pages is 0 and n_pages is 512 before
> >> calling pagemap_scan_output(). found_pages would become 512 after addi=
ng
> >> 512 pages to output buffer. But n_pages would return 8 instead of 512.=
 You
> >> were saying we should return the number of pages added to the output b=
uffer.
> >
> > Ok, if we want this optimization, then i'd rework it so that we have:
> >
> > bool pagemap_scan_output(..., int *n_pages)
> > {
> >    limit n_pages;
> >   ...
> >   return have_more_room_in_output;
> > }
> This is becoming more and more closer to what I have in the code. The onl=
y
> difference now is that you are asking me to not return the buffer full
> status from inside this function and instead there should be a input+outp=
ut
> pointer to n_pages and the caller would return the buffer full status. As
> compared to the suggestion, the current form looks simpler. My earlier
> point (
> https://lore.kernel.org/all/2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabor=
a.com
> ) is valid again. I don't want to bring logic out of pagemap_scan_output(=
).
> This is internal function. There could be thousand ways how internal code
> can be written. I've really liked so many optimizations which you have
> advised. This isn't something worth doing. It would increase lines of cod=
e
> with no added readability benefit.

Yes, I try to suggest a minimal change. The benefit is that you don't
need special error values anymore and so the cognitive load to
understand the code flow is less. The idea is not to strictly save on
lines typed, but on localising the information needed as much as
possible. Also the distinction between BUFFER_FULL and FOUND_MAX_PAGES
is only in which criteria was detected, but otherwise the code should
behave the same way.

Best Regards
Micha=C5=82 Miros=C5=82aw
