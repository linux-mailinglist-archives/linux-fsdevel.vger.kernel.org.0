Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E5438305
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhJWKBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 06:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhJWKBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 06:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634983129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoq4SRX8nlUC60ExyKjDKnJNlAIreRlQA54moSJhKiE=;
        b=e5w5kw5k45IqnrkWdELAoDyjY9boj5QO6cmpxDxfoxeGUmDPVSdJgzJvHcPfvzlPzHvPis
        I4hvbE9PX0s+Slb6JtGUS7RYboOk/2xvOnqBckeif3BMYc5DRN3I37XJlAAmTX11oGAoD8
        CEu+p2241EDVOiMGzKFZxDCqi/sOQpk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-_ot6NK43PByepubA1sIEVQ-1; Sat, 23 Oct 2021 05:58:45 -0400
X-MC-Unique: _ot6NK43PByepubA1sIEVQ-1
Received: by mail-wm1-f70.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so1996590wmc.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 02:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=yoq4SRX8nlUC60ExyKjDKnJNlAIreRlQA54moSJhKiE=;
        b=QSV/243UcYewkew9WKWUBDXs1fapu+xDUOiFKHacVV4mSMCq9EIE+GciKlx6jmmqam
         rYngJmJHbLtr1ypXhnN3Qfr2fyJcizEgypx2WvNUrhnDbIp1Feg60olh0eookNhv1Lo0
         a8b6WaEygW6E69Sl6LY/CGuUfy7PhClGH1KN+zC/v7JzUymmGbpy8LwUp1FPA86pb/Vt
         7YfOoWCgEfhkzcd2myJsfcbOBz0CK9f55rxvWqTY0qlv6mqgCHpr8IwGwaZwGqaYYmWi
         5VVdfeR405HWRIUm82x4aq9xnyGGFAfOe55ZHGHvX0SLjbKWAedEDpPhZZQKyF7neQwu
         Zl/g==
X-Gm-Message-State: AOAM533cdi9E6j3sVaJWBTr0gtuxF6UkRheSRBC30FSfgDdRiauU9UCB
        G/ODTwkdNbCwR1gNHN6RHqpBdTpOaXgEo0N+kD0RMQJnPiTOHNSq5AwYXfDrpJfPSr/AwjfCDiQ
        HdYwMlPWxNoI3kIkAodQz8eVVPg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr5818255wmf.4.1634983124314;
        Sat, 23 Oct 2021 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQkdGIfMgWCPqqzs0M/sDJLjYS7XOY07wYXWAAGr0vZQzH7jFy+6cLLKC9oLNh1amWIzqX5g==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr5818212wmf.4.1634983123931;
        Sat, 23 Oct 2021 02:58:43 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2344f.dip0.t-ipconnect.de. [79.242.52.79])
        by smtp.gmail.com with ESMTPSA id e11sm7007687wrw.16.2021.10.23.02.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 02:58:43 -0700 (PDT)
Message-ID: <404bdc05-487f-3d47-6b30-0687b74c2f2f@redhat.com>
Date:   Sat, 23 Oct 2021 11:58:42 +0200
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
References: <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org> <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org> <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
 <YXNx686gvsJMgS+z@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXNx686gvsJMgS+z@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> In the picture below we want "folio" to be the abstraction of "mappable
>> into user space", after reading your link below and reading your graph,
>> correct? Like calling it "user_mem" instead.
> 
> Hmm.  Actually, we want a new layer in the ontology:
> 
> page
>    folio
>       mappable
>          lru_mem
>             anon_mem
>             ksm
>             file_mem
>          netpool
>          devmem
>          zonedev
>          vmalloc
>       zsmalloc
>       dmapool
>       devmem (*)
>    slab
>    pgtable
>    buddy
> 
> (*) yes, devmem appears twice; some is mappable and some is not
> 

I mostly agree to 99% to the above and I think that's a valuable outcome
of the discussion.

What I yet don't understand why we would require the type "folio" at
all. This will be my last question: you're the folio expert, which
interfaces would you think would actually consume in the above done
right a folio and we would consequently need it?

