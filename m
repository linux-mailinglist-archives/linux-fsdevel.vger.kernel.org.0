Return-Path: <linux-fsdevel+bounces-940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD47D3CB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CC01C20AB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75A31DA5B;
	Mon, 23 Oct 2023 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AubPeD/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6A1CA80
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:36:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92358A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698078991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bPiDJtM89jSenAR/Vf9MLQS+0UWrEcUcrVIZ4BtSNrc=;
	b=AubPeD/b7EhPnRBSeeQCbDRkZ7MXUKioBGOQEpts5bmYl9fkkEj7Z+nJ+PY/M5X94mgog2
	aGQNMRkU+qUmLf2wPEWMg7rPm6XULGGfb0n2lTbyGnKmrjEvtsNgLerPNXLg38973/QBWF
	SPdmkNshr3FQ/2C28Xax8gbv2blNBpg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-uO2saeeFNXKeclYdtIr3pQ-1; Mon, 23 Oct 2023 12:36:20 -0400
X-MC-Unique: uO2saeeFNXKeclYdtIr3pQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408508aa81cso24287185e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078979; x=1698683779;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bPiDJtM89jSenAR/Vf9MLQS+0UWrEcUcrVIZ4BtSNrc=;
        b=GnGdoGpuz3EvpGelnw3WQjxWDWmisisbjaOGLZWPJzi65X49rN7l1QPzBoaoRk4mPF
         svOuEPmBSR7Ai3qGKfmjMd56Rl4qxZRkPs4s5aKGYfXe/gYmPJcGR0SW4mPEkGnSubWY
         lryVnT12djO8dmJnbB8Om7udEYyb7odusWmo9olASJ2OqzlyIUR658b2fo2LlpqD+/Kq
         yqlLrrjUCtg5LdYFSM7MnhoIVSGySVx08DmpXiO9GjucL5TXOoeKJgpnrgQafXbIqsHx
         TinpUa3a1sogYDy9wpMZ/3EGedulGUqtVKDIbj/hi2/DQHLFUw5NcPsZNkWM/0jW+qUV
         8SfA==
X-Gm-Message-State: AOJu0YzYvtHDkXlgDvY5k4oDHmdO9mhzZEn8/U7axKBI0tRFvvQluoly
	3NOzqwW8YOmZbbK2DmnJWiv69C+CMrSw6T0EA+iZiHTd5RbP08qWgPmMgO+26hK67izXdyVPNvo
	eUAWt8+iPQKf3I+kPxo72r8Zl3A==
X-Received: by 2002:a05:600c:5247:b0:401:db82:3edf with SMTP id fc7-20020a05600c524700b00401db823edfmr7218455wmb.39.1698078979126;
        Mon, 23 Oct 2023 09:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFiu1PKt56rYcdGr3G/LTpA9GAgKmQ19nPfcfMRPWQeiQKlKSKWX7+AvElPrWy601J7SQcwQ==
X-Received: by 2002:a05:600c:5247:b0:401:db82:3edf with SMTP id fc7-20020a05600c524700b00401db823edfmr7218423wmb.39.1698078978642;
        Mon, 23 Oct 2023 09:36:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:1900:b6ea:5b9:62c0:34e? (p200300cbc7381900b6ea05b962c0034e.dip0.t-ipconnect.de. [2003:cb:c738:1900:b6ea:5b9:62c0:34e])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c189600b004083a105f27sm14361777wmp.26.2023.10.23.09.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 09:36:18 -0700 (PDT)
Message-ID: <96899aa6-700b-41b9-ab11-2cae48d75549@redhat.com>
Date: Mon, 23 Oct 2023 18:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com> <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com> <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com> <ZTGJHesvkV84c+l6@x1n>
 <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
 <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
 <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com> <ZTVD18RgBfITsQC4@x1n>
 <1156ad46-1952-4892-8092-bfbb8588c3f3@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1156ad46-1952-4892-8092-bfbb8588c3f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.23 14:03, David Hildenbrand wrote:
> On 22.10.23 17:46, Peter Xu wrote:
>> On Fri, Oct 20, 2023 at 07:16:19PM +0200, David Hildenbrand wrote:
>>> These are rather the vibes I'm getting from Peter. "Why rename it, could
>>> confuse people because the original patches are old", "Why exclude it if it
>>> has been included in the original patches". Not the kind of reasoning I can
>>> relate to when it comes to upstreaming some patches.
>>
>> You can't blame anyone if you misunderstood and biased the question.
>>
>> The first question is definitely valid, even until now.  You guys still
>> prefer to rename it, which I'm totally fine with.
>>
>> The 2nd question is wrong from your interpretation.  That's not my point,
>> at least not starting from a few replies already.  What I was asking for is
>> why such page movement between mm is dangerous.  I don't think I get solid
>> answers even until now.
>>
>> Noticing "memcg is missing" is not an argument for "cross-mm is dangerous",
>> it's a review comment.  Suren can address that.
>>
>> You'll propose a new feature that may tag an mm is not an argument either,
>> if it's not merged yet.  We can also address that depending on what it is,
>> also on which lands earlier.
>>
>> It'll be good to discuss these details even in a single-mm support.  Anyone
>> would like to add that can already refer to discussion in this thread.
>>
>> I hope I'm clear.
>>
> 
> I said everything I had to say, go read what I wrote.

Re-read your message after flying over first couple of paragraphs 
previously a bit quick too quickly (can easily happen when I'm told that 
I misunderstand questions and read them in a "biased" way).

I'll happy to discuss cross-mm support once we actually need it. I just 
don't see the need to spend any energy on that right now, without any 
users on the horizon.

[(a) I didn't blame anybody, I said that I don't understand the 
reasoning. (b) I hope I made it clear that this is added complexity (and 
not just currently dangerous) and so far I haven't heard a compelling 
argument why we should do any of that or even spend our time discussing 
that. (c) I never used "memcg is missing" as an argument for "cross-mm 
is dangerous", all about added complexity without actual users. (d) "it 
easily shows that there are cases  where this will require extra work -- 
without any current benefits" -- is IMHO a perfectly fine argument 
against complexity that currently nobody needs]

-- 
Cheers,

David / dhildenb


