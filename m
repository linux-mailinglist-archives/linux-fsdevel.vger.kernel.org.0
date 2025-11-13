Return-Path: <linux-fsdevel+bounces-68407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D777C5AAE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 51735207ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094032B987;
	Thu, 13 Nov 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="GYuBWMBU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSTYKp8f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC130283CB1;
	Thu, 13 Nov 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763077804; cv=none; b=rRg9OzxMIGTN9SwbEUKhTySu/NoyL7Id3o2agJu3pSyJEOBCSyXjnh0BUZcfMl8478/eDM0+BcZvDxurlfI8XJxjoNfOdpCoTlL3C/59mnwNegqiAtMphp93cFHauyql4U/2IpEyx6GudOKs9zwB/QzYb0yka+VZ8dDnbMzEvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763077804; c=relaxed/simple;
	bh=IDKxlzVjrefWyz/H4ssdg5q9tdJll2vCGct4mXcfE4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRuFSA05RNGXdc9f0FtxNT7nsyMlzXliNdLLPmsrP4CrBO6FxYskMraojrn8FqZ3yZRCETnmaMU3Cj2K+kC92lXYa5HDk79LPoI7/32R4V5kpQd/n07MHDlVanWgxNieWhtu+0sTHtQSdPIwaVIYzF0tDvqsXey74Mb08ZJnL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=GYuBWMBU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSTYKp8f; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6B547A00FB;
	Thu, 13 Nov 2025 18:49:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Nov 2025 18:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763077799;
	 x=1763164199; bh=IFomChhFXEns0wsaO2ySlwH36MDegGIFbQ6C1oBCo2U=; b=
	GYuBWMBUmeS5UkN7q+iofeA03gOf/1KMrKP/fJRzj+wcWzRfaNkCJb7pSbY1GpMd
	ocXs6tVcTTBxh4M2XzZsgEGOWm5UEIx+6XttqSBbVRVNJ2BOR0J2enVk6M07bA6m
	OnJUPFJQ29RQDZMYDGeTZXG3Sit50Z9AN+dcetQO7ipU/Ui+Gbkyz/PnW6cG6QRI
	d/gXQ8Bu30uuOp5K5qKJ+4im8FIJHXVqDC7xLSv3FdMCchtbrSYBp4/ikozLyL08
	SlufIJq02Fu0eUtwTMIPgwagfCnMaWHDOKvSO694/cr6rdIlMVYGrcETA/vBPJjf
	YT3CI55tEXzW1UthfxPTTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763077799; x=
	1763164199; bh=IFomChhFXEns0wsaO2ySlwH36MDegGIFbQ6C1oBCo2U=; b=Y
	STYKp8ftz+KVRP1axU51dEpgf0R35yFxxVOPezFQCOORHIRUUbB2gCAMrfqlHaOW
	BRGv+DAtZ5O51yQ6bdmY0AKfFPq6T8XU0AhTZlvrHc4gn/Pi9iTFDFNt06IxOGSr
	nM+UeVZIIDDd1F1GOimrHNEbA0i59AhBxKlD06tWenOxZkLCKzjZ3Dm9KUhQhKHS
	AAvQcC3A0sB7G8PZc5765vKcCE+VO+FhDL6h30ay6mP3kXOkfLjMlJrx+90hyNVV
	n+zqbVYYrebTZo8pCcQ42NhhAi+SWUelgSKr7l/c/Yq5N8QytPFia0a6TdjrvaXL
	Ods9xCzNSbOIV2Cuf/jDQ==
X-ME-Sender: <xms:p24WaZc4v-TkSfGePfuQmJ8paxTdrwuPqdGVffVPtMAiYk1cyJXGEQ>
    <xme:p24WaQgyZDNjzTs_5iAj5VOKF3e0TG-kpliAz0cK5sZO1OqjICS8wyYCSyTKOiQ5M
    KARbAt3ibIKwJdbF5DsBVUWdvpxoTSgaqYCakxwhfLr5nuf>
X-ME-Received: <xmr:p24WaZxMclyo2WRPJIbD6E6L3Sta_GPE-cMzeeUoSJVuTjlVCy3trr8V0SpNzQ3jf4lA_i2T004rLABHDC71pE8iDU6Nq6S3_xoZrrNeOMBctJk0YTZJDSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdekfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:p24WaUPlfoRH2RtTynYGNkg_z_F_xscZOou1alnEt2-L_vT9KOGokw>
    <xmx:p24WaSVGzu2uCncqWv9-W0qBZ4BtlglC24HsRMY7CvAmECeXISHS2A>
    <xmx:p24WaQ0gw1Jnvr7Y9mQkAOkPYJdd6fnWQIvbeftbKaKxZuKx-Oelww>
    <xmx:p24WaYovIElQtxcp0iDCHiCH698K0R98ZJ5Eec6BX6dXRbKUVgRK1Q>
    <xmx:p24WaTI3w8xTaWTDgQLJhBr-hSKri2h7NIrok0-Swa5ah6KPBFcXOuFS>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 18:49:57 -0500 (EST)
Message-ID: <7e040a12-3070-4fad-8b1a-985e71426d41@themaw.net>
Date: Fri, 14 Nov 2025 07:49:53 +0800
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
 <0dfa7fc6-3a15-4adc-ad1d-81bb43f62919@themaw.net>
 <20251113-gechartert-klargemacht-542a0630c88b@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251113-gechartert-klargemacht-542a0630c88b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/25 21:19, Christian Brauner wrote:
