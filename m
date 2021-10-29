Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEB4404F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2VkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 17:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhJ2VkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635543452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClzOUtwTHlAumKjPlNzIMz5TpO4PKPAZvBv0OBmYWZs=;
        b=UWQo5MNvfBfU4bcmCHt3/He2SEUqM9et+fo5nzjVsDL0htv0TB1sPEeGySTfdEE/f4bNzS
        ycCNtdVMd5/SZp9Z30H6Fh0azwP4C4kya/+5MPJTR9dmnhNYWellfr00kDFbSNpH/HI7SH
        tbCYmbQVDJQ0EhCFPhCeYPoZY1T18qw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-ockCFcheMjqaYndJArOMNw-1; Fri, 29 Oct 2021 17:37:31 -0400
X-MC-Unique: ockCFcheMjqaYndJArOMNw-1
Received: by mail-wr1-f71.google.com with SMTP id p17-20020adff211000000b0017b902a7701so1235159wro.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 14:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ClzOUtwTHlAumKjPlNzIMz5TpO4PKPAZvBv0OBmYWZs=;
        b=hvOBunwL9kU5ogtOOH34/4Xv2Cmm0LAkFLTlwCfY1ZG35xswuxhzDQ/M/fMmVUx4Zy
         05GN50oeNcr1ymyvcX8R0PfykAcHRe5nKMm1QjoJ7BUiDpUEkXxwqIA2EBqM+/ByIdUI
         yCBgHDLHB/dLBGChZtoLo6m1+WWC6d9f8xXdStxmHgjSJK/xpbCo5UmR6msxDOiYMEbk
         F7V2edbGZ13mgsdU1YtSVzb2YHuWFSPVeeA84Mn3liWbRTV6JAxJWOoKvI6fPTNA8Mbb
         LBYbQUkEA6poLCw1DBDEBkPWbe3bjBxUnZX8xeNaSx7f0UhItfmc81xVKGZfquIj82dl
         Iejw==
X-Gm-Message-State: AOAM533fgtGmtui5rC6QSRk1OuTdG88mRDA3RSBcFV07ipo1sI2cK3U+
        tejKSdOR1jNZBLwgc7l1ItIPEWs2/lMg9ndhQWngHcY19xxs1+VUbid8O6TmvEYTHvOjuqGxxbU
        uN+f/wnqz7A4/EqIFwcsQU7vSww==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr17564860wrd.178.1635543450066;
        Fri, 29 Oct 2021 14:37:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+1PuI1t0T15zeALBVWJbBxvYeNH54CVOsVpH7Y6OmbPbxKkNOESOUvK44PlZetVVYA9Q2aA==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr17564833wrd.178.1635543449781;
        Fri, 29 Oct 2021 14:37:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b86.dip0.t-ipconnect.de. [79.242.59.134])
        by smtp.gmail.com with ESMTPSA id q4sm2006685wrs.56.2021.10.29.14.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 14:37:29 -0700 (PDT)
Message-ID: <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com>
Date:   Fri, 29 Oct 2021 23:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Nathan Lewis <npl@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211028205854.830200-1-almasrymina@google.com>
 <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
 <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
In-Reply-To: <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29.10.21 22:04, Mina Almasry wrote:
> On Fri, Oct 29, 2021 at 12:11 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 28.10.21 22:58, Mina Almasry wrote:
>>> From: Yu Zhao <yuzhao@google.com>
>>>
>>> This file lets a userspace process know the page flags of each of its virtual
>>> pages.  It contains a 64-bit set of flags for each virtual page, containing
>>> data identical to that emitted by /proc/kpageflags.  This allows the user-space
>>> task can learn the kpageflags for the pages backing its address-space by
>>> consulting one file, without needing to be root.
>>>
>>> Example use case is a performance sensitive user-space process querying the
>>> hugepage backing of its own memory without the root access required to access
>>> /proc/kpageflags, and without accessing /proc/self/smaps_rollup which can be
>>> slow and needs to hold mmap_lock.
>>
>> Can you elaborate on
>>
>> a) The target use case. Are you primarily interested to see if a page
>> given base page is head or tail?
>>
> 
> Not quite. Generally some userspace process (most notably our network
> service) has a region of performance critical memory and would like to
> know if this memory is backed by hugepages or not. It uses
> /proc/self/pageflags to inspect the pageflags of the pages backing
> this region, and counts how many ranges are backed by hugepages and
> how many are not. Generally we export this data to metrics, and if the
> hugepage backing drops or is insufficient we look into the issue
> postmortem.

