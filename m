Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D656437924
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhJVOmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 10:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233140AbhJVOms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634913629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5VYijYo0LM0UNwR49AOTflq9JooV8n64R7vGAicLbM=;
        b=CWNCwUmpUo/G0C57s8fRFxLGzxgyEV0+W9/SrsdayyEqxcT5d5GgJjP55Rr1EjmPAQA6Ya
        s2GRS6Ec7VY3OPzP/NHx4Bx+0cQPM4OH9FWD/jtje4KCQkt9M7z67hcvYig2TI7SDOH0gF
        i/iTgg/kkgw6HeSad7/eBbGsAtBaxEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-f9OgdITjNVeADsIEhczTLg-1; Fri, 22 Oct 2021 10:40:28 -0400
X-MC-Unique: f9OgdITjNVeADsIEhczTLg-1
Received: by mail-wm1-f71.google.com with SMTP id n9-20020a1c7209000000b0030da7d466b8so1119582wmc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 07:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=S5VYijYo0LM0UNwR49AOTflq9JooV8n64R7vGAicLbM=;
        b=5LGZf4fiDXIaM1OH2Gao9RLH+YCrTwPl9+EyFdIOcxmyYQDYT4zCGCTZ4gAC7J3hww
         7arpseN96husYlk3bujmGk2GcSJ68xLH3fsBofi3Wb42yRESrYujUHySAojWVByBpwiE
         eB3aZZ/+dXytMmTOvPtnU4DvWYDx52j2ECIUQ6yePYBKUX4vhkMXJTQZWVdSUBCsXyPe
         fjK59tr/xUf5F4svRI0AKHwYXfX0Iztt95ak+TytE/mI1teIs47heHQMp6gBJ8EAtBRn
         eXj27yabhJalQYgrMmh7Av2S/8n1TV4TUP6si6S6F34GIdfbiNf7pKvNGrOJiI2jS3fa
         RChA==
X-Gm-Message-State: AOAM531eETlgavAnOfORqaD3W5exKE7FFmkqhV3uDOEiLPQo7sIX7Xf/
        Ft45MzuYHtc0JS0NnTipN+qIwgxdL+jAYgBH7zJplznm0HXKhMJ/uK0Chd4G4XSDftzSBCyG75k
        VHETzZS0NPLD8msiQHMmRlz9G5Q==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr180593wmb.78.1634913626856;
        Fri, 22 Oct 2021 07:40:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrc/dZo+MdLVpt8cNByGTw3yh/5+A6Y3Y+vnyc+pC35BkkzHjuZ6ObalnuXaN7d0yTLAbOig==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr180556wmb.78.1634913626541;
        Fri, 22 Oct 2021 07:40:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id b207sm200396wmd.3.2021.10.22.07.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 07:40:25 -0700 (PDT)
Message-ID: <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
Date:   Fri, 22 Oct 2021 16:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org> <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org> <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org> <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXK2ICKi6fjNfr4X@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.10.21 15:01, Matthew Wilcox wrote:
> On Fri, Oct 22, 2021 at 09:59:05AM +0200, David Hildenbrand wrote:
>> something like this would roughly express what I've been mumbling about:
>>
>> anon_mem    file_mem
>>    |            |
>>    ------|------
>>       lru_mem       slab
>>          |           |
>>          -------------
>>                |
>> 	      page
>>
>> I wouldn't include folios in this picture, because IMHO folios as of now
>> are actually what we want to be "lru_mem", just which a much clearer
>> name+description (again, IMHO).
> 
> I think folios are a superset of lru_mem.  To enhance your drawing:
> 

In the picture below we want "folio" to be the abstraction of "mappable
into user space", after reading your link below and reading your graph,
correct? Like calling it "user_mem" instead.

Because any of these types would imply that we're looking at the head
page (if it's a compound page). And we could (or even already have?)
have other types that cannot be mapped to user space that are actually a
compound page.

> page
>    folio
>       lru_mem
>          anon_mem
> 	 ksm
>          file_mem
>       netpool
>       devmem
>       zonedev
>    slab
>    pgtable
>    buddy
>    zsmalloc
>    vmalloc
> 
> I have a little list of memory types here:
> https://kernelnewbies.org/MemoryTypes
> 
> Let me know if anything is missing.

hugetlbfs pages might deserve a dedicated type, right?


> 
>> Going from file_mem -> page is easy, just casting pointers.
>> Going from page -> file_mem requires going to the head page if it's a
>> compound page.
>>
>> But we expect most interfaces to pass around a proper type (e.g.,
>> lru_mem) instead of a page, which avoids having to lookup the compund
>> head page. And each function can express which type it actually wants to
>> consume. The filmap API wants to consume file_mem, so it should use that.
>>
>> And IMHO, with something above in mind and not having a clue which
>> additional layers we'll really need, or which additional leaves we want
>> to have, we would start with the leaves (e.g., file_mem, anon_mem, slab)
>> and work our way towards the root. Just like we already started with slab.
> 
> That assumes that the "root" layers already handle compound pages
> properly.  For example, nothing in mm/page-writeback.c does; it assumes
> everything is an order-0 page.  So working in the opposite direction
> makes sense because it tells us what has already been converted and is
> thus safe to call.

Right, as long as the lower layers receive a "struct page", they have to
assume it's "anything" -- IOW a random base page.

We need some temporary logic when transitioning from "typed" code into
"struct page" code that doesn't talk compound pages yet, I agree. And I
think the different types used actually would tell us what has been
converted and what not. Whenever you have to go from type -> "struct
page" we have to be very careful.

> 
> And starting with file_mem makes the supposition that it's worth splitting
> file_mem from anon_mem.  I believe that's one or two steps further than
> it's worth, but I can be convinced otherwise.  For example, do we have
> examples of file pages being passed to routines that expect anon pages?

That would be a BUG, so I hope we don't have it ;)

> Most routines that I've looked at expect to see both file & anon pages,

Right, many of them do. Which tells me that they share a common type in
many places.

Let's consider LRU code

static inline int folio_is_file_lru(struct folio *folio)
{
	return !folio_swapbacked(folio);
}

I would say we don't really want to pass folios here. We actually want
to pass something reasonable, like "lru_mem". But yes, it's just doing
what "struct page" used to do via page_is_file_lru().


Let's consider folio_wait_writeback(struct folio *folio)

Do we actually want to pass in a folio here? Would we actually want to
pass in lru_mem here or even something else?

> and treat them either identically or do slightly different things.
> But those are just the functions I've looked at; your experience may be
> quite different.

I assume when it comes to LRU, writeback, ... the behavior is very
similar or at least the current functions just decide internally what to
do based on e.g., ..._is_file_lru().

I don't know if it's best to keep hiding that functionality within an
abstracted type or just provide two separate functions for anon and
file. folios mostly mimic what the old struct page used to do,
introducing similar functions. Maybe the reason we branch off within
these functions is because it just made sense when passing around
"struct page" and not having something clearer at hand that let the
caller do the branch. For the cases of LRU I looked at it somewhat makes
sense to just do it internally.

Looking at some core MM code, like mm/huge_memory.c, and seeing all the
PageAnon() specializations, having a dedicated anon_mem type might be
valuable. But at this point it's hard to tell if splitting up these
functions would actually be desirable.

We're knee-deep in the type discussion now and I appreciate it. I can
understand that folio are currently really just a "not a tail page"
concept and mimic a lot of what we already inherited from the old
"struct page" world.

-- 
Thanks,

David / dhildenb

