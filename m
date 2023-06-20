Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC876737730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFTWFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFTWFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:05:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83E1730
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 15:05:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so1982a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687298717; x=1689890717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QnZ16+cR3SKz8OZyy5d1CsXcXjkIRyncSh8yNxkG1M=;
        b=B8QESZcPS8IOqAQ9veug7dutrAkK9Ty1tsh2jQp6IbIscVsQ3171n8gu4ay4YA1jka
         SkkY8idwFT4BOwqktrmuEbxD0Q/eYeyQGlApPqQBEFgsOCmzBHnvaRCdjry6zWAgVZ4G
         yyFUmiO18E4j8x97g+1K1kjmm85SQxOEFP0ccV/TiJVtZ2muvDpMiypubUXTcZdN/Hk6
         vQ570hXUuFVnwEmSHLwMjj9UoRrL3kKGlkVcqEUvhhOT2ok9Y2mDTVOnKKEQQvCbbpHD
         b9luoM6mpvHQG2q9UDVJ10SdF0+qSH5L0gjwTYjn8fi3DenuPM9N1G70ZZFBE3/zqrBq
         ZVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298717; x=1689890717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QnZ16+cR3SKz8OZyy5d1CsXcXjkIRyncSh8yNxkG1M=;
        b=IDgFOOtWjVsBlF2Dlx0PPYI4SDRbu5+Np3GFcqQTgEY6QcgZ4rDgF0m4Hiz6MJojOP
         qp5KsRE1yQmbMpCxw43JCjrEyxQ7xuxfP5Nk3tWPvffHIwbRgrMC71OvwQ7MOI1Ay/Rb
         n+SmulE1G+nvQy8GUvKSob3nAcN8hn+KXkPsJfElJbZ4/VN37ETTH4mRh3x1PS27m+pe
         AmWph6r33cRusz7JxPKsliVCCPVObtnZCGHgRJH59qlH5Zn9PqLuaW5W19dYFp4Q4imW
         jrsNZuJSxO4G03eqpPz+trFgEdoJ8i9TfiI+90mA8Tr/HC7Xh96caAeZLc2H6NAuNjz3
         wE2A==
X-Gm-Message-State: AC+VfDzvxhlM1+MEenAyFIAnsRpQ/pjrNzjX2jZmt+QG+Uvj4lEIt7Fe
        it9XLsFJKR5UvXFdjcAxRBjrIAzn0s5pRq3ph7GmvA==
X-Google-Smtp-Source: ACHHUZ59qq5aWENB/BjU7unJQ0/yUrpV9cMPMC3H9gw6cRwjKcqMmpGu7hrOaqCTn7aGXRAjC3awXkHyEymz3yE+18M=
X-Received: by 2002:a50:9e07:0:b0:50b:f6ce:2f3d with SMTP id
 z7-20020a509e07000000b0050bf6ce2f3dmr574426ede.0.1687298716727; Tue, 20 Jun
 2023 15:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com> <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
 <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com> <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
 <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com> <CABb0KFGOx69Sz6w9JenYUwSTFmW-Cmcns3X-oDyWsC+H57vkvg@mail.gmail.com>
 <444ed144-a2ee-cb16-880a-128383c83a08@collabora.com>
In-Reply-To: <444ed144-a2ee-cb16-880a-128383c83a08@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 00:05:05 +0200
Message-ID: <CABb0KFEqJasf9nM3wL1oaK9ObcYzwzjtrRBcWRc3wGqdZRUpXg@mail.gmail.com>
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

