Return-Path: <linux-fsdevel+bounces-4062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B318B7FBFF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71B21C20CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4AE59B5C;
	Tue, 28 Nov 2023 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgSfnZiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202D10F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701191126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jo81sBdMr2MLOlqsA0e8N717pi+NEeDfgDhIKSqp+U=;
	b=CgSfnZiE01EVWDm8C/Uqpo7TNM3hKsf4EKSZ6D8LHOA61vhg9RRdRdsOQ035Jmkk/3Z/U+
	kgkPRDKZnyFmSJrVjUdW+rodgq0IxTpeSh0r2iSxpLavlmFFLtlD8W4zctBNc8+rMfXfaP
	vHC+NriDmINVMtTIHY6+b4tzbKBLXVM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-m0tB-EcfO3W0QAUSWuVS9w-1; Tue, 28 Nov 2023 12:05:25 -0500
X-MC-Unique: m0tB-EcfO3W0QAUSWuVS9w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33174d082b7so3934977f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191123; x=1701795923;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jo81sBdMr2MLOlqsA0e8N717pi+NEeDfgDhIKSqp+U=;
        b=Y4CScLSvg7qe4i+KNRFHm8+L1pVqEVqPxunhh1lq5aeC+A4uOd/BLOwDpbh4/ZEHIm
         gE1QFPID1ELgXoXVyDT75XNq0a1AaGQWc/yLYoEve5kj41sUsJCV7DR+uu246IEu8R5U
         Xic0oJbeW3Kez5eFEwFIT7COFR4uxpvJgU6BwJ2p8RD0D8v4gG2mf0GjR3hdixgSmdjg
         i/N778HJT7ktazC1uQ9IBccjyFVHj0ELTy+eP4kKEJmKPTA2zmpk54IVNElLmLVvlYvh
         8vS+Ma9FjiOIYO79MhdrHV7bEUVYIUOhlBXol5vgx4+Lf4C8cWEnbKrNcAcrJNREyBc0
         JAGA==
X-Gm-Message-State: AOJu0Yw/j0Zg6I1J0KbLY99JHfWOZK7DGLklGuZh7pqB4QlnAB5buVgf
	Z/gV3LBLArUTuRGXLroEfpvojki4M4sO+e7XJ1zUNiUBv3LJdwu7ZBYHuBCxsmFV4Kmlt8mNiDd
	64c/cvCGrKkwArjjKsKowtTVcyg==
X-Received: by 2002:adf:efcc:0:b0:333:130d:431a with SMTP id i12-20020adfefcc000000b00333130d431amr901457wrp.30.1701191123064;
        Tue, 28 Nov 2023 09:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFWpIG0UYKdT6tD9zribyy61YusjkZU9QIwSSIRGp4e9ejEbIv4PY396usZOr2uFNMBBWnQw==
X-Received: by 2002:adf:efcc:0:b0:333:130d:431a with SMTP id i12-20020adfefcc000000b00333130d431amr901391wrp.30.1701191122580;
        Tue, 28 Nov 2023 09:05:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id d21-20020adf9b95000000b003316ad360c1sm15738401wrc.24.2023.11.28.09.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 09:05:22 -0800 (PST)
Message-ID: <b1c151bb-cd07-43ac-b6e7-b49f8c40573a@redhat.com>
Date: Tue, 28 Nov 2023 18:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/27] arm64: mte: Make tag storage depend on
 ARCH_KEEP_MEMBLOCK
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
 <20231119165721.9849-14-alexandru.elisei@arm.com>
 <91c5d2e2-57b1-4172-88e0-cd07a8d85af4@redhat.com> <ZWSwArYMN1LuyGfO@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWSwArYMN1LuyGfO@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 16:04, Alexandru Elisei wrote:
> Hi,
> 
> On Fri, Nov 24, 2023 at 08:51:38PM +0100, David Hildenbrand wrote:
>> On 19.11.23 17:57, Alexandru Elisei wrote:
>>> Tag storage memory requires that the tag storage pages used for data are
>>> always migratable when they need to be repurposed to store tags.
>>>
>>> If ARCH_KEEP_MEMBLOCK is enabled, kexec will scan all non-reserved
>>> memblocks to find a suitable location for copying the kernel image. The
>>> kernel image, once loaded, cannot be moved to another location in physical
>>> memory. The initialization code for the tag storage reserves the memblocks
>>> for the tag storage pages, which means kexec will not use them, and the tag
>>> storage pages can be migrated at any time, which is the desired behaviour.
>>>
>>> However, if ARCH_KEEP_MEMBLOCK is not selected, kexec will not skip a
>>> region unless the memory resource has the IORESOURCE_SYSRAM_DRIVER_MANAGED
>>> flag, which isn't currently set by the tag storage initialization code.
>>>
>>> Make ARM64_MTE_TAG_STORAGE depend on ARCH_KEEP_MEMBLOCK to make it explicit
>>> that that the Kconfig option required for it to work correctly.
>>>
>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>> ---
>>>    arch/arm64/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 047487046e8f..efa5b7958169 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -2065,6 +2065,7 @@ config ARM64_MTE
>>>    if ARM64_MTE
>>>    config ARM64_MTE_TAG_STORAGE
>>>    	bool "Dynamic MTE tag storage management"
>>> +	depends on ARCH_KEEP_MEMBLOCK
>>>    	select CONFIG_CMA
>>>    	help
>>>    	  Adds support for dynamic management of the memory used by the hardware
>>
>> Doesn't arm64 select that unconditionally? Why is this required then?
> 
> I've added this patch to make the dependancy explicit. If, in the future, arm64
> stops selecting ARCH_KEEP_MEMBLOCK, I thinkg it would be very easy to miss the
> fact that tag storage depends on it. So this patch is not required per-se, it's
> there to document the dependancy.

I see. Could you add some static_assert / BUILD_BUG_ON instead?

I suspect there are plenty other (undocumented) reasons why 
ARCH_KEEP_MEMBLOCK has to be enabled for now, and none sets 
ARCH_KEEP_MEMBLOCK, I suspect/

-- 
Cheers,

David / dhildenb


