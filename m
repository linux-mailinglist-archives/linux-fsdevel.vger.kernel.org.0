Return-Path: <linux-fsdevel+bounces-61423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B9B57F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188F72011EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA6334367;
	Mon, 15 Sep 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJqEilup";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+YNkMxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC627461;
	Mon, 15 Sep 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947257; cv=none; b=o893vUd9mG6COsQA2Z7Fd2JfzT28j/C+IMllAxh72F+t0ozY+f3mQ7VgjDIMBNKiH+DSUGBM2sr7IRX9dkdZQAGNKPCCRa91e4Xxb4gcY0TNTjsgzEr2sy4yNlAg2DBO4rrXJZ93mumpMXoixPU3StwnRtP9WyDvBJ1tDdXZZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947257; c=relaxed/simple;
	bh=x67mCxmqkj9+e9pzvDN8Tta0qPHWFpvcCgabamG1AWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1YuLDuFYnYMhKhOW8vvPXidTn8COjP8bDvsfMC+QEtemcSZ0Cpr0juo862/4ivYAUuliSMHrUp/eOXoV05rwK+8lWnM6CF5/DpSaNl+B3B/h2h5wjc5z8Edo02Ty9tOkUaRDpKyteObeYuWE8zUZmOT6ZvE0N0Qrbg07b/AxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJqEilup; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+YNkMxE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 16:40:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757947254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lni+I3buozORHBU99Fb6S2L5ArlJnPvanU1k2nG+bqs=;
	b=kJqEilupnjshBEyflsSxaQ1cYXo1HmvwEGZxE5Hry+3tMhFnVh3frgVMySXIVU3YA7sr/P
	ZmzsU0E7Km8Wp9l5bZDkkyDgnPFZnbLtBPRK/3LI31uDYiDIGpPjLv9wsR2eeUTNRRAX//
	dmNhtGH6hrZaFy0o25aqc/JiLREHt/y5ZcTdXzlyLdSjRzpWF1ajC/tWXeGrJKOz1r4JdJ
	O+HZHd0cB6caRbdRPYpFuFCDeIfE27yuCYcWeSk2ELWrhiOAF7HeL/2G+EZODCQqXklj6A
	WbRdcD38CnfevP/TM/aX4fpES3ouPOth51eerceMkkYhcApyFTE2c/6EC96NyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757947254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lni+I3buozORHBU99Fb6S2L5ArlJnPvanU1k2nG+bqs=;
	b=u+YNkMxEXUeLN4I2gvc5y9anOucA/bETagP+D7VWVq55ed12wCZJ5YaxLNDq/vrnZRM5c4
	1K1FhWVW76s3WjAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
	bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
Message-ID: <20250915144052.VHYlgilw@linutronix.de>
References: <20250915134729.1801557-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915134729.1801557-1-dolinux.peng@gmail.com>

On 2025-09-15 21:47:29 [+0800], pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> consolidation [2][3], RCU read-side critical sections include:
>   - Explicit rcu_read_lock()
>   - BH/interrupt/preemption-disabling regions
>   - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4])
> 
> Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regions are redundant.
> This patch removes them, simplifying locking semantics while preserving RCU protection.
> 
> [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
> [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
> [3] https://lwn.net/Articles/777036/
> [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/

What about something like this:

  Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side
  function definitions") there is no difference between rcu_read_lock(),
  rcu_read_lock_bh() and rcu_read_lock_sched() in terms of RCU read
  section and the relevant grace period. That means that spin_lock(),
  which implies rcu_read_lock_sched(), also implies rcu_read_lock().

  There is no need no explicitly start a RCU read section if one has
  already been started implicitly by spin_lock().

  Simplify the code and remove the inner rcu_read_lock() invocation.


The description above should make it clear what:
- the intention is
- the proposed solution to it and why it is correct.

You can't send a patch like this. You need to split it at the very least
by subsystem. The networking bits need to follow to follow for instance
   Documentation/process/maintainer-netdev.rst

and so on.

Sebastian

