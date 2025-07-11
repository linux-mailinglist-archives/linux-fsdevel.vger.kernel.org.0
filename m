Return-Path: <linux-fsdevel+bounces-54635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261BB01BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D66A1CA4C31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59322980BF;
	Fri, 11 Jul 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGKV+wBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKv0b5SH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362123ED6F;
	Fri, 11 Jul 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236488; cv=none; b=G5tkLWXerBn19aPivs7twzK2psMU+DltdQrEZpR06BvLTd+BmpE5X1rbdOIWz6Ic35gRKuqOUHbEUcUrB2+LD+zegA6w2s/275n8LJX2xXTGRxu6xFw+ZUNqIBmHtKYf3H3M8oXNIdxQ4Can1FmfvIwYr9jT0KaofiR6Rar3KqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236488; c=relaxed/simple;
	bh=hiGIhRKiTOmNcvBHyDkXssmWtLPbnb5hDySW7wqiltI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsmlEemhGg/0ulvITzEZvRywhGhta3xIVfHTsH+teyRn4s68UJSANzcyIZOFCuEo1eldiI+1NXmfXq4pBeD1L5CE16g4JQPFwQ982T+MWRxRpXQUIwhkO/DWuIP46pOR83Nis8SFXzzeTaxu5Qtc9ehMhJiXzjV5GejJaAzh5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGKV+wBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKv0b5SH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 14:21:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752236484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=on+h7+JPsOaseXxmTBL9Mtf7ti/qneEhfl3yBpXQJ5s=;
	b=sGKV+wBOwX9Xv6F+6+3W4ePgkqqryfMap4ENuXI1zvkYOtof8knG2RqcR8lXsVKDWWPL0a
	jBnuNXqXROX22aAtbqLjIr5lEIYQeHvjnPS4lQoZ0iP4Nx2KIvCHj0SIgljsA8xrgFaPk3
	N/suyvtvIGiF8OmICs4J4uJrK5U51Y4jwZllgoS8RKGU1oj6Rj17AiHCJZ+6rvbO7D23ja
	7I89Yi3Ff9Z/0fYooupiIg0DH9Bqo7bnCpddKgQz3RHWGCR2VzfiC0w2gZpzjvlXHdlxad
	P+dB2pGjSY2YxJKD7pKoQrrlggtnPjVUSPMesoXT7fJyfYgQPFd3n37UjIIcyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752236484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=on+h7+JPsOaseXxmTBL9Mtf7ti/qneEhfl3yBpXQJ5s=;
	b=rKv0b5SH3ytvcxYzwPp4wxZ980VhtFdQ/LC6EeAhwsLGrooaOYaEvJa0vKVnOV42UHDOgl
	FG0olKwBw8wsYLCQ==
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
Message-ID: <20250711122123.qXVK-EkF@linutronix.de>
References: <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
 <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <6856a981f0505233726af0301a1fb1331acdce1c.camel@xry111.site>
 <20250711095830.048P551B@linutronix.de>
 <7a50fd8af9d21aade901fe4d32e14e698378c82f.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a50fd8af9d21aade901fe4d32e14e698378c82f.camel@xry111.site>

On Fri, Jul 11, 2025 at 08:09:12PM +0800, Xi Ruoyao wrote:
> On Fri, 2025-07-11 at 11:58 +0200, Nam Cao wrote:
> > On Fri, Jul 11, 2025 at 05:48:56PM +0800, Xi Ruoyao wrote:
> > > Sadly, still no luck.
> > 
> > That's unfortunate.
> > 
> > I'm still unable to reproduce the issue, so all I can do is staring at the
> > code and guessing. But I'm out of idea for now.
> 
> Same as I.  I tried to reproduce in a VM running Fedora Rawhide but
> failed.
> 
> > This one is going to be hard to figure out..
> 
> And I'm afraid this may be a bug in my userspace...

Yeah I expect the same thing. In the log you sent me, there are some
strange-looking event masks that look like a userspace bug.

I tried those strange looking event masks, but epoll_ctl() correctly
rejects them with EINVAL. So those masks probably aren't the reason, but
they still suggest that userspace may also be broken somewhere else and
triggers hard-to-reproduce problems in kernel's epoll.

> Then I'd feel guilty if this is reverted because of an invalid bug report
> from I :(.

But even when userspace is broken, if the kernel patch makes userspace
non-functional, I would still call it a kernel bug. So it's a valid bug
report alright, don't worry about it.

Until we know exactly the root cause, I think revert is the right thing to
do.

Best regards,
Nam

