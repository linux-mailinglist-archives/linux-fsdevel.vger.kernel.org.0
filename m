Return-Path: <linux-fsdevel+bounces-54830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935ADB03BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C3F189B611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA131244669;
	Mon, 14 Jul 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hR1+mZFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CXlaM7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABC218AA0;
	Mon, 14 Jul 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488056; cv=none; b=CnxycQY6apHcMgZhFiyE9ua6itRxW9LmzYMiCFnAhcFn2J3huFaEb+akhINL9ZVrznk29SjL3EIOjMpEGr3atjN+Hc3SCCWJGvO+IKe84LShmeCygMuWxjGUxxPCNYar84Xu7xkDReM2wNrhA46vGlcvDGkiY1vIFSqSCPCd/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488056; c=relaxed/simple;
	bh=cOpEyTSiBLUg150TjbxK79lmnioNTJJemNhL2gS6kZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEaM5UyaYOsUUPXF2E5NAS/EeDdHLCOcs9tq5yzakfsT2MZ+e3uLvgV23i6Sf8VYMJYnzGFBKTayhtQW0y4m/s+GrIsbqinxAYqy5yOr3gn2t+zdhCzCgL7Rdc4/ZaSfg2dgvIyg0O6OZ9j2b2ZeEdZcZW1CG6HO06kyIFnyfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hR1+mZFQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CXlaM7n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 12:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752488052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOpEyTSiBLUg150TjbxK79lmnioNTJJemNhL2gS6kZ0=;
	b=hR1+mZFQsXh07BTP0mr4H6/1n2IrQRgS2o0EIL2eytqFrc6ehL8mLh0OTJFWJSGNZcIF1T
	8mLPa4aDKRNR1TGEjGTFqJ5EIY/00c8SFW9z39s0i/YC5ZoryvglfDI+AkjtHM2MtKFH/E
	W2x3jd63FF297o3XQrrpFba1tC+NKbCUC/BbAVy/L/yM8Tb+6xnhFuqoKVSLDkcO8Mk8bh
	QxOGPigbkoI/sd/FMgA9vZWOXEirlmNwBy7KmvhIYAqr4eswSj1LqQhq+iuTa//gCKz0dx
	ubA+vRM2hXGL2BrtESUW+f8AX4a2Cog77ZLOLboU/IYZW8zOLnNlHvSg0u1APw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752488052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOpEyTSiBLUg150TjbxK79lmnioNTJJemNhL2gS6kZ0=;
	b=1CXlaM7nBkSJCEFlqjOb1kUplpzguYM6FkOGWrXWpL5Jt5rhN4NahG5M83kHFYnUEPfGpQ
	H3cgbrFzGHNsqRDg==
From: Nam Cao <namcao@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250714101410.Su0CwBrb@linutronix.de>
References: <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de>
 <20250714-leumund-sinnen-44309048c53d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-leumund-sinnen-44309048c53d@brauner>

On Mon, Jul 14, 2025 at 10:59:58AM +0200, Christian Brauner wrote:
> My lesson from this is that touching epoll without a really really good
> and urgent reason always end up a complete mess. So going forward we'll
> just be very careful here.

And my lesson is that lockless is hard. I still have no clue what is the
bug in this patch.

I am implementing a new solution now, completely ditching this old
approach. It survives some basic testing, and the numbers look promising. I
may post it later this week.

Nam

