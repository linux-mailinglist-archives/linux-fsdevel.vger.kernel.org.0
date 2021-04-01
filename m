Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5040A351930
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhDARwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhDARrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:47:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B6C02FE84
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 09:00:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z10so2607605qkz.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/+9Hb7YYQmA2SssmIOWqXZ0kNaROHWnX1DvJqmrmNI=;
        b=c13x1plnbd9O5N0pa2dHAkihjGH6ROBPko3mLq9jsLcZ5dvMbyLYm0/pe8+4HVj7SY
         NqpWRjFmceGkyaBCaeRvbtg1oxZot1s5xFOIlITYkU2RI+OWxtHNsT5vB/SQ5N5cMcOx
         MFeBKHXLwFPoanmzbLqMRMcY9wNvhrrASbOTogFfi3uMEjFNO/FZF24TmaprZJjC+lCX
         UxVRXOYhRVKR+gQVDEyJz59VyO0zcFG1s1F9PG5FgFnG6pVrlZ6/iM8h3tzduY7oz422
         /xu6rR9gOKWyN1rtcKRWB4aHvxcIDUzhLqM06zpkx7vHCu2W97HmNlA4H/NCJvjjfFQj
         wURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/+9Hb7YYQmA2SssmIOWqXZ0kNaROHWnX1DvJqmrmNI=;
        b=F6u98aWTCJwdryn4qiFPm4t/RrdwnIpfRFXX+ytdABy8hLSByHqAntEPzjrUyaJxHR
         6jdi0ynhyrumVhflif/HXe/qubX7Xqt1/FGiG7B+eKqqoaXPSv8H1NJBgYje7KV6CWK3
         f50nhei0av5fbGzK+aBEHrxyhFrlvPPUgLjKofB+J+If239CVGYUb2jcn1pOtOHCoiWa
         oUQVpdpJxXiLAcx0MKfbaugT7LcK3s5sOAFVYYkSjscRXf4611PjJJLOr4vpVO4v0gfN
         qlLkAzybTttNxsi1kyMoDYvfl6gFmP25VNi+zhAB3MqBaD/ig5WG5UCei8Xg0F17tW/3
         pa1w==
X-Gm-Message-State: AOAM531TMuhFe2TP67Ye6JoBKdUYeEDg+7iqpUB1HF/fDcIdfAxXKQPu
        0nj7b99GWmHFkeElwgJM4dugi/z7c8bTQw==
X-Google-Smtp-Source: ABdhPJzhDkBd+v2HhIuSSFxe7q/gCCFa7piTUeuWx+Lf/VxFezQOIFJlwEWQjiaOfJj4rq7XTMPNMA==
X-Received: by 2002:a05:620a:e10:: with SMTP id y16mr9042205qkm.375.1617292811103;
        Thu, 01 Apr 2021 09:00:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:9738])
        by smtp.gmail.com with ESMTPSA id z188sm4335793qkb.40.2021.04.01.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:00:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:00:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YGXuCMfBWL51TVu3@cmpxchg.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
 <20210330210929.GR351017@casper.infradead.org>
 <YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:05:37AM +0000, Al Viro wrote:
> On Tue, Mar 30, 2021 at 10:09:29PM +0100, Matthew Wilcox wrote:
> 
> > That's a very Intel-centric way of looking at it.  Other architectures
> > support a multitude of page sizes, from the insane ia64 (4k, 8k, 16k, then
> > every power of four up to 4GB) to more reasonable options like (4k, 32k,
> > 256k, 2M, 16M, 128M).  But we (in software) shouldn't constrain ourselves
> > to thinking in terms of what the hardware currently supports.  Google
> > have data showing that for their workloads, 32kB is the goldilocks size.
> > I'm sure for some workloads, it's much higher and for others it's lower.
> > But for almost no workload is 4kB the right choice any more, and probably
> > hasn't been since the late 90s.
> 
> Out of curiosity I looked at the distribution of file sizes in the
> kernel tree:
> 71455 files total
> 0--4Kb		36702
> 4--8Kb		11820
> 8--16Kb		10066
> 16--32Kb	6984
> 32--64Kb	3804
> 64--128Kb	1498
> 128--256Kb	393
> 256--512Kb	108
> 512Kb--1Mb	35
> 1--2Mb		25
> 2--4Mb		5
> 4--6Mb		7
> 6--8Mb		4
> 12Mb		2 
> 14Mb		1
> 16Mb		1
> 
> ... incidentally, everything bigger than 1.2Mb lives^Wshambles under
> drivers/gpu/drm/amd/include/asic_reg/
> 
> Page size	Footprint
> 4Kb		1128Mb
> 8Kb		1324Mb
> 16Kb		1764Mb
> 32Kb		2739Mb
> 64Kb		4832Mb
> 128Kb		9191Mb
> 256Kb		18062Mb
> 512Kb		35883Mb
> 1Mb		71570Mb
> 2Mb		142958Mb
> 
> So for kernel builds (as well as grep over the tree, etc.) uniform 2Mb pages
> would be... interesting.

Right, I don't see us getting rid of 4k cache entries anytime
soon. Even 32k pages would double the footprint here.

The issue is just that at the other end of the spectrum we have IO
devices that do 10GB/s, which corresponds to 2.6 million pages per
second. At such data rates we are currently CPU-limited because of the
pure transaction overhead in page reclaim. Workloads like this tend to
use much larger files, and would benefit from a larger paging unit.

Likewise, most production workloads in cloud servers have enormous
anonymous regions and large executables that greatly benefit from
fewer page table levels and bigger TLB entries.

Today, fragmentation prevents the page allocator from producing 2MB
blocks at a satisfactory rate and allocation latency. It's not
feasible to allocate 2M inside page faults for example; getting huge
page coverage for the page cache will be even more difficult.

I'm not saying we should get rid of 4k cache entries. Rather, I'm
wondering out loud whether longer-term we'd want to change the default
page size to 2M, and implement the 4k cache entries, which we clearly
continue to need, with a slab style allocator on top. The idea being
that it'll do a better job at grouping cache entries with other cache
entries of a similar lifetime than the untyped page allocator does
naturally, and so make fragmentation a whole lot more manageable.

(I'm using x86 page sizes as examples because they matter to me. But
there is an architecture independent discrepancy between the smallest
cache entries we must continue to support, and larger blocks / huge
pages that we increasingly rely on as first class pages.)
