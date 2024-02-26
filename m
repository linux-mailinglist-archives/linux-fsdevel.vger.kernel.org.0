Return-Path: <linux-fsdevel+bounces-12750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD08669BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 06:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80228281BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854B1B968;
	Mon, 26 Feb 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IVgxQX5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294A18B1A;
	Mon, 26 Feb 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926860; cv=none; b=DXFZu/ghcKv+zvXrb0jdQJ2QaSng/8IT0b8GMXf97gz2z9l5Wxiis8Y2klywSVpUcnWTx4Egc52w0eBW5tPbFpl6Njd7qKlvRl21BJyJXgQh5DsbDmLFm5dsP2iYIy0qKHG6QKewnEpFrV9S0pbETasR83abNBS/7SCfsnJCkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926860; c=relaxed/simple;
	bh=ziO5kqnT5u7rj2sL7Ro1i1857NkKBcyWaJgBElXIe/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzu0Fbpc/fONdJ7BPejR8Sjpw9rEzUEzg7hEGDxeSEvVvZYM/caMpkKU2HbOyxsPRI9QZ5dC6mVqluqIjYLmBeC+jcDabq2HpHd43Gb91/WpQV5+uJv851sGzgh9KLNlVnv0IJP92TWUuhlEDU9gbT359EKaShxjdfKtwegVbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IVgxQX5Q; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ziO5kqnT5u7rj2sL7Ro1i1857NkKBcyWaJgBElXIe/Y=;
	t=1708926858; x=1709358858; b=IVgxQX5QfB3GWPM5oFteva3LL+zb888O4EIhXCegTEDBpTO
	2AZR+sfOnhU5dnfkzROmcIDQWF7KB5wnH3HZ5Sn/2Q+6d3KY/5FwCrebK5OunumJ+wqJBNW8CpNOn
	3az4JE6/8T5aVjs3/Jb0RbudjRcDpF8JnOGxt9lPK3ikUQ3Ctj2DL2Ub0EkxLIuv4ObUUZhJkIG4M
	0PS8rgxJ2Qss4n3MQVjolBLvggVpTxs/VLAaVLEEa4Hej2btts2QVU1r0wcHK1aScwViiZuHGPj/B
	OFae+wi2FNd3sXGzCQS+jWTxP3BmSyy1qJH1cVRFmPaQqt7IaJVuvHI/NzhIm1EQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1reTwM-0007nl-6e; Mon, 26 Feb 2024 06:54:14 +0100
Message-ID: <ebcdfcf3-e63d-43c3-a770-d87678282cdf@leemhuis.info>
Date: Mon, 26 Feb 2024 06:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Content-Language: en-US, de-DE
To: Kees Cook <keescook@chromium.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jan Bujak <j@exia.io>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
 <202401221339.85DBD3931@keescook>
 <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>
 <202402041526.23118AD@keescook>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <202402041526.23118AD@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708926858;6d7274d8;
X-HE-SMSGID: 1reTwM-0007nl-6e

On 05.02.24 00:27, Kees Cook wrote:
> On Thu, Feb 01, 2024 at 11:47:02AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Eric, what's the status wrt. to this regression? Things from here look
>> stalled, but I might be missing something.
>>
> If Eric doesn't beat me to it, I'm hoping to look at this more this
> coming week.

Friendly reminder that this regression is still out there, as it seems
things stalled. Or was there some progress or even a fix? Then please
tell me!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


