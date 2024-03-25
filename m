Return-Path: <linux-fsdevel+bounces-15223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2D88AA6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1E01C3AE17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0F6BB4E;
	Mon, 25 Mar 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jwIJzb33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BF45972;
	Mon, 25 Mar 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380423; cv=none; b=lil4uv8m9G0byL/L1bgVwQsvoSPww895775lk7y4q5cu/gAMlDrsVESUvX118H9jqMGjpwYGyMcB+z/rP4aUSN/hB7XLUkU+eeNWH4DdMzkFWP2ZvSmGfMRi8gQjewSjJK336hpKn9HrmpRkUoUFpDqFo2zRsVxS0XPxSwvAJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380423; c=relaxed/simple;
	bh=VjNYehxlmh1shv4CW0beIj0KEq/sDFzAXT2PbPSslUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wr0I+wiGOyfiihpp9WSpxy6oH0RxuLoo1LYTQTll1+mC3Ry8o5l32VzGIdbJvEnfwKRwdTYYl801TfabmPhaHjF2P0inaAVQpnjuqXJ1ggPbTH0hoTlXxG0nUUhUSoM3/VoRZuV7KWVufms4XGgzIPfHESNXudXyzXx0DP8FImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jwIJzb33; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=iRDq92pBNpigRTqyv8LxBk6SO4hteY9NpbgiSySDAF0=;
	t=1711380421; x=1711812421; b=jwIJzb33MZPSWDcPxriGLfzhqBgOFiQlejq0KuKi7LhsvFV
	37Nhb4O6yUAJWmzdUkKn4/cxTwho6Ks8u9yRjLotV3qUnockYgCIRaHH/DoANhy7vyd8bmnNVs/mr
	tdTsrJpzdADQ+TGALbf3s5qUwoHT6mMrnLwXxfeBR2HF5R9yjtS1k9OnJf+OrU1ZydUA70PC3YrOx
	wt0qwBa8kPPIPTJqMSpjLfGaau6CFeEpnQWFwnGHDCtU6odvbWL/Zx30oUSCym5xNTbVjtAJpUhcM
	QhjhOEyUr09BegbO+6hE+Y7BQWVNn6YtsL6v8NqcKB+uXP4XhevoNsoC9iNTMk0w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1romDx-0007ED-C7; Mon, 25 Mar 2024 16:26:57 +0100
Message-ID: <51f61874-0567-4b4f-ab06-ecb3b27c9e41@leemhuis.info>
Date: Mon, 25 Mar 2024 16:26:56 +0100
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
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711380421;1d762f29;
X-HE-SMSGID: 1romDx-0007ED-C7

On 05.02.24 00:27, Kees Cook wrote:
> On Thu, Feb 01, 2024 at 11:47:02AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Eric, what's the status wrt. to this regression? Things from here look
>> stalled, but I might be missing something.
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> If Eric doesn't beat me to it, I'm hoping to look at this more this
> coming week.

Friendly reminder: that was quite a while ago by now and it seems
neither you nor Eric looked into this. Or was there some progress and I
just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


