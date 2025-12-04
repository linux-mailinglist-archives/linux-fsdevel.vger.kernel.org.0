Return-Path: <linux-fsdevel+bounces-70639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA5CA2F17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9142230263C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA9334C2F;
	Thu,  4 Dec 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PmLKIth";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9WoiIi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB63081C2;
	Thu,  4 Dec 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839836; cv=none; b=a9TnJuI9wW3sJpdjstXa1mVBzo65H/1ZsSZq8JJpu0VrY6ubZRzkPZbmJW4EzTiyVSBRbT9q8mWZHUfkBmeeEieeMSeHZQqcstJ00tyUArCMe0SU83esjT3/lapY4pxDJCgmCBinWB1SDXYYTamzQrozp4n4b50+lemib+3QZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839836; c=relaxed/simple;
	bh=+i6dNurwDuIZPHOkqeNhRlV8j/tXCFDQrMQ435bByyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUQNM5Dl1oU4lvSbqP2QCQynW4YdOQlUg/hDS4jeJzSjJAgcuBWvg6CMRFvhTCrAx3IwQigC3iEuq2CoFqpFCalMFIHtfVTNjVR7SYFKaoFFQlnba05MQ9163fnGx2PRZ+G2aAOPzMSdR3BvDFUKaVUYFb81SsGCUKqXSO2K6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PmLKIth; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9WoiIi5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Dec 2025 10:17:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764839826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xPHwlaZ+YZXdGHQoOXWy8JwAYnPRZXc46nEvIApVTo=;
	b=1PmLKIthoyTQutHHT4PVHmSqmeqdTSfU7WWKS18W8zWShj6dp542UXB3WJ2mxwLEWheetf
	U5g+uqPoEvOCxNP/RT65D5eAbhj6w+jndBe+WT2OQ3O6tAsrfo6+S5hrdSrdYZlMHz7lDZ
	VDQolwFNVFiN85w9jSbwY2QAOO7PncS838nwLveRitMZIk7ZoE5PkO3gTaDg/0GjP/rWLM
	lB4jo9nBWkTl7OIrR0NIRBZqyVRX44LFOehnJSShOHZlD+eUSnLE+XoGbgxzzGDT39llcF
	M0QtdyEeRltBuQzWs9wvXH6isqw5KgFwh1qv4+J6hTCPja+zO6Wrj+CUkvYwIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764839826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xPHwlaZ+YZXdGHQoOXWy8JwAYnPRZXc46nEvIApVTo=;
	b=i9WoiIi5+2e9Ur41FXzvcosBIWbWe+XCOScq0MJKDONLurQ6xp2QaXTqi0ntdqF4V+Yxap
	EN3/lGQD5fJX+ADw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Message-ID: <20251204101551-fac92797-fad2-4104-bd07-a3069d39f1f5@linutronix.de>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
 <20251204-haargenau-hauen-6d778614c295@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251204-haargenau-hauen-6d778614c295@brauner>

On Thu, Dec 04, 2025 at 10:02:05AM +0100, Christian Brauner wrote:
> On Wed, 03 Dec 2025 14:57:57 +0100, Thomas Weißschuh wrote:
> > Using libc types and headers from the UAPI headers is problematic as it
> > introduces a dependency on a full C toolchain.
> > 
> > Use the fixed-width integer types provided by the UAPI headers instead.
> > 
> > 
> 
> Applied to the vfs-6.20.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.20.misc branch should appear in linux-next soon.

Thanks.

Given that this is a bugfix is there any chance to get it into v6.19?
Preferably even -rc1? This is currently breaking the nolibc tests.

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.20.misc
> 
> [1/1] vfs: use UAPI types for new struct delegation definition
>       https://git.kernel.org/vfs/vfs/c/b496744de0d0

