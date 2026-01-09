Return-Path: <linux-fsdevel+bounces-73053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E12B2D0A798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E5803017859
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23235CB65;
	Fri,  9 Jan 2026 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="IAOSoWvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5bdQ8D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1732ABCD;
	Fri,  9 Jan 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966368; cv=none; b=QA+xqX1hcAuTkzptJOyXHbiZPyqf3igOvmLNRUtI8eMb1fL6ZwkoMQcZjks6PsAzYgYMrMeR12aBGc7buJVEI7CEZvt20spCb7wq0qMYJUo5z0+3aIfUs8ARMZdRM3JjazTNoJIbFmJ43zO3Xijg0DKrQKpt/Db9qIZGz+5x3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966368; c=relaxed/simple;
	bh=/5syR/AUtwe+C+pEcKRaUm7Hbn9akAQNYPE+ShDWbmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgRW+sfARrT4vtj1bb0yV3ChKgo9jk5hN/m6MFxZBy5R6WVOUeTAUEbk5Tih0lazXy5PmJhipWeo9V1lPxeCWQBWaM87FdMAgDVW7sy7t7D01nFxTomxYFKVdtYj1Veh+FWaoJQzRWlO8+1dnUQ+XBFlkl0hCzxQ4iepkIbcLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=IAOSoWvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5bdQ8D9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EAFB3EC0082;
	Fri,  9 Jan 2026 08:46:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 08:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767966364;
	 x=1768052764; bh=x9Y2H00wQGBDprNwkny7aFmArXY4i0TBmcLvK+Q6a7o=; b=
	IAOSoWvQNFqQX8vfvsI4quMLtOpbe3oLWBsMlo27ticvLJT3POhXyrhDs8AfvMwM
	RRGX4F9/Xoaqd+SCwnL9HANuPFlMhCc3ppcMEcdOh7WCf3C8y/9L+70VM8oqD1nH
	xPmAq7uAzsWXJbRZxrfYjwCF4BTSnevDInPLcEWy2GUMIZaaN9QTqDQS/WmGTEOi
	i6/hF1flGoiK5f2S0xDy61XxSEXbxUb0R4yvG63XvL7Kz083RBF39rYZD5lMrgcu
	iLyWDMSkCx2olVq8tHJ2AoAQStradQxmFLAAdKklCHnq/Bclqd738zDx9aKEHYAA
	T0zbMsz+6PlAhy/YfJla7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767966364; x=
	1768052764; bh=x9Y2H00wQGBDprNwkny7aFmArXY4i0TBmcLvK+Q6a7o=; b=Z
	5bdQ8D9KdqGXvpfjX6QoXJP4elmkOgwJDztDJ44BfuFUpnV8hT2aaeHJWcHqIlGE
	XYYSlQYrUpbZZDd3yezNYkrVjW/PHg228gQzADVQ4VcmRq+0IERuPzbgja8uScxA
	YY4NSjNbusmyiUAoOFCEioiqmaN2aSjlejrXnYpCxg1t0GemEnJ3cjjNpPpQqDLD
	4Ip4qTLo3Y6Shr5pF6zBVb/AfhM5j6UMy0rWbB9O44xb32Li56SIzfjF3hiRwgb6
	YOv59mlbuVeZSgy1lNSKpF6fR80Cy5RsLQfgqc9PrnDhoSCfrU49kGqW3Y8mikLl
	sXoPlNw0ISZtCtn9OXogQ==
X-ME-Sender: <xms:nAZhaSYBzBgqHFHFhBq7Esi2Ns8n3asMYaz04tjpDhUuoc0IAmy2NA>
    <xme:nAZhaesQ2r6DMC8N_uTk2zkKfiEwpL3zSSUrPIcaTp0NYgBtYNUHOp7y72DCPaVZK
    vvmujrNWx9573olDVOK3-MxRHYP3ePio90GQJ-QRCrhNgC9jA1GoQ>
X-ME-Received: <xmr:nAZhaUMlJve91OKs_x5we5sUq4eagvlht7DYJkySV2l1fOj8Nh1f5n1zn4-IncIQ0o9cpKRUZFrul9crAsJSVl67tt4_d64n118DIvQNwJk_iG-oDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprh
    gtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nAZhaV4urINnB70UmoPQBLwxVEv6-XqRNDjaGL_KPHKRHQcFmzn5EA>
    <xmx:nAZhaaSoqBL_P88Wz9Nk5k4iiTZWe_D09uN66YqD3HiWa0K33PWfZw>
    <xmx:nAZhaSAqUSdNNc2wR02SzDg_ZxsvdYerD4w5ADOG_fZiZM7c9JN5aQ>
    <xmx:nAZhaaGLKypssn0-oEyFp8zWhNrBfs67MbxsoRhfIJmRacgCuAscbQ>
    <xmx:nAZhad2KuWx4dbhS2k_p_exZ8Aswt_Rpyt5iF-aYDCbw5WUbO_OhDHQU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 08:46:03 -0500 (EST)
