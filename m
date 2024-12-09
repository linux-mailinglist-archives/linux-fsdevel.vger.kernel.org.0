Return-Path: <linux-fsdevel+bounces-36800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4009E97B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3741658F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269781ACEDB;
	Mon,  9 Dec 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="FaqG34c3";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="aqJwxI57";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="IMKixPO9";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="J2d5c4as"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0D1F0E21
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751976; cv=none; b=MSyy7eR4qe2RT5wPHr/tXw51UVC4f2t3JcBezDuvPETF0LJxAd2MjcT7eewmT1z+QKsz4+8y+uEFFAWqjJ+NwTxo6CDNVzWJJ1QjPa2A/l/cxp+BFYbfAVb496rjEVBGV/zynFde3k87T48SFTmGql5W2LL4zAdKwYEgrXGDAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751976; c=relaxed/simple;
	bh=Q7OeVaq8fPsS2cnXoVYh17B7MOxtyBwaJAtsUEf6n3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhMiC8ByvJ0pNQEa0xuDItIpE9ALQUk78PEetaI9wQmZjCxchC5oaU90x3dEzfHe+ZMvjvQ5gh5/TP/s9+TXGXAbMeDbPCozVxwYb9CDw4tXx59QotICf5Gxd1KX/BPU7hnmG6HZJiLjRrw0l7KAPBVJxBWoAtCe1b4nCVB8HvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=FaqG34c3; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=aqJwxI57; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=IMKixPO9; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=J2d5c4as; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:ac35:d9bc:6ccc:da57])
	by mail.tnxip.de (Postfix) with ESMTPS id 07C68208CC;
	Mon,  9 Dec 2024 14:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1733751963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QnlLzmzyFUbgEtSoqUtK4h/uKLvunG6yc8EmWJJ4+k=;
	b=FaqG34c3I2raknQa68q2KCoGiFO/kaxoAw7QhryJbl72FebJdtputjatJGPxA7Majscbwb
	DLKlsLhckUPoFtbUcrPWnqN7x3a5ZKgu/BdKufKaRNnWWfEJBWQVxBzQMIIpWldyEi1akU
	wLcCvmjb4GaN6tD7YDzBLwkeBsI5dL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1733751963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QnlLzmzyFUbgEtSoqUtK4h/uKLvunG6yc8EmWJJ4+k=;
	b=aqJwxI57SULpWS4U5f/rGnXBzHqx2lvHrsqcc2LCrAd9M58iG5QshPVfmzpKKDuAij8uwu
	us/YsZJCXYOtqyAg==
Received: from [192.168.1.99] (_gateway [192.168.1.10])
	by gw.tnxip.de (Postfix) with ESMTPSA id 76AFC500FFC7C;
	Mon, 09 Dec 2024 14:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1733751957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QnlLzmzyFUbgEtSoqUtK4h/uKLvunG6yc8EmWJJ4+k=;
	b=IMKixPO9hYwkVI75REhonEUnorEPi7VNvyXqJJDw9yYen7l5kFMqJJ9d7kgauiqkamSZnJ
	wrpGT17EapQYRKQg0xj9X0QaE1eNLRJGuOwwGBm+MiMRBQfq4xLnPfucsQVh5x30BzoBwS
	HVHeFguJXpVSI61Hl6w4+2S5bPpuBmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1733751957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QnlLzmzyFUbgEtSoqUtK4h/uKLvunG6yc8EmWJJ4+k=;
	b=J2d5c4asncc2dGLPw2h9OXqXRkzyzXPHDLCjyA4LvtHwhIwObSOBmq+2NpOn+ECjlSg/fL
	IeAFgLG7QvoNWeDA==
Message-ID: <5feec55c-c7a0-4d4c-8634-0d99810aec6b@tnxip.de>
Date: Mon, 9 Dec 2024 14:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: silent data corruption in fuse in rc1
To: Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
 <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
 <0c7205c3-f2f2-4400-8b1c-3adda48fdeab@bsbernd.com>
 <77b6c012-8779-4bf8-a034-11b9ee93d1fb@tnxip.de>
 <29ce110b-aa47-4524-a038-8fd2c8e2978a@ddn.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <29ce110b-aa47-4524-a038-8fd2c8e2978a@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/12/2024 14:06, Bernd Schubert wrote:
> On 12/9/24 10:07, Malte Schröder wrote:
>> [You don't often get email from malte.schroeder@tnxip.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 09/12/2024 09:06, Bernd Schubert wrote:
>>> Hi Malte,
>>>
>>> On 12/9/24 07:42, Malte Schröder wrote:
>>>> On 09/12/2024 02:57, Jingbo Xu wrote:
>>>>> Hi, Malte
>>>>>
>>>>> On 12/9/24 6:32 AM, Malte Schröder wrote:
>>>>>> On 08/12/2024 21:02, Malte Schröder wrote:
>>>>>>> On 08/12/2024 02:23, Matthew Wilcox wrote:
>>>>>>>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>>>>>>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>>>>>>>> me.
>>>>>>>> That's a merge commit ... does the problem reproduce if you run
>>>>>>>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>>>>>>>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>>>>>>>> between those two.
>>>>>>>>
>>>>>>>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>>>>>>>> of an interaction to debug ;-(
>>>>>>> I spent half a day compiling kernels, but bisect was non-conclusive.
>>>>>>> There are some steps where the failure mode changes slightly, so this is
>>>>>>> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
>>>>>>> the nfsd-6.13 merge ...
>>>>>>>
>>>>>>> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>>>>>>>
>>>>>>> /Malte
>>>>>>>
>>>>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>>>>> with 3b97c3652d91 as the culprit.
>>>>> Would you mind checking if [1] fixes the issue?  It is a fix for
>>>>> 3b97c3652d91, though the initial report shows 3b97c3652d91 will cause
>>>>> null-ptr-deref.
>>>>>
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/all/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com/
>>>> It does not fix the issue, still behaves the same.
>>>>
>>> could you give instructions how to get the issue? Maybe we can script it and I let
>>> it run in a loop on one my systems?
>>>
>>>
>>> Thanks,
>>> Bernd
>> Sure. To reproduce I set up a VM running Arch and bcachefs as rootfs
>> (Works out of the box on current Arch). Build -rc kernel using
>> pacman-pkg build target. Try to install FreeCAD, "flatpak install
>> flathub org.freecad.FreeCAD". Usually it fails to download some
>> dependencies. It's a pretty wonky test, but I didn't find a more
>> specific way to reproduce this.
>>
> What is the relation to fuse here? pacmang-pkg or 'flatpak' are using
> fuse internally?
>
>
> Thanks,
> Bernd

Flatpak is using fuse when downloading/installing packages

/Malte


