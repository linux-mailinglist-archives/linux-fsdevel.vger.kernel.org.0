Return-Path: <linux-fsdevel+bounces-4679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E2801C34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4683D1C208E0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611B16424
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVJDHyrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220019F
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701511889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FR+VLmSLHtiOk787gJHIjLXiKhSQolv8Z3y5kaZ1lBU=;
	b=ZVJDHyrrV56BggWooEaQVHQJYTg/vcwbOm0QdW6CYXrqwvOFTndUvFjJpld3MKptWzqCR0
	sl7ZEy00wkYkrZWiT9BKobrxh9WiFMKojx9BBtUfxDZMngxUiENBe0QqJsEcuol44Wj09r
	18IhxT0RHtITbnG1pAP/uYwtfWT8Hms=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-gf70APImNGCjRRpB3-87GQ-1; Sat, 02 Dec 2023 05:11:26 -0500
X-MC-Unique: gf70APImNGCjRRpB3-87GQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332e2e0b98bso2359389f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 02:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701511885; x=1702116685;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR+VLmSLHtiOk787gJHIjLXiKhSQolv8Z3y5kaZ1lBU=;
        b=VVzlFL7+jfAyB59H5sqaS4Kyf/Amk6s6sdIQYRPHNqhyv2aIClYBeeYa4RK443TgvV
         E0vt+My5e359YPWZia6JGcahh6bVe1nx1FszEunpmNI4TMj9Q4hh5mNmM3yN6WJ0SiWa
         rSlhgyHG/0GEZl8nY/PLdV98WF7yT3ZQBqZ2EOZN846d4ykHMOS3rkGLW9vSGNNQE/Ui
         X6pqByoFgU1OcgVZllvNiyF/7qLs2PiyaTuUDcnp22g1SHs4k+4CvS2TcB3DAAYufQa5
         LoFBP3JwF1sxZPoE0XMurDP7a/n/XosQyTx6CmFKMSGX0FZQmRT/jQJO+eXREUDmykQt
         v2iQ==
X-Gm-Message-State: AOJu0YwzYLiaDdoVlJ9y4UlpsU5TEYjlOguJmKC74Vup6r2+kZhs/Oty
	MvADLn9RMdkQnARpkfsQpqqSYYxHRFigD+9neXhnMsA3HS/7toHWiK7N4un2c1RhB7FPxTnNdV6
	kQUfsSlh2XF0qVm8lUK5StraYwA==
X-Received: by 2002:a5d:5918:0:b0:333:2fd2:8158 with SMTP id v24-20020a5d5918000000b003332fd28158mr1528120wrd.117.1701511885518;
        Sat, 02 Dec 2023 02:11:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNUZF1AT7Nw3RxMFArdXopZMFsbeJQk9XxSA3NY+Xev6Db9lUh963rx9GT2CHZfGxW23DhTQ==
X-Received: by 2002:a5d:5918:0:b0:333:2fd2:8158 with SMTP id v24-20020a5d5918000000b003332fd28158mr1528089wrd.117.1701511885107;
        Sat, 02 Dec 2023 02:11:25 -0800 (PST)
Received: from ?IPV6:2003:d8:2f28:7800:30d7:645a:7306:e437? (p200300d82f28780030d7645a7306e437.dip0.t-ipconnect.de. [2003:d8:2f28:7800:30d7:645a:7306:e437])
        by smtp.gmail.com with ESMTPSA id e2-20020adf9bc2000000b003332fa77a0fsm4394385wrc.21.2023.12.02.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 02:11:24 -0800 (PST)
Message-ID: <ccdb1080-7a2e-4f98-a4e8-e864fa2db299@redhat.com>
Date: Sat, 2 Dec 2023 11:11:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cb3d3b12-abf3-4eda-8d9a-944684d05505@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.12.23 09:04, Ryan Roberts wrote:
> On 01/12/2023 20:47, David Hildenbrand wrote:
>> On 01.12.23 10:29, Ryan Roberts wrote:
>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>>>> into destination buffer while checking the contents of both after
>>>> the move. After the operation the content of the destination buffer
>>>> should match the original source buffer's content while the source
>>>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>>>> unaligned cases because they utilize different code paths in the kernel.
>>>>
>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>> ---
>>>>    tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>>>    tools/testing/selftests/mm/uffd-common.h     |   1 +
>>>>    tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>>>    3 files changed, 214 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
>>>> b/tools/testing/selftests/mm/uffd-common.c
>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
>>>> --- a/tools/testing/selftests/mm/uffd-common.c
>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>>>        return __copy_page(ufd, offset, false, wp);
>>>>    }
>>>>    +int move_page(int ufd, unsigned long offset, unsigned long len)
>>>> +{
>>>> +    struct uffdio_move uffdio_move;
>>>> +
>>>> +    if (offset + len > nr_pages * page_size)
>>>> +        err("unexpected offset %lu and length %lu\n", offset, len);
>>>> +    uffdio_move.dst = (unsigned long) area_dst + offset;
>>>> +    uffdio_move.src = (unsigned long) area_src + offset;
>>>> +    uffdio_move.len = len;
>>>> +    uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>>>> +    uffdio_move.move = 0;
>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>>>> +        /* real retval in uffdio_move.move */
>>>> +        if (uffdio_move.move != -EEXIST)
>>>> +            err("UFFDIO_MOVE error: %"PRId64,
>>>> +                (int64_t)uffdio_move.move);
>>>
>>> Hi Suren,
>>>
>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
>>>
>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
>>> @uffd-common.c:648)
>>>
>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
>>> happy to go deeper if you can direct.
>>
>> Does it trigger reliably? Which pagesize is that kernel using?
> 
> Yep, although very occasionally it fails with EAGAIN. 4K kernel; see other email
> for full config.
> 
>>
>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
>> default_huge_page_size(), which reads the default hugetlb size.
> 
> My kernel command line is explicitly seting the default huge page size to 2M.
> 

Okay, so that likely won't affect it.

I can only guess that it has to do with the alignment of the virtual 
area we are testing with, and that we do seem to get more odd patterns 
on arm64.

uffd_move_test_common() is a bit more elaborate, but if we aligned the 
src+start area up, surely "step_count" cannot be left unmodified?

So assuming we get either an unaligned source or an unaligned dst from 
mmap(), I am not convinced that we won't be moving areas that are not 
necessarily fully backed by PMDs and maybe don't even fall into the VMA 
of interest?

Not sure if that could trigger the THP splitting issue, though.

But I just quickly scanned that test setup, could be I am missing 
something. It might make sense to just print the mmap'ed range and the 
actual ranges we are trying to move. Maybe something "obvious" can be 
observed.

-- 
Cheers,

David / dhildenb