Okay, so it's all about detecting if/where THPs are mapped. I assume
knowing just the number of THPs getting used by that process is not
sufficient for your use case? If you just need numbers, it might be
better to let the kernel do the counting :)

[...]

>> Also, do you have a rough performance comparison?
>>
> 
> So from my tests with simple processes querying smaps/pageflags I
> don't see any performance difference, but I suspect it's due to my
> test cases not mapping much memory or regions.
> 
> I've CC'd Nathan who works on our network service and has run into
> performance issues with smaps. Nathan, do you have a rough performance
> comparison? If so please do share.
> 

That would be great, because we tend to not add interfaces if the
information can already be obtained differently and there is no clear
benefit. Performance comparisons can help.

>>>
>>> Similar to /proc/kpageflags, the flags printed out by the kernel for
>>> each page are provided by stable_page_flags(), which exports flag bits
>>> that are user visible and stable over time.
>>
>> It exports flags (documented for pageflags_read()) that are not
>> applicable to processes, like OFFLINE. BUDDY, SLAB, PGTABLE ... and can
>> never happen. Some of these kpageflags are not even page->flags, they
>> include abstracted types we use for physical memory pages based on other
>> struct page members (OFFLINE, BUDDY, MMAP, PGTABLE, ...). This feels wrong.
>>
>> Also, to me it feels like we are exposing too much internal information
>> to the user, essentially making it ABI that user space processes will
>> rely on.
>>
> 
> I'm honestly a bit surprised by this comment because AFAIU (sorry if
> wrong) we are already exporting this information via /proc/kpageflags
> and therefore it's already somewhat part of an ABI, and the
> stable_page_flags() output already needs to be stable and backwards
> compatible due to potential root users being affected by any
> non-backwards compatible changes. I am yes extending access to this
> information to non-root users.

Sure, a (root) application could access these flags via /proc/kpageflags
-- in my thinking usually for debugging purposes, like how I've been
using it a couple of times.

Because for something in process context it's barely usable: once you
have the PFN via the pagemap for a virtual address and you would want to
read the flags of that PFN via kpageflags, the PFN might already have
changed for the virtual address and you'd be reading wrong data. It's racy.

I might be wrong, maybe there are some system services making use of
that information for some kind of optimizations. A quick google search
didn't reveal anything, but maybe I just gave up too early :)

Exposing this information to non-root users would most certainly let
some random libraries use this information for real and depend on it,
for whatever purpose. If that makes sense.

> 
>> Did you investigate
>>
>> a) Reducing the flags we expose to a bare minimum necessary for your use
>> case (and actually applicable to mmaped pages).
>>
> 
> To be honest I haven't, but this is something that's certainly doable.
> I'm not sure it's easier for processes to understand or the kernel to
> maintain. My thinking:
> 1. Processes parsing /proc/kpageflags can also easily parse
> /proc/self/pageflags and re-use code/implementations between them.
> 2. Userspace code can extract the flags they need and ignore the ones
> they don't need or are not applicable.
> 3. For kernel it's maybe easier to maintain 1 set of
> stable_page_flags() and keep that list backwards compatible. To
> address your comment I'd need to create a subset,
> stable_ps_page_flags(), and both lists now need to be backwards
> compatible.

I'd love to hear other opinions, because maybe I'm just being paranoid. :)

> 
> But I hear you, and if you feel strongly about this I'm more than
> happy to oblige. Please confirm if this is something you would like to
> see in V2.
> 
>> b) Extending pagemap output instead.
>>
> 
> No I have not until you mentioned it, but even now AFAIU (and again
> sorry if wrong, please correct) all the bits exposed by pagemap as
> documented in pagemap.rst are in use, and it's a non-starter for me to
> modify how pagemap works because it'd break backwards compatibility.
> But if you see a way I'm happy to oblige :-)
> 

Bit 58-60 are still free, no? Bit 57 was recently added for uffd-wp
purposes I think.

#define PM_SOFT_DIRTY		BIT_ULL(55)
#define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
#define PM_UFFD_WP		BIT_ULL(57)
#define PM_FILE			BIT_ULL(61)
#define PM_SWAP			BIT_ULL(62)
#define PM_PRESENT		BIT_ULL(63)

PM_MMAP_EXCLUSIVE and PM_FILE already go into the direction of "what is
mapped" IMHO. So just a thought if something in there (PM_HUGE? PM_THP?)
... could make sense.

-- 
Thanks,

David / dhildenb