> On Thu, Nov 13, 2025 at 08:14:36AM +0800, Ian Kent wrote:
>> On 12/11/25 19:01, Christian Brauner wrote:
>>> On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
>>>> On 11/11/25 18:55, Christian Brauner wrote:
>>>>> On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
>>>>>> On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
>>>>>>
>>>>>>>> +	sbi->owner = current->nsproxy->mnt_ns;
>>>>>>> ns_ref_get()
>>>>>>> Can be called directly on the mount namespace.
>>>>>> ... and would leak all mounts in the mount tree, unless I'm missing
>>>>>> something subtle.
>>>>> Right, I thought you actually wanted to pin it.
>>>>> Anyway, you could take a passive reference but I think that's nonsense
>>>>> as well. The following should do it:
>>>> Right, I'll need to think about this for a little while, I did think
>>>>
>>>> of using an id for the comparison but I diverged down the wrong path so
>>>>
>>>> this is a very welcome suggestion. There's still the handling of where
>>>>
>>>> the daemon goes away (crash or SIGKILL, yes people deliberately do this
>>>>
>>>> at times, think simulated disaster recovery) which I've missed in this
>>> Can you describe the problem in more detail and I'm happy to help you
>>> out here. I don't yet understand what the issue is.
>> I thought the patch description was ok but I'll certainly try.
> I'm sorry, we're talking past each other: I was interested in your
> SIGKILL problem when the daemon crashes. You seemed to say that you
> needed additional changes for that case. So I'm trying to understand
> what the fundamental additional problem is with a crashing daemon that
> would require additional changes here.

Right, sorry.

It's pretty straight forward.


If the daemon is shutdown (or killed summarily) and there are busy

mounts left mounted then when started again they are "re-connected to"

by the newly running daemon. So there's a need to update the mnt_ns_id in

the ioctl that is used to set the new pipefd.


I can't provide a patch fragment because I didn't realise the id in 
ns_common

was added a your recent patch series and I briefly went down a path 
trying to

compile against 6.16.7 before I realised I hadn't been paying attention.


The setting needs to be put in 
fs/autofs/dev-ioctl.c:autofs_dev_ioctl_setpipefd().


Ian

>
>>
>> Consider using automount in a container.
>>
>>
>> For people to use autofs in a container either automount(8) in the init
>>
>> mount namespace or an independently running automount(8) entirely within
>>
>> the container can be used. The later is done by adding a volume option
>>
>> (or options) to the container to essentially bind mount the autofs mount
>>
>> into the container and the option syntax allows the volume to be set
>>
>> propagation slave if it is not already set by default (shared is bad,
>>
>> the automounts must not propagate back to where they came from). If the
>>
>> automount(8) instance is entirely within the container that also works
>>
>> fine as everything is isolated within the container (no volume options
>>
>> are needed).
>>
>>
>> Now with unshare(1) (and there are other problematic cases, I think systemd
>>
>> private temp gets caught here too) where using something like "unshare -Urm"
>>
>> will create a mount namespace that includes any autofs mounts and sets them
>>
>> propagation private. These mounts cannot be unmounted within the mount
>>
>> namepsace by the namespace creator and accessing a directory within the
> Right, but that should only be true for unprivileged containers where we
> lock mounts at copy_mnt_ns().
>
>> autofs mount will trigger a callback to automount(8) in the init namespace
>>
>> which mounts the requested mount. But the newly created mount namespace is
>>
>> propagation private so the process in the new mount namespace loops around
>>
>> sending mount requests that cannot be satisfied. The odd thing is that on
>> the
>>
>> second callback to automount(8) returns an error which does complete the
>>
>> ->d_automount() call but doesn't seem to result in breaking the loop in
>>
>> __traverse_mounts() for some unknown reason. One way to resolve this is to
>>
>> check if the mount can be satisfied and if not bail out immediately and
>>
>> returning an error in this case does work.
> Yes, that's sensible. And fwiw, I think for private mounts that's the
> semantics you want. You have disconnected from the "managing" mount
> namespace - for lack of a better phrase - so you shouldn't get the mount
> events.
>
>> I was tempted to work out how to not include the autofs mounts in the cloned
>>
>> namespace but that's file system specific code in the VFS which is not ok
>> and
>>
>> it (should) also be possible for the namespace creator to "mount
>> --make-shared"
>>
>> in the case the creator wants the mount to function and this would prevent
>> that.
>>
>> So I don't think this is the right thing to do.
>>
>>
>> There's also the inability of the mount namespace creator to umount the
>> autofs
>>
>> mount which could also resolve the problem which I haven't looked into yet.
> Ok, again, that should only be an issue with unprivileged mount
> namespaces, i.e., owned by another user namespace. This isn't easily
> doable. If the unprivileged mount namespaces can unmount the automount
> it might reveal hidden/overmounted directories that weren't supposed to
> be exposed to the container - I hate these semantics btw.
>
>>
>> Have I made sense?
> Yes, though that's not the question I tried to ask you. :)
>
>>
>> Clearly there's nothing on autofs itself and why one would want to use it
>>
>> but I don't think that matters for the description.
>>
>>
>> Ian
>>

