Return-Path: <linux-fsdevel+bounces-4958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BB806C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E8B20DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07932DF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW4qtMBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C79199F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 01:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701854481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C15e7/LIYcrGWdbNEaRKjqFcMT5GroD4qDzg3I8vY9E=;
	b=bW4qtMBDWM6tXQeTlPIYnSvWHOMkWfXtRyQbRk3sqGJKhCmfKGIYaw//u17MNfDJ5+y88h
	l/h3QpWkBi4ZbAdwKY8RFPaA6S5T2kpW4LA1r+LWGe8nStf19YG+ieAWZydAavzXiige7e
	eDhBApEeacxxo005zYJelTovkZHql00=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-_MTMPdUkMwuTfQDItpZbOg-1; Wed, 06 Dec 2023 04:21:20 -0500
X-MC-Unique: _MTMPdUkMwuTfQDItpZbOg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3333c009305so529321f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 01:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701854479; x=1702459279;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C15e7/LIYcrGWdbNEaRKjqFcMT5GroD4qDzg3I8vY9E=;
        b=D8Mrp9NlKShxSEcpbCqCJaI5qpuTUFhORICU0pXCIzChkJJOz1StuWPMpLcMDsxXTQ
         gciTslk2kt7A5JNzaZn5Sa7Owy6B6JuBmPaxDBUJIC9kTfgsRWzetAuh2+ohJzwTDVDc
         jryjf+sQ4RTsBY2FU01T+KLw9vWROainyUPG/toOcEIIVNuVs+ZQaSI44X/vfMFtAZmj
         gLrB9IanPDK5zGrSw60Jqmq5qqPCJRvdjU4LpbSSkcMcv38RQmr4pc9cBuvgXWCTg69p
         jKkqcamo+PWEuKHfIHQ7ZoPyeFZFT0bxT1K9kI8v8slR+c3cFYkg2nQaaaniyukogJjA
         cpmw==
X-Gm-Message-State: AOJu0YwiYcgglwqdgDAxUCid8bwWu+2De+4dVD6fLrc8YsSLoVLA+re6
	dx6RAfvRlLl25LIaeyM/ZI71L45frbaPRG9L7ZsyvEQXTrVGdvnfel9pmUKRe01NQpZSK9071qx
	4KCIRDxLiF3yxUB10dARylG/ZtA==
X-Received: by 2002:a5d:6a0a:0:b0:333:1d9c:c34b with SMTP id m10-20020a5d6a0a000000b003331d9cc34bmr291858wru.41.1701854479093;
        Wed, 06 Dec 2023 01:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJt64TQXsdMHsdf9ZDWJDQBSkounTEA5bVNSVXlVfWZRWe3DfgUgzdli/2NceZuDUSqkkReA==
X-Received: by 2002:a5d:6a0a:0:b0:333:1d9c:c34b with SMTP id m10-20020a5d6a0a000000b003331d9cc34bmr291831wru.41.1701854478657;
        Wed, 06 Dec 2023 01:21:18 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d4887000000b003335ebde680sm2792854wrq.75.2023.12.06.01.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 01:21:18 -0800 (PST)
