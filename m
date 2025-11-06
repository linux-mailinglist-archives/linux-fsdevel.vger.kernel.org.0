Return-Path: <linux-fsdevel+bounces-67307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7FC3B286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF021B80FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456032ABF6;
	Thu,  6 Nov 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TOp0FR5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B0328B5B;
	Thu,  6 Nov 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434656; cv=none; b=uZ2CQIvsZrjcVAM6PeYhJj05vzuZmS6iI1QXkU+2ONySD6iFfAlPq70T92GrlBzS+JSLVxqc9A1J6qWkEJef3jviO6LnTt1WZTKOazZ6NB03n5WpgPTIrdDLx6f6ye71N5RWbvjUqGhMK4H/PqqEDPjUGF3o+EYv3j5wt4HaKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434656; c=relaxed/simple;
	bh=EjE1m+aWY+p8DVs9uFb16oiALA5/7qS6BcefaHxdyOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2yZJGk/UKhdf0czYgd0YjaBgFtT/AO2j91r0s7SXiTwK2vdk4zhcjdkX2nkRLLwI7HoDp1iW5AA64fdqG9yptqogpI+g0Eor63sXdLqEYIXIjicyDTxOc+f9oS4WI6hiWWF8G7XbsOiG4b9FKo39io3Jbgk0mH86Tv8xo2kJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TOp0FR5v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDB2040E015B;
	Thu,  6 Nov 2025 13:10:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PddhDCfaO9_b; Thu,  6 Nov 2025 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762434646; bh=5v/DohS5epIf6oOTb9pffnHzr6pVXPZAsTAJfYNTMO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOp0FR5vr1iptFddVvvn69/xH0/+viFQGvdPQ33Di1Uq9OKNzM+zej51/T1wtCv5q
	 n/2XYrykKkbbDAPGUiVkxztQsPmUxurxIWCwrl1OmtAKAiXghUxheBxP6WGvETU7dm
	 Gzd5Y7FvHPCLXpsyVvfxLmSnZeGfrHGBovGF4NmTjNAjNv+B6vMY5eCHg7kQxC+TH/
	 +/7wj+fAQLGac8ms36y8t5xFKJCzmdrmgBLPlOH5zhAto1ebUqVXV/4PlIrLGuFGXO
	 IN2FuwzO06u8N/QddAcmeWOB16dZzduNkEr1flEmnVGxxePyi7nmcrp8aCdH1IDScC
	 +AmdNLHUYy7cDWdWnTeLKuLTur1qfMpCPTb/yhIntzJSv44/+2TFarBYlriy2Zrioi
	 C39LQ4hwvzWodEzXcMxmWsVOLwpQGqa70oxxDF+us+g2Wim0RgJwfb/xIqbEeXR7rT
	 VsDa91NvEnlzPCzTW8hWbunpzXRnAjjSQPxdG4hUJoRGKF4pSD7mvmD3+zSpVM9E2y
	 RwZeBGXjeLGRJeL/I5U/NvxVMMn+8NAGTrpoGoDC6XB2nLRHdm0+HjGRrhp1VhltID
	 Pdz8QSb9v1fmcWMbeHLE5/vf562noWtDVoX3J+ebgr7C5O4hB4xipM6CR/RzzeA9M8
	 tquaAvgz8kNSbhxeLFn4KShY=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3E9FB40E00DE;
	Thu,  6 Nov 2025 13:10:36 +0000 (UTC)
Date: Thu, 6 Nov 2025 14:10:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
 <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
 <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>

On Thu, Nov 06, 2025 at 01:06:06PM +0100, Mateusz Guzik wrote:
> I don't know what are you trying to say here.
> 
> Are you protesting the notion that reducing cache footprint of the
> memory allocator is a good idea, or perhaps are you claiming these
> vars are too problematic to warrant the effort, or something else?

I'm saying all work which does not change the code in a trivial way should
have numbers to back it up. As in: "this change X shows this perf improvement
Y with the benchmark Z."

Because code uglification better have a fair justification.

Not just random "oh yeah, it would be better to have this." If the changes are
trivial, sure. But the runtime const thing was added for a very narrow case,
AFAIR, and it wasn't supposed to have a widespread use. And it ain't that
trivial, codewise.

IOW, no non-trivial changes which become a burden to maintainers without
a really good reason for them. This has been the guiding principle for
non-trivial perf optimizations in Linux. AFAIR at least.

But hey, what do I know...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

