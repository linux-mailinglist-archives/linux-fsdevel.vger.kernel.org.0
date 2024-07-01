Return-Path: <linux-fsdevel+bounces-22874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478291DFF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78139B242F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2B158DAC;
	Mon,  1 Jul 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Hc9VI9Ov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67115A85A;
	Mon,  1 Jul 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838440; cv=none; b=IViLG9qZNCQnlnPOjhlQI4CBXQKiMbNOiTxEAvoGObKx7gnJu1ej/6PWnI7GpRAWEsG5OD5xksgGWmLIt33uKr2FxsxCJnXtYgTosBnDtAiTe/XIX64EBBZxpZwmc/ez/mzNtLOGsYaHAihxLWP5tzzXrBYAfY82fMrb1pOCrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838440; c=relaxed/simple;
	bh=joqZqxfvJhfI6MGsku+7ZiuyZkmDI6a7ruDeHS6gU1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UipSaXj1wp4C6Igh9xRMrVqZP3+IXmPoAKPL2+HsYHdgFbiIUFQYmgFbsmq76vBx5DZxhLdBgkIoUKXoiQ0lbDX3DrHSB+4BW7CzkRVLmoNuDvxkKyoxlq8UJi8mXUMufEUV/kciEXvEXhiayMFgMZw0v23qLDZmOJD4Y6Pl2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Hc9VI9Ov; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=t+dVjH56wuvAZMPLxREj1dS4Lb8ihceYjbLapljYOh8=;
	t=1719838438; x=1720270438; b=Hc9VI9OvKZk9XydVJKeulcENUM/WMLZTPlh9I4LB0vd8F+O
	JIZ8CpLlIM2wA/EMhYcOvZk8d8NmaI0liLETGL6x0lwYU4/5jXroGpqLdyTHwqhUHY/aVUIZBpeLi
	TEASf/fXYNM6fdLfGCZUqf6quNiWX6FgkQCHzF/C1HhFH+Qw0qInElZGtOXcmjTh3/wg2sOMATIv9
	rovKekvSQyfqaTj2DQGYKl+7/5yJ5kK9R7USI7z51iJf6h27Oi3J0pKY+aHbMcNinK3iY/9UEi9nT
	6XOZMbCdSfO8L23zzLhvLRiRpnzBmA1TPMtCot4yQMjNyyNIL/mG3odNr4qk+IlA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOGXc-0008Qe-Fb; Mon, 01 Jul 2024 14:53:56 +0200
Message-ID: <a60fc742-0ad4-498d-b90f-793b9578b843@leemhuis.info>
Date: Mon, 1 Jul 2024 14:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] fs/ntfs3: Fix memory corruption when page_size changes
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <20240614155437.2063380-1-popcornmix@gmail.com>
 <CAEi1pCSQePMo4X_RvMfYmpxYwmuamhd8=1OXgNCU-N2BBdTXPg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: popcorn mix <popcornmix@gmail.com>, ntfs3@lists.linux.dev,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <CAEi1pCSQePMo4X_RvMfYmpxYwmuamhd8=1OXgNCU-N2BBdTXPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719838438;8fe70a28;
X-HE-SMSGID: 1sOGXc-0008Qe-Fb

[CCing a few lists]

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Konstantin, what's the status of this regression report or the patch Dom
Cobley propsed to fix the issue? From here it looks like it fall through
the cracks, but I might be missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 14.06.24 18:24, popcorn mix wrote:
> On Fri, Jun 14, 2024 at 4:55 PM Dom Cobley <popcornmix@gmail.com> wrote:
>> The kernel panic can be observed when connecting an
>> ntfs formatted drive that has previously been connected
>> to a Windows machine to a Raspberry Pi 5, which by defauilt
>> uses a 16K kernel pagesize.
> 
> Here are links to some bug reports about the issue:
> https://github.com/raspberrypi/linux/issues/6036
> https://forum.libreelec.tv/thread/28620-libreelec-12-0-rpi5-and-ntfs-hdd-problem/?postID=192713#post192713
> https://forums.raspberrypi.com/viewtopic.php?p=2203090#p2203090
> https://forums.raspberrypi.com/viewtopic.php?t=367545
> 
> The common points are it occurs on the (default) 16K pagesize kernel,
> but switching to 4K pagesize kernel
> avoids the issue.
> 
> Issue wasn't present in previous RPiOS LTS kernel (6.1), but is
> present in current LTS kernel (6.6).
> Revering to 6.1 kernel avoids the issue.
> 
> I've confirmed that reverting the commit:
> 865e7a7700d9 ("fs/ntfs3: Reduce stack usage")
> 
> avoids the issue.
> 
> This patch avoids the issue for me, and I'd like confirmation it is correct.

