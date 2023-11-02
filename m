Return-Path: <linux-fsdevel+bounces-1859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51237DF76A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D3EB2105B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB511D6BC;
	Thu,  2 Nov 2023 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUtVhhua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E941C29A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 16:09:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59B12D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698941374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zrAUxeWN/EkPSZYBviBn3GYoRliJE3QDH1vmaFH0DNM=;
	b=QUtVhhuazbq3sSdr7FkFzmlAcm+1o1bHr8Qn3otKMXJOH7fu3mP6IoW1TuUx9G2rt694pz
	a3czf1W3mdgIc48t7Oqdh5R6R4cxSW++GrQnIa2+mMpI7FsV/LLm5R9gpQUUz0Y3tH7VKz
	0iihBy6WhbV7OaPC1LOdDbDW5En/M6s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-D18hI7kOPYai7rz_PEhHAA-1; Thu, 02 Nov 2023 12:09:32 -0400
X-MC-Unique: D18hI7kOPYai7rz_PEhHAA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c50234741eso10905801fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 09:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941371; x=1699546171;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrAUxeWN/EkPSZYBviBn3GYoRliJE3QDH1vmaFH0DNM=;
        b=OdDXpwYImSAfOZdb5Dhup7PK5Ow/rWrFrYFi+rw+nqXL8btjlmOjfV1VrpSvXUl26B
         4G3spsLRAoC44R/yjsghM7v621Wev5ndWTVlQojiCE2flZuGoxL6t/SAd2WJ5VgE9O4O
         /Awn+KRFB7zbhExgzfhsAqmjXTerO9bH1YLz1gGgZiDHf9/ewrOv4Vrjx9b+P/Ko5Fg5
         GwLivYxgdkUmnh3D0o9iIqSLLlIXkSIeD+taKhh+WefVfRrYy2mDnCwKAHbFZTOUAWO0
         izvRVT8IvCibD1RA0w1w2Nl/cdJHXIiifUTOjd6Tj041u4vUgNcPUFJ/FJhm+Tt2v/3j
         +h+w==
X-Gm-Message-State: AOJu0YyjBZf3zVWO0FNPznUdqqbs2973JyWxaiw4/2DA5BiEqbSrX8V0
	/MXa1xKnT7psRXQRgzs/XDu8nnOle4rRfAn2NgnBlKX4YJw319AyTUd29fVIDGRuwAQdiX4syc8
	1wZR9YHhHXp6Vj/XnTYPh6NhG1g==
X-Received: by 2002:a2e:9909:0:b0:2c5:137d:6baa with SMTP id v9-20020a2e9909000000b002c5137d6baamr15012752lji.14.1698941370965;
        Thu, 02 Nov 2023 09:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJlFLj5+3DrDO3VKSLNclsgfN/dX2F6C/t4BIUiZ6w/CFNeVtSshpvZB4HuyvDIGM+ZyTgXg==
X-Received: by 2002:a2e:9909:0:b0:2c5:137d:6baa with SMTP id v9-20020a2e9909000000b002c5137d6baamr15012736lji.14.1698941370513;
        Thu, 02 Nov 2023 09:09:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:3000:f155:cef2:ff4d:c7? (p200300cbc7163000f155cef2ff4d00c7.dip0.t-ipconnect.de. [2003:cb:c716:3000:f155:cef2:ff4d:c7])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b004063977eccesm3307887wme.42.2023.11.02.09.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:09:29 -0700 (PDT)
Message-ID: <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com>
Date: Thu, 2 Nov 2023 17:09:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Xu <weixugc@google.com>, Sourav Panda <souravpanda@google.com>,
 corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
 rppt@kernel.org, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, yosryahmed@google.com, hannes@cmpxchg.org,
 shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, Greg Thelen <gthelen@google.com>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
 <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com>
 <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com>
 <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.11.23 17:02, Pasha Tatashin wrote:
> On Thu, Nov 2, 2023 at 11:53 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 02.11.23 16:50, Pasha Tatashin wrote:
>>>>> Adding reserved memory to MemTotal is a cleaner approach IMO as well.
>>>>> But it changes the semantics of MemTotal, which may have compatibility
>>>>> issues.
>>>>
>>>> I object.
>>>
>>> Could you please elaborate what you object (and why): you object that
>>> it will have compatibility issues, or  you object to include memblock
>>> reserves into MemTotal?
>>
>> Sorry, I object to changing the semantics of MemTotal. MemTotal is
>> traditionally the memory managed by the buddy, not all memory in the
>> system. I know people/scripts that are relying on that [although it's
>> been source of confusion a couple of times].
> 
> What if one day we change so that struct pages are allocated from
> buddy allocator (i.e. allocate deferred struct pages from buddy) will

It does on memory hotplug. But for things like crashkernel size 
detection doesn't really care about that.

> it break those MemTotal scripts? What if the size of struct pages
> changes significantly, but the overhead will come from other metadata
> (i.e. memdesc) will that break those scripts? I feel like struct page

Probably; but ideally the metadata overhead will be smaller with 
memdesc. And we'll talk about that once it gets real ;)

> memory should really be included into MemTotal, otherwise we will have
> this struggle in the future when we try to optimize struct page
> memory.
How far do we want to go, do we want to include crashkernel reserved 
memory in MemTotal because it is system memory? Only metadata? what else 
allocated using memblock?

Again, right now it's simple: MemTotal is memory managed by the buddy.

The spirit of this patch set is good, modifying existing counters needs 
good justification.

-- 
Cheers,

David / dhildenb


