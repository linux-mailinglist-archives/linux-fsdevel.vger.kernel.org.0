Return-Path: <linux-fsdevel+bounces-68123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF7C54E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970DF3B4EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04187EEBB;
	Thu, 13 Nov 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="yGzeVX18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVFFoefh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375D2905;
	Thu, 13 Nov 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992887; cv=none; b=mc1CqhGZStUFsiEds8R4IG+TgREmBlV/XLGIRUvu2oFvWRYSOdkEufgz5KtvEqWtNz72O3UYxErkRsVdxWT5Li6xmXjLY7GFW4SikXnjsRd7GeKbLXhZQJqDyPDUc2Ibab0yfj/UjdKjAPo6HQk/ERaPhlDfUUDSYYb8GfsFrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992887; c=relaxed/simple;
	bh=ZdkIxb/t5hQ7WUCu9nyo3fziclzhOGu4PfXkyH2r2YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSw9vtQnLavrsA8Xl/YEVsHEZg5FWzzbAO16LDJTSIV99hNMG/Oa0ifi8APDpzyUM3Bt0xM/noHow8cC0SFMjqqppWU/qGoyLIWB06sF6r9grMEWai/vA2fA6FlHvwZyQMpgpc4/IH2hGAiLLUM0TMMfQlkayn5QH4RzFMsBSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=yGzeVX18; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVFFoefh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F4F4EC0198;
	Wed, 12 Nov 2025 19:14:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 12 Nov 2025 19:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762992883;
	 x=1763079283; bh=jVuUMhj1KrgwimXJyiXoIkRS9hx86+cnax0jKzvLld8=; b=
	yGzeVX18zMAoywxAQsty3YEoj9XPchKb+BJ1yf7Iii3wzuXAQGyPGUZcH+4ibaUF
	IZWnuKXxcZmY/UFhDJY86aYBjGbP0kadVtea242z/VH8elUSu+BMHimO+tUatcZs
	vcOf6WS5TyCDlTjrrd3klZaVWt0lhQKJXxwP09D04N4LH8rWlgBhMF12ahS5MXu8
	ZIw9qDgrlY5ZP5pbK/W+Lcr8SkUQltYkwTNjho8NceNEnGpT1A0hELbCDjSq9J3O
	yGIKAdVJKSataY8XzJxyqUAJDDSE5NMZacy4JDYvLqGb0jN+UrQrAqp8ZTiVeRKA
	XR4n9rC1RsukN1Uf9d4LCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762992883; x=
	1763079283; bh=jVuUMhj1KrgwimXJyiXoIkRS9hx86+cnax0jKzvLld8=; b=H
	VFFoefh7PH2sux8tGIPQcEChHMjDQSa2Tt4b9v0zVJjkANieMzvV/ww/i9ODTgj2
	4L2eZ3xWFdJ1JwqBW36BwbFzFBWbcwZfQHC/yJ93cuChxbvCrahgNwujK00CbEPn
	Jdf6ZZkyE7RHLraOeMbo0aIGzPRTS9jJ1pG9wC+l83SCBUJHdXW50Jn0sjJpEHvr
	m3/FjibPcmHnh6L1JyPKxh0WK0usdKGjDSm0TdDi+HZBYYXKYM5fbleUsCw4hE5R
	uBbyJCgMqgnwiHggHI8PmR/RPTgkVZfVKOLEJoNqcEyYseJuSHsMhUzrfAcia7wW
	8kOqg0T96GNXxaFXXfdVg==
X-ME-Sender: <xms:8iIVaR72VUalhrotXkFwxA0Gitpym0mwmEmS855u24sDN1PilLbbiQ>
    <xme:8iIVaYMuTvlxHi779zkpx7zViEFV1eFVucMJn731J0WtkeJf-g-j9Csxm8Z1spLZ7
    thGq7utS1Q1t2bibOB-29-xDTmqTM8W3Zxt0Wv19SVR2P_6>
