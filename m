Return-Path: <linux-fsdevel+bounces-6044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB13812AF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946C41F21258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF322576C;
	Thu, 14 Dec 2023 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHqjpOCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26A10A
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702544555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h1TM7UKmcJlXLTWCpMTjmgDFsXanKawH+R6EnWS6jFo=;
	b=AHqjpOCPqhieCPgcKwj1jMS42/EOOFNvqR8cTr/FUw8/N2cnS8pYbi5J3YFdtyuQ3X3dAN
	+mw8D2HP9tUIg48MyRqM7dp1otnHNdAoU2xlX64SYdRafudA0jIyK2X9nAXNqN16la/r4P
	pxyRxbbxcO0Z8gobeheWSwtASwAPpRY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-krTYztYCNviPMfYaChqSIw-1; Thu, 14 Dec 2023 04:02:30 -0500
X-MC-Unique: krTYztYCNviPMfYaChqSIw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3335df64539so6546386f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 01:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702544549; x=1703149349;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1TM7UKmcJlXLTWCpMTjmgDFsXanKawH+R6EnWS6jFo=;
        b=t6aIzjqRRQzGm7vOcL/WB1w2j+5U3/wguiSTLeBZdsTJVI4KlsHe51AJwZ2Rm9Lq3a
         QaieKhQuu4vYNRweFOdEp75QerXqEn+VweGf6y1RGNT88V52aubUhWl5eNd3RLZ/gfhu
         IqTHCKAz7o3eddJTsSwYpdWHP8KIpJG4QNDETwQSf3R0FBqri8XOo5XkCW1b/j+BIXk1
         jFMeBnTD8bCJRnY6NM4t+PNc1SMHRGr4mYka+o0n7C08f8r1Rh6DCra9eBrW0r3+ITz6
         EK4UfdXFrUjk8jKHZXtAooLgc4JCu5U1pJwHWZ2FcCjGoCZVEzk0TpfmorUU8so8ILUc
         8jJA==
X-Gm-Message-State: AOJu0YyOYhB71jAGmrXNuHQ3OZ9dNfYSDahqZab/hNMRBtLnr/IOkL1o
	MjNWx4v6gRPUmj2w4LeOAS53UuALpkv13ApdetmGPx54ddC89fE9nbJg1TOJs6QKZwEAtlmY6gP
	sJi5t83Pg76kEpvUSPk4UzJxW8A==
X-Received: by 2002:a05:600c:3423:b0:40c:224b:a72 with SMTP id y35-20020a05600c342300b0040c224b0a72mr3152291wmp.147.1702544549078;
        Thu, 14 Dec 2023 01:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOBDn00paajws5P0gB/8daVj/BLkCqfKKSO5c19sQQxL5edLeTHbvcV/FQANCLcq3HuvyAHA==
X-Received: by 2002:a05:600c:3423:b0:40c:224b:a72 with SMTP id y35-20020a05600c342300b0040c224b0a72mr3152273wmp.147.1702544548569;
        Thu, 14 Dec 2023 01:02:28 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm26220931wms.30.2023.12.14.01.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:02:28 -0800 (PST)
Message-ID: <345a414e-42df-4b2d-8425-2b605c46d2a9@redhat.com>
Date: Thu, 14 Dec 2023 10:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: John Hubbard <jhubbard@nvidia.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Brown <broonie@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
References: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
 <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
 <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
 <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
 <0d68fe7f-2a96-467d-87b0-52db36704e1d@nvidia.com>
 <926b42f9-3689-480f-8dd5-78fc0ee6088d@nvidia.com>
 <783a4178-1dec-4e30-989a-5174b8176b09@redhat.com>
 <ea6708ce-af4a-4f0a-ba37-a2cb38f60eca@nvidia.com>
Content-Language: en-US
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
In-Reply-To: <ea6708ce-af4a-4f0a-ba37-a2cb38f60eca@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.12.23 23:01, John Hubbard wrote:
> On 12/13/23 01:59, David Hildenbrand wrote:
> ...
>>> Another variation though, would be to run "make headers", and snapshot
>>> some of those files into tools/include.
>>
>> ^ this is what I had in mind
>>
>> If you're writing a test that needs some new fancy thing, update the relevant header.
>>
> 
> OK, and Mark Brown's nearby response [1] supports that, as well.
> 
> Thus fortified, I plan on doing the following steps:
> 
> Step 1: Do nothing about the revert patch that I sent earlier, thus
> allowing it to continue in its journey (so far, Andrew has moved it into
> mm-hotfixes-stable branch).
> 
> Step 2: Send out a patch for a modest part of selftests/mm, that uses
> this latest approach, and see how it fares in reviews.

All sounds good to me!

-- 
Cheers,

David / dhildenb


