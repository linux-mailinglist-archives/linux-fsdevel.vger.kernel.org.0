Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24D4434639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhJTHxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 03:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhJTHxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634716262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aj7Vb0KWV79M1QnYKnvPwJppFiYy0tbNTL9fv9yVSsk=;
        b=M6uVziQxbQzoe5qfRDj6TRt+Y/Ln4ijmJIFA1jlg3WyasP1lc7OEYq6Hqk/0aSWGjRwHoG
        tWEYerXPtL6miUE710uRVXhyHkIQEdf2cFOGH4yBcjUxmCoWj1EkBEqbn6G51ucEJ/rHBx
        5BTa1guDs/jx3ikWkO4fZQ8l4QhiixU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-u9k02r9VMIOQOoUp0KRycg-1; Wed, 20 Oct 2021 03:51:01 -0400
X-MC-Unique: u9k02r9VMIOQOoUp0KRycg-1
Received: by mail-wm1-f69.google.com with SMTP id k9-20020a7bc409000000b0030d978403e9so3728663wmi.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 00:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=aj7Vb0KWV79M1QnYKnvPwJppFiYy0tbNTL9fv9yVSsk=;
        b=pOsKcKECctJWtJP91Y0WEx3ScUOyaD28ZJO3XXtxph1I5Kv0wu+g+hglEhLyd2edDv
         81hA94kugldN/M6FYpRfGI0rOg6fD+V1IK7hy1Gx6g/PWILVNfraQiIP7SgZCMaxRKoR
         We1NvJOCPOSKW5w1VXxgh0+YvPJFofk2Q3Lgv66c/9t7MjLNKTgfXZXsvRrMWWTnnYZs
         lrbkyl/OmZ6fHFmIqHwXXLUge4cGEJnLiSShkrku7HLePmFv9IyPhDtSw/0q/acUK7Vt
         y0x3aq0gITQv+e6vesufOzP9kaeW4z5rdj1mVI2jhnLcm/W+TK4m24p7mK6wavMnnkxE
         ImjA==
X-Gm-Message-State: AOAM530sXOVgMDmaqO6OnGTZpjid3fzNTBARIZl9Sep0jFieRCOPWD9J
        tSuI2i0QdGwDeNRHRAxDa4xm5x1Bqt3rexxzfMSRkYDwzSjfd2719N9Fkm1XLrupRghOBcvcLgj
        j5cmJoAVULWW9QzeevbY+Rotjqw==
X-Received: by 2002:adf:a118:: with SMTP id o24mr49827663wro.15.1634716260020;
        Wed, 20 Oct 2021 00:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXElaXdSpOfBhp+HWj7pfjq41epCfv+2QQ/z2gNb0CvANLqwz4gZXGZKmv6SSMRfA6RszSRw==
X-Received: by 2002:adf:a118:: with SMTP id o24mr49827630wro.15.1634716259710;
        Wed, 20 Oct 2021 00:50:59 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id t4sm1261277wro.1.2021.10.20.00.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 00:50:59 -0700 (PDT)
Message-ID: <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
Date:   Wed, 20 Oct 2021 09:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org> <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan> <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YW7hQlny+Go1K3LT@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.10.21 17:16, Johannes Weiner wrote:
> On Tue, Oct 19, 2021 at 02:16:27AM +0300, Kirill A. Shutemov wrote:
>> On Mon, Oct 18, 2021 at 05:56:34PM -0400, Johannes Weiner wrote:
>>>> I don't think there will ever be consensus as long as you don't take
>>>> the concerns of other MM developers seriously.  On Friday's call, several
>>>> people working on using large pages for anon memory told you that using
>>>> folios for anon memory would make their lives easier, and you didn't care.
>>>
>>> Nope, one person claimed that it would help, and I asked how. Not
>>> because I'm against typesafety, but because I wanted to know if there
>>> is an aspect in there that would specifically benefit from a shared
>>> folio type. I don't remember there being one, and I'm not against type
>>> safety for anon pages.
>>>
>>> What several people *did* say at this meeting was whether you could
>>> drop the anon stuff for now until we have consensus.
>>
>> My read on the meeting was that most of people had nothing against anon
>> stuff, but asked if Willy could drop anon parts to get past your
>> objections to move forward.
>>
>> You was the only person who was vocal against including anon pars. (Hugh
>> nodded to some of your points, but I don't really know his position on
>> folios in general and anon stuff in particular).
> 
> Nobody likes to be the crazy person on the soapbox, so I asked Hugh in
> private a few weeks back. Quoting him, with permission:
> 
> : To the first and second order of approximation, you have been
> : speaking for me: but in a much more informed and constructive and
> : coherent and rational way than I would have managed myself.
> 
> It's a broad and open-ended proposal with far reaching consequences,
> and not everybody has the time (or foolhardiness) to engage on that. I
> wouldn't count silence as approval - just like I don't see approval as
> a sign that a person took a hard look at all the implications.
> 
> My only effort from the start has been working out unanswered
> questions in this proposal: Are compound pages the reliable, scalable,
> and memory-efficient way to do bigger page sizes? What's the scope of
> remaining tailpages where typesafety will continue to lack? How do we
> implement code and properties shared by folios and non-folio types
> (like mmap/fault code for folio and network and driver pages)?
> 
> There are no satisfying answers to any of these questions, but that
> also isn't very surprising: it's a huge scope. Lack of answers isn't
> failure, it's just a sign that the step size is too large and too
> dependent on a speculative future. It would have been great to whittle
> things down to a more incremental and concrete first step, which would
> have allowed us to keep testing the project against reality as we go
> through all the myriad of uses and cornercases of struct page that no
> single person can keep straight in their head.
> 
> I'm grateful for the struct slab spinoff, I think it's exactly all of
> the above. I'm in full support of it and have dedicated time, effort
> and patches to help work out kinks that immediately and inevitably
> surfaced around the slab<->page boundary.
> 
> I only hoped we could do the same for file pages first, learn from
> that, and then do anon pages; if they come out looking the same in the
> process, a unified folio would be a great trailing refactoring step.
> 
> But alas here we are months later at the same impasse with the same
> open questions, and still talking in circles about speculative code.
> I don't have more time to invest into this, and I'm tired of the
> vitriol and ad-hominems both in public and in private channels.

Thanks Johannes for defending your position and I can understand that
you are running out of motivation+energy to defend further.

For the records: I was happy to see the slab refactoring, although I
raised some points regarding how to access properties that belong into
the "struct page". As raised elsewhere, I'd also be more comfortable
seeing small incremental changes/cleanups that are consistent even
without having decided on an ultimate end-goal -- this includes folios.
I'd be happy to see file-backed THP gaining their own, dedicated type
first ("struct $whatever"), before generalizing it to folios.

I'm writing this message solely to back your "not everybody has the time
(or foolhardiness) to engage on that. I wouldn't count silence as
approval.". While I do have the capacity to review smaller, incremental
steps (see struct slab), I don't have the time+energy to gasp the full
folio picture. So I also second "it's a huge scope. [...] it's just a
sign that the step size is too large and too dependent on a speculative
future."

My 2 cents on this topic.

-- 
Thanks,

David / dhildenb