I would assume that there would be no real need for them. Say we have
"struct lru_mem" and we want to test if it's an anon_mem for example to
upcast. Say the function to perform the check is something called
"lru_mem_test_anon()" for example.

Instead of

folio_test_anon(lru_mem_to_folio())

We'd do

_PageAnon(lru_mem_to_page())

Whereby _PageAnon() is just a variant that does no implicit compound
head lookup -- however you would want to call that. Because we know that
lru_mem doesn't point to a tail page.

I imagine the same would hold for any other type of accesses that go via
a page type, except that we might not always go directly via the "struct
page" but instead via an casted type (e.g., cast file_mem -> lru_mem and
call the corresponding helper that implements the magic).

> The ontology is kind of confusing because *every* page is part of a
> folio.  Sometimes it's a folio of one page (eg vmalloc).  Which means
> that it's legitimate to call page_folio() on a slab page and then call
> folio_test_slab().  It's not the direction we want to go though.

That tackles part of the problem I'm having with having a dedicated
"folio" type in the picture above. A folio is literally *any page* as
long as it's not a tail page :)

> 
> We're also inconsistent about whether we consider an entire compound
> page / folio the thing which is mapped, or whether each individual page
> in the compound page / folio can be mapped.  See how differently file-THP
> and anon-THP are handled in rmap, for example.  I think that was probably
> a mistake.

Yes. And whenever I think about "why do we want to split both types" the
thought that keeps dominating is "splitting and migrating anon THP is
just very different from any other THP".

> 
>> Because any of these types would imply that we're looking at the head
>> page (if it's a compound page). And we could (or even already have?)
>> have other types that cannot be mapped to user space that are actually a
>> compound page.
> 
> Sure, slabs are compound pages which cannot be mapped to userspace.
> 
>>> I have a little list of memory types here:
>>> https://kernelnewbies.org/MemoryTypes
>>>
>>> Let me know if anything is missing.
>>
>> hugetlbfs pages might deserve a dedicated type, right?
> 
> Not sure.  Aren't they just file pages (albeit sometimes treated
> specially, which is one of the mistakes we need to fix)?

From all the special-casing in core-mm and remembering that they make
excessive use of compound-tail members, my impression was that they
might look like file pages but are in many cases very different.

<offtopic>
Just for the records, I could imagine a type spanning multiple struct
pages, to handle the cases right now that actually store data in tail
page metadata. Like having "struct hugetlb" that is actually
X*sizeof(struct page) and instead of all these crazy compound tail page
lookups, we'd just be able to reference the relevant members via "struct
hugetlb" directly. We can do that for types we know are actually
compound pages of a certain size -- like hugetlbfs.
</offtopic>

> 
>>> And starting with file_mem makes the supposition that it's worth splitting
>>> file_mem from anon_mem.  I believe that's one or two steps further than
>>> it's worth, but I can be convinced otherwise.  For example, do we have
>>> examples of file pages being passed to routines that expect anon pages?
>>
>> That would be a BUG, so I hope we don't have it ;)
> 
> Right.  I'm asking, did we fix any bugs in the last year or two that
> were caused by this kind of mismatch and would be prevented by using
> a different type?  There's about half a dozen bugs we've had in the
> last year that were caused by passing tail pages to functions that
> were expecting head pages.

For my part, I don't recall either writing (well, it's not my area of
expertise) or reviewing such patches. I do assume that many type checks
catch that early during testing.

I do recall reviewing some patches that remove setting page flags on
(IIRC) anon pages that just don't make any sense, but were not harmful.

<example>
I keep stumbling over type checks that I think might just be due to old
cruft we're dragging along, due to the way we for example extended THP.

Like __split_huge_page(). I can spot two PageAnon(head) calls which end
up looking up the head page again. Then, we call remap_page(), which
doesn't make any sense for !PageAnon(), thus we end up doing a third
call to PageAnon(head). In __split_huge_page_tail() we check
PageAnon(head) again for every invocation.

I'm not saying that we should rewrite __split_huge_page() completely, or
that this cannot be cleaned up differently. I'm rather imagining that
splitting out an "struct anon_mem" might turn things cleaner and avoid
many of the type checks and consequently also more head page lookups.

