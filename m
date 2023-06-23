Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D273B3E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFWJoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 05:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFWJod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:44:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE272100
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 02:44:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so5606a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687513466; x=1690105466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uECgceGWceBpnEwgVEt1AFSmdXNTa/+8ZyNWq8IpWMk=;
        b=Kbr+ZwwHYHvA0TCLJ0MdIwK/ccEwxx5KSPma0dmAvQIY6kj9M5JLiT59I+c/izkmv2
         n9pmwQxDJQNjmwworyPbaKeC3Ld8nQ4YzJQUl81n0uzJKWW+y1YBMTq+bAxjaNy+2Uk1
         2+c6VxKT2l9oN0UJs9rmXFiz2wziDEW+FMecIVeRpyPC+3p6h7YtB2bWAnfvkjFG019s
         SvcL3SBhcYvAVeuiLFX4CwomKL1yZfd3JUWKnS/0/hgwcAMoHAZfCNAKfXwtIiCjg6jh
         Ae993CrxqBpmSq0aTmVtiKkCd/JgjSefymLwf4R5lFK8ec0c85cp6c0CFc3gblvcnhWa
         1m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513466; x=1690105466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uECgceGWceBpnEwgVEt1AFSmdXNTa/+8ZyNWq8IpWMk=;
        b=WTyEAgLF9eudhyDcRP2rnQ0YDwNEBDFrg0TlAaj7yiDLMDAeHrCbi2oBBQW1Uo4bW5
         M8Sv/gjQBNUToguzerrfGAdXO2LMpuDqjH/IBo4MyoO9kU0eKKPVvkBcvE2BdE8/OKgC
         6jCvRec1u5YYfRsL7EMjPdEpBS2EdA8jJSHXAoKDhMNvqBbpHbpOKnRgDW5rEy0Nlq65
         dkyp/KU3sqO6xjCHILqv6x6S/agVOQZLaLSdSmsFi80Hl9PFizHoAg8v+w4mS9vHaqRA
         DpMrFvXeIEsVe7E3awHk+/k7g8yf77XfmmzsbvOuFWXX/+wmkEgw7iO46kOt7qUsY4gZ
         cG5A==
X-Gm-Message-State: AC+VfDxl8DNTiLuXlY0/WoFKnBJAIqNWqUwOY0y0ceEykaJEp0GrBPDt
        FhHnDzCkl6qyzOIrIK/PjO2SDnYTxtrQ+sGkqPGVZg==
X-Google-Smtp-Source: ACHHUZ6rqOZ455iJdXd6CS4M6p+mA/ZNKARrMmKzGjtlcQiR2QyldrbL8+MKATVwRLr7V20zWPJywlF1j6AsPkZ9OkM=
X-Received: by 2002:a50:d08c:0:b0:516:6453:1b76 with SMTP id
 v12-20020a50d08c000000b0051664531b76mr51906edd.5.1687513465752; Fri, 23 Jun
 2023 02:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230615141144.665148-1-usama.anjum@collabora.com>
 <20230615141144.665148-3-usama.anjum@collabora.com> <ZJHp6hSeS6lMo7qx@gmail.com>
 <1c1beeda-ceed-fdab-bbf5-1881e0a8b102@collabora.com> <ZJNTWV+JZ+tTMdcp@gmail.com>
 <c8c3f983-8189-e602-157a-84ca1d8984dd@collabora.com>
In-Reply-To: <c8c3f983-8189-e602-157a-84ca1d8984dd@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 23 Jun 2023 11:44:14 +0200
Message-ID: <CABb0KFFEiTr4TfYnAOOd8tODEaY_KBE2EjNBEJqX6RjxZpCjZA@mail.gmail.com>
Subject: Re: [PATCH v19 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 22 Jun 2023 at 12:21, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 6/22/23 12:45=E2=80=AFAM, Andrei Vagin wrote:
> > On Wed, Jun 21, 2023 at 11:34:54AM +0500, Muhammad Usama Anjum wrote:
> >> On 6/20/23 11:03=E2=80=AFPM, Andrei Vagin wrote:
[...]
> >>> should it be PM_SCAN_FOUND_MAX_PAGES? Otherwise, it fails the ioctl e=
ven
> >>> if it has handled some pages already.
> >> It is a double edge sword. If we don't return error, user will never k=
now
> >> that he needs to specify more max_pages or his output buffer is small =
and
> >> not coverig the entire range. The real purpose here that user gets awa=
re
> >> that he needs to specify full hugetlb range and found pages should cov=
er
> >> the entire range as well.
> >
> > but if PM_SCAN_OP_WP is set, this error will be fatal, because some
> > pages can be marked write-protected, but they are not be reported to
> > user-space.
> >
> > I think the ioctl has to report back the end address of the handled
> > region. It is like read and write syscalls that can return less data
> > than requested.
> This is good point. I'll abort the walk here instead of retuning the erro=
r
> to user.

It would be great if the ioctl returned the address the walk finished
at. This would remove the special case for "buffer full after full
page was added" and if it happens that despite `max_pages` limit was
reached but no more pages would need to be added the caller would not
have to call the ioctl again on the remaining range.

[...]
> >>> How long can it take to run this loop? Should we interrupt it if a
> >>> signal has been queued?
> >> I'm following mincore and pagemap_read here. There is no such thing th=
ere.
> >> IOCTL is performing what user has requested.
> >
> > In case of pagemap, its buffer is limited by MAX_RW_COUNT (0x7ffff000),
> > so it can handle maximum 0xffffe00 pages in one iteration.  Do you have=
 any
> > limits for input parameters?
> >
> >> If the execution time is a
> >> concern, user should have called the IOCTL on shorter address range.
> >
> > It doesn't work this way. There can be many users and signals has to be
> > delivered in a reasonable time. One of the obvious examples when a sign=
al
> > has to be delivered asap is OOM.
> This IOCTL is just like mincore, but with other flags and functionalities=
.
> Mincore doesn't put any limit like this. I don't think we should put any
> limit here as well.

I don't think we should treat mincore() as a good API example. Its
interface has similar performance problems to what select() or poll()
does. In this ioctl's case, we can limit the output at this end (large
anyway) as it won't affect the performance if for x TiB of memory the
call is made twice instead of once. (Returning the end of the walk
reached would be much help here.)

Best Regards
Micha=C5=82 Miros=C5=82aw
