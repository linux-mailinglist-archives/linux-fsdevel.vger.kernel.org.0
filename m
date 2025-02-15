Return-Path: <linux-fsdevel+bounces-41780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE1A36FA8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B833AFF06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22FE1E5B98;
	Sat, 15 Feb 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cLAWtnnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56F1C6FE4
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739639489; cv=none; b=JCyYeDO8P3Iity8J9FYnSsdPHeIyr2/PxOBu5naLN0edemat3XBE9bPzqClYdXuFripyd1Oq6qmNvMjrrRImShcD+nU8bBO8r/J7QUViN4l5niDl2B3FxYr67TTvD84Zjb19MbgB2tC8THWU7UJ/0qxm0ctInUarkdq6UkxQGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739639489; c=relaxed/simple;
	bh=7Mrf6qToUc+ooKdVSK9qwZCScO/hUiwrQR3sR3vnfcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIDrVZ/LyrZz9EpXCz9jBzBlv7xtM5a1BhAfpR+cgol6DtXDJhFaAEFY/8VSYa1tjTOoEIYj+xfr//XsiDmj9sSHPGGw+Ot8R3BwKFebhX2Fi2TXwSTGmJw2usv8Wb17kgHvV50kWf5Xw3vPvqCRkbSBkauA88IJfQ1bE+hZf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cLAWtnnV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=d51xcY9perJbBE2LdGtDlNMNtPq4i/0yM6wtK4zlsZI=; b=cLAWtnnVuMdvSH3o2REL2KPDPB
	rIEOHnK0p1CSORi/1Polc1MnWHY6gTnGBrOziLdeiVNxWLkOeMa0C99m9nTcmNgtHh1k7Qil5emhK
	odIHozXZuDwqohKcyj9phPvfVVQPcEU6kpMvxYgC3hPSV35mxdR+ukNzvHsxAkx3LMS+uyTF57h7+
	yp6Fx5kFks9o0AvN7W8ob7kh+4zx9wRTHftYfGhmmU/LqBAa+MBfoxnrJ/6vzT4gjlSrAycLpf9EM
	3Y0rqAewzqC/NbYZrGM1OYq2jQ3EaVydW4TGafxh3fxxzYnEsZjIWU7yBEbbpNU6JYyXDsDa8QjBq
	/mRoiayQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjLhE-0000000DLLj-0KwG;
	Sat, 15 Feb 2025 17:11:16 +0000
Date: Sat, 15 Feb 2025 17:11:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Random desktop freezes since 6.14-rc. Seems VFS related
Message-ID: <Z7DKs3dSPdDLRRmF@casper.infradead.org>
References: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>

On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
> Hi,
> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 

When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
and 6.14-rc2 is broken?  Or some other version?

> [19136.543931] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [19136.543938] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 16-31): P314703
> [19136.543943] rcu: 	(detected by 29, t=21002 jiffies, g=8366533, q=26504 ncpus=32)
> [19136.543946] task:KIO::WorkerThre state:R  running task     stack:0     pid:314703 tgid:314656 ppid:3984   task_flags:0x400040 flags:0x00004006
> [19136.543951] Call Trace:
> [19136.543953]  <TASK>
> [19136.543958]  __schedule+0x784/0x1520
> [19136.543963]  ? __schedule+0x784/0x1520
> [19136.543966]  ? __schedule+0x784/0x1520
> [19136.543969]  preempt_schedule_irq+0x52/0x90
> [19136.543972]  raw_irqentry_exit_cond_resched+0x2f/0x40
> [19136.543975]  irqentry_exit+0x3e/0x50
> [19136.543977]  irqentry_exit+0x3e/0x50
> [19136.543979]  ? sysvec_apic_timer_interrupt+0x48/0x90
> [19136.543982]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [19136.543985]  ? local_clock_noinstr+0x10/0xc0
> [19136.543987]  ? local_clock+0x14/0x30
> [19136.543990]  ? __lock_acquire+0x1fd/0x6c0
> [19136.543995]  ? local_clock+0x14/0x30
> [19136.543997]  ? lock_release+0x120/0x470
> [19136.544000]  ? find_get_entries+0x76/0x2e0
> [19136.544004]  ? find_get_entries+0xfb/0x2e0
> [19136.544006]  ? find_get_entries+0x76/0x2e0
> [19136.544011]  ? shmem_undo_range+0x35f/0x520
> [19136.544027]  ? shmem_evict_inode+0x135/0x290

This seems very similar to all of these syzbot reports:
https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/

Fortunately, syzbot thinks it's bisected one of them:
https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/

Can you confirm?

