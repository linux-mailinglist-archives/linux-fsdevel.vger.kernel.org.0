Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B903FCC71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhHaRle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 13:41:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhHaRld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:41:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30AB522151;
        Tue, 31 Aug 2021 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630431637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdMI+6lRD2G3u+2aUh0DhRa8Y0EyNFFP/fCE9/AfF38=;
        b=kqkkGcIyh6CEA3ka71xoIpNa4R3Y+ziCRvBQEaDLiYOQKo7orFmj+LUueWOSLXNHxgtDzG
        dfMd3Pm9o+kwRkRYM2+FhqarrUfZgNWVBmXIR6KscUIvxyRY0FhX6KaYkYqwscFydQztee
        m4H0f3QfR/JQ1XaWyBBAEuqhupl/0FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630431637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdMI+6lRD2G3u+2aUh0DhRa8Y0EyNFFP/fCE9/AfF38=;
        b=PlgcLUyqlpnPq0vYXl74bfk9ATownostgZC1o+12r/KnkdYqQdgJfkkT6fPmsCD1rgCb1K
        UamHX93Js1w7pCBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0761713966;
        Tue, 31 Aug 2021 17:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id m+BoAJVpLmHzZwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 17:40:36 +0000
Message-ID: <eef914fb-c3c4-effa-5bd8-81ee2495a2f9@suse.cz>
Date:   Tue, 31 Aug 2021 19:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [GIT PULL] Memory folios for v5.15
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org> <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org> <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org> <YSkyjcX9Ih816mB9@casper.infradead.org>
 <YS0WR38gCSrd6r41@cmpxchg.org> <YS0h4cFhwYoW3MBI@casper.infradead.org>
 <YS0/GHBG15+2Mglk@cmpxchg.org> <YS1PzKLr2AWenbHF@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YS1PzKLr2AWenbHF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/21 23:38, Matthew Wilcox wrote:
> I think something that might actually help is if we added a pair of new
> GFP flags, __GFP_FAST and __GFP_DENSE.  Dense allocations are those which
> are expected to live for a long time, and so the page allocator should
> try to group them with other dense allocations.  Slab and page tables
> should use DENSE, along with things like superblocks, or fs bitmaps where
> the speed of allocation is almost unimportant, but attempting to keep
> them out of the way of other allocations is useful.  Fast allocations
> are for allocations which should not live for very long.  The speed of
> allocation dominates, and it's OK if the allocation gets in the way of
> defragmentation for a while.

Note we used to have GFP_TEMPORARY, but it didn't really work out:
https://lwn.net/Articles/732107/

> An example of another allocator that could care about DENSE vs FAST
> would be vmalloc.  Today, it does:
> 
>         if (array_size > PAGE_SIZE) {
>                 area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
>                                         area->caller);
>         } else {
>                 area->pages = kmalloc_node(array_size, nested_gfp, node);
>         }
> 
> That's actually pretty bad; if you have, say, a 768kB vmalloc space,
> you need a 12kB array.  We currently allocate 16kB for the array, when we
> could use alloc_pages_exact() to free the 4kB we're never going to use.
> If this is GFP_DENSE, we know it's a long-lived allocation and we can
> let somebody else use the extra 4kB.  If it's not, it's probably not
> worth bothering with.
> 

