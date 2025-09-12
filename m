Return-Path: <linux-fsdevel+bounces-61140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A0BB55877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE65C3C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490C280338;
	Fri, 12 Sep 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWe9RqWB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvD9/c5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6E267B7F;
	Fri, 12 Sep 2025 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712937; cv=none; b=iV6/JBFraBka6YGUwoyxQqQwHduqIuc8MbMapeQvRub8pMeWdlDsG1EXOV6FkrYNDpwUn+Ldxr7fW7fWc0TO8iy+JV61KBCt/n0mSI0JmUsMdCsyb1dioWe6HZlK3FnIWo2VlUV+fLB5rmlhk9x/QRlYARG/Zoxa/D4rJxOQc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712937; c=relaxed/simple;
	bh=CIP37YYCjqcGC81JDTnNjx/KUhlRzVtxclTIGTx+YTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVfeFbk7PSsHyeyIuozI52WKALLd2/Hdma2R531BGm68QY07bY4IeQfRC6MZcv6zTza8R5t+DMsgP05zF6ZGqzAmo2/bbHs7VexIRCLKJj11WFtgdw+u8YNkKifH4li4pdlfvoCbsMXxlkGc68VNIkJmCzlQ3if1oKdO/cMSdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWe9RqWB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SvD9/c5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Sep 2025 23:35:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757712933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJywZl8jo9kem9suoU7q3HumG7Ll6JwsETfmVlTVNX4=;
	b=jWe9RqWBVO4W/EhdvStaqwGY4HbFraEYNAbKVdoTZG4L/evb0hNioTSf3W8UIqJWxAM/pg
	0nRLrRp2Jl8fzgXh73Z2JWVwCS4HPuWVqDXGPcMap3CDnX1oDjHXQzbJfIpawNUV3x2wlo
	pBRqB8n45nDvf5OrrFGVgsIFWNYt4SS3z7w+m2piEf04fbHUrHCkpmIQm3JXkaKz1MxpFA
	Y0frJ/M8Tv84Bt0FGNS6W2GrrhxJgUUUJmS+rn7MY7WHSTStay7MlHKhtvHlrqOwGP5sbO
	god4lNKfQhS79hxwetBbeCp85u42rOpQFXRS3AOsDqBZeuZoZmE0Ahdd63kH0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757712933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJywZl8jo9kem9suoU7q3HumG7Ll6JwsETfmVlTVNX4=;
	b=SvD9/c5Fsvauk3tSHRJzFwKmpJQF2S2HYRa09AMsBAhpYOQ2vs26PVNIXCzA7P6J/6ngyo
	cSHMkxFnTiAkpbCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org,
	tony.luck@intel.com, jani.nikula@linux.intel.com,
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
	bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
Message-ID: <20250912213531.7-YeRBeD@linutronix.de>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>

On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
> On 9/12/25 2:50 AM, pengdonglin wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> > 
> > When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> > disable preemption, which provides RCU read-side protection. When
> > CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> > manage RCU read-side critical sections.
> 
> I have some doubt about your claim that disabling preemption provides RCU
> read-side protection. It is true for some flavors but probably not all. I do
> know that disabling interrupt will provide RCU read-side protection. So for
> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
> maybe it applies there too. we need some RCU people to confirm.

The claim is valid since Paul merged the three flavours we had. Before
that preempt_disable() (and disabling irqs) would match
rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
different in terms of grace period and clean up.
So _now_ we could remove it if it makes things easier.

> Cheers,
> Longman

Sebastian

