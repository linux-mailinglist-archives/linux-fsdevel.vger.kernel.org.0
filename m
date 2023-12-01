Return-Path: <linux-fsdevel+bounces-4614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B4880166E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9103B20C44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528823F8CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj4L7pIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF7310C2
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 12:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701463632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=roRHhLauepkrd5alx72dFMXjJCaurGVuqpPk08xyld4=;
	b=cj4L7pIXVjAzwDDpqCXgaESdD9y/+Hszmw3IKc3hl2DL0ftedbNzwTrw7my8RIjV7kr597
	f5MoZm8fQvfWA/wb20BRDZ/kCSSVnLqCzeP3EvHGm4L2IQn6C78croZhRXEPG9VqfvsDjv
	3xzDkT3gewE0kHGjPLiM90O25GQ2lNo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-sek2DQG_M0yLINQtERwvEg-1; Fri, 01 Dec 2023 15:47:11 -0500
X-MC-Unique: sek2DQG_M0yLINQtERwvEg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-407d3e55927so19978585e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 12:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463630; x=1702068430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roRHhLauepkrd5alx72dFMXjJCaurGVuqpPk08xyld4=;
        b=N282axTMNydGyktRn1VARWhfgGHGpE3mdPqShXqvScIgvWOqMXX9QisEkhBq+h1VUd
         bvCMQh0cT38JtRhUajgoJaQ6VWXFJrsoIpVaOPr7liazosDZWBGmZapoEoOrXh/fv4TG
         lF7WB+fcJoysaeMmp7IpR2m9SG9T6GaPR0FRI7aq/hbD1AdkPbPqJKhoyQ1AYmwHtAKo
         hx1c3Amin63Mf4+pgvbwO/4964JKemBNUftK84hQ4uFmT9mBVxa8FLCh8eOww+xwDQVL
         9T2t7ilAX7tJe4icNDE8p2/k4aQNB35QAe5jR70cCMh9JDL8N6rfGb8oC2OKDPuSp0tJ
         o6wg==
X-Gm-Message-State: AOJu0Yw+N+2S7GBft1yd7RsD3Wi/saLL9ps7CqsGRbwDGi3bsJ+MJKOS
	GxEeInQ1/By9F15Vac+HjxLLh6II7mai+gmMVhh1ApmdUePPReScs80IiVuYXb9xlwmkT267Vwa
	+Rde5uKaINA0tSfFLncgfUS4dyg==
X-Received: by 2002:adf:ef0e:0:b0:333:2fd2:5d4e with SMTP id e14-20020adfef0e000000b003332fd25d4emr1458938wro.128.1701463629944;
        Fri, 01 Dec 2023 12:47:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZKMjh8pTfwrN7X75z4hiGXRlcazvFaCrgi3fYPEKkR9z/8z96TQOeqZHjl2bfL/NASM0NAw==
X-Received: by 2002:adf:ef0e:0:b0:333:2fd2:5d4e with SMTP id e14-20020adfef0e000000b003332fd25d4emr1458915wro.128.1701463629604;
        Fri, 01 Dec 2023 12:47:09 -0800 (PST)
Received: from ?IPV6:2003:d8:2f28:7800:30d7:645a:7306:e437? (p200300d82f28780030d7645a7306e437.dip0.t-ipconnect.de. [2003:d8:2f28:7800:30d7:645a:7306:e437])
        by smtp.gmail.com with ESMTPSA id c12-20020a056000104c00b00333339e5f42sm1767916wrx.32.2023.12.01.12.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:47:09 -0800 (PST)
Message-ID: <a41c759f-78d8-44ed-b708-1bb737a8e6c1@redhat.com>
Date: Fri, 1 Dec 2023 21:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.12.23 10:29, Ryan Roberts wrote:
> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>> into destination buffer while checking the contents of both after
>> the move. After the operation the content of the destination buffer
>> should match the original source buffer's content while the source
>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>> unaligned cases because they utilize different code paths in the kernel.
>>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> ---
>>   tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>   tools/testing/selftests/mm/uffd-common.h     |   1 +
>>   tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>   3 files changed, 214 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
>> index fb3bbc77fd00..b0ac0ec2356d 100644
>> --- a/tools/testing/selftests/mm/uffd-common.c
>> +++ b/tools/testing/selftests/mm/uffd-common.c
>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>   	return __copy_page(ufd, offset, false, wp);
>>   }
>>   
>> +int move_page(int ufd, unsigned long offset, unsigned long len)
>> +{
>> +	struct uffdio_move uffdio_move;
>> +
>> +	if (offset + len > nr_pages * page_size)
>> +		err("unexpected offset %lu and length %lu\n", offset, len);
>> +	uffdio_move.dst = (unsigned long) area_dst + offset;
>> +	uffdio_move.src = (unsigned long) area_src + offset;
>> +	uffdio_move.len = len;
>> +	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>> +	uffdio_move.move = 0;
>> +	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>> +		/* real retval in uffdio_move.move */
>> +		if (uffdio_move.move != -EEXIST)
>> +			err("UFFDIO_MOVE error: %"PRId64,
>> +			    (int64_t)uffdio_move.move);
> 
> Hi Suren,
> 
> FYI this error is triggering in mm-unstable (715b67adf4c8):
> 
> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
> @uffd-common.c:648)
> 
> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
> happy to go deeper if you can direct.

Does it trigger reliably? Which pagesize is that kernel using?

I can spot that uffd_move_pmd_test()/uffd_move_pmd_handle_fault() uses 
default_huge_page_size(), which reads the default hugetlb size.

That, however, does not necessarily correspond to the THP size. That one 
can be obtained using read_pmd_pagesize() in vm_util.c

I quickly scanned the code (still want to take a deeper look), but all 
PAE checks looked sane to me.

I think the issue is folio split handling. I replied to the patch.

-- 
Cheers,

David / dhildenb


