Return-Path: <linux-fsdevel+bounces-4795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E06803D3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47D01F21220
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B462FC2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBVshDLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A5B0
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 10:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701714457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MsCR3w3iP/fbWtFIHfml8iFRMkitafuttFnD2iLIZic=;
	b=dBVshDLA9/kD70QjW2dzwAsUUez8cwbp5f7te6ajHlBUeH33WJ2I9barhnmd17/BW9FdfD
	v/MHPgYmGjRpPg8rngUroh24AxduCMlvTJTHDjN0SWx87T5xn8d9G5zbebhi35tfenACg8
	5gYPr/aK0wNTZJtDeuOkqKg0NMBD2Ds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-QSRjVYBoNAG_6_WBWzQDxA-1; Mon, 04 Dec 2023 13:27:36 -0500
X-MC-Unique: QSRjVYBoNAG_6_WBWzQDxA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33335c6d495so2010984f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 10:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714455; x=1702319255;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsCR3w3iP/fbWtFIHfml8iFRMkitafuttFnD2iLIZic=;
        b=sudsnC+8PhO1Xr52ENCu/HgYgVC8pGQG1s+Yg1G3uBRQxR3DNQmraWPy3gEpUeYfe/
         7AZylwzOeUX9ogQBhyJuG9oAxmW8/mOdqh8PhLVAL4Ah5Fn1/sPA2/gdQBD6UFEIBGIu
         T+3jrnA4KS143MlzkAbTgLYTTBzdrcsKbp0jQdymb/H0lxDwA5LJIIQZdqvO6jP7lYln
         FFjZLmoFoYa62n2Ac4UVDY/YKuVyU2Wnb5raZdnbWyrxa8fQD8nG9XAssZudomm+t26r
         pBhxqE24QIVteq/m5JWrjKYbJ5TcWGqL/u/+k+SNaFIkH1I2eGpAhP28QcJQyGjG384B
         WWtA==
X-Gm-Message-State: AOJu0YwwPbDxBrK+6c6LJ2IJBB2XVj304Hr+wCo1KbjrW6QgmnFzEdAM
	f9OZGf/9CWeYaWep0T6v/RQ04QHDmAbBCIRTSpYaBnpKKIIi4AIRwIgh4QpwadTZcM7tyAt9s1e
	6CPtp1+AlJI7YcppnbZOXSHqAUw==
X-Received: by 2002:a5d:4402:0:b0:333:2fd2:6f64 with SMTP id z2-20020a5d4402000000b003332fd26f64mr3528693wrq.110.1701714455278;
        Mon, 04 Dec 2023 10:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSV8kYq6adpaC56C7Llu3Yl8ioyuD6XQmmCo/8TnVNJ6VX5WXiBhZpY16lx0rh5pfD/VchbQ==
X-Received: by 2002:a5d:4402:0:b0:333:2fd2:6f64 with SMTP id z2-20020a5d4402000000b003332fd26f64mr3528665wrq.110.1701714454771;
        Mon, 04 Dec 2023 10:27:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6803000000b003333eadd206sm6363571wru.27.2023.12.04.10.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:27:34 -0800 (PST)
