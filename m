Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523DE6DD6B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDKJa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKJaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:30:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE893C10
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 02:29:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xi5so18674185ejb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681205396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJF2YBEivbAPJS4QQn75FqV7euOHKuYSxMpUJHAYYIA=;
        b=D8673ys/7alW1jYcJSvlooEOVSYGU8uFheQLlNiFLSREDV21ZsPJJr5Ktj3FomPy1E
         q4UadnXFYbOVxKWzwM1TMkIW2DiaNaPZFbAtk1NR5AW1Mz3rUvyJ62gS8KNTEGEPMIJr
         66R7URAlRwCf3NLhtBLiJkfBf4KNLQoRMGsIhOQNRbsbNTknittQa03UbKCj2/eIUpSV
         ZA0McsK4guufSrWQVyGAxkhJXtNLC/M7HRUVoUdTwV5kTxVBpucMQGtRDQJj5MSOweJq
         OQmAaUK10c1W1OGocYhQNAyA/2YkBs5gPkucrRt4Zv/xI3pHcg5OxmxRQQQrKc/+UWJf
         Ms1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681205397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJF2YBEivbAPJS4QQn75FqV7euOHKuYSxMpUJHAYYIA=;
        b=UKH8Xkm58/alqaKrVqJZm9AqByysSgzf6aZw+EAfEnm6LaXrdzitdC1P0oqGHIdiK6
         wXleWKcrVYvg/m0z3JVh7wE0QsSidCB6Ay0TCsAn47OKf06OfkXxqJL/c6FO80dnNIqo
         Sao5UsRQ2wS52jd4SmpP857u620badSbBrNMqhe35pMss0dGM5nsi7wDE30yZEwGZEOw
         UUF7ucFp3+xIR/3bmEKu6F2J6icEJ+ACDQ2cacUFsPiYk34u2/A2BnRkl2HZ5n8/J6O+
         fcU3KB9blkqRtEh8tCqCv9AH1lJQoGWmoM6HQDkwgzgj4ZxloMcmqfj+yHZklwl3Yykx
         jB+Q==
X-Gm-Message-State: AAQBX9cSb/8UNWkdqi/ZgEHuU72EUK1ZwGurYURjVELC7S1evNGrcfPL
        EcPbWjBg6H1XreJueqEpAw9lxnoSvsD24gx2TSfyvA==
X-Google-Smtp-Source: AKy350YciC056geHubwxcdJsmaoBPi16cp8aurI4qOglRyDHG/cvxK/Ql9YEmFxW0jx+zwWEqAPGI0ZBL6z80oGpEw0=
X-Received: by 2002:a17:906:11d8:b0:94e:fdd:9319 with SMTP id
 o24-20020a17090611d800b0094e0fdd9319mr1132630eja.15.1681205396442; Tue, 11
 Apr 2023 02:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com> <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
 <8a837998-604f-a871-729e-aa274a621481@collabora.com> <CABb0KFEBqAMWWpAeBfqzA4JrHo3yLyaT0rqKTUn28O0hE+szBA@mail.gmail.com>
 <c5b9201d-141c-10ae-0475-4b230d36508b@collabora.com> <CABb0KFH3mj5qt22qDLHRKjh-wB7Jrn6Pz8h-QARaf9oR65U0Qg@mail.gmail.com>
 <05e14540-7092-5dd2-d503-473b673af716@collabora.com>
In-Reply-To: <05e14540-7092-5dd2-d503-473b673af716@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 11 Apr 2023 11:29:44 +0200
Message-ID: <CABb0KFE6Y=a5DQKjy3vKeP9YURwri3JHNKTCnN7PzOPOxr9SKQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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

On Fri, 7 Apr 2023 at 13:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 3:14=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Fri, 7 Apr 2023 at 12:04, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 4/7/23 12:34=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 6 Apr 2023 at 23:04, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> On 4/7/23 1:00=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> > [...]
> >>>>>>>> +       /*
> >>>>>>>> +        * Allocate smaller buffer to get output from inside the=
 page walk
> >>>>>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE si=
ze chunks. As
> >>>>>>>> +        * we want to return output to user in compact form wher=
e no two
> >>>>>>>> +        * consecutive regions should be continuous and have the=
 same flags.
> >>>>>>>> +        * So store the latest element in p.cur between differen=
t walks and
> >>>>>>>> +        * store the p.cur at the end of the walk to the user bu=
ffer.
> >>>>>>>> +        */
> >>>>>>>> +       p.vec =3D kmalloc_array(p.vec_len, sizeof(struct page_re=
gion),
> >>>>>>>> +                             GFP_KERNEL);
> >>>>>>>> +       if (!p.vec)
> >>>>>>>> +               return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +       walk_start =3D walk_end =3D start;
> >>>>>>>> +       while (walk_end < end && !ret) {
> >>>>>>>
> >>>>>>> The loop will stop if a previous iteration returned ENOSPC (and t=
he
> >>>>>>> error will be lost) - is it intended?
> >>>>>> It is intentional. -ENOSPC means that the user buffer is full even=
 though
> >>>>>> there was more memory to walk over. We don't treat this error. So =
when
> >>>>>> buffer gets full, we stop walking over further as user buffer has =
gotten
> >>>>>> full and return as success.
> >>>>>
> >>>>> Thanks. What's the difference between -ENOSPC and
> >>>>> PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (co=
de
> >>>>> flow).
> >>>> -ENOSPC --> user buffer has been filled completely
> >>>> PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer m=
ay
> >>>>                             still have more space
> >>>
> >>> What is the difference in code behaviour when those two cases are
> >>> compared? (I'd expect none.)
> >> There is difference:
> >> We add data to user buffer. If it succeeds with return code 0, we enga=
ge
> >> the WP. If it succeeds with PM_SCAN_FOUND_MAX_PAGES, we still engage t=
he
> >> WP. But if we get -ENOSPC, we don't perform engage as the data wasn't =
added
> >> to the user buffer.
> >
> > Thanks! I see it now. I see a few more corner cases here:
> > 1. If we did engage WP but fail to copy the vector we return -EFAULT
> > but the WP is already engaged. I'm not sure this is something worth
> > guarding against, but documenting that would be helpful I think.
> Sure.
>
> > 2. If uffd_wp_range() fails, but we have already processed pages
> > earlier, we should treat the error like ENOSPC and back out the failed
> > range (the earier changes would be lost otherwise).
> Backing out is easier to do for hugepages. But for normal pages, we'll ha=
ve
> to write some code to find where the current data was added (in cur or in
> vec) and back out from that. I'll have to write some more code to avoid t=
he
> side-effects as well.

If I read the code correctly, the last page should always be in `cur`
and on failure only a single page is needed to be backed out. Did I
miss something?

> But aren't we going over-engineering here? Error occurred and we are tryi=
ng
> to keep the previously generated correct data and returning successfully
> still to the user? I don't think we should do this. An error is error. We
> should return the error simply even if the memory flags would get lost. W=
e
> don't know what caused the error in uffd_wp_range(). Under normal
> situation, we there shouldn't have had error.

In this case it means that on (intermittent) allocation error we get
inconsistent or non-deterministic results. I wouldn't want to be the
one debugging this later - I'd prefer either the syscall be
"exception-safe" (give consistent and predictable output) or kill the
process.

Best Regards
Micha=C5=82 Miros=C5=82aw
