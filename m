Return-Path: <linux-fsdevel+bounces-943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291937D3D66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6131281397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA2200CB;
	Mon, 23 Oct 2023 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1ULEi1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600912B7F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:22:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71694
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698081759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7tOvXGzE2NpQ6tZnzJg9WmExIPulJp9KgVxJ9uvAFEE=;
	b=M1ULEi1goPyH5Vq0CW9r+gY5lDkR1gY0XjJG1txB56cgSChcJgNkxk5FqcJ94u2XqO20F3
	/vONP8hpbfrxFZfbGh7T/FVNhTZ+ZAz3Otr/dIkVxlDzV2JmX6S1eb/hP6vE3V1RFzPd3r
	QezkvsKQojvbxN8o1NUnRX7lNZQlDjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-ByUMj3iNOOaFL_FspEaIXg-1; Mon, 23 Oct 2023 13:22:27 -0400
X-MC-Unique: ByUMj3iNOOaFL_FspEaIXg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32dcad22c5fso1451707f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081746; x=1698686546;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tOvXGzE2NpQ6tZnzJg9WmExIPulJp9KgVxJ9uvAFEE=;
        b=Sln0ZwQbUfkc7/tORGz6TrTqBoPeqX/GUJyqnXfMmEo+ecn31d4GsVv3G052mWRztq
         8BJaK26nJVmLHN2cGlbgJbOSHmiIajQq5oJsDSidWMbDMKAqLDU8l+OZvmOjO2JRZDVh
         y4egT8oyAcf9kAPTuHX3uvWA38gn3q+tbQG/k2t5e6f+YII6Hqc9wrUF4Q0VVDqvT0Kt
         aGm7DLU468uR5mlIK+03uVJ3MV4f3SaixIFnfFLQL7ZFS/y1r7Sf6fYwek2mCBdIHtOc
         As0dlIpPCDjLuNWGWTigjeEz2hpAcnPwiJo03UV3o7tuno0znNgEPHqJOYUfl4ZZFxEP
         RZbQ==
X-Gm-Message-State: AOJu0YxI33RARmNzNGSJAp+yPTdDoch0d2SmFCUDTBdlBGJIRMuRsG49
	DNTpF+1f1wBZHh0IUVbEuqT6coN6x7odmVZJPl3ohZdREililkVbYHEn77EPVhUt9CfdFIibEwP
	RVqpyEQcBIgD3WNER8erh5wGvmA==
X-Received: by 2002:a5d:5267:0:b0:31f:f65f:74ac with SMTP id l7-20020a5d5267000000b0031ff65f74acmr8223975wrc.70.1698081746192;
        Mon, 23 Oct 2023 10:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCMOI1KN9UzvpFgp9lfJ0fqVHI9JbN2l0Rq7ZKvD1mIJErINDA2Vo0dhINX9e9eZUR/WKTYg==
X-Received: by 2002:a5d:5267:0:b0:31f:f65f:74ac with SMTP id l7-20020a5d5267000000b0031ff65f74acmr8223956wrc.70.1698081745763;
        Mon, 23 Oct 2023 10:22:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:1900:b6ea:5b9:62c0:34e? (p200300cbc7381900b6ea05b962c0034e.dip0.t-ipconnect.de. [2003:cb:c738:1900:b6ea:5b9:62c0:34e])
        by smtp.gmail.com with ESMTPSA id u16-20020adff890000000b0032d8ce46caasm8184399wrp.93.2023.10.23.10.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:22:25 -0700 (PDT)
Message-ID: <11fa8d5a-483f-4460-acc0-79ba4eabc4c5@redhat.com>
Date: Mon, 23 Oct 2023 19:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp lists
 only if ALLOC_FROM_METADATA
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
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
 <ZTZP66CA1r35yTmp@arm.com> <25fad62e-b1d9-4d63-9d95-08c010756231@redhat.com>
 <ZTaohewXhtkqoLZD@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZTaohewXhtkqoLZD@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.23 19:08, Catalin Marinas wrote:
> On Mon, Oct 23, 2023 at 01:55:12PM +0200, David Hildenbrand wrote:
>> On 23.10.23 12:50, Catalin Marinas wrote:
>>> On Mon, Oct 23, 2023 at 04:16:56PM +0900, Hyesoo Yu wrote:
>>>> Does tag storage itself supports tagging? Will the following version be unusable
>>>> if the hardware does not support it? The document of google said that
>>>> "If this memory is itself mapped as Tagged Normal (which should not happen!)
>>>> then tag updates on it either raise a fault or do nothing, but never change the
>>>> contents of any other page."
>>>> (https://github.com/google/sanitizers/blob/master/mte-dynamic-carveout/spec.md)
>>>>
>>>> The support of H/W is very welcome because it is good to make the patches simpler.
>>>> But if H/W doesn't support it, Can't the new solution be used?
>>>
>>> AFAIK on the current interconnects this is supported but the offsets
>>> will need to be configured by firmware in such a way that a tag access
>>> to the tag carve-out range still points to physical RAM, otherwise, as
>>> per Google's doc, you can get some unexpected behaviour.
> [...]
>> I followed what you are saying, but I didn't quite read the following
>> clearly stated in your calculations: Using this model, how much memory would
>> you be able to reuse, and how much not?
>>
>> I suspect you would *not* be able to reuse "1/(32*32)" [second carve-out]
>> but be able to reuse "1/32 - 1/(32*32)" [first carve-out] or am I completely
>> off?
> 
> That's correct. In theory, from the hardware perspective, we could even
> go recursively to the third/fourth etc. carveout until the last one is a
> single page but I'd rather not complicate things further.
> 
>> Further, (just thinking about it) I assume you've taken care of the
>> condition that memory cannot self-host it's own tag memory. So that cannot
>> happen in the model proposed here, right?
> 
> I don't fully understand what you mean. The tags for the first data
> range (0 .. ram_size * 31/32) are stored in the first tag carveout.
> That's where we'll need CMA. For the tag carveout, when hosting data
> pages as tagged, the tags go in the second carveout which is fully
> reserved (still TBD but possibly the firmware won't even tell the kernel
> about it).

You got my cryptic question right: you make sure that the tag for the 
first carveout go to the second carveout.

Sounds very good, thanks.

-- 
Cheers,

David / dhildenb


