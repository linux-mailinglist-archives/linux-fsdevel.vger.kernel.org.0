Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598D6DA972
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjDGHfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjDGHe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:34:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669FA5D3
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 00:34:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94748e41044so135898766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680852892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xufJewXyhNV91ceoQQRbqkfFuhj5XUSD9386rC0IB28=;
        b=gDMbr9D7tJfW5EhGD1TauIK78v+jZ7HUY7e7xfnLQhu1bEnuRBb0SqZjJ51+UqnBdc
         QrABNaCBE42IvweCIbz+OmT7FfcD6fDU31Aj8En6ELtBabJM0gTH+lLXGmKH/DZRtp+P
         FfNP2yFQVIMY0xfUglALIrdcxAM40WZgLRaKlFjvmvF8nzE0LpLZqVSTArizOpK6o86n
         F59MbAyWPqLUz1onQKYeDGol9W6HmV3j24HnaNBKgFUPpu5qPJSUTORcD+uWZSzrhoJH
         Gft2x4kLBBdmGR32hJdvvPnUqtQCfIryMpFtmCWIgxEzTKwurrEKiBUVgyu4XHizGsur
         iMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xufJewXyhNV91ceoQQRbqkfFuhj5XUSD9386rC0IB28=;
        b=tOZU9yJ2ecO2/M9yXTckx7+uuoQTVMmMsnqad+ScLBNuQfG2dm5bdd3A+fErsCWxs0
         S/46ShRoeVOQ4+P2rTj3nvv5QpXqPuqGLz6qte02gJ8uL/HmEwKY4x/lAZ4N37syzVfT
         9qzZK1g0Sj+A1YwfE/7w/wV1NPz9ITISPfucM40Xs2bMtPpe5XVXKHkOFEA+QwczNESG
         OvWr7H/wbIJYcsj7A1GGul7vqbMtUv3Ll/QUEydRfwFuU4GQlVzI3+4+bwVBaLPE9W69
         h2UnfSc9uUBG+vmKQVQlXOdjq/3jCzWlFmBlTwLJIomllYZHZy2sNFADaKnF/9QVA7AR
         FYcw==
X-Gm-Message-State: AAQBX9coUwnqMON/f25mD439laU/Gny9P7ssQU+HBUo8UNF7xgTFQGnu
        vidaM89iZa3wrfdMsqVTMEkk7IUR6dzHnPPNPzptjw==
X-Google-Smtp-Source: AKy350bF8961SbdQkzvhhN/J2V2TxAtpP2NJYlX5JDDN+lnoULk6K/VoRyybz83rRM6Adk8ORW5BfMtw4ISKJ9e8OKk=
X-Received: by 2002:a50:d716:0:b0:502:6d4b:40f5 with SMTP id
 t22-20020a50d716000000b005026d4b40f5mr997137edi.7.1680852891875; Fri, 07 Apr
 2023 00:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com> <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
 <8a837998-604f-a871-729e-aa274a621481@collabora.com>
In-Reply-To: <8a837998-604f-a871-729e-aa274a621481@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 7 Apr 2023 09:34:40 +0200
Message-ID: <CABb0KFEBqAMWWpAeBfqzA4JrHo3yLyaT0rqKTUn28O0hE+szBA@mail.gmail.com>
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

