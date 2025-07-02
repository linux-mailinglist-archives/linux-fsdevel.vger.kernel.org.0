Return-Path: <linux-fsdevel+bounces-53610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E827AF0FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5953B1C27A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0C242D87;
	Wed,  2 Jul 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9GjE5ix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2xWDQTnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66BA339A1
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447747; cv=none; b=ZYpP6h7wttVJ/3yQOUrmR16EKPhqqAJ750/W2tD60Up35hf3seWg27IipwPt5ptbFdGMOnOyccN+avW6EJ8RhBV+mbQkbRRqas3J0cpPFsz9pgIWmrOnybQq6YLaQ2wp8+pYg/gg+hYs/2g86wAItKjdqBoZr52t9tR0Cr6P4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447747; c=relaxed/simple;
	bh=CndgwlHRgOZthwD5DyXASu5VNyHbH0pDUi/qHVRr1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQdHqxWym/UYD9fztGL/t49Za0thVH67GBtwcDon4Vkl7PgCs+K50odY6Pr3oMFaGgYS15ejr5Kg3W2ZZWgszqDprrcSmR19oYYb9Epg/FQ4uW5zWfyjCmVW0FuYtHHs4Epjo3A/BughNnb+gcfR0mrx6XBPJPow5QxgjQJ4DBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9GjE5ix; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2xWDQTnC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Jul 2025 11:15:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751447743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5hXHySVY0Z2KIA6NHkHAaBuc/mXp8otI0ZRTy1A46A=;
	b=J9GjE5ix+TynHToflQXzFMhBbU98yyFILDG/yjV9c9Ur7Q+fPDNys25vy4DsVG1QJgCR5K
	HnJQwUE5ZE/T7jVnSr3f4EPmH7yyYcV97XNlptfAkHMAoPVMuAMOEz2gL1Mocc5sSVrrOC
	qBKLpcnN76oAFtY6FMNjJ8izMiIkQZtUa2D9cbADM/tXiQnm5Pc1xwSDPWaCL2Z6trB5AO
	izZD9gguJyWNifWVuObOHU08ZW7h/Rrhv4XdXqShv+28L8mIMBAnq100P28NPRqOniGwK+
	t6m2ZbE4iA3R1zYpdDVwU/ThqriQcJ76AyH84wORYTKep6wgxjvSJ9ResLTCjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751447743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5hXHySVY0Z2KIA6NHkHAaBuc/mXp8otI0ZRTy1A46A=;
	b=2xWDQTnC2S4xfk9BoGm9igtFbADPWMOJ982X/XM+5I9RsXe/Uhv2W2yGNZ1M0SmNaPV4V0
	Q4CeF/2Hmw6b0IBg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] fold fs_struct->{lock,seq} into a seqlock
Message-ID: <aGT4vvHMFxBsbSv1@lx-t490>
References: <20250702053437.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702053437.GC1880847@ZenIV>

On Wed, 02 Jul 2025, Al Viro wrote:
>
> 	The combination of spinlock_t lock and seqcount_spinlock_t seq
> in struct fs_struct is an open-coded seqlock_t (see linux/seqlock_types.h).
> 	Combine and switch to equivalent seqlock_t primitives.  AFAICS,
> that does end up with the same sequence of underlying operations in all
> cases.
> 	While we are at it, get_fs_pwd() is open-coded verbatim in
> get_path_from_fd(); rather than applying conversion to it, replace with
> the call of get_fs_pwd() there.  Not worth splitting the commit for that,
> IMO...
>
> 	A bit of historical background - conversion of seqlock_t to
> use of seqcount_spinlock_t happened several months after the same
> had been done to struct fs_struct; switching fs_struct to seqlock_t
> could've been done immediately after that, but it looks like nobody
> had gotten around to that until now.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Ahmed S. Darwish <darwi@linutronix.de>

