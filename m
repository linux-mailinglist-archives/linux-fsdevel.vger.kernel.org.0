Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF21422F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhJERez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 13:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234511AbhJERey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633455182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGNbaD457msJgVdKh0PPRgk92evjmql7WYFpgopbLNQ=;
        b=hF0f9dNzShk22Hh9oLXt22JYDKTmSvG79SXn43/ZhCHHDEBSMvDemJVFumpsLYbVz56LgU
        TcG5QOcriy5tcZfDvu/WvTVI9PjDCtyliWdNAHrYdsWcu9l0K+84ETYVWa+NriGUk1S/3U
        xt3OkguNsMsIuDkN6UPCv34Rpv7zMro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-hS2SCALLNF2w4i9xYj7klA-1; Tue, 05 Oct 2021 13:33:01 -0400
X-MC-Unique: hS2SCALLNF2w4i9xYj7klA-1
Received: by mail-wm1-f69.google.com with SMTP id x3-20020a05600c21c300b0030d2b0fb3b4so15055wmj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 10:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DGNbaD457msJgVdKh0PPRgk92evjmql7WYFpgopbLNQ=;
        b=btFZ8vMvyjxXqhAyp23d/GzgCrN/z4Rsv5t1SkSMcE/ycMV6dDxmEoFMUeYeJEiKXX
         5QryGCwBF3m8NXxXFyqxLiB6m7B2jdYOceEgwAOC3gAuSPO9Aj4qJ9bcfZY74X4lxvL4
         czkA04BrMJ4R/+wDPSoG5Y23P/olpmYzp6ugCj3GNBbWOwHDQZ60w93lBKKvr6BQRf+w
         0s15FRMNEm6T3S1rat0HBML6RvWQb9WRnFHQmvfQ0nqMGYr8IYlWjd7CyUXOOVNlIX2a
         54ciV4Ze1+sKfVvMMt9bMRI2e0APzdnZMpUfEtGDdtMTF7jJVj59eW049PB7CmbmvyOC
         Wrjw==
X-Gm-Message-State: AOAM530/Y9R7skpGiL/Bk6Userm7s/KF5sREzHfSqHk82ZdnnTxzCzSq
        if3tfzDiuvwqie1r3TBDdGfSypiVdIxO5jspfMhun2WAxGn6VIUxfwY8UXBge+ycSslaJDaXZha
        Pq4K3wAMUzX3pMFCkCbLP/gUruQ==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr4937366wmq.154.1633455180714;
        Tue, 05 Oct 2021 10:33:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK5P/yoc8rNM3rXntf+k70Y2v/zMNddpcdV9cSYPP4ViHxZlYT7fhz5Hy7rnFKdBkGsYmjpA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr4937342wmq.154.1633455180492;
        Tue, 05 Oct 2021 10:33:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6741.dip0.t-ipconnect.de. [91.12.103.65])
        by smtp.gmail.com with ESMTPSA id o3sm18358930wra.52.2021.10.05.10.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:33:00 -0700 (PDT)
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org> <YVxYgQa1cECYMtOL@casper.infradead.org>
 <YVyLh+bnZzNeQkyb@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ab06fae3-3239-ee70-87b8-7ec380e47920@redhat.com>
Date:   Tue, 5 Oct 2021 19:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVyLh+bnZzNeQkyb@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.10.21 19:29, Johannes Weiner wrote:
> On Tue, Oct 05, 2021 at 02:52:01PM +0100, Matthew Wilcox wrote:
>> On Mon, Aug 23, 2021 at 05:26:41PM -0400, Johannes Weiner wrote:
>>> One one hand, the ambition appears to substitute folio for everything
>>> that could be a base page or a compound page even inside core MM
>>> code. Since there are very few places in the MM code that expressly
>>> deal with tail pages in the first place, this amounts to a conversion
>>> of most MM code - including the LRU management, reclaim, rmap,
>>> migrate, swap, page fault code etc. - away from "the page".
>>>
>>> However, this far exceeds the goal of a better mm-fs interface. And
>>> the value proposition of a full MM-internal conversion, including
>>> e.g. the less exposed anon page handling, is much more nebulous. It's
>>> been proposed to leave anon pages out, but IMO to keep that direction
>>> maintainable, the folio would have to be translated to a page quite
>>> early when entering MM code, rather than propagating it inward, in
>>> order to avoid huge, massively overlapping page and folio APIs.
>>
>> Here's an example where our current confusion between "any page"
>> and "head page" at least produces confusing behaviour, if not an
>> outright bug, isolate_migratepages_block():
>>
>>                  page = pfn_to_page(low_pfn);
>> ...
>>                  if (PageCompound(page) && !cc->alloc_contig) {
>>                          const unsigned int order = compound_order(page);
>>
>>                          if (likely(order < MAX_ORDER))
>>                                  low_pfn += (1UL << order) - 1;
>>                          goto isolate_fail;
>>                  }
>>
>> compound_order() does not expect a tail page; it returns 0 unless it's
>> a head page.  I think what we actually want to do here is:
>>
>> 		if (!cc->alloc_contig) {
>> 			struct page *head = compound_head(page);
>> 			if (PageHead(head)) {
>> 				const unsigned int order = compound_order(head);
>>
>> 				low_pfn |= (1UL << order) - 1;
>> 				goto isolate_fail;
>> 			}
>> 		}
>>
>> Not earth-shattering; not even necessarily a bug.  But it's an example
>> of the way the code reads is different from how the code is executed,
>> and that's potentially dangerous.  Having a different type for tail
>> and not-tail pages prevents the muddy thinking that can lead to
>> tail pages being passed to compound_order().
> 
> Thanks for digging this up. I agree the second version is much better.
> 
> My question is still whether the extensive folio whitelisting of
> everybody else is the best way to bring those codepaths to light.
> 
> The above isn't totally random. That code is a pfn walker which
> translates from the basepage address space to an ambiguous struct page
> object. There are more of those, but we can easily identify them: all
> uses of pfn_to_page() and virt_to_page() indicate that the code needs
> an audit for how exactly they're using the returned page.

+pfn_to_online_page()


-- 
Thanks,

David / dhildenb

