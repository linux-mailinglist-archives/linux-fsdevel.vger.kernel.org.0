Return-Path: <linux-fsdevel+bounces-54803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D9B03642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9763B6F78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977C20C488;
	Mon, 14 Jul 2025 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WAwcwBxM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQSTvngi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0D1FECB0;
	Mon, 14 Jul 2025 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752472352; cv=none; b=Xdi9ms6N+Jhfc4Tq5CWFgzRkf5fBwr/NOU7ccwLN5vOwtdSw8rpk//hIO4q1PdLf2EbTVfFoklwxrSOHosdbnXM9r+tdAOoOguCOflQH64lw0ra63LkL3um4eFuii9Bh8Up22EVG/1Zc+6R1Wl2H6CkweYS7ei3S7jZoSACufpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752472352; c=relaxed/simple;
	bh=iG2qaT7w/dT9D0g11thzAv3huQ/PeXWKlk/XO2ue5c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlBABGVlUNEAsZjraBE95VNkPTKHunWVYwUUDL/fF1i+P+i+1pwvfiR7ybZA/1VNW1pnFSBgCZ4BaQW8wFP1C0FYFf4AX6CBfk5qLZj8N3qeaemyrG65Gsybw9LoJz9E0/QI61MItSXUCpbSx782+HWTKGtyRRYLHlm1zR+70U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WAwcwBxM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQSTvngi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 07:52:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752472348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tcn7KzoF3+YrILZ3Kdq0XPJoobaWTLboR5t69HVtrPo=;
	b=WAwcwBxMpxobTR/w4nAwY+rAv/N8ucjCOv7U1ImZc6uiv5ATTUJZ2AnrNJmdip/i/WEfyz
	yPc7OVVidfZzVTan7eVHkUrF0zX5lWm9//5sbRpxwtx5DGI+kIs+SX8Yxe6l82BrblozfL
	22eqULLjFV8j8rHP9w+9dC5cEvtmNSxN3cfl0EGHP9XuxI+KUC12hj8FTtbQI6gYOqb5aY
	NJCQmj6/z7H7Oe6C6ppaqepDJIJQDnZm6/ouLK/HQazp4+GmzfPynM14PyKfMDEfrhQPop
	QqSnOBZquEHxiB7piqdbCN39cqeVl+p+a3XSLMA6xwmkzlL0utxGjmVt/uWPpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752472348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tcn7KzoF3+YrILZ3Kdq0XPJoobaWTLboR5t69HVtrPo=;
	b=LQSTvngi/vg/uvwHf64AM3bw+vJJx/DNfD4JQmn7evNrWg8k5Lor8vj82gOCO2b87Syk+g
	toHwpFkkAF9aIECA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711154423.GW1880847@ZenIV>

(+Luis for the usermode helper discussion)

On Fri, Jul 11, 2025 at 04:44:23PM +0100, Al Viro wrote:
> On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> > Hi Kees, Al, Christian and Honza,
> > 
> > On Thu, Jun 26, 2025 at 08:10:14AM +0200, Thomas Weißschuh wrote:
> > > The KUnit UAPI infrastructure starts userspace processes.
> > > As it should be able to be built as a module, export the necessary symbols.
> 
> What's wrong with kernel/umh.c?

It gets neutered by CONFIG_STATIC_USERMODEHELPER_PATH. That could be worked
around be overriding sub_info->path, but it would be a hack.
It does not allow to implement a custom wait routine to forward the process
output to KUnit as implemented in kunit_uapi_forward_to_printk() [0].
That may be solved by adding another thread, but that would also be hacky.

It would probably be possible to extend kernel/umh.c for my usecase but I
didn't want bloat the core kernel code for my test-only functionality.

> > could you take a look at these new symbol exports?
> 
> > > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
> 
> What's that one for???

What are you referring to?

The macro EXPORT_SYMBOL_GPL_FOR_MODULES() will only export the symbol for one
specific module. Personally I'm also fine with EXPORT_SYMBOL_GPL().

"kunit-uapi" is a new module I am implementing in this patchset. It allows to
run userspace executables as part of KUnit.
Some more information in the cover-letter [1] of the series and the code using
these symbols[0]. Both should also be in your inbox.
There is also an article on LWN [2].

[0] https://lore.kernel.org/lkml/20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de/
[1] https://lore.kernel.org/lkml/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
[2] https://lwn.net/SubscriberLink/1029077/fa55c3b2d238a6bb/


Thomas

