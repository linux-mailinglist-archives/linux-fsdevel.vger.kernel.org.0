Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E9437363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhJVIB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231846AbhJVIB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634889549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZoWYLLUFZ8JY44SKry8OHyZeTm3yXeRKD2OKegls7I=;
        b=RxQsVKb/eZ/rRNO/XF2IFs1755HwZpxWUfu+jXCQRGjTpNgnc3UVkGXwgzrxFbCLs6qnve
        Gz+24vSMSDWizzX3HAWxkFveYhYMdaSmronW+zYk6DTfxoE3c4Mv+jeOtsTXadBiBCZybD
        o/VWj7Fyk2s7+fSE6KWV+pQJq9ar6YM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-BkrmPDHCOPGMGfU2Ar1bOg-1; Fri, 22 Oct 2021 03:59:08 -0400
X-MC-Unique: BkrmPDHCOPGMGfU2Ar1bOg-1
Received: by mail-wm1-f72.google.com with SMTP id v18-20020a7bcb52000000b00322fea1d5b7so679322wmj.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 00:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=kZoWYLLUFZ8JY44SKry8OHyZeTm3yXeRKD2OKegls7I=;
        b=GVYHK7zo1SWFbETknYXb5LtKnBZs+61G5HwbPRdJKqDD9jm+8ccOG1KPVpaVEOqotW
         +oE4A5LSK9DyFsKNDwCtTcF8X02HLWvnCr8pXQKxeAooTJBaw9yFyTZReSoc1KJXVMK6
         Xc514u/KYf57ybtgLrAubox6IPEYuU3BfssvQYwvIC2+0cfpoVjkCe5j/5QQD8AVlH3Z
         g/VeUhpii/Nfkys1e+iSsYA0+eO1CYXLJS0O+mtgvxDsD5XVyxrqqNnTJkR8pJiS+cDG
         FIKd9P64O3GGxk62dFMr2e4VdbztvzQvUvZRu4gtryooF+IeBlLGRIXrGfv3Ziiv94O5
         K7aQ==
X-Gm-Message-State: AOAM533rm4diBtAd17F2w6AYCFfbBE8A7yxoSe+nopTKznQ9xbhUMaj6
        kHLwYnWIc8K4aiu3AILHs5WVNXzOEJXQmKpSXNL5a97L8da8Sa+FOpwNlf6pa8HsGV6n5rnuG16
        l1M9qfnzkPGat20hJSSfBtRpdZA==
X-Received: by 2002:a5d:6d8f:: with SMTP id l15mr14121149wrs.350.1634889546661;
        Fri, 22 Oct 2021 00:59:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLtKFRJX+mIe1fizAqfht37OT+GQUelpvBz5XAYxttgYXk3SlQgfC0gIGg3GDQtW72nlShUA==
X-Received: by 2002:a5d:6d8f:: with SMTP id l15mr14121107wrs.350.1634889546352;
        Fri, 22 Oct 2021 00:59:06 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id i17sm7855993wru.18.2021.10.22.00.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 00:59:05 -0700 (PDT)
