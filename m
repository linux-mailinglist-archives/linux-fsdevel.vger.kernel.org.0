Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AC405408
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbhIIM4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 08:56:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353909AbhIIMk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 08:40:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C0FE22054;
        Mon,  6 Sep 2021 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630936832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hIjf468KJX7FgXekLf1GhnwbjEE8Ay9pZMcMMriN3c=;
        b=jtQQmbJnAhrGrry/epSyygyXmbbt9pVXtD1WxN1t7eG8vY18pyaaoxTRWXPPaP4glAcsA5
        bnco0KZwn1QikVSds/aalXJa2whdv9SUMfJt9qfyobbI719+q48XnIwfDpTEguAyfwi8WN
        3AgCaDJyWUgGhT0YCkgMB43wwisH80k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630936832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hIjf468KJX7FgXekLf1GhnwbjEE8Ay9pZMcMMriN3c=;
        b=ma9mLcVL+HDg8ICHECfquc83SmWqSsfArJtwv73VM8DtISleDaHviNaI/HkARjnhZcNwjS
        knUnc/sFsD7iHLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 706DB13C25;
        Mon,  6 Sep 2021 14:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZGLLGgAfNmErVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Sep 2021 14:00:32 +0000
Message-ID: <4421a2ae-2cc6-624b-c1a4-20409a4652eb@suse.cz>
Date:   Mon, 6 Sep 2021 16:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [GIT PULL] Memory folios for v5.15
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org> <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia> <YSjxlNl9jeEX2Yff@cmpxchg.org>
 <YSkyjcX9Ih816mB9@casper.infradead.org> <YS0WR38gCSrd6r41@cmpxchg.org>
 <YS0h4cFhwYoW3MBI@casper.infradead.org> <YS0/GHBG15+2Mglk@cmpxchg.org>
 <YS1PzKLr2AWenbHF@casper.infradead.org> <YS+7pzI7pttxtFHT@cmpxchg.org>
 <D77FE2D5-E2ED-4590-95C5-142DF55922F5@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <D77FE2D5-E2ED-4590-95C5-142DF55922F5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/21 17:13, Zi Yan wrote:
>> You're really just recreating a crappier, less maintainable version of
>> the object packing that *slab already does*.
>>
>> It's *slab* that is supposed to deal with internal fragmentation, not
>> the page allocator.
>>
>> The page allocator is good at cranking out uniform, slightly big
>> memory blocks. The slab allocator is good at subdividing those into
>> smaller objects, neatly packed and grouped to facilitate contiguous
>> reclaim, while providing detailed breakdowns of per-type memory usage
>> and internal fragmentation to the user and to kernel developers.
>>
>> [ And introspection and easy reporting from production are *really
>>   important*, because fragmentation issues develop over timelines that
>>   extend the usual testing horizon of kernel developers. ]
> 
> Initially, I thought it was a great idea to bump PAGE_SIZE to 2MB and
> use slab allocator like method for <2MB pages. But as I think about it
> more, I fail to see how it solves the existing fragmentation issues
> compared to our existing method, pageblock, since IMHO the fundamental
> issue of fragmentation in page allocation comes from mixing moveable
> and unmoveable pages in one pageblock, which does not exist in current
> slab allocation. There is no mix of reclaimable and unreclaimable objects
> in slab allocation, right?

AFAICS that's correct. Slab caches can in general merge, as that
decreases memory usage (with the tradeoff of potentially mixing objects
with different lifetimes more). But SLAB_RECLAIM_ACCOUNT (a flag for
reclaimable caches) is part of SLAB_MERGE_SAME, so caches can only merge
it they are both reclaimable or not.

> In my mind, reclaimable object is an analog
> of moveable page and unreclaimable object is an analog of unmoveable page.

More precisely it resembles reclaimable and unreclaimable pages. Movable
pages can be also migrated, but slab objects not.

> In addition, pageblock with different migrate types resembles how
> slab groups objects, so what is new in using slab instead of pageblock?

Slab would be more strict in not allowing the merge. At page allocator
level, if memory is exhausted, eventually page of any type can be
allocated from pageblock of any other type as part of the fallback. The
only really strict mechanism is movable zone.

> My key question is do we allow mixing moveable sub-2MB data chunks with
> unmoveable sub-2MB data chunks in your new slab-like allocation method?
> 
> If yes, how would kernel reclaim an order-0 (2MB) page that has an
> unmoveable sub-2MB data chunk? Isn’t it the same fragmentation situation
> we are facing nowadays when kernel tries to allocate a 2MB page but finds
> every 2MB pageblock has an unmoveable page?

Yes, any scheme where all pages are not movable can theoretically
degrade to a situation where at one moment all memory is allocated by
the unmovable pages, and later almost all pages were freed, but leaving
one unmovable page in each pageblock.

> If no, why wouldn’t kernel do the same for pageblock? If kernel disallows
> page allocation fallbacks, so that unmoveable pages and moveable pages
> will not sit in a single pageblock, compaction and reclaim should be able
> to get a 2MB free page most of the time. And this would be a much smaller
> change, right?

If we did that restriction of fallbacks, it would indeed be as strict
the way as slab is, but things could still degrade to unmovable pages
scattered all over the pageblocks as mentioned above.

But since it's so similar to slabs, the same thing could happen with
slabs today, and I don't recall reports of that happening massively? But
of course slabs are not all 2MB large, serving 4k pages.

> Let me know if I miss anything.
> 
> 
> --
> Best Regards,
> Yan, Zi
> 

