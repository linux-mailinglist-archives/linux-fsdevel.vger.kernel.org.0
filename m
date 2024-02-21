Return-Path: <linux-fsdevel+bounces-12278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C590085E36D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7312C1F226D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4082D97;
	Wed, 21 Feb 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IgAevZrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8B7F7D7;
	Wed, 21 Feb 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533144; cv=none; b=HSmchMMHwLSsVPGCvkk/ZMlkkCcoZ32hEjKNhXF12k8O8gOh12PU/qiTM6eJQ51dJlz03GRblXVncyr2fwe44+W7L3wmXXN/cPgY6tlhk9ou7RcLduw9FVo1bklq95GjVECHdltrvyoDjWRt/8lU6LVo4GHeqiX0ww1dG3bgVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533144; c=relaxed/simple;
	bh=1MY42GYKeQl4pBf7/EpDY2KnlbZje5n89I21J5Mggok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b34JyFsRaAQDJuCktAJuoKOVHvIoxe2bKsf1/SG8C0aUA6a7An6qQRlkuP7cH5wcw1kklaSwdqpxA6hoPGs4o2MiC8rKsLjK6koAfu7wywT1q9FAgxGtOfAgvFbc4CuXa3Z9BC9K+PCC2gY3W3N6dkyg8FAoF3EfwTKVTqo3/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IgAevZrJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=dXUkax5DrpcQGAUD0QqUBnpDaiAKU5xWauNGdR5FkxU=;
	t=1708533142; x=1708965142; b=IgAevZrJR4+ZulADgkjxkwhuKB9ENyHLSjYjH1Cogk+MDb2
	zLAJiVk74kTdtVDeN8BhOU1OZ8fA2HJArtnUi4zLWlkxj6d4Dy/iZ1lJH94c6dd/fjJnmDF4XolpA
	FERJE6xyGnx5Qk27YrOysPonWxZZ1BBjXWjXbHtkq9US1dQuIRzwoSPpfWHvQwOv7ClW1+N4lAQIC
	hEylfHEjl7UGS/qmDmFmnYGX8h3NaljvUJWDsTRomOke3d1YfFAje1ZoWkVDxq56jlEylSc2DQwrM
	xiTy7kJjcn0/oymnmVvFZQxp3DKnB6UesS22fMzk7+2oX6SKcjRpXQVlqUpI6eWg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rcpW4-0003Ls-DQ; Wed, 21 Feb 2024 17:32:16 +0100
Message-ID: <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
Date: Wed, 21 Feb 2024 17:32:15 +0100
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
To: "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Matt Heon <mheon@redhat.com>, Ed Santiago <santiago@redhat.com>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paul Holzinger <pholzing@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com>
 <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708533142;e4797df2;
X-HE-SMSGID: 1rcpW4-0003Ls-DQ

[adding Al, Christian and a few lists to the list of recipients to
ensure all affected parties are aware of this new report about a bug for
which a fix is committed, but not yet mainlined]

Thread starts here:
https://lore.kernel.org/all/6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com/

On 21.02.24 16:56, Paul Holzinger wrote:
> Hi Thorsten,
> 
> On 21/02/2024 15:42, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 21.02.24 15:31, Paul Holzinger wrote:
>>> On 21/02/2024 15:20, Paul Holzinger wrote:
>>>> we are seeing problems with the 6.8-rc kernels[1] in our CI systems,
>>>> we see random process timeouts across our test suite. It appears that
>>>> sometimes a process is unable to exit, nothing happens even if we send
>>>> SIGKILL and instead the process consumes a lof of cpu.
>>> [...]
>> Thx for the report.
>>
>> Warning, this is not my area of expertise, so this might send you in the
>> totally wrong direction.
>>
>> I briefly checked lore for similar reports and noticed this one when I
>> searched for shrink_dcache_parent:
>>
>> https://lore.kernel.org/all/ZcKOGpTXnlmfplGR@gmail.com/
>
>> Do you think that might be related? A fix for this is pending in vfs.git.
>>
> yes that does seem very relevant. Running the sysrq command I get the
> same backtrace as the reporter there so I think it is fair to assume
> this is the same bug. Looking forward to get the fix into mainline.

FWIW, "the fix" afaics is 7e4a205fe56b90 ("Revert "get rid of
DCACHE_GENOCIDE"") sitting 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for more than
a week now.

I assume Al or Christian will send this to Linus soon. Christian in fact
already mentioned that he plans to send another vfs fix to Linux, but
that one iirc was sitting in another repo (but I might be mistaken there!).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me update regzbot while at it:

#regzbot introduced 57851607326a2beef21e67f83f4f53a90df8445a.
#regzbot fix: Revert "get rid of DCACHE_GENOCIDE"