Message-ID: <a52284a4-2b8c-4118-965d-04c472fbee05@redhat.com>
Date: Mon, 4 Dec 2023 19:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpHpbz4fWawmYU=B1D5pPE4+x0Wj0V-514Dja9UWcwiL9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.12.23 17:35, Suren Baghdasaryan wrote:
> On Mon, Dec 4, 2023 at 1:27 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 04/12/2023 04:09, Suren Baghdasaryan wrote:
>>> On Sat, Dec 2, 2023 at 2:11 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 02.12.23 09:04, Ryan Roberts wrote:
>>>>> On 01/12/2023 20:47, David Hildenbrand wrote:
>>>>>> On 01.12.23 10:29, Ryan Roberts wrote:
>>>>>>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>>>>>>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>>>>>>>> into destination buffer while checking the contents of both after
>>>>>>>> the move. After the operation the content of the destination buffer
>>>>>>>> should match the original source buffer's content while the source
>>>>>>>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>>>>>>>> unaligned cases because they utilize different code paths in the kernel.
>>>>>>>>
>>>>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>>>>> ---
>>>>>>>>     tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>>>>>>>     tools/testing/selftests/mm/uffd-common.h     |   1 +
>>>>>>>>     tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>>>>>>>     3 files changed, 214 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/testing/selftests/mm/uffd-common.c
>>>>>>>> b/tools/testing/selftests/mm/uffd-common.c
>>>>>>>> index fb3bbc77fd00..b0ac0ec2356d 100644
>>>>>>>> --- a/tools/testing/selftests/mm/uffd-common.c
>>>>>>>> +++ b/tools/testing/selftests/mm/uffd-common.c
>>>>>>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>>>>>>>         return __copy_page(ufd, offset, false, wp);
>>>>>>>>     }
>>>>>>>>     +int move_page(int ufd, unsigned long offset, unsigned long len)
>>>>>>>> +{
>>>>>>>> +    struct uffdio_move uffdio_move;
>>>>>>>> +
>>>>>>>> +    if (offset + len > nr_pages * page_size)
>>>>>>>> +        err("unexpected offset %lu and length %lu\n", offset, len);
>>>>>>>> +    uffdio_move.dst = (unsigned long) area_dst + offset;
>>>>>>>> +    uffdio_move.src = (unsigned long) area_src + offset;
>>>>>>>> +    uffdio_move.len = len;
>>>>>>>> +    uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>>>>>>>> +    uffdio_move.move = 0;
>>>>>>>> +    if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>>>>>>>> +        /* real retval in uffdio_move.move */
>>>>>>>> +        if (uffdio_move.move != -EEXIST)
>>>>>>>> +            err("UFFDIO_MOVE error: %"PRId64,
>>>>>>>> +                (int64_t)uffdio_move.move);
>>>>>>>
>>>>>>> Hi Suren,
>>>>>>>
>>>>>>> FYI this error is triggering in mm-unstable (715b67adf4c8):
>>>>>>>
>>>>>>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
>>>>>>> @uffd-common.c:648)
>>>>>>>
>>>>>>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
>>>>>>> happy to go deeper if you can direct.
>>>>>>
>>>>>> Does it trigger reliably? Which pagesize is that kernel using?
>>>>>
>>>>> Yep, although very occasionally it fails with EAGAIN. 4K kernel; see other email
>>>>> for full config.
>>>>>
>>>>>>
>>>>>> I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses
>>>>>> default_huge_page_size(), which reads the default hugetlb size.
>>>>>
>>>>> My kernel command line is explicitly seting the default huge page size to 2M.
>>>>>
>>>>
>>>> Okay, so that likely won't affect it.
>>>>
>>>> I can only guess that it has to do with the alignment of the virtual
>>>> area we are testing with, and that we do seem to get more odd patterns
>>>> on arm64.
>>>>
>>>> uffd_move_test_common() is a bit more elaborate, but if we aligned the
>>>> src+start area up, surely "step_count" cannot be left unmodified?
>>>>
>>>> So assuming we get either an unaligned source or an unaligned dst from
>>>> mmap(), I am not convinced that we won't be moving areas that are not
>>>> necessarily fully backed by PMDs and maybe don't even fall into the VMA
>>>> of interest?
>>>>
>>>> Not sure if that could trigger the THP splitting issue, though.
>>>>
>>>> But I just quickly scanned that test setup, could be I am missing
>>>> something. It might make sense to just print the mmap'ed range and the
>>>> actual ranges we are trying to move. Maybe something "obvious" can be
>>>> observed.
>>>
>>> I was able to reproduce the issue on an Android device and after
>>> implementing David's suggestions to split the large folio and after
>>> replacing default_huge_page_size() with read_pmd_pagesize(), the
>>> move-pmd test started working for me. Ryan, could you please apply
>>> attached patches (over mm-unstable) and try the test again?
>>
>> Yep, all fixed with those patches!
> 
> Great! Thanks for testing and confirming. I'll post an updated
> patchset later today and will ask Andrew to replace the current one
> with it.
> I'll also look into the reasons we need to split PMD on ARM64 in this
> test. It's good that this happened and we were able to test the PMD
> split path but I'm curious about the reason. It's possible my address
> alignment calculations are  somehow incorrect.

I only skimmed the diff briefly, but likely you also want to try 
splitting in move_pages_pte(), if you encounter an already-pte-mapped THP.

-- 
Cheers,

David / dhildenb


