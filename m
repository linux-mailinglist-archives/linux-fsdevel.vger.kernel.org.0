Return-Path: <linux-fsdevel+bounces-246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0347C7F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B21C20A35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7E10791;
	Fri, 13 Oct 2023 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMAb/LPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6435101EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159BD6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697184258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnw6CV1in12hPMuWpKYAfFREANvgubRLaHRIuqtezJI=;
	b=MMAb/LPYjNSLIkM2RDgXyaGsae9bF2uIZ9WmTojalLO8CFb6SHmcbqiP5/C094IATsmO8+
	D3wqUDApM8JiM1bio/9ude+YIA3lxXrvs9IJtU0aOqgA9jnUlbAOzIBlWRSPLVPGJwc6ko
	ISs8PHrEKMiG4IOo6loqRJPCiqv+IZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-0hVPXHV5PzybrzXNExvEYw-1; Fri, 13 Oct 2023 04:04:16 -0400
X-MC-Unique: 0hVPXHV5PzybrzXNExvEYw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d879cac50so1081641f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 01:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184255; x=1697789055;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jnw6CV1in12hPMuWpKYAfFREANvgubRLaHRIuqtezJI=;
        b=jTde87wP5si+NKF63xrxdjV1FJSWhM5FIZDzWZqqkFKXf6qLkXKgyxz6zLpSo6sy4f
         e7nw+aumwTVg4qoWhcGTiSuSh2QMEsHORg9dblnxfj2vgpHDLurb3T+JswZEccnr7+kU
         Kzf33x+V9Py5oQiv31hZxZ3eQmwIr0+Zpv0uDX8LaYMwX0sBHwulOIwMfMM6ZsYwrrmz
         y539f43QPg8ByO8prClxmoEDOqOKJ4b36Danfv4tlhAmyfapfVgmTR5kAYRKgUr9FCYF
         Oin1L7vqHSb+nfB199HzyafqVQXlhZhwJAWQhVAzVA4tu9JRSJam/cwMjSEGdhWETKYl
         kt3g==
X-Gm-Message-State: AOJu0YxVgxeNpi79mg2bsPGowalMRN7kiwLGOYbEQDVXV/K0ubzidmk/
	v6MF7ganj0ZWU2dwdaGvQNQRHHT/E8Ry6hLre+jCwYzRO47FovqQn4ipYJvCHnzRLFfCBHyMb4q
	CaBr8UA9NSAGQ01t22BehBsbfTA==
X-Received: by 2002:a05:6000:68d:b0:32d:88fd:5c65 with SMTP id bo13-20020a056000068d00b0032d88fd5c65mr7476682wrb.1.1697184255423;
        Fri, 13 Oct 2023 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD0RaO/ot8dyeG7Uo8SggGQU+QRrkA+qeVDmJJk2llvQffd95k8QMI2UC91Kh+CNR4GjHY2g==
X-Received: by 2002:a05:6000:68d:b0:32d:88fd:5c65 with SMTP id bo13-20020a056000068d00b0032d88fd5c65mr7476648wrb.1.1697184254961;
        Fri, 13 Oct 2023 01:04:14 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6028.dip0.t-ipconnect.de. [91.12.96.40])
        by smtp.gmail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm20377154wrm.66.2023.10.13.01.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 01:04:14 -0700 (PDT)
Message-ID: <7495754c-9267-74af-b943-9b0f86619b5d@redhat.com>
Date: Fri, 13 Oct 2023 10:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/3] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
 rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
 jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
 kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-2-surenb@google.com> <ZShswW2rkKTwnrV3@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZShswW2rkKTwnrV3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13.10.23 00:01, Peter Xu wrote:
> On Sun, Oct 08, 2023 at 11:42:26PM -0700, Suren Baghdasaryan wrote:
>> From: Andrea Arcangeli <aarcange@redhat.com>
>>
>> For now, folio_move_anon_rmap() was only used to move a folio to a
>> different anon_vma after fork(), whereby the root anon_vma stayed
>> unchanged. For that, it was sufficient to hold the folio lock when
>> calling folio_move_anon_rmap().
>>
>> However, we want to make use of folio_move_anon_rmap() to move folios
>> between VMAs that have a different root anon_vma. As folio_referenced()
>> performs an RMAP walk without holding the folio lock but only holding the
>> anon_vma in read mode, holding the folio lock is insufficient.
>>
>> When moving to an anon_vma with a different root anon_vma, we'll have to
>> hold both, the folio lock and the anon_vma lock in write mode.
>> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
>> read-lock the anon_vma, we have to re-check if the mapping was changed
>> in the meantime. If that was the case, we have to retry.
>>
>> Note that folio_move_anon_rmap() must only be called if the anon page is
>> exclusive to a process, and must not be called on KSM folios.
>>
>> This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
>> the anon_vma lock in write mode, and the mmap_lock in read mode.
>>
>> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> ---
>>   mm/rmap.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index c1f11c9dbe61..f9ddc50269d2 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -542,7 +542,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>>   	struct anon_vma *root_anon_vma;
>>   	unsigned long anon_mapping;
>>   
>> +retry:
>>   	rcu_read_lock();
>> +retry_under_rcu:
>>   	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>>   	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
>>   		goto out;
>> @@ -552,6 +554,16 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>>   	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
>>   	root_anon_vma = READ_ONCE(anon_vma->root);
>>   	if (down_read_trylock(&root_anon_vma->rwsem)) {
>> +		/*
>> +		 * folio_move_anon_rmap() might have changed the anon_vma as we
>> +		 * might not hold the folio lock here.
>> +		 */
>> +		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
>> +			     anon_mapping)) {
>> +			up_read(&root_anon_vma->rwsem);
>> +			goto retry_under_rcu;
> 
> Is adding this specific label worthwhile?  How about rcu unlock and goto
> retry (then it'll also be clear that we won't hold rcu read lock for
> unpredictable time)?

+1, sounds good to me

-- 
Cheers,

David / dhildenb


