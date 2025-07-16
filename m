Return-Path: <linux-fsdevel+bounces-55145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D3CB074D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B677D16FBBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2D2F3C3D;
	Wed, 16 Jul 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFXun/AC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Si8PLErS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738B2F3C2F;
	Wed, 16 Jul 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665590; cv=none; b=Rc20K/62xUZ+hshLV2acxfzAXScKH6ptBXRJy9sr9rES15tTUQF4YQFZ/ckTprQ4osBDBoN1UI9GGtEgDo3Y5NCEZxEnUTREz9sbhKc6MFHod9x13vk+yX8j7gaAB5sEwyhOVBSRmdw8Vd4nPKm1iPFm/M26WIXOcbH/H3Ku6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665590; c=relaxed/simple;
	bh=Nz+LqjX5AqtDcJiAJNGSPoYRY8OQXHSZ1/YtE9z2tQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt/MTnIiYer1Kk8TXX5ovlQNqV+/DMIxX6K1CPv7/xLDaIyYL4qlo+U1GLKfjBxKLKIDhFHBMDNaMgrzhHMcmLQA3fEZe6FzRLBwMo1C0HH8Vy4OybzjqZj63w86jHgUu9GH0nKixgZSv2gy0X9MQZSk2PSfz/AotLT3BsyqSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFXun/AC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Si8PLErS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 13:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752665586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kR7LcrsxKijUwYNswy3miVNVgGptwZeFr0D7nxGSi0=;
	b=mFXun/ACNobdrZHYzesF7z9GzYnPHb18tVL34S3wEmE5Rh49G7AW4BHng/O1UVq0UAZRcx
	kN2lCKQa0s2UsYE1NGaa3WMU+XcbbEQ1bpxRnHn+0Lm7D4yemXsguROhSy+RZoiVGHneCg
	zqThnlw27fSVpjfz1yfgxRAFFbTTJmjqALScf6a0/a1sn+bvkAgyQiKt8LkCDibN9fq/yD
	vLgNtcjMw7qrxmb/IY+QPwrDN/g442GUQ767XAvghprBijHYyfBwVeVWUoDxrPG2hQivad
	rJS1+ebwtvQOoIBtL3777ceqYu1NzA4Zob8FA6/6E03XabTn9Cnhvz/MkrXM/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752665586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kR7LcrsxKijUwYNswy3miVNVgGptwZeFr0D7nxGSi0=;
	b=Si8PLErSndRrX68Q3AZundbYy3m1S9btk3KOsHGMdRDELFjRkRwqPDDOy7bp21y+XGiAXN
	H+vO6vTJpqYF+5BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250716132337-ee01c8f1-0942-4d45-a906-67d4884a765e@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
 <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
 <aHeIyNmIYsKkBktV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHeIyNmIYsKkBktV@infradead.org>

On Wed, Jul 16, 2025 at 04:11:04AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 16, 2025 at 10:39:57AM +0200, Thomas Weißschuh wrote:
> > Let's take kernel_execve() as example, there is no way around using this
> > function in one way or another. It only has two existing callers.
> > init/main.c: It is completely unsuitable for this usecase.
> > kernel/umh.c: It is also what Al suggested and I am all for it.
> > Unfortunately it is missing features. Citation from my response to Al:
> 
> But why does the code that calls it need to be modular?  I get why
> the actual test cases should be modular, but the core test runner is
> small and needs a lot of kernel internals.  Just require it to be
> built-in and all this mess goes away.

KUnit UAPI calls into KUnit proper which itself is modular.
As such it needs to be modular, too.
This also makes a small always-builtin component annoying as it will need
to call into KUnit through indirect calls.

But again:
I see that it makes sense to restrict random out-of-tree modules
from accessing kernel internals. But here the symbols are only exported for
one single, in-tree user. What is the advantage of forcing this user to be
non-modular to get access?

> That being said some of this stuff, like get_fs_type / put_filesystem
> or replace_fd seem like the wrong level of abstractions for something
> running tests anyway.

This was modelled after usermode helper and usermode driver.
To me it makes sense, and I don't see an obvious way to get rid of these.

Or do you mean to introduce a new in-core helper to abstract this away?
Then everybody would need to pay the cost for this helper even if it is only
used from some modular code.


Thomas

