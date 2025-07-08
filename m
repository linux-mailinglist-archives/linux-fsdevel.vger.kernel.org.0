Return-Path: <linux-fsdevel+bounces-54218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A552AFC243
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622AB1AA15A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745621ABCB;
	Tue,  8 Jul 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8n0lnY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="INR+2vDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952A645;
	Tue,  8 Jul 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953870; cv=none; b=q/KWeTWTbMXB8Y/SI6N4Jm8AWcduWy3l2nrgiL4hfrpa+fAbUJz0sf0Oqh4JXCgQ2WgapygpvSpHp2/c6uQfmWx4IKWnOUZhTmXFFkcavfVkGbQYY32N8ynLU+xImO0/soPOfXX+a144SlnffKBdyQz9q5r2aYshBrnQJ4qwpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953870; c=relaxed/simple;
	bh=JNXE1M1GfAKMAx2fUOYQYN/tMN4M5F8WF2dNBw1efi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXq9ic/8B6chehkwdabvQKrRMPUbCX+mnG/NRwLa2dXXN8XNtJrHp4t7wRqJNmp9y//5oteC/U5+h1Om2CNC89QJ17uOZHMiNgTXmMaUhmy6m2toJPqzJSs8pPpXWjpVnmClFU9WO5b2m3sdzfx9g08ZMLB/MABVaXfeRvua9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8n0lnY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=INR+2vDk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 07:51:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751953867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yXuyD2y1tDDXkXTAWSlgEy9p6IqbbB6Wt8X6nTw+yw=;
	b=n8n0lnY/41yNWuVFmE+/ybyOP7pjLAwdANsDu25x71x2iLUxcY2j98kP0F8IoS9FeO7nIB
	IuiHyWSc18jAP1if6ai8eCvUJoqp6CvshYC8CvvYwGDJa/9Lus7SuGLTN3VaxQED5YS/Ex
	VH0w/KUQm1QaF+ubfS0VOA/r/kxzFMCpcKkme3lLmILlBhEaFfgQEMrJgudahurUvcDd32
	plT7rsth56Fi+OXvHRJqFLgcpYBS+JVcRwVJHZfrnPsmrZCaQJ+LHIAfbXV0D72IsEmGQC
	c2dZgSOa1FTNz121Sb7dtf1zTY16SqPNYIvjpINbMX6TtDWuODLeHDozG8UaZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751953867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yXuyD2y1tDDXkXTAWSlgEy9p6IqbbB6Wt8X6nTw+yw=;
	b=INR+2vDkhbgRjXvWu5PX2SOpL4900BafsvNCjtbJR9vEisIi3Sh4QioImKSLts6+T+8tX3
	bWVpeAke5ucjk+Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] kunit: Introduce UAPI testing framework
Message-ID: <20250708073940-c2e9ee11-549b-4ef0-a480-942d86821f41@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <87qzyr7tly.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzyr7tly.fsf@trenco.lwn.net>

On Mon, Jul 07, 2025 at 12:18:01PM -0600, Jonathan Corbet wrote:
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> writes:
> 
> > This series aims to combine kselftests and kunit, avoiding both their
> > limitations. It works by compiling the userspace kselftests as part of
> > the regular kernel build, embedding them into the kunit kernel or module
> > and executing them from there.
> 
> Please forgive the possibly dumb question but ... this series sets up
> the framework, but doesn't actually integrate the kselftests, right?

Correct.

> Will it be necessary to write a little KUnit glue function for each
> kselftest, or is there some other scheme in mind here?

With the current framework it is necessary to write some glue code:
* A stub .c file which #includes the existing kselftest source
* A kbuild userprog Makefile
* A custom KUnit function which calls kunit_uapi_run_kselftest()

A more high-level scheme may come later, but so far I have not worked on that.
It would be nice for example to build and run the tests for all ABIs supported
by a kernel without a lot of manual code duplication.
And maybe have some higher level helpers around declaring the tests.


Thomas

