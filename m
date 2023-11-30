Return-Path: <linux-fsdevel+bounces-4383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A87FF2A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402891C20BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FD51007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkdoPy5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8710C9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701348580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EnBEPg3GHi1Q+xUTeF0QPxeBJXMhNl/wGhqix5nD240=;
	b=CkdoPy5tMWP0pnmjtxrXRDCGMhFnXqa77y6W1vnokyWxB4upNAiJLVK0ULzUXu2jOmlr8V
	tO6ZaRV3+DxOMq05gmmuWVczwVvy0bs0LiBFTPXRhorV5zJ0Ya5SRmpVKsRIG1lusMsJuU
	/5RsNCtCCVytq9WQ0lM2fKU5XEBCtWU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-lY9MxG19N0eOSTABQ-nRZg-1; Thu, 30 Nov 2023 07:49:38 -0500
X-MC-Unique: lY9MxG19N0eOSTABQ-nRZg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bc433c9ccso1028172e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701348577; x=1701953377;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnBEPg3GHi1Q+xUTeF0QPxeBJXMhNl/wGhqix5nD240=;
        b=s1uD6yxoSY5qjWEIcuZhKnXhznYXHCuhHlgci4xrX0fGEkSEIRUNnGr8omI/Bn1/ow
         jalcqDXDOTgu0EiPNUrMb9EIaBHZ4P/Y7kmSZo+CY4T+IHbhtPYzay2VXSN3WVAAo61+
         V0koX/JbjZle9VVPTnd+Nw9u0ssXw3P0KypZygBneX/92Jp0lynsIGNDu8EEPPFCuJBb
         DoVrUpmYXDrn4aWVcLY4LvllsFTE8VT5fCA17ZRJkdcWU8NtYT4Nb/ebu4Cljq+nH1iG
         Nt6zkXCI5F/83astZbeC1ChQNHQUpybPDMg9JWXthPtTKgVPzEOzWCUyEf2UICjc6iqs
         n6Gw==
X-Gm-Message-State: AOJu0YxAhTbZqXUzfUHPVR0YLDI+N1oZl7dUyiJVnayysd3ydtJGlBSs
	9Ghz+U8MoKgQl6LO2Oc30RUDD5B7174l6/NULBAIQfxEBiKd8ersdQUsFYFUoa1gD3kIgIZrhnS
	tJAlfWemDiARHAylACgN32pMj5Q==
X-Received: by 2002:ac2:44ba:0:b0:50b:ca71:4129 with SMTP id c26-20020ac244ba000000b0050bca714129mr1389903lfm.58.1701348577354;
        Thu, 30 Nov 2023 04:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz5VuDRF3qSzNNkHYw5OfrBg9j+9t8BoZjOCfVF5tg+RVdeWrUxPX0uBR3Vcs37p9k5XosKw==
X-Received: by 2002:ac2:44ba:0:b0:50b:ca71:4129 with SMTP id c26-20020ac244ba000000b0050bca714129mr1389861lfm.58.1701348576878;
        Thu, 30 Nov 2023 04:49:36 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm1977198wmb.15.2023.11.30.04.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 04:49:36 -0800 (PST)
Message-ID: <4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com>
Date: Thu, 30 Nov 2023 13:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS
 for mprotect(PROT_MTE)
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d@epcas2p3.samsung.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <20231129092725.GD2988384@tiffany> <ZWh6vl8DfXQbKo9O@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWh6vl8DfXQbKo9O@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> +
>>> +out_retry:
>>> +	put_page(page);
>>> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
>>> +		vma_end_read(vma);
>>> +	if (fault_flag_allow_retry_first(vmf->flags)) {
>>> +		err = VM_FAULT_RETRY;
>>> +	} else {
>>> +		/* Replay the fault. */
>>> +		err = 0;
>>
>> Hello!
>>
>> Unfortunately, if the page continues to be pinned, it seems like fault will continue to occur.
>> I guess it makes system stability issue. (but I'm not familiar with that, so please let me know if I'm mistaken!)
>>
>> How about migrating the page when migration problem repeats.
> 
> Yes, I had the same though in the previous iteration of the series, the
> page was migrated out of the VMA if tag storage couldn't be reserved.
> 
> Only short term pins are allowed on MIGRATE_CMA pages, so I expect that the
> pin will be released before the fault is replayed. Because of this, and
> because it makes the code simpler, I chose not to migrate the page if tag
> storage couldn't be reserved.

There are still some cases that are theoretically problematic: 
vmsplice() can pin pages forever and doesn't use FOLL_LONGTERM yet.

All these things also affect other users that rely on movability (e.g., 
CMA, memory hotunplug).

-- 
Cheers,

David / dhildenb


