Return-Path: <linux-fsdevel+bounces-1849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F387DF6F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B54B212FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF921D52B;
	Thu,  2 Nov 2023 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtaEO8iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8C1CF9C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:47:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D8E185
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698940064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oJmds8NpMYR077/qYm0AkkAJkl9e2cZ92kDZE2Ii8D4=;
	b=RtaEO8iyMqhqOM6HFXoVkaEVXWBSJxP/OiOo8nxuG9Jo+quDr12/P26pmIdhjqjRl0M709
	X7S6loDaPuBbe981M4Kw5ChXj3FkTvB0dCT/IMkroq7EDZ7okSSxYogFdmd9EX4RtlJx5M
	9mJoH3g9sIcjajSzpNTHpQX6NuwWSew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-pswMAb0MOguRFkaxuYdygQ-1; Thu, 02 Nov 2023 11:47:42 -0400
X-MC-Unique: pswMAb0MOguRFkaxuYdygQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408524e2368so7018535e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 08:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940061; x=1699544861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJmds8NpMYR077/qYm0AkkAJkl9e2cZ92kDZE2Ii8D4=;
        b=QMB8vcatIzViNPdbz42kCROwRjFPYVlz22nJ10Xb7vPErJLZFcAuArS/leucqngZEQ
         PUy+8a/PFKxid75KasnQ4lynxL9lssVbI78+AYlrXV0+bbQJWF871fpzBOYLaqqpfpln
         g3b4aoO3l8dh6ip1YSAAtmnf0w7lp0hyJwyXXwFgHze/VovlepIN2/HtloDX19XQMZYS
         Q4RQnpMYv5uT125eercpBXo7YTvz4taVD2J83nG95gLOZBM3h7LmJFgsaT84gpBRWE3S
         UM5MCy24m/dpPDHj7tMfDAy2V1tAy4z6DCz5iVCWi7ft5b+EMZ/R9zAD19BOYEg5RAox
         8KOw==
X-Gm-Message-State: AOJu0YwWncaWH7AMV+IJeYro0/oxtA3LDDaBZgPy0TzAloh6ahLU/Eds
	IyrIxssvAtL50k8aWqegc5jHCKZVXO/uHx4tFxDqPeHqF5fbOhakdv10sPYAFxKljxFAE3AFz9n
	Yg48Rverfz7ct1st3clt8fitSCQ==
X-Received: by 2002:a05:600c:3502:b0:407:8e85:899f with SMTP id h2-20020a05600c350200b004078e85899fmr15830947wmq.16.1698940061390;
        Thu, 02 Nov 2023 08:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOCzssmUk/tJw4NAOHqAirTLWSJvlMpbAFjBemCO93pbhRqq0e+/haFrydEEYvw/ckXBd9kw==
X-Received: by 2002:a05:600c:3502:b0:407:8e85:899f with SMTP id h2-20020a05600c350200b004078e85899fmr15830908wmq.16.1698940060957;
        Thu, 02 Nov 2023 08:47:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:3000:f155:cef2:ff4d:c7? (p200300cbc7163000f155cef2ff4d00c7.dip0.t-ipconnect.de. [2003:cb:c716:3000:f155:cef2:ff4d:c7])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00326dd5486dcsm2790857wrp.107.2023.11.02.08.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 08:47:40 -0700 (PDT)
Message-ID: <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com>
Date: Thu, 2 Nov 2023 16:47:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Content-Language: en-US
To: Wei Xu <weixugc@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org,
 mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
 rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
 tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
 yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
 kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
 adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
 surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, Greg Thelen <gthelen@google.com>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
 <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.11.23 16:43, Wei Xu wrote:
> On Wed, Nov 1, 2023 at 7:58 PM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>>
>> On Wed, Nov 1, 2023 at 7:40 PM Wei Xu <weixugc@google.com> wrote:
>>>
>>> On Wed, Nov 1, 2023 at 4:08 PM Sourav Panda <souravpanda@google.com> wrote:
>>>>
>>>> Adds a new per-node PageMetadata field to
>>>> /sys/devices/system/node/nodeN/meminfo
>>>> and a global PageMetadata field to /proc/meminfo. This information can
>>>> be used by users to see how much memory is being used by per-page
>>>> metadata, which can vary depending on build configuration, machine
>>>> architecture, and system use.
>>>>
>>>> Per-page metadata is the amount of memory that Linux needs in order to
>>>> manage memory at the page granularity. The majority of such memory is
>>>> used by "struct page" and "page_ext" data structures. In contrast to
>>>> most other memory consumption statistics, per-page metadata might not
>>>> be included in MemTotal. For example, MemTotal does not include memblock
>>>> allocations but includes buddy allocations. While on the other hand,
>>>> per-page metadata would include both memblock and buddy allocations.
>>>
>>> I expect that the new PageMetadata field in meminfo should help break
>>> down the memory usage of a system (MemUsed, or MemTotal - MemFree),
>>> similar to the other fields in meminfo.
>>>
>>> However, given that PageMetadata includes per-page metadata allocated
>>> from not only the buddy allocator, but also the memblock allocations,
>>> and MemTotal doesn't include memory reserved by memblock allocations,
>>> I wonder how a user can actually use this new PageMetadata to break
>>> down the system memory usage.  BTW, it is not robust to assume that
>>> all memblock allocations are for per-page metadata.
>>>
>>
>> Hi Wei,
>>
>>> Here are some ideas to address this problem:
>>>
>>> - Only report the buddy allocations for per-page medata in PageMetadata, or
>>
>> Making PageMetadata not to contain all per-page memory but just some
>> is confusing, especially right after boot it would always be 0, as all
>> struct pages are all coming from memblock during boot, yet we know we
>> have allocated tons of memory for struct pages.
>>
>>> - Report per-page metadata in two separate fields in meminfo, one for
>>> buddy allocations and another for memblock allocations, or
>>
>> This is also going to be confusing for the users, it is really
>> implementation detail which allocator was used to allocate struct
>> pages, and having to trackers is not going to improve things.
>>
>>> - Change MemTotal/MemUsed to include the memblock reserved memory as well.
>>
>> I think this is the right solution for an existing bug: MemTotal
>> should really include memblock reserved memory.
> 
> Adding reserved memory to MemTotal is a cleaner approach IMO as well.
> But it changes the semantics of MemTotal, which may have compatibility
> issues.

I object.

-- 
Cheers,

David / dhildenb