Message-ID: <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
Date:   Fri, 22 Oct 2021 09:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YUpNLtlbNwdjTko0@moria.home.lan> <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org> <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org> <YXIZX0truEBv2YSz@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXIZX0truEBv2YSz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.10.21 03:52, Matthew Wilcox wrote:
> On Thu, Oct 21, 2021 at 05:37:41PM -0400, Johannes Weiner wrote:
>> Here is my summary of the discussion, and my conclusion:
> 
> Thank you for this.  It's the clearest, most useful post on this thread,
> including my own.  It really highlights the substantial points that
> should be discussed.
> 
>> The premise of the folio was initially to simply be a type that says:
>> I'm the headpage for one or more pages. Never a tailpage. Cool.
>>
>> However, after we talked about what that actually means, we seem to
>> have some consensus on the following:
>>
>> 	1) If folio is to be a generic headpage, it'll be the new
>> 	   dumping ground for slab, network, drivers etc. Nobody is
>> 	   psyched about this, hence the idea to split the page into
>> 	   subtypes which already resulted in the struct slab patches.
>>
>> 	2) If higher-order allocations are going to be the norm, it's
>> 	   wasteful to statically allocate full descriptors at a 4k
>> 	   granularity. Hence the push to eliminate overloading and do
>> 	   on-demand allocation of necessary descriptor space.
>>
>> I think that's accurate, but for the record: is there anybody who
>> disagrees with this and insists that struct folio should continue to
>> be the dumping ground for all kinds of memory types?
> 
> I think there's a useful distinction to be drawn between "where we're
> going with this patchset", "where we're going in the next six-twelve
> months" and "where we're going eventually".  I think we have minor
> differences of opinion on the answers to those questions, and they can
> be resolved as we go, instead of up-front.
> 
> My answer to that question is that, while this full conversion is not
> part of this patch, struct folio is logically:
> 
> struct folio {
> 	... almost everything that's currently in struct page ...
> };
> 
> struct page {
>     unsigned long flags;
>     unsigned long compound_head;
>     union {
>         struct { /* First tail page only */
>             unsigned char compound_dtor;
>             unsigned char compound_order;
>             atomic_t compound_mapcount;
>             unsigned int compound_nr;
>         };
>         struct { /* Second tail page only */
>             atomic_t hpage_pinned_refcount;
>             struct list_head deferred_list;
>         };
>         unsigned long padding1[4];
>     };
>     unsigned int padding2[2];
> #ifdef CONFIG_MEMCG
>     unsigned long padding3;
> #endif
> #ifdef WANT_PAGE_VIRTUAL
>     void *virtual;
> #endif
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>     int _last_cpupid;
> #endif
> };
> 
> (I'm open to being told I have some of that wrong, eg maybe _last_cpupid
> is actually part of struct folio and isn't a per-page property at all)
> 
> I'd like to get there in the next year.  I think dynamically allocating
> memory descriptors is more than a year out.
> 
> Now, as far as struct folio being a dumping group, I would like to
> split other things out from struct folio.  Let me address that below.
> 
>> Let's assume the answer is "no" for now and move on.
>>
>> If folios are NOT the common headpage type, it begs two questions:
>>
>> 	1) What subtype(s) of page SHOULD it represent?
>>
>> 	   This is somewhat unclear at this time. Some say file+anon.
>> 	   It's also been suggested everything userspace-mappable, but
>> 	   that would again bring back major type punning. Who knows?
>>
>> 	   Vocal proponents of the folio type have made conflicting
>> 	   statements on this, which certainly gives me pause.
>>
>> 	2) What IS the common type used for attributes and code shared
>> 	   between subtypes?
>>
>> 	   For example: if a folio is anon+file, then the code that
>>            maps memory to userspace needs a generic type in order to
>>            map both folios and network pages. Same as the page table
>>            walkers, and things like GUP.
>>
>> 	   Will this common type be struct page? Something new? Are we
>> 	   going to duplicate the implementation for each subtype?
>>
>> 	   Another example: GUP can return tailpages. I don't see how
>> 	   it could return folio with even its most generic definition
>> 	   of "headpage".
>>
>> (But bottomline, it's not clear how folio can be the universal
>> headpage type and simultaneously avoid being the type dumping ground
>> that the page was. Maybe I'm not creative enough?)
> 
> This whole section is predicated on "If it is NOT the headpage type",
> but I think this is a great list of why it _should_ be the generic
> headpage type.
> 
> To answer a questions in here; GUP should continue to return precise
> pages because that's what its callers expect.  But we should have a
> better interface than GUP which returns a rather more compressed list
> (something like today's biovec).
> 
>> Anyway. I can even be convinved that we can figure out the exact fault
>> lines along which we split the page down the road.
>>
>> My worry is more about 2). A shared type and generic code is likely to
>> emerge regardless of how we split it. Think about it, the only world
>> in which that isn't true would be one in which either
>>
>> 	a) page subtypes are all the same, or
>> 	b) the subtypes have nothing in common
>>
>> and both are clearly bogus.
> 
> Amen!
> 
> I'm convinced that pgtable, slab and zsmalloc uses of struct page can all
> be split out into their own types instead of being folios.  They have
> little-to-nothing in common with anon+file; they can't be mapped into
> userspace and they can't be on the LRU.  The only situation you can find
> them in is something like compaction which walks PFNs.
> 
> I don't think we can split out ZONE_DEVICE and netpool into their own
> types.  While they can't be on the LRU, they can be mapped to userspace,
> like random device drivers.  So they can be found by GUP, and we want
> (need) to be able to go to folio from there in order to get, lock and
> set a folio as dirty.  Also, they have a mapcount as well as a refcount.
> 
> The real question, I think, is whether it's worth splitting anon & file
> pages out from generic pages.  I can see arguments for it, but I can also
> see arguments against it (whether it's two types: lru_mem and folio,
> three types: anon_mem, file_mem and folio or even four types: ksm_mem,
> anon_mem and file_mem).  I don't think a compelling argument has been
> made either way.
> 
> Perhaps you could comment on how you'd see separate anon_mem and
> file_mem types working for the memcg code?  Would you want to have
> separate lock_anon_memcg() and lock_file_memcg(), or would you want
> them to be cast to a common type like lock_folio_memcg()?

FWIW,

something like this would roughly express what I've been mumbling about:

anon_mem    file_mem
   |            |
   ------|------
      lru_mem       slab
         |           |
         -------------
               |
	      page

I wouldn't include folios in this picture, because IMHO folios as of now
are actually what we want to be "lru_mem", just which a much clearer
name+description (again, IMHO).

Going from file_mem -> page is easy, just casting pointers.
Going from page -> file_mem requires going to the head page if it's a
compound page.

But we expect most interfaces to pass around a proper type (e.g.,
lru_mem) instead of a page, which avoids having to lookup the compund
head page. And each function can express which type it actually wants to
consume. The filmap API wants to consume file_mem, so it should use that.

And IMHO, with something above in mind and not having a clue which
additional layers we'll really need, or which additional leaves we want
to have, we would start with the leaves (e.g., file_mem, anon_mem, slab)
and work our way towards the root. Just like we already started with slab.

Maybe that makes sense.

-- 
Thanks,

David / dhildenb