X-ME-Received: <xmr:8iIVaftOTUUTNSE6n2hREJQ7tFu3tG_2qSlokyN2z4FKOCl1uWUr-gNbG99WdMUGpXRsjXQzqhHemYA98g_2m4SzWj3zyXrOMMnE5-0GNyOT6dcjO5JT6HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8yIVabZBdP_VHHdVVAAxqXUvBN7d_69wYz5Cl5N1GuIxaP52MVXe4w>
    <xmx:8yIVaRz1Wa2YlpVxUZtoasIGDYFYnefd_fCuYX8wov9THb4pGmY3wA>
    <xmx:8yIVaTiJIt5qeKpi3xtaU8UyNPZzyETUENbGdwMQqo12Zv60RJA6Vw>
    <xmx:8yIVadmY4JZB0btjl8Aec4XYfzlUmK4-Mc5VScvMHESuMQQNzDrdeA>
    <xmx:8yIVaSXpEHUdCrbgx0U9Uwyl51PejtGu-fjX5SrfY_GTh7F2NIYktJrA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:14:40 -0500 (EST)
Message-ID: <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>
Date: Thu, 13 Nov 2025 08:14:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
 <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
 <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 19:01, Christian Brauner wrote:
> On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
>> On 11/11/25 18:55, Christian Brauner wrote:
>>> On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
>>>> On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
>>>>
>>>>>> +	sbi->owner = current->nsproxy->mnt_ns;
>>>>> ns_ref_get()
>>>>> Can be called directly on the mount namespace.
>>>> ... and would leak all mounts in the mount tree, unless I'm missing
>>>> something subtle.
>>> Right, I thought you actually wanted to pin it.
>>> Anyway, you could take a passive reference but I think that's nonsense
>>> as well. The following should do it:
>> Right, I'll need to think about this for a little while, I did think
>>
>> of using an id for the comparison but I diverged down the wrong path so
>>
>> this is a very welcome suggestion. There's still the handling of where
>>
>> the daemon goes away (crash or SIGKILL, yes people deliberately do this
>>
>> at times, think simulated disaster recovery) which I've missed in this
> Can you describe the problem in more detail and I'm happy to help you
> out here. I don't yet understand what the issue is.

I thought the patch description was ok but I'll certainly try.


Consider using automount in a container.


For people to use autofs in a container either automount(8) in the init

mount namespace or an independently running automount(8) entirely within

the container can be used. The later is done by adding a volume option

(or options) to the container to essentially bind mount the autofs mount

into the container and the option syntax allows the volume to be set

propagation slave if it is not already set by default (shared is bad,

the automounts must not propagate back to where they came from). If the

automount(8) instance is entirely within the container that also works

fine as everything is isolated within the container (no volume options

are needed).


Now with unshare(1) (and there are other problematic cases, I think systemd

private temp gets caught here too) where using something like "unshare -Urm"

will create a mount namespace that includes any autofs mounts and sets them

propagation private. These mounts cannot be unmounted within the mount

namepsace by the namespace creator and accessing a directory within the

autofs mount will trigger a callback to automount(8) in the init namespace

which mounts the requested mount. But the newly created mount namespace is

propagation private so the process in the new mount namespace loops around

sending mount requests that cannot be satisfied. The odd thing is that 
on the

second callback to automount(8) returns an error which does complete the

->d_automount() call but doesn't seem to result in breaking the loop in

__traverse_mounts() for some unknown reason. One way to resolve this is to

check if the mount can be satisfied and if not bail out immediately and

returning an error in this case does work.


I was tempted to work out how to not include the autofs mounts in the cloned

namespace but that's file system specific code in the VFS which is not 
ok and

it (should) also be possible for the namespace creator to "mount 
--make-shared"

in the case the creator wants the mount to function and this would 
prevent that.

So I don't think this is the right thing to do.


There's also the inability of the mount namespace creator to umount the 
autofs

mount which could also resolve the problem which I haven't looked into yet.


Have I made sense?


Clearly there's nothing on autofs itself and why one would want to use it

but I don't think that matters for the description.


Ian


