Return-Path: <linux-fsdevel+bounces-4392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A367FF2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E612826AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DA4A9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3JguiYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2319F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701351833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vXLmPI3YKuWjybHeV+zzmSdSrTMtOftgtk5WyUqCzCo=;
	b=M3JguiYj/JrTc3QEgd52WCpnSNl3j9jk+C9fDVonEiS46D32sT/Pvnb9Nh1kBF89aXzsbD
	zSCpuA2KB7lQFlB5d2zohk62oe/azyxTi1oWlS+NPXhIAuQ2so0Rd8BPaVuVMgsH1pcasa
	7bVpuZEd+Gync+2VqxerpNnq2en0mBo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-NDkiDxAdN7WP5oDTmFD7iw-1; Thu, 30 Nov 2023 08:43:51 -0500
X-MC-Unique: NDkiDxAdN7WP5oDTmFD7iw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c9b97a391bso11212631fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351830; x=1701956630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXLmPI3YKuWjybHeV+zzmSdSrTMtOftgtk5WyUqCzCo=;
        b=wVEsa1tPKxpgpygMzKt6jhbmzTOlbzlzT2kz+nSukbgVsbPTriUFtD/CM4akJGS5q1
         iSulh7ml4uqUP/Jp87vJeJC+KL0NctOkCblnAYn34hnYHmiv3S+/vNAngaMDGAaUypRr
         OCBLraty2n3zKzzseypkT7eCsT+Kv0+Mf3e/eojIxPipNNCG7/BJT6ydDpx75zkz39iU
         ffxaMtSMEslN+Wv7FCnN37CoCYBxeFraVx6XeGrJpCGgYSSWpnpBO2wbGD4iQEVOiafm
         8IN1WWSTzfbn1dbqJ4iZ2DCHdE5uGfTLhHW8SeoXZl1scfEajdfTWR/Fw+Crge7gvF2P
         usgA==
X-Gm-Message-State: AOJu0Yx2lqb6uCawdihU5DfHBCrSiFHGt5WcR+Ah/jsn86DR8MR7QXXZ
	fk6YEQY4KhG35xfrPWADXy1lBCNiOIjBgKT0E6grU+LY341e0tccnYKcq+EG5aL70q9aY+iDM5g
	5x2INnzN3eOyzQfZs0mtYXDz5KA==
X-Received: by 2002:a2e:9b4d:0:b0:2c9:b4c6:a7ff with SMTP id o13-20020a2e9b4d000000b002c9b4c6a7ffmr5098585ljj.40.1701351830307;
        Thu, 30 Nov 2023 05:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNEah9uEWG0d1eEyNvSkC2EScna+/OIpBCKDONcD2fN4xZ88Wfm1ISF4DLZSarzZEBaM0Hyg==
X-Received: by 2002:a2e:9b4d:0:b0:2c9:b4c6:a7ff with SMTP id o13-20020a2e9b4d000000b002c9b4c6a7ffmr5098553ljj.40.1701351829882;
        Thu, 30 Nov 2023 05:43:49 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b4fca8620sm5777979wmo.37.2023.11.30.05.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 05:43:49 -0800 (PST)
Message-ID: <d7e0574d-c74d-4e91-bf60-aa6691df78e3@redhat.com>
Date: Thu, 30 Nov 2023 14:43:48 +0100
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
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com,
 steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
 eugenis@google.com, kcc@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d@epcas2p3.samsung.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <20231129092725.GD2988384@tiffany> <ZWh6vl8DfXQbKo9O@raptor>
 <4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com> <ZWiO4PWfK2gKDLGr@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWiO4PWfK2gKDLGr@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.11.23 14:32, Alexandru Elisei wrote:
> Hi,
> 
> On Thu, Nov 30, 2023 at 01:49:34PM +0100, David Hildenbrand wrote:
>>>>> +
>>>>> +out_retry:
>>>>> +	put_page(page);
>>>>> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
>>>>> +		vma_end_read(vma);
>>>>> +	if (fault_flag_allow_retry_first(vmf->flags)) {
>>>>> +		err = VM_FAULT_RETRY;
>>>>> +	} else {
>>>>> +		/* Replay the fault. */
>>>>> +		err = 0;
>>>>
>>>> Hello!
>>>>
>>>> Unfortunately, if the page continues to be pinned, it seems like fault will continue to occur.
>>>> I guess it makes system stability issue. (but I'm not familiar with that, so please let me know if I'm mistaken!)
>>>>
>>>> How about migrating the page when migration problem repeats.
>>>
>>> Yes, I had the same though in the previous iteration of the series, the
>>> page was migrated out of the VMA if tag storage couldn't be reserved.
>>>
>>> Only short term pins are allowed on MIGRATE_CMA pages, so I expect that the
>>> pin will be released before the fault is replayed. Because of this, and
>>> because it makes the code simpler, I chose not to migrate the page if tag
>>> storage couldn't be reserved.
>>
>> There are still some cases that are theoretically problematic: vmsplice()
>> can pin pages forever and doesn't use FOLL_LONGTERM yet.
>>
>> All these things also affect other users that rely on movability (e.g., CMA,
>> memory hotunplug).
> 
> I wasn't aware of that, thank you for the information. Then to ensure that the
> process doesn't hang by replying the loop indefinitely, I'll migrate the page if
> tag storage cannot be reserved. Looking over the code again, I think I can reuse
> the same function that migrates tag storage pages out of the MTE VMA (added in
> patch #21), so no major changes needed.

It's going to be interesting if migrating that page fails because it is 
pinned :/

-- 
Cheers,

David / dhildenb


