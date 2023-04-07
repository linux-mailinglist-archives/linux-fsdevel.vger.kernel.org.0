Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228A6DAB48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjDGKOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDGKOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:14:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA94903F
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 03:14:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-4fb22f1f91eso1636760a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680862454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quNG0/wNI8R4PE48ZPLbRS2Bu1I51NvVN8NOjnDtCG0=;
        b=JcECVJwtE1OnPOTAeOUPTVfA5DreOqkA9WYtxG4fnxJ2f84SN0+8ur0Ij38TZ8F0Ey
         +E13rWXKyFkyiraUO9dvaxcoIGBpad6Smc5H/L0RqNZIZAWzdTcVOdfJOfMIm8jSVfCa
         dVUOxoHjI8FYYh81x6bvI4Iyqv1qpTo/1PFxUIzz4uNQycwswnWKDnG67CpXYPbcRKgr
         qy60/lnshum8MWT71alOWw3DaYY+8VovHIAVLaq4nbKhDRIvehY2B7kz/VcMFOHLtrVZ
         pvzCSfY9mGlE9CYYde3Oac6L/GEcJ8D3gTkfFQ9fofuHnwENI/JreGFoq4iROZS9ApaL
         QyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680862454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quNG0/wNI8R4PE48ZPLbRS2Bu1I51NvVN8NOjnDtCG0=;
        b=SpxS6jBnmRq8MNrw/n7oRnv59nlW20sftY9cBYrG7Rh6F2vFrdscxcgvOKqv2x5xzN
         tFPZWKihuzXT3ff+Umw9lRfRXL5L001FtZ37e74G9f6ZIng3bUq9ZR99PxDBftof2Eyu
         lAnWagEOxf9QHg0GtMiTnTpcmYKJ8DUL0nzMMtx6UAhg0EUv/C/QJ9Ua6ngDPI5hFhdy
         b5/AS/vnbYvZdwGd1v0NYiABqoTCQwx9AqpbtJEqNVmFGtp7YzESpVOfDakDtD/KQxNO
         jskO4nA1dpvq9zYAPMW9WVf0EKRg/aaPuQoi8PL4fuHI4CVFFGhmIpZudjjGSlpZoiz5
         oHIw==
X-Gm-Message-State: AAQBX9dxUoaWl8H+L1dUH1pCAkWIVFzmsNpHdPKL9+lHzRYbscAaLCZ5
        5YHPjOcU/Hise7fLb7qj1Lr56/kJD+1DHkBKDRRnog==
X-Google-Smtp-Source: AKy350aXhjdkSqobczCxGxZfYh9g2IVUgJJqiGQ7eeBTICfWYwKlrYT86twOyByKnkSZt/pnAlZQTgEbn3ZN2++tDSk=
X-Received: by 2002:a50:cd84:0:b0:4ad:6052:ee90 with SMTP id
 p4-20020a50cd84000000b004ad6052ee90mr1254691edi.7.1680862454074; Fri, 07 Apr
 2023 03:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com> <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
 <8a837998-604f-a871-729e-aa274a621481@collabora.com> <CABb0KFEBqAMWWpAeBfqzA4JrHo3yLyaT0rqKTUn28O0hE+szBA@mail.gmail.com>
 <c5b9201d-141c-10ae-0475-4b230d36508b@collabora.com>
In-Reply-To: <c5b9201d-141c-10ae-0475-4b230d36508b@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 7 Apr 2023 12:14:02 +0200
Message-ID: <CABb0KFH3mj5qt22qDLHRKjh-wB7Jrn6Pz8h-QARaf9oR65U0Qg@mail.gmail.com>
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

On Fri, 7 Apr 2023 at 12:04, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 12:34=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 6 Apr 2023 at 23:04, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 4/7/23 1:00=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
[...]
> >>>>>> +       /*
> >>>>>> +        * Allocate smaller buffer to get output from inside the p=
age walk
> >>>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size=
 chunks. As
> >>>>>> +        * we want to return output to user in compact form where =
no two
> >>>>>> +        * consecutive regions should be continuous and have the s=
ame flags.
> >>>>>> +        * So store the latest element in p.cur between different =
walks and
> >>>>>> +        * store the p.cur at the end of the walk to the user buff=
er.
> >>>>>> +        */
> >>>>>> +       p.vec =3D kmalloc_array(p.vec_len, sizeof(struct page_regi=
on),
> >>>>>> +                             GFP_KERNEL);
> >>>>>> +       if (!p.vec)
> >>>>>> +               return -ENOMEM;
> >>>>>> +
> >>>>>> +       walk_start =3D walk_end =3D start;
> >>>>>> +       while (walk_end < end && !ret) {
> >>>>>
> >>>>> The loop will stop if a previous iteration returned ENOSPC (and the
> >>>>> error will be lost) - is it intended?
> >>>> It is intentional. -ENOSPC means that the user buffer is full even t=
hough
> >>>> there was more memory to walk over. We don't treat this error. So wh=
en
> >>>> buffer gets full, we stop walking over further as user buffer has go=
tten
> >>>> full and return as success.
> >>>
> >>> Thanks. What's the difference between -ENOSPC and
> >>> PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
> >>> flow).
> >> -ENOSPC --> user buffer has been filled completely
> >> PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer may
> >>                             still have more space
> >
> > What is the difference in code behaviour when those two cases are
> > compared? (I'd expect none.)
> There is difference:
> We add data to user buffer. If it succeeds with return code 0, we engage
> the WP. If it succeeds with PM_SCAN_FOUND_MAX_PAGES, we still engage the
> WP. But if we get -ENOSPC, we don't perform engage as the data wasn't add=
ed
> to the user buffer.

Thanks! I see it now. I see a few more corner cases here:
1. If we did engage WP but fail to copy the vector we return -EFAULT
but the WP is already engaged. I'm not sure this is something worth
guarding against, but documenting that would be helpful I think.
2. If uffd_wp_range() fails, but we have already processed pages
earlier, we should treat the error like ENOSPC and back out the failed
range (the earier changes would be lost otherwise).

Best Regards
Micha=C5=82 Miros=C5=82aw
