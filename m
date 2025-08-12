Return-Path: <linux-fsdevel+bounces-57503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F60EB224B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E81B6372A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D62EBBAC;
	Tue, 12 Aug 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkptLrlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxXbnB89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B82E972A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995093; cv=none; b=nvzpuqg6JmFQcssIIHNEFxv6hgIYnnr08K+Zswk/lrqW94SYUwR9G5vtc6ABdO4t5KtSxNNFhEthkniizDG78VE2r13Vzo/RXw95msdRi7Zkv0kkJIJDjC6loqLll2IbavUinqwizwLR3twp5MmE35KYSnwtF8aWARUb0bgBwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995093; c=relaxed/simple;
	bh=cLnBpd72VBS2+hhGUbX+DMUqzztxaUjmtieHDgku2+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKwTJH8G2S2R+DRsUTAz62X7MoDDdn2nNuL2oe5PFCuk6Gfdw2KvgB5rHEKa8H3s1KKsz2rbKQYZN0mKnLPOfYp5rxJALxk1H7MNwEZlG2ms6/O55b9yB/aMa7mOoB6lxMQOPLwmUG1keEpD58dsdcldQrekqRxtEd0oYhWTj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkptLrlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxXbnB89; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Aug 2025 12:38:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754995090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAQ4XH9zyEGG2wHnV4u9Eqr0i5CTANCWMyZk/cAJB1g=;
	b=kkptLrlS8UE5HjdN5eyZSlg/I2EZtUawlboIg5TiK68XByIfep7vNJN1j1ql/ZIChKNWQV
	CdNqZYeUW7a1omZDnYSF7cpCY8gspH/yFgp6Ya0Kw6s4MZpZizM/zcgxrNSLocWgSkmOOp
	Qv3BbgEPgOHmU3SFp0IolVSCvjXxCVMj8Msrkjfv0lZ2PtscqP5gRhLIqf8Ap+bqfspq5B
	oC7ym1LDSLTElwpOLl+KGmqTTQ9vtvEVxnPoO+LR8IVUEnHnBh7/9cvGWkTIQQfkO1BQkz
	qMDmlRx6kLmhz5bgwRYUKTUloJBKqMAongUN+rmedXf0Cy0+1pFHIyBiI0IaCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754995090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAQ4XH9zyEGG2wHnV4u9Eqr0i5CTANCWMyZk/cAJB1g=;
	b=ZxXbnB89qMkbg6cxtEQfKnszsXtu7CENbFvteG5G77LioBSRABWIni4Zryg2YwajaHPpGu
	cONytd5M2p0LzMBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com, Austin Kim <austindh.kim@gmail.com>
Subject: Re: [BUG] gfs2: sleeping lock in gfs2_quota_init() with preempt
 disabled on PREEMPT_RT
Message-ID: <20250812103808.3mIVpgs9@linutronix.de>
References: <7a68c944-0199-468e-a0f2-ae2a9f21225b@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7a68c944-0199-468e-a0f2-ae2a9f21225b@kzalloc.com>

On 2025-08-12 14:39:29 [+0900], Yunseong Kim wrote:
> While testing with PREEMPT_RT enabled, I encountered a potential issue in
> gfs2_quota_init() where preemption is disabled via bit_spin_lock(), but a
> subsequent call eventually reaches a sleepable lock.
>=20
> Below is the simplified call flow:
> [PREEMPT_RT]
=E2=80=A6
> At the moment, two possible approaches come to mind:
>=20
> 1. Avoid using the bit-spinlock in this path entirely
>  - Rework the bucket protection so we do not call into code that may sleep
>    while preemption is disabled.
>  - no sleeping while preemption-disabled.
>  - May require reworking bucket protection/race re-check logic.

So this would add 4096 spinlocks for RT. Given that those a bit bigger
than the other ones, it will use a bit more than 16KiB of memory.
Maybe fewer could be used assuming lock sharing is fine here but I
haven't checked the code

> 2. Replace the inner lock with a non-sleeping primitive
>  - (e.g., use a raw_spinlock_t for lockref->lock) so it can be taken while
>    preemption is disabled.
>  - Since lockref does not currently support raw_spinlock_t, this would re=
quire
>    additional rework of the lockref structure.
>  - Minimal structural change; avoids sleeping in the problematic context.

This is something.=20
Looking at the layout of struct lockref USE_CMPXCHG_LOCKREF can only
work if the spinlock is the raw_spinlock_t without lockdep. So it
expects the lock to be unlocked and does a 64bit cmpxchg() to inc/ dec
the counter that follows.

I was confused why lockref_mark_dead() works for dcache given that the
lock is not released outside of lockref.c except for
lockref_put_or_lock(). But then I noticed d_lock.

So making the lock raw_spinlock_t breaks the few lockref_put_or_lock()
users. The impact on dcache is huge and I noticed some waitqueue
handling which would break. So there is that.

Based on this I think it should be handled somehow within gfs2.

> I can help test patches for this on both PREEMPT_RT and NON-RT kernels.
>=20
>=20
> Thanks,
> Yunseong Kim

Sebastian

