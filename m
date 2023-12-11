Return-Path: <linux-fsdevel+bounces-5469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCB80C8EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6DCB210D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC138FAB;
	Mon, 11 Dec 2023 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnysTxZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CEB19BF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702296212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eaq72ijy7ksxG1UNPMWHN+8Pe2cAfZW+wwSGb5GojGo=;
	b=PnysTxZDplNGtu1Nkk4vm83V1zjMO5IgcsOlCEa6ka9FM9RKAA6HyQQRcdBiFjsBmA2Egx
	oqbXwqWHCpmdjSFkqgqIpl0SpmpopeMv1CsxcetS8n7hJWMUXL8PuGpHNn0B1cvFZyboK/
	b/4uJlxd8a1E7TkrY0CYkmuRBctDGys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-BBezZWZOMHSnAECPL6UAXQ-1; Mon, 11 Dec 2023 07:03:31 -0500
X-MC-Unique: BBezZWZOMHSnAECPL6UAXQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33331e69698so3683675f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 04:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296210; x=1702901010;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eaq72ijy7ksxG1UNPMWHN+8Pe2cAfZW+wwSGb5GojGo=;
        b=xH7hq4HicjOsdWG851NK0+KHzIgLslJqEvmChuwwXk1Uv7abN0ynd4lLu38hklunlP
         f4CksrmGQ2TlWNEhkNd6UUnilQNIlqFvSpFHA8yKsNqQirsMewvsuxBdzw6Hf2SxYEcL
         FFQqnw8aH7sxOxcAhYwl7PO8rpH/iJ0h/j0Z+EhhVd9btabOwB/hwP3S/yn+VtfsN9qv
         l9aqiQNvwN+9jr6+7IZ/yyK6EofChy5JZZtNFYHUbXQWwviD2TnUA0UlUtAhWaFNK8Rt
         MSg+I4Am8//iSXc/+SFyMtI1VQyXJ29O0iw4yM/4xx4cjtEA0muHctwJYLbl9aILKtJo
         KoBA==
X-Gm-Message-State: AOJu0YwsE1FCzMBn1McikFD/T0QbHUuzDJc+HCOtjpM9oiZfhEsPYnWY
	PI7I2+fnCxeMJW+rZ1Wx+XukdTfx9PdaTpYdQUszZmhOUv1v6mcuxlYwas1BLdkrmPh/byimf0Y
	rJjPpsrLFe5vQMu9JCMkpa1JJKA==
X-Received: by 2002:adf:fbc5:0:b0:333:4bd9:88 with SMTP id d5-20020adffbc5000000b003334bd90088mr1585443wrs.51.1702296210034;
        Mon, 11 Dec 2023 04:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhYpnoiGb6ozb1FNvNHnzUnC/GdcsqbUgFsrOJQ0NZrW4zXeCa7sTAy1Yfnx84xqWZAoC+Dg==
X-Received: by 2002:adf:fbc5:0:b0:333:4bd9:88 with SMTP id d5-20020adffbc5000000b003334bd90088mr1585431wrs.51.1702296209583;
        Mon, 11 Dec 2023 04:03:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c742:ae00:6e5f:7195:98f6:3ed1? (p200300cbc742ae006e5f719598f63ed1.dip0.t-ipconnect.de. [2003:cb:c742:ae00:6e5f:7195:98f6:3ed1])
        by smtp.gmail.com with ESMTPSA id o1-20020adfe801000000b003333c06fa79sm8478223wrm.71.2023.12.11.04.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 04:03:29 -0800 (PST)
Message-ID: <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
Date: Mon, 11 Dec 2023 13:03:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Mark Brown <broonie@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
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
In-Reply-To: <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.12.23 12:15, Mark Brown wrote:
> On Sun, Dec 10, 2023 at 07:04:19PM -0800, Suren Baghdasaryan wrote:
>> On Sun, Dec 10, 2023 at 5:01 PM Suren Baghdasaryan <surenb@google.com> wrote:
> 
>>> Thanks for reporting! I'll try that later today.
>>> Just to clarify, are you using mm-unstable and if so, has it been
>>> rebased since Friday? There was an update to this patchset in
>>> mm-unstable which Andrew merged on Friday and the failure does look
>>> like something that would happen with the previous version.
> 
>> I tried reproducing the issue but so far unsuccessfully. Could you
>> please confirm that on the latest mm-unstable branch it's still
>> reproducible and if so, please provide detailed instructions on how
>> you reproduce it.
> 
> This is linux-next.  I pasted the commands used to build and sent links
> to a full build log in the original report.

Probably also related to "make headers-install":

https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com

The general problem is that some mm selftests are currently not written 
in way that allows them to compile with old linux headers. That's why 
the build fails if "make headers-install" was not executed, but it does 
not fail if "make headers-install" was once upon a time executed, but 
the headers are outdated.

-- 
Cheers,

David / dhildenb


