Return-Path: <linux-fsdevel+bounces-26871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D795C4D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAB61C2382B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806526A022;
	Fri, 23 Aug 2024 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JGJmwxWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA255E53;
	Fri, 23 Aug 2024 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390605; cv=none; b=Wgi3iGyM7lOTBaDd9KxpuPiYI6mh+L3i3QPTnsvYMS2nEb/E2tAOCSWYrqhq1dC4IuA1laedK3rlJDUjFIC0Ly8skXh14yzxxRCckPUaVTuBRw+R3m1y6dEXXQhM6QuhmGCsVIu98UaXaYd2TpQ+4e2tWi2dBMzSwkg6VLy3vEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390605; c=relaxed/simple;
	bh=ptkDJuB4wN9LbPHBE9yxjtR4r1HRV4cAD6INkJxUbkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciiTRgqIG9ycncMU1IMSEBR6tvxAMuXKvH9rK8yhSQhqYGcbIMojFGKSmuLuoB7ZblLEUv67CKRNmeyvcALnynbtb949b1LexUgfZtcWW3FawrUX000T04O3d1w99Pn7Ig5o/dZ42NGaKcECVtK/pHAJYjW3ds+6z2parKZMJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JGJmwxWw; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=wSIT3l0Rz2s5QcxaavD9w3qriHdaS0mTvhZFg3F9mOY=;
	t=1724390603; x=1724822603; b=JGJmwxWwPODZCpkWM4XOl/ZxNH9wtN+TdaL5JGD0zrTOWaN
	9AttkRu+vvPIyZ/9jHgC5Kwc1N6RVuVW151tjVP7uBi3hnItjCdBSzaf3hbuV8Bxi9TnWAba63af3
	NWtP0UxJua/Wx+QOERrHFK+2RwPu9m8tBOzKovqpTlse/zpZP5h4LTrjZx9fcUTIyQvSK5xBOZLhH
	iDue+wI+jZT2dydMSyaAuqMm8SLR+sg+HlYQgWsu6kdegurOdoEafudojEwdLNAtLu7xDognPOOey
	WoQ06XdJ9l13MQzQ8pmV4f5SX3yfh0Je9mmBHygyQfh39SPYEvtQD2tWMZbklA3Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1shMlX-0005Py-LR; Fri, 23 Aug 2024 07:23:15 +0200
Message-ID: <93296f30-1a3c-44b6-91d1-61408e1d9270@leemhuis.info>
Date: Fri, 23 Aug 2024 07:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Tycho Andersen <tandersen@netflix.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain>
 <20240819-staudamm-rederei-cb7092f54e76@brauner>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240819-staudamm-rederei-cb7092f54e76@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1724390603;21903e02;
X-HE-SMSGID: 1shMlX-0005Py-LR

On 19.08.24 10:41, Christian Brauner wrote:
> On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
>> On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
>>> It's currently possible to create pidfds for kthreads but it is unclear
>>> what that is supposed to mean. Until we have use-cases for it and we
>>> figured out what behavior we want block the creation of pidfds for
>>> kthreads.
>>>
>>> Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> ---
>>>  kernel/fork.c | 25 ++++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> Unfortunately this commit broke systemd-shutdown's ability to kill processes,
>> which makes some filesystems no longer get unmounted at shutdown.
>>
>> It looks like systemd-shutdown relies on being able to create a pidfd for any
>> process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
>> fatal error and stops looking for more processes...
> 
> Thanks for the report!
> I talked to Daan De Meyer who made that change and he said that this
> must a systemd version that hasn't gotten his fixes yet. In any case, if
> this causes regression then I'll revert it right now. See the appended
> revert.

Greg, Sasha, JFYI in case you are not already aware of it: I by
chance[1] noticed that the patch Christian plans to revert is still in
the 6.10-queue. You might want to drop it (or apply the revert as well,
which is in -next, but not yet in mainline afaics).

Ciao, Thorsten

[1] after I noticed this thread a third time, this time via some SELinux
problems it caused in Fedora land:
https://bugzilla.redhat.com/show_bug.cgi?id=2306818
https://bugzilla.redhat.com/show_bug.cgi?id=2305270

