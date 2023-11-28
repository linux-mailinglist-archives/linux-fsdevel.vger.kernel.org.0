Return-Path: <linux-fsdevel+bounces-4058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65237FBFD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDEB1C20C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64221A1A;
	Tue, 28 Nov 2023 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcmDT7nH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84FD62
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701190657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mhz2aAjozGznk5js3AKekQTCp0LGPxPOzTnF3OrDrGk=;
	b=DcmDT7nHwttuTinhgZ24+i8amJxNNGQJW3QwvNLDU/pKBoNiybFcAGaJO1T31yGOY1J1Y+
	AVx3ib0g+L2zDqElnT80HtS2dyRLAAWB72PL5RCOfVbAEG6maYykdh187PqvRFKPZkYTZd
	FF7nGHcPigQO5g5TV7VjQDznNaXUlQU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120--0Hy8aEBPYy6zAkZebDZsw-1; Tue, 28 Nov 2023 11:57:35 -0500
X-MC-Unique: -0Hy8aEBPYy6zAkZebDZsw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b32faeb7eso33036535e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 08:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190654; x=1701795454;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhz2aAjozGznk5js3AKekQTCp0LGPxPOzTnF3OrDrGk=;
        b=gfrEWm30t3ER1AyAU2CQ1TVEfPOtXrItJ1fCy13Quir3Qsm7D1c4eL42vtPLzA0DD2
         NOFAM+WwHaHOnfyw6KIKxvAVI/iH9WT3ldY3U70Q0UH3kmqLwTee+zQEl92m8Hdc/hqZ
         xGmas0/OFy/id1nmqkOuwlYc+ziEtL+Xf+tvC40DEiqFx+7KR7Vi10eikZuSbUJtWqXF
         lJZpyFdw6+ViWwfkHdMqfef19mni/RnNCEbjnL5hieRr8612m057GRbY6JFPMqT8Nm7X
         O7JbFtYmtgHijQ7opvSP4IfoOzgCUta6PbK2uxpM43eMF5H6E6QomOlhE4mUy5htqeLK
         gAsQ==
X-Gm-Message-State: AOJu0YyboTl4vMWsH90NcTrcc1a+i3W5/UCfB+e6hfmvDlgj+vDfslU3
	wdZkPujEfNr3ToApnpw3jOrCOTG+pBWl1LPnGl4QIdhBkfqOPU+5D99j9vUoQJiEib35g0h8gEN
	wjd0VP+l/MYHfenuyDCNo0uKndQ==
X-Received: by 2002:a05:600c:5486:b0:40b:4aee:ea9e with SMTP id iv6-20020a05600c548600b0040b4aeeea9emr1841384wmb.17.1701190654571;
        Tue, 28 Nov 2023 08:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2rxk0Q3GVvHMRjedMUVFzyjVJeCSZm/niH70YFfgmRZLrknHuTNDj9GCIicfRzDSV2e5yEg==
X-Received: by 2002:a05:600c:5486:b0:40b:4aee:ea9e with SMTP id iv6-20020a05600c548600b0040b4aeeea9emr1841351wmb.17.1701190654112;
        Tue, 28 Nov 2023 08:57:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d4a06000000b003330aede2aesm2717126wrq.112.2023.11.28.08.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 08:57:33 -0800 (PST)
Message-ID: <0a0f9345-3138-4e89-80cd-c7edaf2ff62d@redhat.com>
Date: Tue, 28 Nov 2023 17:57:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/27] mm: page_alloc: Add an arch hook to allow
 prep_new_page() to fail
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-6-alexandru.elisei@arm.com>
 <dadc9d17-f311-47f1-a264-28b42bed0ab0@redhat.com> <ZWSHF2hVOPTBIQLY@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWSHF2hVOPTBIQLY@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 13:09, Alexandru Elisei wrote:
> Hi,
> 
> Thank you so much for your comments, there are genuinely useful.
> 
> On Fri, Nov 24, 2023 at 08:35:47PM +0100, David Hildenbrand wrote:
>> On 19.11.23 17:56, Alexandru Elisei wrote:
>>> Introduce arch_prep_new_page(), which will be used by arm64 to reserve tag
>>> storage for an allocated page. Reserving tag storage can fail, for example,
>>> if the tag storage page has a short pin on it, so allow prep_new_page() ->
>>> arch_prep_new_page() to similarly fail.
>>
>> But what are the side-effects of this? How does the calling code recover?
>>
>> E.g., what if we need to populate a page into user space, but that
>> particular page we allocated fails to be prepared? So we inject a signal
>> into that poor process?
> 
> When the page fails to be prepared, it is put back to the tail of the
> freelist with __free_one_page(.., FPI_TO_TAIL). If all the allocation paths
> are exhausted and no page has been found for which tag storage has been
> reserved, then that's treated like an OOM situation.
> 
> I have been thinking about this, and I think I can simplify the code by
> making tag reservation a best effort approach. The page can be allocated
> even if reserving tag storage fails, but the page is marked as invalid in
> set_pte_at() (PAGE_NONE + an extra bit to tell arm64 that it needs tag
> storage) and next time it is accessed, arm64 will reserve tag storage in
> the fault handling code (the mechanism for that is implemented in patch #19
> of the series, "mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for
> mprotect(PROT_MTE)").
> 
> With this new approach, prep_new_page() stays the way it is, and no further
> changes are required for the page allocator, as there are already arch
> callbacks that can be used for that, for example tag_clear_highpage() and
> arch_alloc_page(). The downside is extra page faults, which might impact
> performance.
> 
> What do you think?

That sounds a lot more robust, compared to intermittent failures to 
allocate pages.

-- 
Cheers,

David / dhildenb