Message-ID: <deff86e1-f124-4e5d-9313-d7339bcc664a@bsbernd.com>
Date: Fri, 9 Jan 2026 14:46:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: David Laight <david.laight.linux@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251230-uapi-fuse-v2-1-5a8788d62525@linutronix.de>
 <8efcbf41-7c74-4baf-9d75-1512f4f3fb03@bsbernd.com>
 <b975404f-fd6d-42aa-9743-c11e0088596b@bsbernd.com>
 <20260105092847-f05669a4-f8a1-498d-a8b4-dc1c5a0ac1f8@linutronix.de>
 <51731990-37fe-4821-9feb-7ee75829d3a0@bsbernd.com>
 <2c1dc014-e5aa-4c1d-a301-e10f47c74c7d@app.fastmail.com>
 <e22544a1-dea4-44d0-9a72-b60d38eeac19@bsbernd.com>
 <20260109085917-e316ce57-5e78-4827-96d7-4a48a68aa752@linutronix.de>
 <20260109103827.1dc704f2@pumpkin>
 <ccdbf9b8-68d1-4af6-9ed4-f2259d1cecb4@bsbernd.com>
 <20260109114918-1c5ea28d-f32d-49e5-affb-cc3c74c4dd5b@linutronix.de>
 <20260109131134.7aba4acf@pumpkin>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260109131134.7aba4acf@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/9/26 14:11, David Laight wrote:
> On Fri, 9 Jan 2026 11:55:30 +0100
> Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
> 
>> On Fri, Jan 09, 2026 at 11:45:33AM +0100, Bernd Schubert wrote:
>>>
>>>
>>> On 1/9/26 11:38, David Laight wrote:  
>>>> On Fri, 9 Jan 2026 09:11:28 +0100
>>>> Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
>>>>   
>>>>> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:  
>>>>>>
>>>>>>
>>>>>> On 1/5/26 13:09, Arnd Bergmann wrote:    
>>>>>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:    
>>>> ...  
>>>>>>> I don't think we'll find a solution that won't break somewhere,
>>>>>>> and using the kernel-internal types at least makes it consistent
>>>>>>> with the rest of the kernel headers.
>>>>>>>
>>>>>>> If we can rely on compiling with a modern compiler (any version of
>>>>>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
>>>>>>> could be used for custom typedef:
>>>>>>>
>>>>>>> #ifdef __UINT64_TYPE__
>>>>>>> typedef __UINT64_TYPE__		fuse_u64;
>>>>>>> typedef __INT64_TYPE__		fuse_s64;
>>>>>>> typedef __UINT32_TYPE__		fuse_u32;
>>>>>>> typedef __INT32_TYPE__		fuse_s32;
>>>>>>> ...
>>>>>>> #else
>>>>>>> #include <stdint.h>
>>>>>>> typedef uint64_t		fuse_u64;
>>>>>>> typedef int64_t			fuse_s64;
>>>>>>> typedef uint32_t		fuse_u32;
>>>>>>> typedef int32_t			fuse_s32;
>>>>>>> ...
>>>>>>> #endif    
>>>>>>
>>>>>> I personally like this version.    
>>>>>
>>>>> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE__
>>>>> should be guaranteed to be identical.  
>>>>
>>>> Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
>>>> You've still got the problem of the correct printf format specifier.
>>>> On 32bit the 32bit types could be 'int' or 'long'.
>>>>
>>>> stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
>>>> But I don't know how you find out what gcc's format checking uses.
>>>> So you might have to cast all the values to underlying C types in
>>>> order pass the printf format checks.
>>>> At which point you might as well have:
>>>> typedef unsigned int fuse_u32;
>>>> typedef unsigned long long fuse_u64;
>>>> _Static_assert(sizeof (fuse_u32) == 4 && sizeof (fuse_u64) == 8);
>>>> And then use %x and %llx in the format strings.  
>>
>> These changes to format strings are what we are trying to avoid.
> 
> Where do PRIu64 (and friends) come from if you don't include stdint.h ?
> I think Linux kernel always uses 'int' and 'long long', but other
> compilation environments might use 'long' for one of them [1].
> So while you can define ABI correct PRIu64 and PRIu32 you can't define
> ones that pass compiler format checking without knowing the underlying
> C types.

libfuse uses PRIu64 and it make heavy usage of stdint.h in general, I
don't think building it in that no-libc environment would work. But that
doesn't mean the header couldn't be included in another lib that works
differently.

Thanks,
Bernd

