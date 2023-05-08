Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFB6FB861
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 22:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEHUkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjEHUkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 16:40:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96059F5
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 13:40:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso36655713276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683578408; x=1686170408;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zp9MF4afK7LOvc1F2U5JVnBUybefUQdIksarawJ2o+k=;
        b=HGgJ4D5cDpYlkabNRd1PNopWqWAJ436/Ae803Xn1AOz7pwbztYV2/Tl/mrT6SBh+pI
         j0RI67jevmzkktR8gSWIFEXFTUvvw4K866R2Uthrqz2dQYNtIqGCOeviEQkYWBo7KlJq
         7/+BmWM5owKUlDUm1b0FDW9Z989glOz5nPUAxilSrGyENKKqR3ZOwHB/xzJBH+z5oA5P
         OpW2NiJLSJAJ9S+ltwAfV4afVKO1RQ9qRwTrSi4hysguEfpj4czRiRvBrjrbcVX6mFVI
         IKQjm0+TMHIsQklQddq0AlyGV5fN99oewNxdUDPoBQFiJ0Hzwa4SsVAz16gjjJghKrDV
         JZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578408; x=1686170408;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp9MF4afK7LOvc1F2U5JVnBUybefUQdIksarawJ2o+k=;
        b=PfQ4Wk7Ayky0lFCyLc0RyxSOO/Cf9bYFLpaJyecwlOKN1f3BjIqpDZiruO1Amwv733
         NLPyGb5++AZYxPNNXWwPXv5VdTDOsL2AT/u3HbpD7DUYl81D04trGlM5xPM5QN+TGF8A
         M/5B5Cq4K0DY+EdqKIguCkaasEv61w+gbUDTmLTlJmDdLcmnd5HOjRwd2o06vHYG/a14
         JW6tKplDRvyioVhd0Brbia1TtmdUhSwb9DLh9rjstW0SMEnU9Tq4TwxCPlampHNIblgC
         lcMnJy7PurOVsqY0z0bEHCuYNO0McxgGs8RhobQ076RIJ9sny58RPJGR2J5wgcGDsLRX
         IH0w==
X-Gm-Message-State: AC+VfDxKZqiuPWtD1Ju37INUE4n/8cdUdamcLOh/Hie+zSnP2Ka05jQg
        RbhH7HXjURbJvoRoPplL/+1P2PvQsMLXovb2HQ==
X-Google-Smtp-Source: ACHHUZ6UCLfD1sTZmb/EWhwwc/INAhyN/1c7ic2WE25k5j68yRheUtzOOBb/+fOVm4BYPuVNYnr1CfTSC+f5iScc5w==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:990:b0:b8f:5b11:6d6c with
 SMTP id bv16-20020a056902099000b00b8f5b116d6cmr7998217ybb.1.1683578408608;
 Mon, 08 May 2023 13:40:08 -0700 (PDT)
Date:   Mon, 08 May 2023 20:40:07 +0000
In-Reply-To: <diqz5y92g51y.fsf@ackerleytng-ctop.c.googlers.com> (message from
 Ackerley Tng on Mon, 08 May 2023 16:29:29 +0000)
Mime-Version: 1.0
Message-ID: <diqz3546ftg8.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit in
 page cache
From:   Ackerley Tng <ackerleytng@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     mike.kravetz@oracle.com, willy@infradead.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, jhubbard@nvidia.com,
        vannapurve@google.com, erdemaktas@google.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I figured it out, the bug is still in the use of page_cache_next_miss(),
but my earlier suggestion that xas_next always advances the pointer is
wrong.

Mike is right in that xas_next() is effectively xas_load() for the first
call after an XA_STATE() initialiation.

However, when max_scan is set to 1, xas.xa_index has no chance to be
advanced since the loop condition while(max_scan--) terminates the loop
after 1 iteration.

Hence, after loading happens with xas_next() regardless of the checks
within the loop (!entry, or xa_is_value(entry), etc), xa.xas_index is
not advanced, and the index returned always == the index passed in to
page_cache_next_miss().

Hence, in hugetlb_fallocate(), it always appears to be a page cache
miss.

Here's code from a selftest that can be added to lib/test_xarray.c:

/* Modified from page_cache_next_miss() */
static unsigned long xa_next_empty(struct xarray *xa, unsigned long start,  
unsigned long max_scan)
{
	XA_STATE(xas, xa, start);

	while (max_scan--) {
		void *entry = xas_next(&xas);
		if (!entry) {
			printk("entry not present");
			break;
		}
		if (xa_is_value(entry)) {
			printk("xa_is_value instead of pointer");
		}
		if (xas.xa_index == 0) {
			printk("wraparound");
			break;
		}
	}

	if (max_scan == -1)
		printk("exceeded max_scan");

	return xas.xa_index;
}

/* Replace this function in lib/test_xarray.c to run */
static noinline void check_find(struct xarray *xa)
{
	unsigned long max_scan;

	xa_init(&xa);
	xa_store_range(&xa, 3, 5, malloc(10), GFP_KERNEL);

	max_scan = 1;
	for (int i = 1; i < 8; i++)
		printk(" => xa_next_empty(xa, %d, %ld): %ld\n", i, max_scan,  
xa_next_empty(&xa, i, max_scan));

	printk("\n");

	max_scan = 2;
	for (int i = 1; i < 8; i++)
		printk(" => xa_next_empty(xa, %d, %ld): %ld\n", i, max_scan,  
xa_next_empty(&xa, i, max_scan));
}

Result:

entry not present => xa_next_empty(xa, 1, 1): 1
entry not present => xa_next_empty(xa, 2, 1): 2
exceeded max_scan => xa_next_empty(xa, 3, 1): 3
exceeded max_scan => xa_next_empty(xa, 4, 1): 4
exceeded max_scan => xa_next_empty(xa, 5, 1): 5
entry not present => xa_next_empty(xa, 6, 1): 6
entry not present => xa_next_empty(xa, 7, 1): 7

entry not present => xa_next_empty(xa, 1, 2): 1
entry not present => xa_next_empty(xa, 2, 2): 2
exceeded max_scan => xa_next_empty(xa, 3, 2): 4
exceeded max_scan => xa_next_empty(xa, 4, 2): 5
exceeded max_scan => xa_next_empty(xa, 5, 2): 6
entry not present => xa_next_empty(xa, 6, 2): 6
entry not present => xa_next_empty(xa, 7, 2): 7

Since the xarray was set up with pointers in indices 3, 4 and 5, we
expect xa_next_empty() or page_cache_next_miss() to return the next
index (4, 5 and 6 respectively), but when used with a max_scan of 1, we
just get the index passed in.

While max_scan could be increased to fix this bug, I feel that having a
separate function like filemap_has_folio() makes the intent more
explicit and is less reliant on internal values of struct xa_state.

xas.xa_index could take other values to indicate wraparound or sibling
nodes and I think it is better to use a higher level abstraction like
xa_load() (used in filemap_has_folio()). In addition xa_load() also
takes the locks it needs, which helps :).

I could refactor the other usage of page_cache_next_miss() in
hugetlbfs_pagecache_present() if you'd like!

On this note, the docstring of page_cache_next_miss() is also
inaccurate. The return value is not always outside the range specified
if max_scan is too small.