Message-ID: <3ba0015b-b36e-449a-8445-0f6272694db5@redhat.com>
Date: Wed, 6 Dec 2023 10:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
 rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
 jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
 kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231121171643.3719880-1-surenb@google.com>
 <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
 <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
 <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com>
 <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
 <CAJuCfpHS63bXkRGE1_G4z-2fDe72BeLka8t5ioSg2OXjbUrHXg@mail.gmail.com>
 <744be4e0-48e0-4c77-825c-711386dd205f@arm.com>
 <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
 <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com>
 <CAJuCfpEbxPksw3WtLWRT9mmGUCSZ431E4vaWMtbu8OrXmMxCdw@mail.gmail.com>
 <CAJuCfpG=seLkKbMRjwuWNQozGSQmP-JqKVUuCGRqMqxND2u18A@mail.gmail.com>
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
In-Reply-To: <CAJuCfpG=seLkKbMRjwuWNQozGSQmP-JqKVUuCGRqMqxND2u18A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.12.23 05:46, Suren Baghdasaryan wrote:
> On Mon, Dec 4, 2023 at 10:44 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Mon, Dec 4, 2023 at 10:27 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 04.12.23 17:35, Suren Baghdasaryan wrote:
>>>> On Mon, Dec 4, 2023 at 1:27 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
>>>>>> On Sat, Dec 2, 2023 at 2:11 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 02.12.23 09:04, Ryan Roberts wrote:
>>>>>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
>>>>>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
>>>>>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>>>>>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>>>>>>>>>>> into destination buffer while checking the contents of both after
>>>>>>>>>>> the move. After the operation the content of the destination buffer
>>>>>>>>>>> should match the original source buffer's content while the source
>>>>>>>>>>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>>>>>>>>>>> unaligned cases because they utilize different code paths in the kernel.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>>>>>>>>>>      tools/testing/selftests/mm/uffd-common.h     |   1 +
>>>>>>>>>>>      tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>>>>>>>>>>      3 files changed, 214 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
>>>>>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
>>>>>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
>>>>>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
>>>>>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
>>>>>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>>>>>>>>>>          return __copy_page(ufd, offset, false, wp);
>>>>>>>>>>>      }
>>>>>>>>>>>      +int move_page(int ufd, unsigned long offset, unsigned long len)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct uffdio_move uffdio_move;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (offset + len > nr_pages * page_size)
>>>>>>>>>>> +        err("unexpected offset %lu and length %lu\n", offset, len);
>>>>>>>>>>> +    uffdio_move.dst = (unsigned long) area_dst + offset;
>>>>>>>>>>> +    uffdio_move.src = (unsigned long) area_src + offset;
>>>>>>>>>>> +    uffdio_move.len = len;
>>>>>>>>>>> +    uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>>>>>>>>>>> +    uffdio_move.move = 0;
>>>>>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>>>>>>>>>>> +        /* real retval in uffdio_move.move */
>>>>>>>>>>> +        if (uffdio_move.move != -EEXIST)
>>>>>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
>>>>>>>>>>> +                (int64_t)uffdio_move.move);
>>>>>>>>>>
>>>>>>>>>> Hi Suren,
>>>>>>>>>>
>>>>>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
>>>>>>>>>>
>>>>>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
>>>>>>>>>> @uffd-common.c:648)
>>>>>>>>>>
>>>>>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
>>>>>>>>>> happy to go deeper if you can direct.
>>>>>>>>>
>>>>>>>>> Does it trigger reliably? Which pagesize is that kernel using?
>>>>>>>>
>>>>>>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; see other email
>>>>>>>> for full config.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
>>>>>>>>> default_huge_page_size(), which reads the default hugetlb size.
>>>>>>>>
>>>>>>>> My kernel command line is explicitly seting the default huge page size to 2M.
>>>>>>>>
>>>>>>>
>>>>>>> Okay, so that likely won't affect it.
>>>>>>>
>>>>>>> I can only guess that it has to do with the alignment of the virtual
>>>>>>> area we are testing with, and that we do seem to get more odd patterns
>>>>>>> on arm64.
>>>>>>>
>>>>>>> uffd_move_test_common() is a bit more elaborate, but if we aligned the
>>>>>>> src+start area up, surely "step_count" cannot be left unmodified?
>>>>>>>
>>>>>>> So assuming we get either an unaligned source or an unaligned dst from
>>>>>>> mmap(), I am not convinced that we won't be moving areas that are not
>>>>>>> necessarily fully backed by PMDs and maybe don't even fall into the VMA
>>>>>>> of interest?
>>>>>>>
>>>>>>> Not sure if that could trigger the THP splitting issue, though.
>>>>>>>
>>>>>>> But I just quickly scanned that test setup, could be I am missing
>>>>>>> something. It might make sense to just print the mmap'ed range and the
>>>>>>> actual ranges we are trying to move. Maybe something "obvious" can be
>>>>>>> observed.
>>>>>>
>>>>>> I was able to reproduce the issue on an Android device and after
>>>>>> implementing David's suggestions to split the large folio and after
>>>>>> replacing default_huge_page_size() with read_pmd_pagesize(), the
>>>>>> move-pmd test started working for me. Ryan, could you please apply
>>>>>> attached patches (over mm-unstable) and try the test again?
>>>>>
>>>>> Yep, all fixed with those patches!
>>>>
>>>> Great! Thanks for testing and confirming. I'll post an updated
>>>> patchset later today and will ask Andrew to replace the current one
>>>> with it.
>>>> I'll also look into the reasons we need to split PMD on ARM64 in this
>>>> test. It's good that this happened and we were able to test the PMD
>>>> split path but I'm curious about the reason. It's possible my address
>>>> alignment calculations are  somehow incorrect.
>>>
>>> I only skimmed the diff briefly, but likely you also want to try
>>> splitting in move_pages_pte(), if you encounter an already-pte-mapped THP.
>>
>> Huh, good point. I might be able to move the folio splitting code into
>> pte-mapped case and do a retry after splitting. That should minimize
>> the additional code required. Will do and post a new set shortly.
>> Thanks!
> 
> Was planning to post an update today but need some more time. Will try
> to send it tomorrow.

It would be great to have tests that cover these cases (having to 
PTE-map a PMD-mapped THP, and stumbling over an already-PTE-mapped one).

-- 
Cheers,

David / dhildenb


