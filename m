Return-Path: <linux-fsdevel+bounces-45721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189BA7B7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670A3189D76B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA218A6BA;
	Fri,  4 Apr 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6mPp4QR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE232E62B3;
	Fri,  4 Apr 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747392; cv=none; b=Y2J2CtoaVQkslMJSClMWHyU7h9aGXM+JaF4MAmCMBiZjrXm95f5uF1OxM7rnD15TFImdUh2mvA5FhR6bPzZ0Sxd2BPhALGvVATYSWhMDgQjtJYz/Wa9lJcfz2ObHMsao8ni5zz+E1Zn6POKwqW0xaiqAqizjYHlOCqksI4gyDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747392; c=relaxed/simple;
	bh=5K9WuFhO0Y/ftqRe+dkWKefKGlW1ugCcdAxceJhNO3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlGRAHe7bYdMsOtKC/2OJsy5xDn7i6NY2nskW7DVd3tVcna0Y2a8cmM/kNKwikFjR/D6UEAYBrdCwiw9ogTdeSQkIh4c5ZQdHmTojz0DDSeHzTQGQTLgyLlEdRWUovJanhIjMX8mSzKTyV0RRU3t0oBb6ClhA5eEx+IlKjaiPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6mPp4QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A85C4CEEE;
	Fri,  4 Apr 2025 06:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743747391;
	bh=5K9WuFhO0Y/ftqRe+dkWKefKGlW1ugCcdAxceJhNO3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6mPp4QR6peyhSEhFHzM5ipUM21NsHb0pH2dkoSdgZwFTWqsijqLkFa7Hjvz8oH/y
	 +83UlJPNZFiC0d9MZ3DKxPlRVkTYb7ApOqBrd43eZD4ZNG5sBVjAzPZEK9Hpa0/uoH
	 YNKO0kwWkicwgDwhLY+Hu7klVbO+dQ4Rer+gvKoIoJ4KwBdts8kfshT0Qp3+rlg/du
	 oQPKt/5RzBniQLSto66hV8+sLYwmdJBZoV4ViUPtsekn12j3hi0F3Kdw9hk5no6KfO
	 A0sKo3L91i5ScwbMS7tmCUQ/ydgC6k4rU1Llko7rzMzUXpnWm6tsWQWmwZHSepewY+
	 4EMNB12IrOXIQ==
Date: Fri, 4 Apr 2025 09:16:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, pr-tracker-bot@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250404061626.GK84568@unreal>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <20250403182455.GI84568@unreal>
 <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7wDF1FQL4TG1Bf-LrDr1RrXNwu0-cnOd4ZQRjFZB43A@mail.gmail.com>

On Thu, Apr 03, 2025 at 12:18:45PM -0700, Linus Torvalds wrote:
> On Thu, 3 Apr 2025 at 11:25, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > -     scoped_guard(rwsem_read, &namespace_sem)
> > > +     guard(rwsem_read, &namespace_sem);
> >
> > I'm looking at Linus's master commit a2cc6ff5ec8f ("Merge tag
> > 'firewire-updates-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394")
> > and guard is declared as macro which gets only one argument: include/linux/cleanup.h
> >   318 #define guard(_name) \
> >   319         CLASS(_name, __UNIQUE_ID(guard))
> 
> Christian didn't test his patch, obviously.
> 
> It should be
> 
>         guard(rwsem_read)(&namespace_sem);
> 
> the guard() macro is kind of odd, but the oddity relates to how it
> kind of takes a "class" thing as it's argument, and that then expands
> to the constructor that may or may not take arguments itself.

Thanks, fixed.

Regarding syntax, in my opinion it is too odd and not intuitive.

> 
> That made some of the macros simpler, although in retrospect the odd
> syntax probably wasn't worth it.
> 
>             Linus

