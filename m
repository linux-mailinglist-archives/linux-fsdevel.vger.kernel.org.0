Return-Path: <linux-fsdevel+bounces-54412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C3AFF7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6E21C26574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92554283CA2;
	Thu, 10 Jul 2025 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SnApjbS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Skd/vG4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80729DDC1;
	Thu, 10 Jul 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120372; cv=none; b=qB743XDFdINmjqGcDnTlh30ePsNh0OildweMLeBO3B7Arhq2WdvXSgzECNfsEZXWfB0UYWtVtyJZECljmf/AJcn/VMPG/cH44Mp/ZBGjd4Q+nh4JuXEdcuuJd/3B/faf3cc2YFNuNVRFj/5jfRh4ulMg5B6fTJ2XSLT8w4WuYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120372; c=relaxed/simple;
	bh=EOJvIJKcp1uaEI3Nv8Nu8Gfe2d92xfES/f4sTFodMkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh++im0UDf0VKi/BqGtfvXJJGhBO0TP0yYf1zl7onrM9hEoseqP9by6pF2AhMBa7rHkfY/L5HXcq+5LY+wn4N7XZKERGKrRAr1Hx2u7Acq5l7WdyCrpLEfBZgY+4jm3Zk8LhcOSjsMV/AtknJ7H+bK/1i+yms0ZQwSZBAIzkQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SnApjbS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Skd/vG4r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 06:06:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752120368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MiGQOhHJzmi7Jd1WWo/0Ygq0kCc1gl9yVILzeL51PFE=;
	b=SnApjbS1/YX+oS4g8XRJfjTFWGsZzia5xtIieth5I6yuu71sa/sPkekyaJZ31hdAdHq7pO
	YR12N4ow+utaaLruRTVSmVvh1GdUrgF5iVXwA/1flcA05wORZlvh2/8LY4jzXAZJRMsrxe
	Nu6UlC2C8npaL0rsNhAWrFy9Vc60JZr58lygcUB0AJd/BTV6qiTnTks4OQQ29fq/oIZe+U
	Z2EQ/+WhYj0Vu+9AX82tWHcRm27bcBuRnsM1NdgOWaMUVlw2SeHsDRl+fF7wls7kBCpo2J
	SM+Ab9Wbzmw3kmvuy3iqOrQc2ISBsMrZ7Gm9BGiJwoBacLXWelPzHO/b1QVMJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752120368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MiGQOhHJzmi7Jd1WWo/0Ygq0kCc1gl9yVILzeL51PFE=;
	b=Skd/vG4rUwqi/EJmaHNXAMTkFbV8KycrfhGyvTXe9yudxnR9XOtzreimY4sbrkeOv7BIyX
	w9M/yazjnol1FlCQ==
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
Message-ID: <20250710040607.GdzUE7A0@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710034805.4FtG7AHC@linutronix.de>

On Thu, Jul 10, 2025 at 05:48:08AM +0200, Nam Cao wrote:
> On Thu, Jul 10, 2025 at 11:08:18AM +0800, Xi Ruoyao wrote:
> > After upgrading my kernel to the recent mainline I've encountered some
> > stability issue, like:
> > 
> > - When GDM started gnome-shell, the screen often froze and the only
> > thing I could do was to switch into a VT and reboot.
> > - Sometimes gnome-shell started "fine" but then starting an application
> > (like gnome-console) needed to wait for about a minute.
> > - Sometimes the system shutdown process hangs waiting for a service to
> > stop.
> > - Rarely the system boot process hangs for no obvious reason.
> > 
> > Most strangely in all the cases there are nothing alarming in dmesg or
> > system journal.
> > 
> > I'm unsure if this is the culprit but I'm almost sure it's the trigger.
> > Maybe there's some race condition in my userspace that the priority
> > inversion had happened to hide...  but anyway reverting this patch
> > seemed to "fix" the issue.
> > 
> > Any thoughts or pointers to diagnose further?

I fetched Linus's tree, and noticed that the latest commit in Linus tree
fixes an use-after-free issue in eventpoll:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2

Any chance it resolves your issue?

Nam

