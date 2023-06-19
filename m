Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4591734D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFSIQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjFSIQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:16:17 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4FF94
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 01:16:14 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33d928a268eso279175ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687162574; x=1689754574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUxNLC+gaxAx6q4yk9Zr89shiO34QlAjv1HZ696Wg1U=;
        b=6jB0Vaksw7QYyR3aieZrQMpKBSoFdhf1SglIAWLr1IUfcUcsjNjZT047OxQ/zQDxn/
         Q9VLzY0piRJkaAmLa8H4wzNvh8yfWhfZ2IWwJ+gHskDnk2EqS3ffbkHr01hFU11k/zF0
         xgsVP5PPjtZeLsInnU48wBXWitsB5Cg42pRR7NSKqCaGZsK8UpHqajQTimFQ0q5vd/9r
         acH2E9d4CQJy/awvToQdq8wrpNqwUmb65hWO8yhrGnfXzNPlCCI+qzY7RPDt1S85CFV0
         QZ8a7hay4Wk37tQGl8s76uSpDIge/MKmH10WPIqNLvcYLXmP9kohSEeLvCiG8udvDi4l
         XIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162574; x=1689754574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUxNLC+gaxAx6q4yk9Zr89shiO34QlAjv1HZ696Wg1U=;
        b=diZY+nxF/PNuFLW8jj1bM7f04NLM6i89Ca5EG9D2paj1oM62PM1/gawMUTttGN0nOI
         FDlsLDR0fyQ2cIa2yB9SiqsCmr0aWLER5WuI83O6smZuHcqDMlS6tTLFvhsUpKMep2BX
         rLjkpLRKxf6YnVO6O1glrJCytKcNnCjrvmjfAzBJ0SDqWSAYXrvH0v0XX844YGOGvXLZ
         5AuIlTRNz/emBdr4AccbbAmj6esCPaWjBA+ns0Ok99t8ffz/w+Hs8gW0GKHkpwBm3XCa
         DUUlfgEGfn7lPc02ftM/nNYVE0/gCGZhsL+u0gg7oMPT7w0fZllobOasG5IB7CZN2S5U
         68Ag==
X-Gm-Message-State: AC+VfDyY684dUSI3ONWXhUXyhjdAOlG4zVJyy+QSeb2TO8RnrWbDEzi4
        gGGfXNtq/cZsVjmsx57oDWWcJEGKguwqH6PUgp7Dsw==
X-Google-Smtp-Source: ACHHUZ7pPgmfxfjpyVDu/lfSWd41l6pU01tdM9sEKUPUeywUHyKDUU+RDI/ym0egdMQruqWyQjzGX8yWcNRZAY/X9kE=
X-Received: by 2002:a92:c243:0:b0:340:f76:4292 with SMTP id
 k3-20020a92c243000000b003400f764292mr894272ilo.0.1687162574121; Mon, 19 Jun
 2023 01:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com> <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
 <39bc8212-9ee8-dbc1-d468-f6be438b683b@collabora.com> <CABb0KFHx2hV9M7oinCdKnagRmcrGHagH9eAO3TkVTQH+o9x=5A@mail.gmail.com>
 <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com>
In-Reply-To: <2e1b80f1-0385-0674-ae5f-9703a6ef975d@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Mon, 19 Jun 2023 10:16:01 +0200
Message-ID: <CABb0KFGOx69Sz6w9JenYUwSTFmW-Cmcns3X-oDyWsC+H57vkvg@mail.gmail.com>
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

On Fri, 16 Jun 2023 at 08:57, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 6/16/23 1:07=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 15 Jun 2023 at 17:11, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 6/15/23 7:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> I'll send next revision now.
> >>>> On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> (A quick reply to answer open questions in case they help the next =
version.)
[...]
> >>>>> I guess this will be reworked anyway, but I'd prefer this didn't ne=
ed
> >>>>> custom errors etc. If we agree to decoupling the selection and GET
> >>>>> output, it could be:
> >>>>>
> >>>>> bool is_interesting_page(p, flags); // this one does the
> >>>>> required/anyof/excluded match
> >>>>> size_t output_range(p, start, len, flags); // this one fills the
> >>>>> output vector and returns how many pages were fit
> >>>>>
> >>>>> In this setup, `is_interesting_page() && (n_out =3D output_range())=
 <
> >>>>> n_pages` means this is the final range, no more will fit. And if
> >>>>> `n_out =3D=3D 0` then no pages fit and no WP is needed (no other sp=
ecial
> >>>>> cases).
> >>>> Right now, pagemap_scan_output() performs the work of both of these =
two
> >>>> functions. The part can be broken into is_interesting_pages() and we=
 can
> >>>> leave the remaining part as it is.
> >>>>
> >>>> Saying that n_out < n_pages tells us the buffer is full covers one c=
ase.
> >>>> But there is case of maximum pages have been found and walk needs to=
 be
> >>>> aborted.
> >>>
> >>> This case is exactly what `n_out < n_pages` will cover (if scan_outpu=
t
> >>> uses max_pages properly to limit n_out).
> >>> Isn't it that when the buffer is full we want to abort the scan alway=
s
> >>> (with WP if `n_out > 0`)?
> >> Wouldn't it be duplication of condition if buffer is full inside
> >> pagemap_scan_output() and just outside it. Inside pagemap_scan_output(=
) we
> >> check if we have space before putting data inside it. I'm using this s=
ame
> >> condition to indicate that buffer is full.
> >
> > I'm not sure what do you mean? The buffer-full conditions would be
> > checked in ..scan_output() and communicated to the caller by returning
> > N less than `n_pages` passed in. This is exactly how e.g. read()
> > works: if you get less than requested you've hit the end of the file.
> > If the file happens to have size that is equal to the provided buffer
> > length, the next read() will return 0.
> Right now we have:
>
> pagemap_scan_output():
>         if (p->vec_buf_index >=3D p->vec_buf_len)
>                 return PM_SCAN_BUFFER_FULL;
>         if (p->found_pages =3D=3D p->max_pages)
>                 return PM_SCAN_FOUND_MAX_PAGES;

Why do you need to differentiate between those cases?

> pagemap_scan_pmd_entry():
>         ret =3D pagemap_scan_output(bitmap, p, start, n_pages);
>         if (ret >=3D 0) // success
>                 make_UFFD_WP and flush
>         else
>                 buffer_error
>
> You are asking me to do:
>
> pagemap_scan_output():
>         if (p->vec_buf_index >=3D p->vec_buf_len)
>                 return 0;

>         if (p->found_pages =3D=3D p->max_pages)
>                 return PM_SCAN_FOUND_MAX_PAGES;

This should be instead:

n_pages =3D min(p->max_pags - p_found_pages, n_pages)
...
return n_pages;

> pagemap_scan_pmd_entry():
>         ret =3D pagemap_scan_output(bitmap, p, start, n_pages);
>         if (ret > 0) // success
>                 make_UFFD_WP and flush
>         else if (ret =3D=3D 0) // buffer full
>                 return PM_SCAN_BUFFER_FULL;
>         else //other errors
>                 buffer_error

And this would be:

if (ret > 0 && WP)
   WP + flush

if (ret < n_pages)
   return -ENOSPC;

> So you are asking me to go from consie code to write more lines of code. =
I
> would write more lines without any issue if it improves readability and
> logical sense. But I don't see here any benefit.

Please see the clarifications above.

Best Regards
Micha=C5=82 Miros=C5=82aw
