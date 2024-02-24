Return-Path: <linux-fsdevel+bounces-12655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F8862341
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 08:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3222848D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D988F66;
	Sat, 24 Feb 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aOxtT090"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610384C64;
	Sat, 24 Feb 2024 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708758042; cv=none; b=TH46GksPb1+YLf0S1+QC2J1gflTDAfnHjr7L3M5iM8535VdkMevNIu6ztQhd6Tqwv8wq5IXQbKtosaCCtfvS+8jCsvvaDRUTp9lMyhhHD/yJ/sPgHKt9goZfDqVWdFyjiNmZtycqh4F2dZV25FwhNn23lfyQ2WyDFSRRgRSWEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708758042; c=relaxed/simple;
	bh=274OjcGhqqvLhljdp6duAIrxTZju4G8b8t5E2V8XKyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=urJshLi394o5xqXH5t/RauKJl/AgXVZB/x11Nr7FzM6ZKKAmsOFHjQ5PgccwkCUnXFkszUwW4o0czGNrY21O5w3Ww2xTFyr0+uoG4JVxRDcvMVY/N52D4eBj2tzR+LZqk8lzgCJ1CD7Yg1dBQ+/2qh2zwRddRzaUb9ZioMA73cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aOxtT090; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=6ZLkgbwJWG402shRNmQgM7t1ff3qC1484QmYAQ5fASg=;
	t=1708758040; x=1709190040; b=aOxtT090ER9I8s0iDfJtuITcUaGIW798t3m70YE9LBr9jU/
	J74s2/kC5ZNNS56rbpiju5mSyysseh/uayLJzACYr9Xk8WSErcQMMdVPthL1hZ3R7bNJWe4T1zcug
	qRqvBhuggr920MCLNc65zX75xEmmg67KH6k9hKSrVw5CEU1M3kF8ckLznE9+dv7/k9tqZ1kcHleBE
	sszMc1yCNL+7mjtpPppXY8iWVOyCPFsDum+pHs+rPcea71m04CtCHbmeI16JMqXLB9Z4hSQeA806q
	pKdAUVyyi2FKhQdxA+7KzuiUoOJrT4/7p4W2WYPeYCXO2h5ibtdVXjGC98Vk9+hg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rdm1M-00042C-Ez; Sat, 24 Feb 2024 08:00:28 +0100
Message-ID: <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
Date: Sat, 24 Feb 2024 08:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Heon <mheon@redhat.com>, Ed Santiago <santiago@redhat.com>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paul Holzinger <pholzing@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com>
 <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
 <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
In-Reply-To: <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708758040;08c21b20;
X-HE-SMSGID: 1rdm1M-00042C-Ez

On 21.02.24 17:32, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding Al, Christian and a few lists to the list of recipients to
> ensure all affected parties are aware of this new report about a bug for
> which a fix is committed, but not yet mainlined]
> 
> Thread starts here:
> https://lore.kernel.org/all/6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com/

[adding Linus now as well]

TWIMC, the quoted mail apparently did not get delivered to Al (I got a
"48 hours on the queue" warning from my hoster's MTA ~10 hours ago).

Ohh, and there is some suspicion that the problem Calvin[1] and Paul
(this thread, see quote below for the gist) encountered also causes
problems for bwrap (used by Flapak)[2].
[1] https://lore.kernel.org/all/ZcKOGpTXnlmfplGR@gmail.com/
[2] https://github.com/containers/bubblewrap/issues/620

Christian, Linus, all that makes me wonder if it might be wise to pick
up the revert[1] Al queued directly in case Al does not submit a PR
today or tomorrow for -rc6.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=fixes&id=7e4a205fe56b9092f0143dad6aa5fee081139b09

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> On 21.02.24 16:56, Paul Holzinger wrote:
>> Hi Thorsten,
>>
>> On 21/02/2024 15:42, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 21.02.24 15:31, Paul Holzinger wrote:
>>>> On 21/02/2024 15:20, Paul Holzinger wrote:
>>>>> we are seeing problems with the 6.8-rc kernels[1] in our CI systems,
>>>>> we see random process timeouts across our test suite. It appears that
>>>>> sometimes a process is unable to exit, nothing happens even if we send
>>>>> SIGKILL and instead the process consumes a lof of cpu.
>>>> [...]
>>> Thx for the report.
>>>
>>> Warning, this is not my area of expertise, so this might send you in the
>>> totally wrong direction.
>>>
>>> I briefly checked lore for similar reports and noticed this one when I
>>> searched for shrink_dcache_parent:
>>>
>>> https://lore.kernel.org/all/ZcKOGpTXnlmfplGR@gmail.com/
>>
>>> Do you think that might be related? A fix for this is pending in vfs.git.
>>>
>> yes that does seem very relevant. Running the sysrq command I get the
>> same backtrace as the reporter there so I think it is fair to assume
>> this is the same bug. Looking forward to get the fix into mainline.
> 
> FWIW, "the fix" afaics is 7e4a205fe56b90 ("Revert "get rid of
> DCACHE_GENOCIDE"") sitting 'fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for more than
> a week now.
> 
> I assume Al or Christian will send this to Linus soon. Christian in fact
> already mentioned that he plans to send another vfs fix to Linux, but
> that one iirc was sitting in another repo (but I might be mistaken there!).
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: let me update regzbot while at it:
> 
> #regzbot introduced 57851607326a2beef21e67f83f4f53a90df8445a.
> #regzbot fix: Revert "get rid of DCACHE_GENOCIDE"

