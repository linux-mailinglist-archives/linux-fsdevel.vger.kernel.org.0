Return-Path: <linux-fsdevel+bounces-771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7B7CFE3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8392821A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F05315AD;
	Thu, 19 Oct 2023 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo4WqJ/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0A30F82
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:41:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734A18A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697730072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JJr/PRGCFlMD3E/uH7FWSeqfLKgpGGhQWrbZ5EJs+i0=;
	b=Oo4WqJ/oqTpO8F3pwGyVTC4y2UO8C/v+91Z76twEKI5vR7LeYXqIAHbr+grnZHpoVvcXna
	QlD6oGH8FDRqSU+I6XTtSw10idgjPK2f2DpOaX9KI3BeviLfyaPIh09Z7Se7xf2lAcl3mz
	b7h0zP3upsMhb6lM74DztO+npf9ehCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Qax5xVTxO2ihXLPeKuXkFw-1; Thu, 19 Oct 2023 11:41:05 -0400
X-MC-Unique: Qax5xVTxO2ihXLPeKuXkFw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4077e9112b4so31201075e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730064; x=1698334864;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJr/PRGCFlMD3E/uH7FWSeqfLKgpGGhQWrbZ5EJs+i0=;
        b=DKOoFMJ//pLLnbdoCsQ0Y9zLNYfWwx4NdDWjnjMupse154jTi2UJbQXRD2lQRDfOV8
         5cHhVV8WTY4IjRV2kczFMtSAAy/zVpRR2+KOsGdbe8QSDEFw24dYmJS3fwhg0tH4McXF
         G9wWILSk6zB+TwZZaIO5PHnPdnV6O9aIHCW6baDjln/g3wCbGZ0qIKH6RKZp4TrB0hlH
         DkmUlMwBGI6ISEQvO5BZRVI5fb3TdSIIweufDPitwZD2HHeAlubVQRXiyv3JYVAeD4uw
         i27RyFh8581v6yPfDYyWQOhXBAT016EathE4L2ALbLJYY1pDLr1TR2NnxByL0qfr69OX
         R1fw==
X-Gm-Message-State: AOJu0YzBuJ9MDjdbZKm2NwguG6paI6xB95/jT7jg+dNu6d9Pexli50rU
	pdYva/Repz3z6uI2hrTEjAqGEAJ95nG1PM6eWKS+9Zm7bQdrWoDiw4VS60kBFZJ2Sk3Ijj17Yco
	IJQ6LU23vV/b1L14OFWkT1v9Pdw==
X-Received: by 2002:a05:600c:4592:b0:408:2686:e1cb with SMTP id r18-20020a05600c459200b004082686e1cbmr1998638wmo.23.1697730063995;
        Thu, 19 Oct 2023 08:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHKkD2UN+e0cvlgFYNJSwe9iV/QR1vJcmNnxULpah0wDYZWON0YAd8NW45+8h/OjODMZZOPg==
X-Received: by 2002:a05:600c:4592:b0:408:2686:e1cb with SMTP id r18-20020a05600c459200b004082686e1cbmr1998620wmo.23.1697730063400;
        Thu, 19 Oct 2023 08:41:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:500:6a06:17fc:810b:b054? (p200300cbc70b05006a0617fc810bb054.dip0.t-ipconnect.de. [2003:cb:c70b:500:6a06:17fc:810b:b054])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm4630990wmh.21.2023.10.19.08.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:41:02 -0700 (PDT)
Message-ID: <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
Date: Thu, 19 Oct 2023 17:41:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZS7ZqztMbhrG52JQ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.23 20:59, Peter Xu wrote:
> David,
> 
> On Tue, Oct 17, 2023 at 05:55:10PM +0200, David Hildenbrand wrote:
>> Don't get me wrong, but this feature is already complicated enough that we
>> should really think twice if we want to make this even more complicated and
>> harder to maintain -- because once it's in we all know it's hard to remove
>> and we can easily end up with a maintenance nightmare without sufficiently
>> good use cases.
> 
> Yes I agree it's non-trivial.  My point is adding cross-mm doesn't make it
> even more complicated.. afaics.

That's not my main point. It can easily become a maintenance burden 
without any real use cases yet that we are willing to support.