Again, this is most probably a bad example, I just wanted to share
something that I noticed.
<\example>

Passing "struct page *" to random functions just has to let these functions
* Eventually lookup or at least verify that it's not a tail page
* Eventually lookup or at least verify that it's the right type.
And some functions to the same lookup over and over again.

> 
> I can think of one problem we have, which is that (for a few filesystems
> which have opted into this), we can pass an anon page into ->readpage()
> and we've had problems with those filesystems then mishandling the
> anon page.  The solution to this problem is not to pass an lru_mem to
> readpage, but to use a different fs operation to read swap pages.

Interesting example!

> 
>> Let's consider folio_wait_writeback(struct folio *folio)
>>
>> Do we actually want to pass in a folio here? Would we actually want to
>> pass in lru_mem here or even something else?
> 
> Well, let's look at the callers (for simplicity, look at Linus'
> current tree).  Other than the ones in filesystems which we can assume
> have file pages, mm/migrate.c has __unmap_and_move().  What type should
> migrate_pages() have and pass around?

That's an interesting point. Ideally it should deal with an abstract
type "struct migratable", which would include lru and !lru migratable
pages (e.g., balloon compaction).

The current function name indicates that we're working on pages
("migrate_pages") :) so the upcast would have to happen internally
unless we'd change the interface or even split it up ("migrate_lru_mems()").

But yes, that's an interesting case.

> 
>> Looking at some core MM code, like mm/huge_memory.c, and seeing all the
>> PageAnon() specializations, having a dedicated anon_mem type might be
>> valuable. But at this point it's hard to tell if splitting up these
>> functions would actually be desirable.
> 
> Yes.  That's my point; it *might* be desirable.  I have no objections to
> it, but the people doing the work need to show the benefits.  I'm showing
> the benefits to folios -- fewer bugs, smaller code, larger pages in the
> page cache leading to faster systems.  I acknowledge the costs in terms
> of churn.

See my bad example above. From the "bitwise" discussion I get the
feeling that some people care about type safety (including me) :)

> 
> You can see folios as a first step to disentangling some of the users
> of struct page.  It certainly won't be the last step.  But I'd really
> like to stop having theoretical discussions of memory types and get on
> with writing code.  If that means we modify the fs APIs again in twelve
> months to replace folios with file_mem, well, I'm OK with that.

I know, the crowd is screaming "we want folios, we need folios, get out
of the way". I know that the *compound page* handling is a mess and that
we want something to change that. The point I am making is that folios
are not necessarily what we *need*.

Types as discussed above are really just using the basic idea of a folio
lifted to the next level that not only avoid any kind of PageTail checks
but also any kind of type checks we have splattered all over the place.
IMHO that's a huge win when it comes to code readability and
maintainability. This also tackles the point Johannes made: folios being
the dumping ground for everything. And he has a point, because folios
are really just "not tail pages", so consequently they will 99% just
mimic what "struct page" does, and we all know what that means.

Your patches introduce the concept of folio across many layers and your
point is to eventually clean up later and eventually remove it from all
layers again. I can understand that approach, yet I am at least asking
the question if this is the right order to do this.

And again, I am not blocking this, I think cleaning up compound pages is
very nice. I'm asking questions to see how the concept of folios would
fit in long-term and if it would be required at all if types are done right.

And I think a valuable result of this discussion at least to me is that:
* I can understand why we want (many parts of) the filemap API to
  consume an abstracted type instead of file_mem and anon_mem.
* I understand that compound pages are a fact and properly teaching
  different layers subsystems of how to handle them cleanly is not
  something radical. It's just the natural and clean thing to do.
* I believe types as discussed above are realistic and comparatively
  easy to add. I believe they are much more realistic than
  a bunch of other ideas I heard throughout the last couple of months.

I acknowledge that defragmentation is a real problem, though. But it has
been and most probably will remain a different problem than just getting
compound page handling right.


Again, I appreciate this discussion. I know you're sick and tired of
folio discussions, so I'll stop asking questions.

-- 
Thanks,

David / dhildenb

