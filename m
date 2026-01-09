Return-Path: <linux-fsdevel+bounces-73042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BAD08F60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41309308C8C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38583375CB;
	Fri,  9 Jan 2026 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="swga332A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="co0wjBNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D4328B5F;
	Fri,  9 Jan 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958599; cv=none; b=oYB/57ZlVvUe8VJM5Fimj9eNlaUfh3cFVOq1PNQNLCHFwCLQcmUdmqMarrHyh5X7Bh7gQQo6qns0uPxwvwqUbcy1eD1KGkTnhQg7e/Al6YcFMRi21qh9UFrJUrnYmExdImyGrmS8eQfQ1zQKq3ZY7y4LhmOKOA3Al4RvN+k9GVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958599; c=relaxed/simple;
	bh=YHJ2ldPBt/AEqru/kYn1w7AXOnQKTmeaA4j+gehfHd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFj4KV0uZPq1EvJaQHIG6Gm2+tH341BWNR8OuTJC4J8LErHIEwm3R5bxDimFeCnqcMmglKcl/6F+BvmHuNr9qNPT41c8F5CzF8aJOlJwHKLAu1gWEHLKd8cyMPq8uIjkWI44cjuEW75tJZyAyDf0e2O0tdXJ1vAYKQe6758x8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=swga332A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=co0wjBNm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C873B1D00053;
	Fri,  9 Jan 2026 06:36:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 06:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767958596;
	 x=1768044996; bh=IJ5UPvJeatR6ooQ9Y+kTtGdHkVRZIsEyCpqQkMFnSPM=; b=
	swga332AepvzxNT8KXmZ+Rb+NfTV0/d2Y1HPb0M3Lul+8FsApSfsrvYY8okJO7+j
	yVLnNeAEL0qjztW+VTYOdJrCKKmw24SlNucj/zyh2v2xyJqwhxUB6JkCl/+/8dDz
	mQUBq0etFAPC4oDSHcgWWFPz+1C31F3M35MoWzDf4tgFFcZjFwAZR1F/LhqXXIOQ
	yMKekvhar5tNzMo8+uP8Vy6WbgnUdmfFFCv5Agov9yW8BP22KDhQ3KXAE9AOLRtM
	4COXImQsrW+VkCqjY9hxxSRipr2HKNMknoAV7YgoMiVFcYQOfR5dpUg3WrJUtziD
	N2vJqjAxqaCFkr3IfJ5Gtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767958596; x=
	1768044996; bh=IJ5UPvJeatR6ooQ9Y+kTtGdHkVRZIsEyCpqQkMFnSPM=; b=c
	o0wjBNm+XTyR/RqeJw8YM4Iv5mKQBsw0bhc0vpGQy73Hf9coYWMn7AZHAlsef82k
	zMaOWNgAq4pwUnKcOeXB75yhfaRhy3DKykqZK11fkjtjq0yJzIqNn3fHMxr91FOy
	Z2uxyb4wVI8WAbBwoXzkn9KHqKD3PEceQmCldkB0v98BpPZMit09bMreso6VVPOs
	wcLyQ/L/IUPN89BA7lws5GmjbYFC0LVQiif9ECejLhgTc628t2jns+kgPHkwPOAB
	xMBcBEgoIFUNZdbfC/tZKPHR5bQrwNB8dgCjhXyIBa4v17wRQSbvRwrC8lGXZ8Ic
	HkUChhypqM1asKwF9/phw==
X-ME-Sender: <xms:ROhgaWQiRwv-LtB__7DsvS7gNMrMHpNauNDsP0Eb4S2mZ-S5bY4Khg>
    <xme:ROhgaVHsTAY2frmX5DJX7886SLkVGqTX4mfAMcdWMcRjuUF6xoKkExG7sNPcPto4L
    VBaYfdx1ZGEK0UmgSNPZljQZ7GhSFK_IJOZO_6wvgUX-s5k3m52>
X-ME-Received: <xmr:ROhgabEzM0o27h02lQtHoH2j1wNLM0CxxwDjaJotxkw-s6cRdPumwEzcDh8AV-jaeOJyMYKb2V1tYo2F38vLHwt5YO1OXgfy9Uy5okwZN1EMQv3umw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleek
    jeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepth
    hhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphht
    thhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgtph
    htthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepmhhikhhlohhssehsiigv
    rhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ROhgaTQnmkxP2H4mTfXrkEaFK7S7YDVhlrCWIbOndPcxQbRYC0-yRA>
    <xmx:ROhgacLf02ZzUs8-qzlWccXB13mVV6IcS2DYeFjRN2LMid6p4nwGHg>
    <xmx:ROhgaeaV5KS2h8UBGAtYO-hpwf1JJhG1hjR8-YyYWhLjD33okGekxw>
    <xmx:ROhgae9STCPz6XCxSNmnZqnhB2HdXF5236ERLNgO3603ihO9EvC7YQ>
    <xmx:ROhgaespeqy3RxDa9JVeoxHOnjhv8neEWtLCCDgQvZkICINQuOiPg_fj>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 06:36:35 -0500 (EST)
