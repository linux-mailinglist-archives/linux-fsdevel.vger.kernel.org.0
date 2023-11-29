Return-Path: <linux-fsdevel+bounces-4188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1F7FD982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F881C2097C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8A32C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp2IxfAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A4610C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 04:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701262136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3SvqkGKhkhbr5E/QgNHUmxR2NH2z++nAn+Ad162nVUI=;
	b=Dp2IxfAgfjg2i6YPaRU6eCNZ172t12yTDHgvNm3UPqOazuvcYL78JoQpItqcJ0RD8IPO0e
	xmRclSUG5dFCmD37/dx05KMJVMXCno0J7EoLY1WJoaQqqRRO78fUDL3H8sWWC+raoMGguN
	BL2znbBxOpn6+RtsZyk0gVj9SzK7MjU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-U4BbofiNP_Oq23FCICyIkA-1; Wed, 29 Nov 2023 07:48:54 -0500
X-MC-Unique: U4BbofiNP_Oq23FCICyIkA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b53c8194cso3726785e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 04:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262134; x=1701866934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SvqkGKhkhbr5E/QgNHUmxR2NH2z++nAn+Ad162nVUI=;
        b=Ixs8QvFxu1vqej6V7SS2BUygC4KnxlkLzHvBqv44qFpfNfswaBnqYK48INRp8XaQSK
         ZuUaSff1IcI3xACRrBGrRuVYKAcnMiA5nX0QZKleIxlCyr0Re2EERnEFeo3jQFR51X+y
         YUuF/Uxo18pPbJeavI4nArFRkYgwZZlQ7r4Kvp484leWy987LUI1nn9rskoccw9kNQFP
         iqqLX7tb1YFh+HMGINj69MZP/0c4poD4z0hnbxB638ecOdlnh94Ge0b+b8FIuEoI9eF1
         zXnhBrsztgnB3bGUCNPz7Wpfr6vKR9PuHlzy+Tblx7V9K7ioD++Z9SbJHSvUhkCJ7HRc
         U3EQ==
X-Gm-Message-State: AOJu0YznHx1XWlXQnE/Qtpp/CXzeWb9fX14v/yIqvblhVywBYIw9d1JK
	O4ak2jTdebnsx1O2/CJNDSmCSyOihEn4SPYd96kTraLkPgZkqeX5/YO5/GT6YnY4A/iwzoyM2Ou
	GyOAZ+8ZaCSmeQfJ+8dViyJT/Fg==
X-Received: by 2002:a05:600c:4444:b0:40b:2a69:6c38 with SMTP id v4-20020a05600c444400b0040b2a696c38mr12962143wmn.20.1701262133705;
        Wed, 29 Nov 2023 04:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/GvtkSi+X8gkjupkbSZUxXcDP9aiKyH7RkbFc+bdVSZqXF9jIt9LVVfG/zAvruGlNfPRVhg==
X-Received: by 2002:a05:600c:4444:b0:40b:2a69:6c38 with SMTP id v4-20020a05600c444400b0040b2a696c38mr12962123wmn.20.1701262133260;
        Wed, 29 Nov 2023 04:48:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c710:f600:634b:35f:ffa8:475b? (p200300cbc710f600634b035fffa8475b.dip0.t-ipconnect.de. [2003:cb:c710:f600:634b:35f:ffa8:475b])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b003fee6e170f9sm2174737wmo.45.2023.11.29.04.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:48:52 -0800 (PST)
Message-ID: <ca069bdf-3d53-41d9-adf1-f7a8b245f57b@redhat.com>
Date: Wed, 29 Nov 2023 13:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS
 for mprotect(PROT_MTE)
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <1c79ad05-cb52-4820-b2aa-bbe07ff82b19@redhat.com> <ZWcmuzUcpVeUnlk2@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWcmuzUcpVeUnlk2@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.23 12:55, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Nov 28, 2023 at 06:55:18PM +0100, David Hildenbrand wrote:
>> On 19.11.23 17:57, Alexandru Elisei wrote:
>>> To enable tagging on a memory range, userspace can use mprotect() with the
>>> PROT_MTE access flag. Pages already mapped in the VMA don't have the
>>> associated tag storage block reserved, so mark the PTEs as
>>> PAGE_FAULT_ON_ACCESS to trigger a fault next time they are accessed, and
>>> reserve the tag storage on the fault path.
>>
>> That sounds alot like fake PROT_NONE. Would there be a way to unify hat
> 
> Yes, arm64 basically defines PAGE_FAULT_ON_ACCESS as PAGE_NONE |
> PTE_TAG_STORAGE_NONE.
> 
>> handling and simply reuse pte_protnone()? For example, could we special case
>> on VMA flags?
>>
>> Like, don't do NUMA hinting in these special VMAs. Then, have something
>> like:
>>
>> if (pte_protnone(vmf->orig_pte))
>> 	return handle_pte_protnone(vmf);
>>
>> In there, special case on the VMA flags.
> 
> Your suggestion from the follow-up reply that an arch should know if it needs to
> do something was spot on, arm64 can use the software bit in the translation
> table entry for that.
> 
> So what you are proposing is this:
> 
> * Rename do_numa_page->handle_pte_protnone
> * At some point in the do_numa_page (now renamed to handle_pte_protnone) flow,
>    decide if pte_protnone() has been set for an arch specific reason or because
>    of automatic NUMA balancing.
> * if pte_protnone() has been set by an architecture, then let the architecture
>    handle the fault.
> 
> If I understood you correctly, that's a good idea, and should be easy to
> implement.

yes! :)

-- 
Cheers,

David / dhildenb


