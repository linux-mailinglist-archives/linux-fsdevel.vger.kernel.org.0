Return-Path: <linux-fsdevel+bounces-74234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE3D385CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BB48301C34A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D53A0B1D;
	Fri, 16 Jan 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WgX6+imk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642203644CC;
	Fri, 16 Jan 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591648; cv=none; b=aropFfetvdXIR86ZBd6eKJkU7OXknDXUx3J3Oeygvzy8zjBLgwyNBPeHXAtennK8rdp99ZoSW9N3gcuaI0yrncGVqF+bKCkebo9DpT4facQohpoTdGct4EJIjQlS0RAH4jUeq9/ShPBapKYadLrFSZNiJeroyTdPAakGwgUAbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591648; c=relaxed/simple;
	bh=Lp6ehBD3QHZJLR01CDWLGpcwUq3e5ShN7osXBR3t36E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A5Hcn+qvuknQLljSllER/LWxFhe+SmPqA56U4rDvkxrCTrXEjDTFmMT5mSyCatK3y+sO3mUXmZeX0B98rDiCqcar3zO9F90huj/p3NPkxgGDRTJpipA+G9szKNcfFPh2YjHnXFWh5d1j+TgHB6mm7jMaLHOUwlr91WgA2YpewiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WgX6+imk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A727840425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1768591646; bh=GrPaD38g+pXSIroomzoA1woRAXCB/+QRFuyOOw8Q+Xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WgX6+imkwi9Q9XdI0xgLaU/fWn3FKexytNCwXuYeKdKdshizK8asLdbrvIibNbkkx
	 KyAy8qbZqZcux5RWpaSEyC+l8peiy42BxVJB0Qg07DJUGMiIdKGIqhgGKsf+px3nIw
	 WCMduRMXOTWKrDpPAi/KiYM5lQxfwP5LnxCq9ZBoCG9rZU31W5MnLknagr679iM4Pg
	 6N3CEsNYHQHLGuLMDbnZOPjUqh/E7gq4kGKNh2oyGwzpb/TZnZyXYXcoStsPwzPdr/
	 2Df8JvupYOiMMmMXsBTu5m6QyGWzR+O6a0fiZtwv8GreJ1f6NZqQI2wU5+povUxxxn
	 0bQ5Tw1e9E74w==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A727840425;
	Fri, 16 Jan 2026 19:27:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
In-Reply-To: <c7d47b56-2d37-4893-b8ec-1fb23f75a55e@infradead.org>
References: <20260104204530.518206-1-rdunlap@infradead.org>
 <871pjpo0ya.fsf@trenco.lwn.net>
 <501f8b16-272b-4ea5-92ef-6bdb6f58f77b@infradead.org>
 <c7d47b56-2d37-4893-b8ec-1fb23f75a55e@infradead.org>
Date: Fri, 16 Jan 2026 12:27:25 -0700
Message-ID: <87wm1hmk82.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Seems I was confused with fs/namei.c, where I see similar warnings.
> I don't see those warnings in fs/open.c.
>
> I'm using today's linux-next tree, where the latest change to
> fs/open.c is:
> ommit 750d2f1f7b5c
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Dec 14 03:13:59 2025 -0500
>     chroot(2): switch to CLASS(filename)
>
> Do you have something later (newer) than that?
>
> Also, at fs/open.c lines 1147-1157, I don't see anything that would
> cause docs warnings.

No, docs-next is older - based on -rc2.  It seems that linux-next has
significantly thrashed thing there, and the offending function
(dentry_create()) moved to namei.c...

jon