> 
> For example, could you provide a list of things that will be different to
> support single mm or cross mm?  I see two things that can be different, but
> I'd rather have all of them even if single-mm..
> 
>    - cgroup: I assume single-mm may avoid uncharge and charge again, but I
>      prefer it be there even if we only allow single-mm.  For example, I'm
>      not 100% sure whether memcg won't start to behave differently according
>      to vma attribute in the future.
> 
>    - page pinning: I assume for single-mm we can avoid checking page pinning
>      based on the fact that MMF_HAS_PINNED is per-mm, but I also prefer we
>      fail explicitly on pinned pages over UFFDIO_MOVE because it doesn't
>      sound correct, and avoid future changes on top of pinning solution that
>      can change the assumption that "move a pin page within mm" is ok.
> 
> Is there anything else that will be different?  Did I miss something
> important?

Again, that's not my main point. All I'm asking for is to separate it 
out, make it a separate flag, and include it once we have reasonable use 
cases that we are actually willing to support -- including actual data 
why it's beneficial to have.

For the single-mm use it has been shown that there are reasonable, 
existing use cases exist, and I think we are willing to support that.

This patch set is close to doubling (!) the size of mm/userfaultfd.c, 
and it already has every possible smell of maintanance nightmare IMHO. 
It does things that shouldn't be specific to some MM subsystem. I'm 
happy to see any possible complexity reduced. Moving pages between MMs 
is added complexity.

But I will stop arguing further; I hope I made my point clear and I have 
other things to work on than fighting against overly-complicated uffd 
features.


> 
> [...]
> 
>> BTW, wasn't there a way to do VM live-upgrade using fork() and replacing the
>> binary? I recall that there was at some time either an implementation in
>> QEMU or a proposal for an implementation; but I don't know how VM memory was
>> provided. It's certainly harder to move VM memory using fork().
> 
> Maybe you meant the cpr project.  I didn't actually follow that much
> previously (and will need to follow more after I took the migration
> duties.. when there's a new post), but IIUC at least the latest version
> needs to go with file memory only, not anonymous:
> 
> https://lore.kernel.org/all/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/
> 
>          Guest RAM must be non-volatile across reboot, which can be achieved by
>          backing it with a dax device, or /dev/shm PKRAM as proposed in...
> 
>          Guest RAM must be backed by a memory backend with share=on, but
>          cannot be memory-backend-ram.  The memory is re-mmap'd in the
>          updated process, so guest ram is efficiently preserved in place
> 
> My understanding is there used to have solution for anonymous but that
> needs extra kernel changes (MADV_DOEXEC).

Probably, I also stumbled over a paper from 2019 that mentioned that that.

> 
> https://lore.kernel.org/linux-mm/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
> 
> I saw that you were part of the discussion, so maybe you will remember some
> more clue of that part.
> 

Ouch, 2020. But my comments were only regarding mshare, not MADV_DOEXEC. 
In fact, I don't even know why both discussions/threads show up as a 
single one there..

> IIUC one core requirement of the whole approach is also that it will cover
> VFIO and maintenance of device DMA mappings, in which case it'll be
> different with any approach to leverage UFFDIO_MOVE because VFIO will not
> be allowed here; again I hope we start with forbid pinning. But it should
> be much cleaner on the design when with UFFDIO_MOVE, just not working with
> VFIO.
> 
> One thing I'd need to measure is latency of UFFDIO_MOVE on page fault
> resolutions.  I expect no more than tens of microseconds or even less.
> Should be drastically smaller than remote postcopy anyway.
> 
> I'm probably off topic.. To go back: let's try to figure out what is
> special with cross-mm support.  It'll be very weird in the future for
> anyone to propose a patch just add a feature flag and declaring cross-mm
> support, if the code is mostly all there.  Nothing stops us from discussing
> what a cross-mm design will need.

Again, I hope I made my point clear.

> 
> [...]
> 
>> Is that and will that remain the case? I know people have been working on
>> transparent user-space swapping using monitor processes using uffd. I
>> thought there would have been ways to achieve that without any corporation
>> of the dst.
> 
> Any example?

Nothing concrete, I only heard about uffd monitors that implement 
user-space based swapping. I don't recall if they require some kind of 
support from a library that gets loaded into these processes,

Same thoughts regarding CRIU using uffd.

> 
> For what I am aware, all corporation requires uffd desc forwarding.  I
> think the trick here is any userfaultfd desc must be created by its own
> process, so far nobody else.  That's more or less saying "I want to do
> this" from its own opinion.  The next is forwarding that to someone else.
> Parent process is fine taking uffd of child with EVENT_FORK, as I
> mentioned, but besides that nothing else I can think of that can violate
> this guard to manipulate a random process.

Do you have any idea how CRIU makes that work (at least I recall that 
they wanted to use UFFD).

-- 
Cheers,

David / dhildenb


