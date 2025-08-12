Return-Path: <linux-fsdevel+bounces-57463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7055B21F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021EA1719F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35542D8376;
	Tue, 12 Aug 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="IYsQGkEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5A311C28;
	Tue, 12 Aug 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983044; cv=none; b=X+qzS3VuJTxdfkaY77Pzl8jr0UJ9zjFbVfSZpSGGI44Zrm1mq6IUNgEeDe7zwvLhxwAqMfYNi43PXL4YI0T/ymBtScSQ1CvYOjpAeQsMc3YM+dx2fSIrrO5j0GPOf0mf/mC9Oak8XB3e+1ZrQQ8RUZu4cAVFX7jN4mFY1ScemUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983044; c=relaxed/simple;
	bh=Nw5DXZD4EG15mYMBDrHw8FvaFfajl4SMYn2QjYQl9ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGIm/pCnwswczWS5yvnLIPRnHW2taaWzgz4lE5uYW8t7J4ZAh/N/uYyNmMFL/sC4QWkg9InP1Abp8kisisDb0akLu30CIuH/TuP0LHPY8h+g7QqVhPJA43aMyhKoCmAkbM/7JP988vqAKUY9SijRY3i+Q5dSlkBKEnMKpet+Rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=IYsQGkEF; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
Message-ID: <9e81bbfd-1688-46bd-bf38-252fed3b1c82@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1754983034; bh=Nw5DXZD4EG15mYMBDrHw8FvaFfajl4SMYn2QjYQl9ME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IYsQGkEFxANswCrL89YQRKOb2KF/WB6jiMguv7n7IhNDwJLQhjqRfH9ftl1DZhVCj
	 2Q8/sDb7QHhl/z/LxypbrU3X61l67JwvqoBpNaZf4JhqNSGDWQzfqQUIYmWnKHyz4i
	 HPVbzkhdNMYfBh7m/rtAceCkQl95n/HsafkoviZaitA+rAvfcegFX8LVpGll7tB1lN
	 tBsoyjzta8bFvSmGT7Ps6ODN+D44b500mYrBBZNTChPaliwGlyq4ADKByU9OcnSbVu
	 rQ5M1HUjFdZBEVA6MV0nNRw7rGurbd/yJQaSynvdP71QJ1qQS++nZhx3idbgVG1VyE
	 y5wMknNvVcotw==
Date: Tue, 12 Aug 2025 04:17:07 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, list-bcachefs@carlthompson.net,
 malte.schroeder@tnxip.de, torvalds@linux-foundation.org
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <c1516337-a681-40be-b3f1-4d1e5290cbff@cock.li>
 <rabpjlpydnsnlkrgqmolvgg5tyo2kk5v45evwdt6ffetsqynfy@dt2r3cxio5my>
Content-Language: en-US
From: asdx <asdx52@cock.li>
In-Reply-To: <rabpjlpydnsnlkrgqmolvgg5tyo2kk5v45evwdt6ffetsqynfy@dt2r3cxio5my>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/12/25 4:04 AM, Kent Overstreet wrote:
> On Tue, Aug 12, 2025 at 03:52:39AM -0300, asdx wrote:
>> On 8/11/25 11:26 AM, Kent Overstreet wrote:
>>> On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
>>>>>    Yes, this is accurate. I've been getting entirely too many emails from Linus about
>>>>> how pissed off everyone is, completely absent of details - or anything engineering
>>>>> related, for that matter.
>>>> That's because this is not an engineering problem, it's a communication problem. You just piss
>>>> people off for no good reason. Then people get tired of dealing with you and now we're here,
>>>> with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be happy? Probably not.
>>>> Will your sponsors be happy? Probably not either. Then why are you keep doing this?
>>>>
>>>> If you really want to change the way things work go see a therapist. A competent enough doctor
>>>> probably can fix all that in a couple of months.
>>> Konstantin, please tell me what you're basing this on.
>>>
>>> The claims I've been hearing have simply lacked any kind of specifics;
>>> if there's people I'd pissed off for no reason, I would've been happy to
>>> apologize, but I'm not aware of the incidences you're claiming - not
>>> within a year or more; I have made real efforts to tone things down.
>>>
>> You keep lying. How can you be so cynical? Just two days ago you were
>> complaining on #bcache about how much control Linus has over Linux and there
>> was a lot of talk about getting him removed from Linux via CoC action.
> Are you the same guy who was just posting this on Phoronix? Either
> you're trolling, or you misread something.
>
> For the record, I'm one of the more anti CoC people out there - I agree
> with the spirit of their goals, not so much the approach. I would never
> invoke them on anyone; I prefer to talk things out (and I don't mind
> getting flamed, so long as it doesn't get in the way of the work).

I read your messages well.

Linus Torvalds is way more valuable than bcachefs. Please back off.


