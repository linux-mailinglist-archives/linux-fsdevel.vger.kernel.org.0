Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210F3704B0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhEABdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 21:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:33:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E4C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 18:32:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y2so3265288plr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=A2A0sc0ibpGRObArrf856v6artvUyLBvrSP/rauEHZM=;
        b=dTdzE/ywka9nrPdX+QwFz6j9UB51qNNcagD7P92W4OSxbEerkeF+CUzs5nF07mGi9v
         RfvzodgfrTFRe7e/45aajNmewKM4Aox8rz84W2WO311ZE4+h4dDpTToeGJWG2h7yw5O8
         KTD+beFgdQkbWlSnx7RLiLrD1X9Gf3+Taqf1HZVUz9Yk0FCHxr7U94P0yuDa41V1scHe
         Quk1/dAv9rBITiUL/x2C+F0ZvAHMz1mI78zOWL/ffb7csu/k5GlmUllqexjtrPiAKR4Z
         J2Nh7R8nrNSHDMJlXINfSOZPoPWplFH1x64oEuKPU/xSt4s8iad6dMKibYp9e6kbyrXI
         Z6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=A2A0sc0ibpGRObArrf856v6artvUyLBvrSP/rauEHZM=;
        b=fjBmfBOJCgsYZhiRNfq90lkzfR0rO58bqvGh9b59Cvqtf0anWVBpnLxmvNs5ln+cxl
         sYTn8YS6MgLlEYJzQfhPKbp0d2AO0S7ZcErTM71kGOC7nULHkndnyDGAFC5X1+i/p9ck
         g4Petafq14/7Jfe7KpXGIPJ9rBS6BlBDYu0U41z//Nin35tIxF0nEEYwrTHoH7rG6vQK
         4KrigPWSfi3HIOPkAlOfLkMF5IaNzcQYx1X0OnTxqccjRG5jhoKiVZPlC9/oLnXClffO
         dry3Uaws881IVo8YEk6Yx4U8UmdtIzzB1w1gMOMQV0BGxRzaHJ0d+aAbfbwztN8fB0Xy
         6CLQ==
X-Gm-Message-State: AOAM530tHwwMrNdLOqBj1WlKuigQOrXtzwROaa6HJol9nUKqGl+xzFqq
        gtB62HG2sEp04A4vr1KZiWqdCbfIuvSzcQ==
X-Google-Smtp-Source: ABdhPJz3GeJE6oOuurnasV8V+UQQcA8JLk4FTbqtTR91l8SpVcMKLWi5PaLuQ8u2hIX6JuhWMNYWdQ==
X-Received: by 2002:a17:90a:de09:: with SMTP id m9mr7830662pjv.41.1619832745434;
        Fri, 30 Apr 2021 18:32:25 -0700 (PDT)
Received: from localhost ([61.68.127.20])
        by smtp.gmail.com with ESMTPSA id w14sm3279317pfn.3.2021.04.30.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 18:32:25 -0700 (PDT)
Date:   Sat, 01 May 2021 11:32:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8.1 00/31] Memory Folios
To:     Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <20210430180740.2707166-1-willy@infradead.org>
        <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
MIME-Version: 1.0
Message-Id: <1619832406.8taoh84cay.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Hugh Dickins's message of May 1, 2021 4:47 am:
> Adding Linus to the Cc (of this one only): he surely has an interest.
>=20
> On Fri, 30 Apr 2021, Matthew Wilcox (Oracle) wrote:
>=20
>> Managing memory in 4KiB pages is a serious overhead.  Many benchmarks
>> benefit from a larger "page size".  As an example, an earlier iteration
>> of this idea which used compound pages (and wasn't particularly tuned)
>> got a 7% performance boost when compiling the kernel.
>>=20
>> Using compound pages or THPs exposes a serious weakness in our type
>> system.  Functions are often unprepared for compound pages to be passed
>> to them, and may only act on PAGE_SIZE chunks.  Even functions which are
>> aware of compound pages may expect a head page, and do the wrong thing
>> if passed a tail page.
>>=20
>> There have been efforts to label function parameters as 'head' instead
>> of 'page' to indicate that the function expects a head page, but this
>> leaves us with runtime assertions instead of using the compiler to prove
>> that nobody has mistakenly passed a tail page.  Calling a struct page
>> 'head' is also inaccurate as they will work perfectly well on base pages=
.
>>=20
>> We also waste a lot of instructions ensuring that we're not looking at
>> a tail page.  Almost every call to PageFoo() contains one or more hidden
>> calls to compound_head().  This also happens for get_page(), put_page()
>> and many more functions.  There does not appear to be a way to tell gcc
>> that it can cache the result of compound_head(), nor is there a way to
>> tell it that compound_head() is idempotent.
>>=20
>> This series introduces the 'struct folio' as a replacement for
>> head-or-base pages.  This initial set reduces the kernel size by
>> approximately 6kB by removing conversions from tail pages to head pages.
>> The real purpose of this series is adding infrastructure to enable
>> further use of the folio.
>>=20
>> The medium-term goal is to convert all filesystems and some device
>> drivers to work in terms of folios.  This series contains a lot of
>> explicit conversions, but it's important to realise it's removing a lot
>> of implicit conversions in some relatively hot paths.  There will be ver=
y
>> few conversions from folios when this work is completed; filesystems,
>> the page cache, the LRU and so on will generally only deal with folios.
>>=20
>> The text size reduces by between 6kB (a config based on Oracle UEK)
>> and 1.2kB (allnoconfig).  Performance seems almost unaffected based
>> on kernbench.
>>=20
>> Current tree at:
>> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/=
folio
>>=20
>> (contains another ~120 patches on top of this batch, not all of which ar=
e
>> in good shape for submission)
>>=20
>> v8.1:
>>  - Rebase on next-20210430
>>  - You need https://lore.kernel.org/linux-mm/20210430145549.2662354-1-wi=
lly@infradead.org/ first
>>  - Big renaming (thanks to peterz):
>>    - PageFoo() becomes folio_foo()
>>    - SetFolioFoo() becomes folio_set_foo()
>>    - ClearFolioFoo() becomes folio_clear_foo()
>>    - __SetFolioFoo() becomes __folio_set_foo()
>>    - __ClearFolioFoo() becomes __folio_clear_foo()
>>    - TestSetPageFoo() becomes folio_test_set_foo()
>>    - TestClearPageFoo() becomes folio_test_clear_foo()
>>    - PageHuge() is now folio_hugetlb()

If you rename these things at the same time, can you make it clear=20
they're flags (folio_flag_set_foo())? The weird camel case accessors at=20
least make that clear (after you get to know them).

We have a set_page_dirty(), so page_set_dirty() would be annoying.
page_flag_set_dirty() keeps the easy distinction that SetPageDirty()
provides.

Thanks,
Nick

