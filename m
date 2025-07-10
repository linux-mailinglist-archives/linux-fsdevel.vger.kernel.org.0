Return-Path: <linux-fsdevel+bounces-54411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E1AFF7B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65301C203FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 03:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA8281538;
	Thu, 10 Jul 2025 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnXMuC4E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcs0nt/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949AB660;
	Thu, 10 Jul 2025 03:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752119292; cv=none; b=ZHjr7zjc3juF/AT/fvYJi0bAgWWdChlSoq60jbgQ/eVWNC1oiKUaeocfpcUf1E5UA56sNehnxgcCzBB6JbetsVVwaCxd5YLKwY0JGlR90qKH/Z30ZNZU4JurdQgcMj29GaXCcTvGCpdrfcd2q+7hvfzOqJKgs9JUPXNqLhpyWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752119292; c=relaxed/simple;
	bh=BdFbONTtnjgKbs64vRH2l6lz4Ut6wcLqB7fwFQKl1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5m3EvaFFrmdyUa8WH1ZI0pXGQJ6nQMJnpdo/ABCmSpOIYxvYC+lPRdqfqDX1q4pTFklFpKc3Xi0YeaEjQaeJbSr4xASa/Ctadco0jbMOMjT/4+S1Br1r6W+idXbDRnkn2xg9WAEDphQWK7GeTPy1L19vVWjtpMYxhBshhEFVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnXMuC4E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcs0nt/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 05:48:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752119288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+sY3z68x9Bwu1dqm+DwYPuEvGjqzY4XAcSPOiZPvco=;
	b=MnXMuC4EAiBfQMq8CwjHkUGGGvoPYzhSWHmrhcGsGDzgm8nGB/uFkYBMr+4N3AUA3D7qdt
	AgpV2t90ec1ROHqquWH67b+Eb44RuqqSzakZO9VXyqGwkYoueeCCgFVJ4dpvsksqEuxOW5
	hHF1lCrlKVwdmKLA0KByVrNx+rCP6Xofl9v70xLTCt8CdF8MGSNGG2jKB/7uoTkkUI3WhN
	YdrliYK6l4cjZKcp91INRnvGqWxftovtwQYyYITxt7Ofo7XFZTREejRwCzPMlyQUT1foGI
	1Hox+i62o2eIK/BnFtZp2foj/UHYE2F0+2txY0AO9FwydwSIXPLEPbCn/k6S0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752119288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+sY3z68x9Bwu1dqm+DwYPuEvGjqzY4XAcSPOiZPvco=;
	b=hcs0nt/TAZ+fhP2MHYXNzg/YPBBxVyBLfFRN+RcoixPpiBY44Y4XYxcN4WaSHXZ9LnpZ3G
	qLBkZwkDIGuamCAw==
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
Message-ID: <20250710034805.4FtG7AHC@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>

On Thu, Jul 10, 2025 at 11:08:18AM +0800, Xi Ruoyao wrote:
> After upgrading my kernel to the recent mainline I've encountered some
> stability issue, like:
> 
> - When GDM started gnome-shell, the screen often froze and the only
> thing I could do was to switch into a VT and reboot.
> - Sometimes gnome-shell started "fine" but then starting an application
> (like gnome-console) needed to wait for about a minute.
> - Sometimes the system shutdown process hangs waiting for a service to
> stop.
> - Rarely the system boot process hangs for no obvious reason.
> 
> Most strangely in all the cases there are nothing alarming in dmesg or
> system journal.
> 
> I'm unsure if this is the culprit but I'm almost sure it's the trigger.
> Maybe there's some race condition in my userspace that the priority
> inversion had happened to hide...  but anyway reverting this patch
> seemed to "fix" the issue.
> 
> Any thoughts or pointers to diagnose further?

No immediate idea, sorry.

May I know your exact setup (distro version etc.)? I will attempt to
reproduce the issue.

Best regards,
Nam

