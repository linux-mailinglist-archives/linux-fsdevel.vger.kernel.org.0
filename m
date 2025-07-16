Return-Path: <linux-fsdevel+bounces-55087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B7B06D35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A561AA7767
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960CF2E2F1C;
	Wed, 16 Jul 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22B1OU6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4idTolZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF22E266C;
	Wed, 16 Jul 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643851; cv=none; b=uhJ1Y5fYymDedv2Gj4rreJgI8pSfHFa2W046mjb+lsiBGmo80fHcu0x2w+Pa7bXreYK6qWMRTCVdKqIySQYlohw3mwDmW8Nqqc5+1ni41wTyG1e3Y/gQTkukKZPxMV2u9uW4xbB+suHtT+a6JgZ5fTRFGhtT8UDVYPVvsXVUixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643851; c=relaxed/simple;
	bh=v9qQLU/BJWXqPyZKzovvW05GyhD99N/9jPNz+XBBLog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqGkPeTCVe6MxpBevnaZe+cUGaZEkSAf9BR12+0Zzbtc52AOGohA1iG6HDddiercNAA+kq9HeoWbTq+VOVrORM5vj/iA4hu9SD5KeADpxWgfjeX5n24QakV40WDrlc/OTo2b0hq8gphB7kvHGK8LW9ntq0fWgXf633SWo2FTY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22B1OU6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4idTolZ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 07:30:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752643847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=597Uwv/nwiJEMg3K3zUxrHDVxe9LBCiZrOEhEZo5dRo=;
	b=22B1OU6pS5tefu3luqPb6fEOSXD/6CwZa27JZz1GRbDCqje6uLI9E0etqx/LLmz90gTXHW
	XYCrHB3YsLs6gWMu6cil3228xEI/XVmNuAOe72G98Vsymx4b2Pw441B/ttpXtrE/tfm90S
	bHmF5MlDbfxgHJFda1PEdaI2oHwxxwWzMI3TIZ3AeuVZ/fTbt2+jjqEIRldq8V6FL1+aUm
	fJPvKI2EIT/UQt/xkGSvU88tDYIEtGyuvfw9IRlNTrCzLuOT9fTAVu1FvTv9yZXN6gs9uI
	+C9J4umDr8d6FlZpAzd52VsK5HiOShXhMPDtwWDh6xhqrTM1S1eVCcYMMgPWlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752643847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=597Uwv/nwiJEMg3K3zUxrHDVxe9LBCiZrOEhEZo5dRo=;
	b=4idTolZ/c/zsXRlNtYQJpqLSXlkJIPkOsaCx9Me1aK5BRbgFAcrGLsASCjJ0SK+8HEr1vE
	gzll8GyMnjdvsZAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>

On Mon, Jul 14, 2025 at 07:52:28AM +0200, Thomas Weißschuh wrote:
> On Fri, Jul 11, 2025 at 04:44:23PM +0100, Al Viro wrote:

(...)

> > On Fri, Jul 11, 2025 at 12:35:59PM +0200, Thomas Weißschuh wrote:
> > > could you take a look at these new symbol exports?
> > 
> > > > +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
> > 
> > What's that one for???
> 
> What are you referring to?

Reading this again you probably asked why put_filesystem() is exported.

As I see it, that should be called after being done with the return value of
get_fs_type(). Not that it does anything for the always built-in ramfs.
The alternatives I see are a commented-out variant with an explanation or
making put_filesystem() into an inline function.


Thomas