Message-ID: <519e25f7-ee5a-4458-b2cf-df3c3eb3694f@bsbernd.com>
Date: Fri, 9 Jan 2026 12:36:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: uapi: use UAPI types
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>,
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260109114918-1c5ea28d-f32d-49e5-affb-cc3c74c4dd5b@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/9/26 11:55, Thomas Weißschuh wrote:
> On Fri, Jan 09, 2026 at 11:45:33AM +0100, Bernd Schubert wrote:
>>
>>
>> On 1/9/26 11:38, David Laight wrote:
>>> On Fri, 9 Jan 2026 09:11:28 +0100
>>> Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
>>>
>>>> On Thu, Jan 08, 2026 at 11:12:29PM +0100, Bernd Schubert wrote:
>>>>>
>>>>>
>>>>> On 1/5/26 13:09, Arnd Bergmann wrote:  
>>>>>> On Mon, Jan 5, 2026, at 09:50, Bernd Schubert wrote:  
>>> ...
>>>>>> I don't think we'll find a solution that won't break somewhere,
>>>>>> and using the kernel-internal types at least makes it consistent
>>>>>> with the rest of the kernel headers.
>>>>>>
>>>>>> If we can rely on compiling with a modern compiler (any version of
>>>>>> clang, or gcc-4.5+), it predefines a __UINT64_TYPE__ macro that
>>>>>> could be used for custom typedef:
>>>>>>
>>>>>> #ifdef __UINT64_TYPE__
>>>>>> typedef __UINT64_TYPE__		fuse_u64;
>>>>>> typedef __INT64_TYPE__		fuse_s64;
>>>>>> typedef __UINT32_TYPE__		fuse_u32;
>>>>>> typedef __INT32_TYPE__		fuse_s32;
>>>>>> ...
>>>>>> #else
>>>>>> #include <stdint.h>
>>>>>> typedef uint64_t		fuse_u64;
>>>>>> typedef int64_t			fuse_s64;
>>>>>> typedef uint32_t		fuse_u32;
>>>>>> typedef int32_t			fuse_s32;
>>>>>> ...
>>>>>> #endif  
>>>>>
>>>>> I personally like this version.  
>>>>
>>>> Ack, I'll use this. Although I am not sure why uint64_t and __UINT64_TYPE__
>>>> should be guaranteed to be identical.
>>>
>>> Indeed, on 64bit the 64bit types could be 'long' or 'long long'.
>>> You've still got the problem of the correct printf format specifier.
>>> On 32bit the 32bit types could be 'int' or 'long'.
>>>
>>> stdint.h 'solves' the printf issue with the (horrid) PRIu64 defines.
>>> But I don't know how you find out what gcc's format checking uses.
>>> So you might have to cast all the values to underlying C types in
>>> order pass the printf format checks.
>>> At which point you might as well have:
>>> typedef unsigned int fuse_u32;
>>> typedef unsigned long long fuse_u64;
>>> _Static_assert(sizeof (fuse_u32) == 4 && sizeof (fuse_u64) == 8);
>>> And then use %x and %llx in the format strings.
> 
> These changes to format strings are what we are trying to avoid.
> 
>> The test PR from Thomas succeeds in compilation and build testing. Which
>> includes 32-bit cross compilation
>>
>> https://github.com/libfuse/libfuse/pull/1417
> 
> Unforunately there might still be issues on configurations not tested by the CI
> where the types between the compiler and libc won't match.
> But if it works sufficiently for you, I'm fine with it.

I don't have a problem to adopt libfuse - that is the simple part. The
harder part are other fuse implementations that use the same header. And
they will complain to Miklos if compilation fails.
Which is why it is important that we catch beforehand as many issues as
we can and then the commit message should explain very detailed the use
case. I.e. if something breaks for others, we can still point to you use
case that would be broken without these changes.

> 
> Also with the proposal from Arnd there were format strings warnings when
> building the kernel, so now I have this:
> 
> #if defined(__KERNEL__)
> #include <linux/types.h>
> typedef __u64		fuse_u64;
> ...
> 
> #elif defined(__UINT64_TYPE__)
> typedef __UINT64_TYPE__		fuse_u64;
> ...
> 
> #else
> #include <stdint.h>
> typedef uint64_t		fuse_u64;
> ...
> #endif  


I guess you can see why Miklos is resisting these changes without a good
use case :)


Thanks,
Bernd

