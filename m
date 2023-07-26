Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB77640F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjGZVKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGZVKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:10:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C11FFA
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so4647a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690405845; x=1691010645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwlPGFA6Wt4wHaQbg7XU0SaMv13PMQh8DDGdrKpf/oA=;
        b=eLu+gNofp9wRbALE2bkVYGmwGJxPl36LCy1T4+1JgQnamYSfKJ9xDY86bimfkqoGIQ
         zvgmsb7odQAULMETzbuIwLSJWIQ/Fwquxp67SYVP8fIfPzevZLwU33RjsCF5loWfigIi
         D8J4p2w/m17TwgF7ZjEcVORxUQWSKgUpBlnqLCLO4uiCN/AITyww9rYNx7N4V3GnnYo0
         HquyCXm2Odan4UPZidq5GwLDJdEDg9GXDQmUCnqz6MGT0lKOyrxtKU8w/LD8/mwZSugI
         gH5NOFaIeUr6rA5zO0GBlWhk+rwHe8158VQtUck3GyvOBRGBVJ8hg9PlIx1e1hVSXqyV
         yI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405845; x=1691010645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwlPGFA6Wt4wHaQbg7XU0SaMv13PMQh8DDGdrKpf/oA=;
        b=IvtNoWxlKThW8VdmnzlYKQlyIUx+1dglsZMpSbOkL6n5/WXac7vrJ43YY5k1GRAYbA
         /bvfvcdyHh2GiU5194uCpONqHV79aO0u+0Vx8az5GF+U/lYymSzU3cRJxN0V3OPSI33w
         XwIwbKKxnfLZvJXpjdZ/U4vLwzo452L6bDZEyum5NoocIw5EkVSHxj2+HOvVnXo32X49
         NKRZq15MuG1ksWaxjI8AxAMIZ7v8kKQmTzmCJ032aiSrAvdNXXwDPIUZ62qmaLXAXwUn
         HIFDnFCZS+SxHXcqjL5SYDGgfftsTvPaiXzY67m1rv00h7ngHDIfWa2w9AImH8BjLZwl
         SA5A==
X-Gm-Message-State: ABy/qLbMgzX/Q+T/S0Y8GPa6l9HAl6AIhR/sk9YYKqHoxf8p91VC85e2
        LvcdioauuYXsDW1IGef8lnPqrm7MEYPP8cy4Jz8iog==
X-Google-Smtp-Source: APBJJlHivbRzuJT8P6p6jbxegWClyIOonCFtye/wSfmGogOINZRhaBvz2SCuEPMI1MLUCqxE5bFrkaSD3dQXAy/1y34=
X-Received: by 2002:a50:d797:0:b0:522:4741:d992 with SMTP id
 w23-20020a50d797000000b005224741d992mr34619edi.4.1690405844799; Wed, 26 Jul
 2023 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com> <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com> <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com> <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com> <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com> <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
 <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com> <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
 <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
In-Reply-To: <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 26 Jul 2023 23:10:33 +0200
Message-ID: <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table scanning
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
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

On Wed, 26 Jul 2023 at 10:34, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 7/25/23 11:05=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 25 Jul 2023 at 11:11, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> ----
> >> Michal please post your thoughts before I post this as v26.
> >> ----
> > [...]
> >
> > Looks ok - minor things below.
> >
> > 1. I'd change the _WPASYNC things to something better, if this can
> > also work with "normal" UFFD WP.
> Yeah, but we don't have any use case where UFFD WP is required. It can be
> easily added later when user case arrives. Also UFFD WP sends messages to
> userspace. User can easily do the bookkeeping in userspace as performance
> isn't a concern there.

We shouldn't name the flags based on the use case but based on what
they actually do. So if this checks UFFD registration for WP, then
maybe PAGE_IS_WPALLOWED or something better describing the trait it
matches?

> > 2. For the address tagging part I'd prefer someone who knows how this
> > is used take a look. We're ignoring the tag (but clear it on return in
> > ->start) - so it doesn't matter for the ioctl() itself.
> I've added Kirill if he can give his thoughts about tagged memory.
>
> Right now we are removing the tags from all 3 pointers (start, end, vec)
> before using the pointers on kernel side. But we are overwriting and
> writing the walk ending address in start which user can read/use.
>
> I think we shouldn't over-write the start (and its tag) and instead retur=
n
> the ending walk address in new variable, walk_end.

The overwrite of `start` is making the ioctl restart (continuation)
easier to handle. I prefer the current way, but it's not a strong
opinion.

> > 3. BTW, One of the uses is the GetWriteWatch and I wonder how it
> > behaves on HugeTLB (MEM_LARGE_PAGES allocation)? Shouldn't it return a
> > list of huge pages and write *lpdwGranularity =3D HPAGE_SIZE?
> Wine/Proton doesn't used hugetlb by default. Hugetlb isn't enabled by
> default on Debian as well. For GetWriteWatch() we don't care about the
> hugetlb at all. We have added hugetlb's implementation to complete the
> feature and leave out something.

How is GetWriteWatch() working when passed a VirtualAlloc(...,
MEM_LARGE_PAGES|MEM_WRITE_WATCH...)-allocated range? Does it still
report 4K pages?
This is only a problem when using max_pages: a hugetlb range might
need counting and reporting huge pages and not 4K parts.

Best Regards
Micha=C5=82 Miros=C5=82aw
