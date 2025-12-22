Return-Path: <linux-fsdevel+bounces-71819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FAECD5843
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 11:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4320130567B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532943128AE;
	Mon, 22 Dec 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TG/Gbp8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BfFRRnf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE527312820;
	Mon, 22 Dec 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398243; cv=none; b=ddTpgqgwDwFR76q+nXh6dxWCEzgJbqjXD7hc8PevimxsxRQ+Nvgc/SZCgEwqwPAu15uwZdqUe1wJtE/vVNfIfs0YkRB+M/9efj5Ypa1YjZnZFVZYPSXE5Y9Wdrfj2nI6B8LgPf9IkxNKbUnuTl/EjcXpy2RpT0ogOXhTBAYOrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398243; c=relaxed/simple;
	bh=El+QgOQoL0dHGW45zPCfODFN5tT2KfagLc3tQqcC8ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq2hWtkaBLIafTIRt3/vGgVgBS8ySlB4CXv+sTatt3kHIxv7Ndod8h1hwJ5VR4vzoWGqGr1GaBhfKjdHZi1ktjD3j01BTsv5tIc3MlgLoAuQdrHleeMZNDQOJBx3BirH2BaWCcRv8mZm/q00Itn5d5E+aPDH72ScjlqVQx4s2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TG/Gbp8U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BfFRRnf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Dec 2025 11:10:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766398238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RN1bU46CphtjGZMZAyqmD3P8daZNuypB9j1Czhh8tU=;
	b=TG/Gbp8Uv6IuKFrnGEDXGYNb8FcBSJAFs/CgcKPsD7VIEs1c9IyN4DfYZQ8QBGPW7WI/7r
	KNlIAzL+t7puKDXiLtRyL3TlcoATUGqpd9FqQ5X/ZJ2VWhI0IyI3xOGlIGZs5j0QYiWN/v
	BG8fN+YtYZO5/z1KssTty00T4Mf3OudeS0fJrnjhUapcbNC7duC4HfcsgWToDnk7qKR8S3
	hC0G6uBM+g3Kdner1RiNoS6yoKU8TSPKgcT+MnwxRPNToUVI2wRQyjOIeB67gLPvHwN74c
	/fLm37MSaBBKoLD2c79XAdrQQuE1YZu4JiwLncTGOvzMFPw3MBARSMMrVe/t+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766398238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RN1bU46CphtjGZMZAyqmD3P8daZNuypB9j1Czhh8tU=;
	b=BfFRRnf+ctm5qPDi0ne7jFFyLxdIqUw+31bZxKH7TfOWy9L/6jmEESfqC/w1sXCKDxIyPf
	6DgiiQB4evbd8zDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: uapi: use UAPI types
Message-ID: <20251222111015-6697b41f-0dd3-44b0-8433-9e0849c40b19@linutronix.de>
References: <20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de>
 <43f1fd40-438a-4589-a6f5-7e044a9a3caa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43f1fd40-438a-4589-a6f5-7e044a9a3caa@app.fastmail.com>

On Mon, Dec 22, 2025 at 09:54:08AM +0100, Arnd Bergmann wrote:
> On Mon, Dec 22, 2025, at 09:06, Thomas Weiﬂschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> >
> > Use the fixed-width integer types provided by the UAPI headers instead.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Please check the whitespace though:

Yeah, I forgot to doublecheck this patch.
Thanks for noticing.

