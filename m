Return-Path: <linux-fsdevel+bounces-52933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FAAE890C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7919417844C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B62652A6;
	Wed, 25 Jun 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FguH6EMx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ew88KGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E651A5BAE;
	Wed, 25 Jun 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867353; cv=none; b=CO4fn9+aV35wCIyqyO2EDCxyc7LpdQiF/3EIeqFNXmqr9/9/z8T0DQEnXssqKXF26bGeopq7x9AQMRpKKBGD4eOykOSo/2A2JTVd2May9hAvePpb1pMyDRX7QDJlec1kYIXkGMgqPMS/JgIHxexoKFAuD4CRYwxBd5yEiHyCoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867353; c=relaxed/simple;
	bh=duzoY+pMo4GvUeP8s0Wcqxd5ma8zu9k983I5cbyMHj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OizwA9BlVuJmoGT4kSpemdqfVd/2VDKUVpiGx5psGs/c0KgYa/9ocAXQHRCAXo+n3DSFXPBd5E9DotICyJARZ9tePuFK67XSWAGjHtBFz//4dDFGok78j/59v3QKsSxeWjrIYOQu1z59NFVoCdUJajxKErjeV6TYOkEfdCABN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FguH6EMx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ew88KGH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 18:02:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750867349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2k28J0GqkwD41odig31t01aFjj1gFdE0i9C212uxb8Y=;
	b=FguH6EMxIZWkIAqXUYxmX9Zvl5L9m2J3BtWzHm3oy0EG84efhNf1290d5tUfMcq2pB5z+o
	wNnaG7IMcP8/xLDqS0eCAleBcIMcCu+9o5XDOK9refEsKM0/Ncn4AlTd+OVCtYqGHR/TIY
	4qhcWSSYFz3VHpTydPE0QJ3fElGLRNZkTYSq6gCWvw6zR9JdvhDp071nXfVBLifwlPCs+n
	xJMRvLpHRofcKp9bMq+EXYUKj3rZVN2OZ+pt2b0ZLBVHohv54NWf/gQ+qSkoHlvLAujOr8
	vnA4CYOCZNTz4Dyed2dYQIOtugIqu/pZm8vRDPxIoGOePW1NGW/qAtlEz25+kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750867349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2k28J0GqkwD41odig31t01aFjj1gFdE0i9C212uxb8Y=;
	b=9ew88KGHeSDR+rS2lIH9AgVoGhtpRMAqhhNgjueSYsNpFezge+eiIgL2zOiEVYgGqFKEU+
	mxDvHTb227AesGDg==
From: Nam Cao <namcao@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250625160227.B9-NAdc2@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250625145031.GQ4Bnc4K@linutronix.de>
 <20250625152702.JiI8qdk-@linutronix.de>
 <20250625153354.0cgh85EQ@linutronix.de>
 <20250625155713.lckVkmJH@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625155713.lckVkmJH@linutronix.de>

On Wed, Jun 25, 2025 at 05:57:18PM +0200, Nam Cao wrote:
> On Wed, Jun 25, 2025 at 05:33:54PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-25 17:27:02 [+0200], Nam Cao wrote:
> > > To be sure, I tried your suggestion. Systemd sometimes failed to boot, and
> > > my stress test crashed instantly.
> > 
> > I had a trace_printk() there while testing and it never triggered.
> 
> This code path is only executed for broken userspace.

Forgot to mention, my test crashed because the __llist_add(n, &txlist)
below doesn't care if 'n' is already in a list. By changing to from
llist_del_first() to llist_del_first_init(), it is possible for 'n' to be
in a list, therefore __llist_add() would break.

Nam

