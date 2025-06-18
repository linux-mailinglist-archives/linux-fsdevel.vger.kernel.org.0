Return-Path: <linux-fsdevel+bounces-52016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F3ADE46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E93C189C02C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610827E075;
	Wed, 18 Jun 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQw0JLpq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45KHpBZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF19EACD;
	Wed, 18 Jun 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750231273; cv=none; b=mSUCoYsWJhdHmHHqGKcDPRRFzK9dGdomFmGJtkfxPJxGud9i1MSjGqQm1lZx9iXx2rRX7suYASqYghXU+BpxwsSnRHqpAyhpr/FzAXosLPokKeJEkhPHMdcY8hsWTqX7oed8zIQAcqpRgUMBf58zgYmQN9dXs7MqbJLHgZciahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750231273; c=relaxed/simple;
	bh=sjB703QluQSzTWrHVjgzDeTwIWV7HZPKCRAuLcbrQa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBQKq/J9aa/5REhD6kFxrLtmVzi7ygXxehjZIRlF0hphwS7zebzei+3d8gW9xWFXryQMVbX9UZ6N2F+V8SM+dhOCXFf602eV9JMDWWyVBUddJYJTnFpEKEYA4V85NEn2ZVQIosCC515SJiTHOaWZQ4gKdLazqfnxc4nK74eThMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQw0JLpq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45KHpBZ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 09:21:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750231264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NT1J6AneAG1SMoBsBfoH2toLt+/AIuOF2DLmmnrK1bw=;
	b=sQw0JLpqvksf4cTGH335uBk2nD4g604O0lLqs0rASlu9+/b5UTy3bvBhIu4vpbnrt8mVho
	oMuVC3DpoF3LLpQ51Jt34Xd2TmUrqT5IzAZ2DaHonpY6uSqOSH9PwBoevb3bJxdR7ijr+B
	SgElNrbL3e5DlTBwmjxLlWn7s67Gh8lso8hRMnA1WH4Ci49jaZkBLD0ugb0NZYUGu2OI4J
	hIyhMPmKTJusHxjMIHDMqupAsO2NOPWkGj21YXWupZl/IKeML6gbd7UBK8Mvv1LDDVq5G8
	+GY2E30Tp81me0vx4Xv6EFTCgg4nHtddrdZcJmD4yPDiPoXJaDIZCJXDHUQ4XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750231264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NT1J6AneAG1SMoBsBfoH2toLt+/AIuOF2DLmmnrK1bw=;
	b=45KHpBZ2vHDd6wdSx+eK84JDbGs5YjJI83py47O0xA+3d/7aXVNE1k1R+DrL4ZeqLjqC7e
	GWzBrA7l1aGmQ2Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	"linux-trace-users@vger.kernel.org" <linux-trace-users@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [RFC][PATCH] tracing: Deprecate auto-mounting tracefs in debugfs
Message-ID: <20250618072102.1fnuVt8d@linutronix.de>
References: <20250617133614.24e2ba7f@gandalf.local.home>
 <20250617174107.GB1613376@noisy.programming.kicks-ass.net>
 <3201A571-6F08-4E26-AC33-39E0D1925D27@goodmis.org>
 <20250617180023.GC1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617180023.GC1613376@noisy.programming.kicks-ass.net>

On 2025-06-17 20:00:23 [+0200], Peter Zijlstra wrote:
> If I have to edit the mount table, I'll just keep it at /debug/tracing/.
> Tracing is very much debug stuff anyway. While I knew there was tracefs,
> I never knew there was another mount point.
> 
> Just annoying I now have to add two entries to every new machine.. Oh
> well.

I don't know what you run but since Debian 11/ Bullseye (v5.10) this happens
more or less on its own. systemd has the proper mount units:
| # mount | grep trace
| tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
| # ls -lh /sys/kernel/debug/tracing/ > /dev/null
| # mount | grep trace
| tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
| tracefs on /sys/kernel/debug/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)

This of course doesn't work if you manually mount it to /debug. While a
symlink would work, you still have to touch the boxes.

Sebastian

