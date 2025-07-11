Return-Path: <linux-fsdevel+bounces-54611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F6B018F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571381CA7B54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5A27E7DB;
	Fri, 11 Jul 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVFdqbnc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtxk43Wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70727CB06;
	Fri, 11 Jul 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227915; cv=none; b=X5BO/xTHdNcLq9hQhDr0RDShJyryevsyoOwEvFpr44Y49fECu8xpLCwyahBs+oQoip8YURLpKjO5gdzXSRTMkBiWucy1a/xMJyr8NVkQPXYEJTbQaIk6o8u2GY/j4O8QQyLk3eVUt+CfuLB8ehqpYyPu4YSV+QAtMQ6iQIBKMfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227915; c=relaxed/simple;
	bh=g1xrU+e1GsGmN+uweAiTje1VtKoc1T+zH6tvL1x68zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn6IVEht68GNS/nFFQLjR2TdqzjOnnWEHCak7g4KMFZdhIXtZ1q2ZqRou13LvIPsJnZeHbzloJCj63PkUcwn4vYaHk9KBcgWFc81GrsvPvKSLOrFOFvcbAqdBP7itzAC1Y6VOiu9Lb6REgeUnnw1qi4GqOGizjmf18V8Z7aV46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVFdqbnc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtxk43Wn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 11:58:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752227912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1xrU+e1GsGmN+uweAiTje1VtKoc1T+zH6tvL1x68zk=;
	b=HVFdqbncBetLRIYMMQ0nPvTUiPU/19OzfMPzPk1ZvzssCzMJjj4TncNehyxDUNOMjhPjjJ
	WeLXyxWsJhnveWJwiwWMQERpGgpduQb71xhcdL+OgOGL5AO0rXAWnchFc0/q/sTp12s8yD
	vCtI/lqhZN2SdHkq+MPZdIYAcXp9wTQZK3GbHme7ZAk8AxwiHJ14jfrpr5mp65bs6IU/ws
	eUv5QhffyxcidbtnEjXunF0O6OZw62J+4QagkhZekkzQCQUGoz/Xm8vxbP8P53mZuzQMrn
	3aMvGu9jrDKuFbKjGZKixc10jsOY0W768SXl1lqRd2G1tBklqt9e5ITlzxkpnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752227912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1xrU+e1GsGmN+uweAiTje1VtKoc1T+zH6tvL1x68zk=;
	b=rtxk43Wng2JyxZH/v9g3kK+T40NfuVpuNT8DdZPJlyeyCf05c7FZ0LXEmFQpGu0QnfUk1G
	SnIjFBftdF9YRxCA==
From: Nam Cao <namcao@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20250711095830.048P551B@linutronix.de>
References: <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>

On Fri, Jul 11, 2025 at 05:48:56PM +0800, Xi Ruoyao wrote:
> Sadly, still no luck.

That's unfortunate.

I'm still unable to reproduce the issue, so all I can do is staring at the
code and guessing. But I'm out of idea for now.

This one is going to be hard to figure out..

Nam