On Thu, 6 Apr 2023 at 23:04, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 1:00=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
[...]
> >>>> +               cur->len +=3D n_pages;
> >>>> +               p->found_pages +=3D n_pages;
> >>>> +
> >>>> +               if (p->max_pages && (p->found_pages =3D=3D p->max_pa=
ges))
> >>>> +                       return PM_SCAN_FOUND_MAX_PAGES;
> >>>> +
> >>>> +               return 0;
> >>>> +       }
> >>>> +
> >>>> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {
> >>>
> >>> It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
> >>> have vec_len =3D=3D 0 here, then we'd not fit the entry in the usersp=
ace
> >>> buffer anyway. Am I missing something?
> >> No. I'd explained it with diagram last time:
> >> https://lore.kernel.org/all/3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@colla=
bora.com
> >>
> >> I'll add a concise comment here.
> >
> > So it seems, but I think the code changed a bit and maybe could be
> > simplified now? Since p->vec_len =3D=3D 0 is currently not valid, the
> > field could count only the entries available in p->vec[] -- IOW: not
> > include p->cur in the count.
> I see. But this'll not work as we need to count p->cur to don't go above
> the maximum count, p->vec_size.

You can subtract 1 from p->vec_size before the page walk to account
for the buffer in `cur`.

[...]
> >>>> +static inline int pagemap_scan_deposit(struct pagemap_scan_private =
*p,
> >>>> +                                      struct page_region __user *ve=
c,
> >>>> +                                      unsigned long *vec_index)
> >>>
> >>> ..._deposit() is used only in single place - please inline.
> >> It is already inline.
> >
> > Sorry. I mean: please paste the code in place of the single call.
> I've made it a separate function to make the code look better in the call=
er
> function and logically easier to understand. This function is ugly.
> do_pagemap_scan() is also already very long function with lots of things
> happening. If you still insist, I'll remove this function.

Please do remove - it will make the copy to userspace code all neatly toget=
her.

[...]
> >>>> +                */
> >>>> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
> >>>> +                   ((end - start < HPAGE_SIZE) ||
> >>>> +                    (p->max_pages &&
> >>>> +                     (p->max_pages - p->found_pages) < n_pages))) {
> >>>> +
> >>>> +                       split_huge_pmd(vma, pmd, start);
> >>>> +                       goto process_smaller_pages;
> >>>> +               }
> >>>> +
> >>>> +               if (p->max_pages &&
> >>>> +                   p->found_pages + n_pages > p->max_pages)
> >>>> +                       n_pages =3D p->max_pages - p->found_pages;
> >>>> +
> >>>> +               ret =3D pagemap_scan_output(is_written, is_file, is_=
present,
> >>>> +                                         is_swap, p, start, n_pages=
);
> >>>> +               if (ret < 0)
> >>>> +                       return ret;
> >
> > So let's simplify this:
> >
> > if (p->max_pages && n_pages > max_pages - found_pages)
> >   n_pages =3D max_pages - found_pages;
> >
> > if (is_written && DO_WP && n_pages !=3D HPAGE_SIZE / PAGE_SIZE) {
> >   split_thp();
> >   goto process_smaller_pages;
> > }
> Clever!! This looks very sleek.
>
> >
> > BTW, THP handling could be extracted to a function that would return
> > -EAGAIN if it has split the page or it wasn't a THP -- and that would
> > mean `goto process_smaller_pages`.
> Other functions in this file handle the THP in this same way. So it feels
> like more intuitive that we follow to same pattern in this file.

I'll leave it to you. Extracting THP support would avoid a goto and
#ifdef inside a function, though (and make the function smaller).

> >>>> +       /*
> >>>> +        * Allocate smaller buffer to get output from inside the pag=
e walk
> >>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size c=
hunks. As
> >>>> +        * we want to return output to user in compact form where no=
 two
> >>>> +        * consecutive regions should be continuous and have the sam=
e flags.
> >>>> +        * So store the latest element in p.cur between different wa=
lks and
> >>>> +        * store the p.cur at the end of the walk to the user buffer=
.
> >>>> +        */
> >>>> +       p.vec =3D kmalloc_array(p.vec_len, sizeof(struct page_region=
),
> >>>> +                             GFP_KERNEL);
> >>>> +       if (!p.vec)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       walk_start =3D walk_end =3D start;
> >>>> +       while (walk_end < end && !ret) {
> >>>
> >>> The loop will stop if a previous iteration returned ENOSPC (and the
> >>> error will be lost) - is it intended?
> >> It is intentional. -ENOSPC means that the user buffer is full even tho=
ugh
> >> there was more memory to walk over. We don't treat this error. So when
> >> buffer gets full, we stop walking over further as user buffer has gott=
en
> >> full and return as success.
> >
> > Thanks. What's the difference between -ENOSPC and
> > PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
> > flow).
> -ENOSPC --> user buffer has been filled completely
> PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer may
>                             still have more space

What is the difference in code behaviour when those two cases are
compared? (I'd expect none.)

Best Regards
Micha=C5=82 Miros=C5=82aw
