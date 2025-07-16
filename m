Return-Path: <linux-fsdevel+bounces-55156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F556B07618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F103B961F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912262F5318;
	Wed, 16 Jul 2025 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBXk9ORg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wpPEXIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F822C1A2;
	Wed, 16 Jul 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670033; cv=none; b=ulRwvz4PWDZ57e+Rww9M5NaxvujL7a7hdAJG8Btg60kgP3NsVPhHI5e8nMTzegbvzWLEmwKrg35XaP4vYCjRz6PKh9veOPWks7BaHuMAg0j2XdggmxFy5ATTAhXo5+Nmp0uiCwak16hQnLSn6Sul23wD6lOxMwRG/9MKGc3zEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670033; c=relaxed/simple;
	bh=E33oCGnC3dSM3GzEUM81/v7+bAKmIDujf+HQ8+qfR9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dim8PsRnE4hHmjI19JDJRE0IPJSK6GL9vBQ4ZzjSoMv9vXzHvd8OFnqDhSDJ5UYelON+GatBJD1Lb7631UE1cDjFyDVtdqUlaj7FVKJ6NIbYbry47DT/sFYujQpHel3tEWky+5EGT6rfBuBz9KpvmLJDXsPtTP9OUVvnY6cLyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBXk9ORg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wpPEXIQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 14:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752670029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqfXUKy/vI83eF5nnnMHFFlDFX1raXpxewjeTec5Ggo=;
	b=hBXk9ORgvip2fx1qyGcConFE63IkenS1aAXA6eJ6doGYW++1cU3VJSc0JzMFQj7LTWshqk
	Vhquw/noFUdu6pxfO7FPkb5czREFUp0MBUrDfqR2d/vluvtY/G7lH7+KuWqB03OpaoInRs
	L/B+kjzkNt5CHR2QoZ60Jv17oeMK2neWMSYK44dxthcG145eSDybmwFox21j5NxnRa1NoU
	aj/eQABZqwK7WtQUr2WWbAkRUgLkoz85F5O/djCoFSMPAXMX9ikBKZ+UrxTA9IqPVVYS0e
	9OdqKFV4RnZ+d17O6Yo7bXW/9aIDUrlbpV7vxhihos6ZoopawP8NFRbaiDMkhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752670029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqfXUKy/vI83eF5nnnMHFFlDFX1raXpxewjeTec5Ggo=;
	b=4wpPEXIQztKghYoI9EjheWn47o+FrWS3vgZvNaE5ZQ8pjZYorhP73E+pv8wj4oRarkW1Xu
	6Hu3/+yQbFNOXoDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250716143500-d42ea724-1bac-476e-80b8-1e033625392a@linutronix.de>
References: <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
 <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
 <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
 <aHeIyNmIYsKkBktV@infradead.org>
 <20250716132337-ee01c8f1-0942-4d45-a906-67d4884a765e@linutronix.de>
 <aHeOxh_yaQGFVVwM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHeOxh_yaQGFVVwM@infradead.org>

On Wed, Jul 16, 2025 at 04:36:38AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 16, 2025 at 01:33:05PM +0200, Thomas Weißschuh wrote:
> > On Wed, Jul 16, 2025 at 04:11:04AM -0700, Christoph Hellwig wrote:
> > > On Wed, Jul 16, 2025 at 10:39:57AM +0200, Thomas Weißschuh wrote:
> > > > Let's take kernel_execve() as example, there is no way around using this
> > > > function in one way or another. It only has two existing callers.
> > > > init/main.c: It is completely unsuitable for this usecase.
> > > > kernel/umh.c: It is also what Al suggested and I am all for it.
> > > > Unfortunately it is missing features. Citation from my response to Al:
> > > 
> > > But why does the code that calls it need to be modular?  I get why
> > > the actual test cases should be modular, but the core test runner is
> > > small and needs a lot of kernel internals.  Just require it to be
> > > built-in and all this mess goes away.
> > 
> > KUnit UAPI calls into KUnit proper which itself is modular.
> > As such it needs to be modular, too.
> 
> Not if you depend on KUNIT=y.

This is exactly what I did in the beginning. Then I got told about the distros
using KUNIT=m [0] and decided that it does make sense to support.
We'd have this discussion sooner or later. But I'm still not sure what
difference an in-tree-module-specific export should make.

> > > That being said some of this stuff, like get_fs_type / put_filesystem
> > > or replace_fd seem like the wrong level of abstractions for something
> > > running tests anyway.
> > 
> > This was modelled after usermode helper and usermode driver.
> > To me it makes sense, and I don't see an obvious way to get rid of these.
> > 
> > Or do you mean to introduce a new in-core helper to abstract this away?
> > Then everybody would need to pay the cost for this helper even if it is only
> > used from some modular code.
> 
> I have no idea what you are doing as you only Cc'ed the exports patch
> but not the actual work to the mailing lists, so I have no way of
> helping you with the actual code.  I can just tell you my gut feeling
> based on the symbols, and they are something that doesn't feel outside
> of very core code.

The actual code using these exports [1] was Cc'ed to both linux-fsdevel and
linux-mm. In addition to the cover-letter and the exports patch.
The rest of the series does not interact with the exports at all.

[0] https://lore.kernel.org/all/CABVgOSmdcOZ0+-k=SM4LibOVMKtcbF27p6N40kuDX_axTPZ=QQ@mail.gmail.com/
[1] https://lore.kernel.org/lkml/20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de/


Thomas

