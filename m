Return-Path: <linux-fsdevel+bounces-41781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC15A37138
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 00:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C9B16F313
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B791EA7C0;
	Sat, 15 Feb 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Wq3MQSzM";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="zO8OSdsp";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="W/IwRS7o";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="s+LnqDab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC71624D4
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739661979; cv=none; b=hPRoNy1bLjb22HybfLL5u3jaF8JIdnulBSIc80uxh80Jh1iSabMLZuN8tN3YD+0Dc1R+6jGCJC8CErjNdd4ATXbZHWjDhwXnj95sHidHVg6W6e5DCtnXDaNkdPsGGWIYCQeRzCaXD89YUa9/kaXQ32+stRJTt0Whixp//ochFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739661979; c=relaxed/simple;
	bh=IJZYaEBuYiAitXUUY2Vvpc6huMh20vfCfczdpkTHreQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhV5SiXwe+ubnv7kVqrzkYwNuwR7rSJU6VuSkbV7S7dOXF6oggMj8sMZ+f4zYUE6lso+37m1gHvKSbMqFCRjTA1hRpXMiooNUkN+xWUUgKYTp43j55743nC86E3odLpmKzObHinegUNEsdLt8MbkxMNbq/XoEUZXBRVAxSMpXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Wq3MQSzM; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=zO8OSdsp; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=W/IwRS7o; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=s+LnqDab; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:38a6:d2b6:c381:d8f4])
	by mail.tnxip.de (Postfix) with ESMTPS id D26B7208AB;
	Sun, 16 Feb 2025 00:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1739661969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gap/CXytVzjJfH9lgdlMKYLNTPArTafLUHLMXtKvVk4=;
	b=Wq3MQSzMVc6EUPkfKBO2Gq/xsBcvAP8oZV2i61YlVPNU9deBQ6lGLKeAN3u8rkGgLFUGEK
	VD3EsOB8cBnRQE0MIneSgk9yfdxfQVI8L1L3px+YVJN6WZVS+XL2/LX1e77KASLbycNuOW
	JAT6TWvMNgPCzx96j3Gcv2QuUR6qIfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1739661970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gap/CXytVzjJfH9lgdlMKYLNTPArTafLUHLMXtKvVk4=;
	b=zO8OSdspe+ortGd4omlH9sWaO4B8ND4oDMKXgSiy/klJKa39dWt5euUU4jZ+cA2flsnZXU
	IcJQWmvGZbZSedDA==
Received: from [IPV6:2a04:4540:8c0a:7600:7815:7644:40c1:fe9e] (unknown [IPv6:2a04:4540:8c0a:7600:7815:7644:40c1:fe9e])
	by gw.tnxip.de (Postfix) with ESMTPSA id 7E3C420000000002EA49D;
	Sun, 16 Feb 2025 00:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1739661969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gap/CXytVzjJfH9lgdlMKYLNTPArTafLUHLMXtKvVk4=;
	b=W/IwRS7oa/mTJaUdZVT3eW3rObOXGGEknC8q8Q7l+alscnIRUAoAPVRea4+QOz2ZkdQ4XC
	5kVUTNhv9WN/gC7cLut1Doo9ZXvfFBOJqmfygW76wEFb2U/aj6w0CluXuEvRkrsfO9+41q
	dU+PQLD5WpeGPQVhqYPM7R+nw5D1aZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1739661969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gap/CXytVzjJfH9lgdlMKYLNTPArTafLUHLMXtKvVk4=;
	b=s+LnqDabLU/8fSKWYbTW6n/R40ojtXPRvF8TjBdOGYlsQN2CII7BCWgjrOatNn2SdYQvwt
	31OnxFRFdwARoNAQ==
Message-ID: <87e7e4e9-b87b-4333-9a2a-fcf590271744@tnxip.de>
Date: Sun, 16 Feb 2025 00:26:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Random desktop freezes since 6.14-rc. Seems VFS related
To: Matthew Wilcox <willy@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
 <Z7DKs3dSPdDLRRmF@casper.infradead.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <Z7DKs3dSPdDLRRmF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/02/2025 18:11, Matthew Wilcox wrote:
> On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
>> Hi,
>> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
> When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
> and 6.14-rc2 is broken?  Or some other version?
6.13 and 6.13 + bcachefs-master was fine. Issue started with 6.14-rc1.
>
>> [19136.543931] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [19136.543938] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 16-31): P314703
>> [19136.543943] rcu: 	(detected by 29, t=21002 jiffies, g=8366533, q=26504 ncpus=32)
>> [19136.543946] task:KIO::WorkerThre state:R  running task     stack:0     pid:314703 tgid:314656 ppid:3984   task_flags:0x400040 flags:0x00004006
>> [19136.543951] Call Trace:
>> [19136.543953]  <TASK>
>> [19136.543958]  __schedule+0x784/0x1520
>> [19136.543963]  ? __schedule+0x784/0x1520
>> [19136.543966]  ? __schedule+0x784/0x1520
>> [19136.543969]  preempt_schedule_irq+0x52/0x90
>> [19136.543972]  raw_irqentry_exit_cond_resched+0x2f/0x40
>> [19136.543975]  irqentry_exit+0x3e/0x50
>> [19136.543977]  irqentry_exit+0x3e/0x50
>> [19136.543979]  ? sysvec_apic_timer_interrupt+0x48/0x90
>> [19136.543982]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
>> [19136.543985]  ? local_clock_noinstr+0x10/0xc0
>> [19136.543987]  ? local_clock+0x14/0x30
>> [19136.543990]  ? __lock_acquire+0x1fd/0x6c0
>> [19136.543995]  ? local_clock+0x14/0x30
>> [19136.543997]  ? lock_release+0x120/0x470
>> [19136.544000]  ? find_get_entries+0x76/0x2e0
>> [19136.544004]  ? find_get_entries+0xfb/0x2e0
>> [19136.544006]  ? find_get_entries+0x76/0x2e0
>> [19136.544011]  ? shmem_undo_range+0x35f/0x520
>> [19136.544027]  ? shmem_evict_inode+0x135/0x290
> This seems very similar to all of these syzbot reports:
> https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/
>
> Fortunately, syzbot thinks it's bisected one of them:
> https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/
>
> Can you confirm?

From my limited understanding of how bcachefs works I do not think this
commit is the root cause of this issue. That commit just changes the
autofix flags, so it might just uncover some other issue in fsck code.
Also I've been running that code before the 6.14 merge without issues.


