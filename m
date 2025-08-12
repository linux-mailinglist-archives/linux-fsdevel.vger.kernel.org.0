Return-Path: <linux-fsdevel+bounces-57461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4476B21EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5038C683EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14A2D4809;
	Tue, 12 Aug 2025 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="ynjNOlEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5029BD9D;
	Tue, 12 Aug 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981953; cv=none; b=fXpjszmyNn/TwE2r2HzVTPq94n4t1WV530nc+U7QR5euPGfAlLDloHrPK+wKKL3rGmrwi+q4o0WZmE28Lwn6gfuSDVxayZH2Q2oRz9jGK4aIhjHLgCzasoIIUEBa46tn7YVnWkroj4PhRtshBMNfpNMJGL2o+VGr/mSLgf8ZH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981953; c=relaxed/simple;
	bh=9UEi0vvuOxe0cr2zQrxpGVKvfEJkEHlbCm1OGHsA1wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsmVrHC5RVKF7fh/9iDKw1yftRhE/o1MYdDcJZc+gYijBczODiLo46EObY+ZRKK3bd33urEi7TLSpAVt6Mf/m4I/6Cq2QdGNGQlt8lpFWDpWX9tpv8Z+H1TSBMoNwZ63QV15zBf7yjyb6sGnZoRJXlQE2egUgLwZjzkYm076I6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=ynjNOlEP; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
Message-ID: <c1516337-a681-40be-b3f1-4d1e5290cbff@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1754981565; bh=9UEi0vvuOxe0cr2zQrxpGVKvfEJkEHlbCm1OGHsA1wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ynjNOlEP0J2AkEcvfa+sSvfln71FiRWiceor5/01D27L9/9oEDJSzvrTCC6az6z8J
	 aRN0/N10onNqzJYDa+L49iY1biwSqn+QYMh3QbryooHCFdnEvNwftLofL+/SZ99Msq
	 GmGZet5EerUtugzAYFxJWvNVuHrpm+xY0kkJBAM8ETfgL4Laeu9AgwAbbH8jMHjvRU
	 tRTvx/Z9LNXmQXgZU1M25Q6e7N++95jujyEQpZTY/XdDHTWV8Tqg/SKe/y7rfTwcIZ
	 GBF1qHSIsgv0SY1iATPmI2ZtgWuZqS10xuYJvvGKfBs/aIK0wb1X39QGFBsxSaGuZ3
	 p2xBhgiA1JwiQ==
Date: Tue, 12 Aug 2025 03:52:39 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de,
 torvalds@linux-foundation.org
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
Content-Language: en-US
From: asdx <asdx52@cock.li>
In-Reply-To: <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/11/25 11:26 AM, Kent Overstreet wrote:
> On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
>>>   Yes, this is accurate. I've been getting entirely too many emails from Linus about
>>> how pissed off everyone is, completely absent of details - or anything engineering
>>> related, for that matter.
>> That's because this is not an engineering problem, it's a communication problem. You just piss
>> people off for no good reason. Then people get tired of dealing with you and now we're here,
>> with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
>> Will your sponsors be happy? Probably not either. Then why are you keep doing this?
>>
>> If you really want to change the way things work go see a therapist. A competent enough doctor
>> probably can fix all that in a couple of months.
> Konstantin, please tell me what you're basing this on.
>
> The claims I've been hearing have simply lacked any kind of specifics;
> if there's people I'd pissed off for no reason, I would've been happy to
> apologize, but I'm not aware of the incidences you're claiming - not
> within a year or more; I have made real efforts to tone things down.
>
You keep lying. How can you be so cynical? Just two days ago you were
complaining on #bcache about how much control Linus has over Linux and there
was a lot of talk about getting him removed from Linux via CoC action.

All you do is act in bad faith and when you get called out for your nonsense,
you resort to playing the victim.

You are not fooling anyone anymore.


