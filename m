Return-Path: <linux-fsdevel+bounces-914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C77D35E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 13:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77082815C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F91804A;
	Mon, 23 Oct 2023 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgxtEHbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FB18032
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 11:55:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E002E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698062127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o/9FLnbNSf/pR1bSdYODMnRrmn+49lv+yZ1gIhHzF7k=;
	b=YgxtEHbDFNzWXlbaJvPfLwrvmm1wM/MhHrGS9sqmTPM5GvnzZaoHd5JEcT+Y6Odw3Ip9Zb
	Xkfwr+fYdgrBjqTgBQvmJyZn3O3nVlfoK7+khfnTtmXuywMIllMsihasKpKrsmiJzDxiht
	tYljqSa8495KRBzqOD8frphwbP0dJto=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-k72VAeZ2MQahQec3GfrXAA-1; Mon, 23 Oct 2023 07:55:16 -0400
X-MC-Unique: k72VAeZ2MQahQec3GfrXAA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso18486615e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 04:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062115; x=1698666915;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/9FLnbNSf/pR1bSdYODMnRrmn+49lv+yZ1gIhHzF7k=;
        b=k1WvW472rqFG9x+cL0mcK5HYBzF12T6Ue57CeZuPe63ZdF5UIFM9L55mAFe7qvXrbW
         GgpGOSWGChuAxmp4qZVUKi3RTnmdoe6vhzEVvinsvuEZTUfZMY23esG3YiGBAcYdx24r
         s9Ous3bj/3j525qo8Pu1INQaGjdnyKNpY1dKfbLIvD5oG+etw+HXuprvhnvp9N6wPxYe
         U0/PNo9+FVfROKP9Df9iQLIt4LLcW6X0s980Hin+ZrnqQPL8+WzvbFN/JOCUps+Y4wjW
         Xz4bw0JE6vIrHpU/5MTZsow+RmjXoPz25WUXJzfzaYK4mK1MTxPDGH2hnPaH9+jHFY7b
         icKQ==
X-Gm-Message-State: AOJu0YzhXiVjyo9D3/HsITwqcs5ur5i4b35UJcGAvFlWjDxGd0E2Xj6C
	bJQd57/yl+4nu0j9M+ndupcabmQXQKyNZ7XHUavQhmXoi4oR+MHTMzkLsyZ1a+7O+QessAKglVq
	6Zs7udW2yGER2h0RjKpW5g1mDYw==
X-Received: by 2002:a05:600c:2b10:b0:407:73fc:6818 with SMTP id y16-20020a05600c2b1000b0040773fc6818mr11867974wme.2.1698062114867;
        Mon, 23 Oct 2023 04:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlr9qIwPl6k6OX+uZdhA5xuIhpGw+iftZpfgyQvE2XhPBIipN6WbijSbqNG+SHoesh1bMHHQ==
X-Received: by 2002:a05:600c:2b10:b0:407:73fc:6818 with SMTP id y16-20020a05600c2b1000b0040773fc6818mr11867936wme.2.1698062114449;
        Mon, 23 Oct 2023 04:55:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:1900:b6ea:5b9:62c0:34e? (p200300cbc7381900b6ea05b962c0034e.dip0.t-ipconnect.de. [2003:cb:c738:1900:b6ea:5b9:62c0:34e])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c220600b0040684abb623sm13855577wml.24.2023.10.23.04.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 04:55:13 -0700 (PDT)
Message-ID: <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>
Date: Mon, 23 Oct 2023 13:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp lists
 only if ALLOC_FROM_METADATA
To: Catalin Marinas <catalin.marinas@arm.com>,
 Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
 oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
 akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
 rppt@kernel.org, hughd@google.com, pcc@google.com, steven.price@arm.com,
 anshuman.khandual@arm.com, vincenzo.frascino@arm.com, eugenis@google.com,
 kcc@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany> <ZS0va9nICZo8bF03@monolith>
 <ZS5hXFHs08zQOboi@arm.com> <20231023071656.GA344850@tiffany>
 <ZTZP66CA1r35yTmp@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZTZP66CA1r35yTmp@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.23 12:50, Catalin Marinas wrote:
> On Mon, Oct 23, 2023 at 04:16:56PM +0900, Hyesoo Yu wrote:
>> On Tue, Oct 17, 2023 at 11:26:36AM +0100, Catalin Marinas wrote:
>>> BTW, I suggest for the next iteration we drop MIGRATE_METADATA, only use
>>> CMA and assume that the tag storage itself supports tagging. Hopefully
>>> it makes the patches a bit simpler.
>>
>> I am curious about the plan for the next iteration.
> 
> Alex is working on it.
> 
>> Does tag storage itself supports tagging? Will the following version be unusable
>> if the hardware does not support it? The document of google said that
>> "If this memory is itself mapped as Tagged Normal (which should not happen!)
>> then tag updates on it either raise a fault or do nothing, but never change the
>> contents of any other page."
>> (https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)
>>
>> The support of H/W is very welcome because it is good to make the patches simpler.
>> But if H/W doesn't support it, Can't the new solution be used?
> 
> AFAIK on the current interconnects this is supported but the offsets
> will need to be configured by firmware in such a way that a tag access
> to the tag carve-out range still points to physical RAM, otherwise, as
> per Google's doc, you can get some unexpected behaviour.
> 
> Let's take a simplified example, we have:
> 
>    phys_addr - physical address, linearised, starting from 0
>    ram_size - the size of RAM (also corresponds to the end of PA+1)
> 
> A typical configuration is to designate the top 1/32 of RAM for tags:
> 
>    tag_offset = ram_size - ram_size / 32
>    tag_carveout_start = tag_offset
> 
> The tag address for a given phys_addr is calculated as:
> 
>    tag_addr = phys_addr / 32 + tag_offset
> 
> To keep things simple, we reserve the top 1/(32*32) of the RAM as tag
> storage for the main/reusable tag carveout.
> 
>    tag_carveout2_start = tag_carveout_start / 32 + tag_offset
> 
> This gives us the end of the first reusable carveout:
> 
>    tag_carveout_end = tag_carveout2_start - 1
> 
> and this way in Linux we can have (inclusive ranges):
> 
>    0..(tag_carveout_start-1): normal memory, data only
>    tag_carveout_start..tag_carveout_end: CMA, reused as tags or data
>    tag_carveout2_start..(ram_size-1): reserved for tags (not touched by the OS)
> 
> For this to work, we need the last page in the first carveout to have
> a tag storage within RAM. And, of course, all of the above need to be at
> least 4K aligned.
> 
> The simple configuration of 1/(32*32) of RAM for the second carveout is
> sufficient but not fully utilised. We could be a bit more efficient to
> gain a few more pages. Apart from the page alignment requirements, the
> only strict requirement we need is:
> 
>    tag_carverout2_end < ram_size
> 
> where tag_carveout2_end is the tag storage corresponding to the end of
> the main/reusable carveout, just before tag_carveout2_start:
> 
>    tag_carveout2_end = tag_carveout_end / 32 + tag_offset
> 
> Assuming that my on-paper substitutions are correct, the inequality
> above becomes:
> 
>    tag_offset < (1024 * ram_size + 32) / 1057
> 
> and tag_offset is a multiple of PAGE_SIZE * 32 (so that the
> tag_carveout2_start is a multiple of PAGE_SIZE).
> 
> As a concrete example, for 16GB of RAM starting from 0:
> 
>    tag_offset = 0x3e0060000
>    tag_carverout2_start = 0x3ff063000
> 
> Without the optimal placement, the default tag_offset of top 1/32 of RAM
> would have been:
> 
>    tag_offset = 0x3e0000000
>    tag_carveou2_start = 0x3ff000000
> 
> so an extra 396KB gained with optimal placement (out of 16G, not sure
> it's worth).
> 
> One can put the calculations in some python script to get the optimal
> tag offset in case I got something wrong on paper.

I followed what you are saying, but I didn't quite read the following 
clearly stated in your calculations: Using this model, how much memory 
would you be able to reuse, and how much not?

I suspect you would *not* be able to reuse "1/(32*32)" [second 
carve-out] but be able to reuse "1/32 - 1/(32*32)" [first carve-out] or 
am I completely off?

Further, (just thinking about it) I assume you've taken care of the 
condition that memory cannot self-host it's own tag memory. So that 
cannot happen in the model proposed here, right?

Anyhow, happy to see that we might be able to make it work just by 
mostly reusing existing CMA.

-- 
Cheers,

David / dhildenb