On Tue, 20 Jun 2023 at 13:16, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/19/23 1:16=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Fri, 16 Jun 2023 at 08:57, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> On 6/16/23 1:07=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> On 6/15/23 7:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> >>>>>> I'll send next revision now.
> >>>>>> On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>>>> (A quick reply to answer open questions in case they help the nex=
t version.)
> > [...]
> >>>>>>> I guess this will be reworked anyway, but I'd prefer this didn't =
need
> >>>>>>> custom errors etc. If we agree to decoupling the selection and GE=
T
> >>>>>>> output, it could be:
> >>>>>>>
> >>>>>>> bool is_interesting_page(p, flags); // this one does the
> >>>>>>> required/anyof/excluded match
> >>>>>>> size_t output_range(p, start, len, flags); // this one fills the
> >>>>>>> output vector and returns how many pages were fit
> >>>>>>>
> >>>>>>> In this setup, `is_interesting_page() && (n_out =3D output_range(=
)) <
> >>>>>>> n_pages` means this is the final range, no more will fit. And if
> >>>>>>> `n_out =3D=3D 0` then no pages fit and no WP is needed (no other =
special
> >>>>>>> cases).
> >>>>>> Right now, pagemap_scan_output() performs the work of both of thes=
e two
> >>>>>> functions. The part can be broken into is_interesting_pages() and =
we can
> >>>>>> leave the remaining part as it is.
> >>>>>>
> >>>>>> Saying that n_out < n_pages tells us the buffer is full covers one=
 case.
> >>>>>> But there is case of maximum pages have been found and walk needs =
to be
> >>>>>> aborted.
> >>>>>
> >>>>> This case is exactly what `n_out < n_pages` will cover (if scan_out=
put
> >>>>> uses max_pages properly to limit n_out).
> >>>>> Isn't it that when the buffer is full we want to abort the scan alw=
ays
> >>>>> (with WP if `n_out > 0`)?
> >>>> Wouldn't it be duplication of condition if buffer is full inside
> >>>> pagemap_scan_output() and just outside it. Inside pagemap_scan_outpu=
t() we
> >>>> check if we have space before putting data inside it. I'm using this=
 same
> >>>> condition to indicate that buffer is full.
> >>>
> >>> I'm not sure what do you mean? The buffer-full conditions would be
> >>> checked in ..scan_output() and communicated to the caller by returnin=
g
> >>> N less than `n_pages` passed in. This is exactly how e.g. read()
> >>> works: if you get less than requested you've hit the end of the file.
> >>> If the file happens to have size that is equal to the provided buffer
> >>> length, the next read() will return 0.
> >> Right now we have:
> >>
> >> pagemap_scan_output():
> >>         if (p->vec_buf_index >=3D p->vec_buf_len)
> >>                 return PM_SCAN_BUFFER_FULL;
> >>         if (p->found_pages =3D=3D p->max_pages)
> >>                 return PM_SCAN_FOUND_MAX_PAGES;
> >
> > Why do you need to differentiate between those cases?
> >
> >> pagemap_scan_pmd_entry():
> >>         ret =3D pagemap_scan_output(bitmap, p, start, n_pages);
> >>         if (ret >=3D 0) // success
> >>                 make_UFFD_WP and flush
> >>         else
> >>                 buffer_error
> >>
> >> You are asking me to do:
> >>
> >> pagemap_scan_output():
> >>         if (p->vec_buf_index >=3D p->vec_buf_len)
> >>                 return 0;
> >
> >>         if (p->found_pages =3D=3D p->max_pages)
> >>                 return PM_SCAN_FOUND_MAX_PAGES;
> >
> > This should be instead:
> >
> > n_pages =3D min(p->max_pags - p_found_pages, n_pages)
> > ...
> > return n_pages;
> You are missing the optimization here that we check for full buffer every
> time adding to user buffer. This was added to remove extra iteration of
> page walk if buffer is full already. The way you are suggesting will remo=
ve it.
>
> So you are returning remaining pages to be found now. This doesn't seem
> right. If max_pages is 520, found_pages is 0 and n_pages is 512 before
> calling pagemap_scan_output(). found_pages would become 512 after adding
> 512 pages to output buffer. But n_pages would return 8 instead of 512. Yo=
u
> were saying we should return the number of pages added to the output buff=
er.

Ok, if we want this optimization, then i'd rework it so that we have:

bool pagemap_scan_output(..., int *n_pages)
{
   limit n_pages;
  ...
  return have_more_room_in_output;
}

The compiler should remove the pointer and memory storage for
`n_pages` when inlining the function.

Best Regards
Micha=C5=82 Miros=C5=82aw
