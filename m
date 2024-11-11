Return-Path: <linux-fsdevel+bounces-34219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BB9C3DE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CAA1C21649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754E1922D6;
	Mon, 11 Nov 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="uTRR0vka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210417C91;
	Mon, 11 Nov 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326567; cv=none; b=ejiiBVg9CzryUpy8Z0gwS2Wb3Yfys8mnOacdb0iOTiDEXZZyy5JEb95VGtzrMX6SjqLnrG3P3Fmw9la3DqSySdvLorcbOuBMlQNGME+pgu+cNNaxbCoptRqvU7/Zw5C1bSKgalYUpFuzgJ420+7i/6q4DFzOiuXIpo0B01KbLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326567; c=relaxed/simple;
	bh=08sS6cwXMoWfNauUkFLNf/k9pKsznTrXfxG4nKKTWpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrWFR9EOhIqgnyb7VMZLTXmmV/T3DV7iVY6QB13A/ke3RrFI0gvUWeY0KNa6JJjsGHn66LnMuP4NiYT5AoAa8C89tIOTJYDD7203lR9QNxv3FEy2VUqKYRM18sURLXsJtQsh2XXY1ddsG9C1/Jj3CUrHb4xMYm8Li0efxnr7rRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=uTRR0vka; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9YaQLcqFNWYZJzwagmClaaK35HaKd6sDjy4+a++ePW4=; t=1731326565;
	x=1731758565; b=uTRR0vkaRnO/zcz+CDvNAqOzT3IRSdlzlddi8uCXgkGVpzfvRi+upMb0+z71x
	N8lk2faQH8iYLaemC27nMj8D2MzcWBk8lH7IMDJymTnLWdIfNQ7P96mPdRAa76J4E4wyG5GLwPj9l
	S2gIrEsLjXe3dPO5qHa23d1N5lMfZcMuf7vNzWfacdy+uLJsvi1J3xnto451g+oBGK/cKk8Csjmyu
	cPMC5wOoOw7xGvw/dOZmKwA+XCgYgCoPCeerefWcn2wN4CG5MrSD5bkC0Pi95aUQqg/giWO2evznO
	rrIjEeXZAmVh28ftFLvGALJcWcJXXe2ZtTK3ncBOVOdLkmn2qg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tAT7z-0000M7-Gn; Mon, 11 Nov 2024 13:02:43 +0100
Message-ID: <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info>
Date: Mon, 11 Nov 2024 13:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
To: brauner@kernel.org, Rui Ueyama <rui314@gmail.com>
Cc: regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
In-Reply-To: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731326565;223670ee;
X-HE-SMSGID: 1tAT7z-0000M7-Gn

[adding a few CCs, dropping stable]

On 28.10.24 12:15, Rui Ueyama wrote:
> I'm the creator and the maintainer of the mold linker
> (https://github.com/rui314/mold). Recently, we discovered that mold
> started causing process crashes in certain situations due to a change
> in the Linux kernel. Here are the details:
> 
> - In general, overwriting an existing file is much faster than
> creating an empty file and writing to it on Linux, so mold attempts to
> reuse an existing executable file if it exists.
> 
> - If a program is running, opening the executable file for writing
> previously failed with ETXTBSY. If that happens, mold falls back to
> creating a new file.
> 
> - However, the Linux kernel recently changed the behavior so that
> writing to an executable file is now always permitted
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a010c412853).

FWIW, that is 2a010c41285345 ("fs: don't block i_writecount during
exec") [v6.11-rc1] from Christian Brauner.

> That caused mold to write to an executable file even if there's a
> process running that file. Since changes to mmap'ed files are
> immediately visible to other processes, any processes running that
> file would almost certainly crash in a very mysterious way.
> Identifying the cause of these random crashes took us a few days.
> 
> Rejecting writes to an executable file that is currently running is a
> well-known behavior, and Linux had operated that way for a very long
> time. So, I don’t believe relying on this behavior was our mistake;
> rather, I see this as a regression in the Linux kernel.
> 
> Here is a bug report to the mold linker:
> https://github.com/rui314/mold/issues/1361

Thx for the report. I might be missing something, but from here it looks
like nothing happened. So please allow me to ask:

What's the status? Did anyone look into this? Is this sill happening?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

