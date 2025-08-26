Return-Path: <linux-fsdevel+bounces-59175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D910B35779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A60F3A85AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CA2FC891;
	Tue, 26 Aug 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvcL5yqR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T32aPWHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19227D77B;
	Tue, 26 Aug 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197808; cv=none; b=Q9LFk/inLzRiHdNWgvf9IKMozM5L9DXUWCXA6t8HOpeVQifx3iuWia6QBmWQk7IjQUK9iiKu0eTgI/LPc16DHDdJcljMuYoZFQW8BYChycE3hKLco60d9TW0QbNqgqHI9lznJo2NX7N1E3nmJ0DsE2kpmcqjiKbg6D1tw959/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197808; c=relaxed/simple;
	bh=y4dwqQVgtSX6sPHPMwAuaPOfXvlILwfzYILH/VuFM1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghkiV2tPuhG2E9Rr90EgWVpQp7UpO1wqngxQKSWBe//6yFoxXsPtw7e+vDttWx6mVaCbVCJTOqyWKTuaOYBepWX3nGQrHaer3BpTsBxYIeL/CpsOke58Mqf6EzlkjepYbGnor9P0hG4vuC2TLQ6uriNokiDTUArDy3hZSjDadAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvcL5yqR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T32aPWHZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Aug 2025 10:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756197804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vW0GsgV7Ep6s4XIArheKm/LdDZZmdIK5t24jU+6kggw=;
	b=EvcL5yqRd2AKS+Y8UMGkM5b9exWowZdlqZLZFId2q0cdJEUZ6rCghtwN2F2RL6mtYmm2BD
	i+8+vbOBOVH+dQaEBkunBVi3JNeRGkUgQ+KNqcz2chZS1YkSfOzFoUdKhvt5D0OnZQzSxF
	nTQkh3syh8J7XKjIAuYIpgzGXxanKF5RGamHo3bttlX9HMf2RlUDG1MCwU/eiz/0N6duPz
	YZPYnd5iUeYHFSy+kSUTLv5EiXIn5oYkR1qXgX3j+hte5JQdtDUSsPqhMSfuyppcG5PCu8
	iPchwwOW9ixRj+h+8Y7xiRB4BwGYZQeFWF8jDdosveKfYLqhRhluQ0D0gF1xgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756197804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vW0GsgV7Ep6s4XIArheKm/LdDZZmdIK5t24jU+6kggw=;
	b=T32aPWHZdJeTw+a5UJKU3WD36z2iBIV7xYlqQ6KAqP2pHQwPD7bhFhGgVpi2WefMqunUNQ
	ps8p7jmoDxApSYCg==
From: Nam Cao <namcao@linutronix.de>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
Message-ID: <20250826084320.XeTd6XAK@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>

On Tue, Jul 15, 2025 at 02:46:34PM +0200, Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
> 
>   - The consumer (waiter) acquires the write lock and takes items.
>   - the producer (waker) takes the read lock and adds items.
> 
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
> 
> Unfortunately, this implementation may cause scheduling priority inversion
> problem. Suppose the consumer has higher scheduling priority than the
> producer. The consumer needs to acquire the write lock, but may be blocked
> by the producer holding the read lock. Since read-write semaphore does not
> support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> we have a case of priority inversion: a higher priority consumer is blocked
> by a lower priority producer. This problem was reported in [1].
> 
> Furthermore, this could also cause stall problem, as described in [2].
> 
> Fix this problem by replacing rwlock with spinlock.

Hi Christian,

May I know your plan with this patch? Are you still waiting for something?

You may still understandably be paranoid about epoll due to the last
regression. But it's been weeks, and this patch is quite simple, so I start
to wonder if it is forgotten.

Nam

