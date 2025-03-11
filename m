Return-Path: <linux-fsdevel+bounces-43732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65796A5CF5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65F13AE568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB02641EF;
	Tue, 11 Mar 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JuT4u340"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04A2641F2;
	Tue, 11 Mar 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721340; cv=none; b=KjJgJ/uwkfDwIg9CGCgyqzE7pdo7OgY5FlSqd2HkbuNsmFaaHZ50qkL4AaxASD+pBPe2ohCaw0fv9sycavVPkZW6tDzlnSX5B3t3aWFlc60gR8w12s59iWra7GDVq4N/ddIcEihQd5AgNgW9T30+wfSwX8M89wcVg1QUtJR93fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721340; c=relaxed/simple;
	bh=ckOQ5DVeQ7G6zPTXIPWg0N+133mH477tzc8eWLtJ/uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MffSFgdgHmfT5ufnbp8Ge75M6DA/JfoqxPyRuaqw5pk7tlhlysokUe2G8fQ5LEZJqt7quAdwzzt9tB9vFGGhFnM3+RCGKCG+E9PoENmn6g7Cs1k0+HbZyTqDI07X7G2g31h+FslkaP+Te5DiWA4YJajJQyu5Kl9sEoNsFRKhc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JuT4u340; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZC3hw5rkXzC41;
	Tue, 11 Mar 2025 20:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741721328;
	bh=0Kv5AquxqTfaAo9UNPr4KiZ+3PfiqgdgmdtBkHrZlLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuT4u340X5FvPqcVpUrre/vXvc8uflgQ/iC0Ow2bt53sler5Jzad1mEsn9oMkopGv
	 MZ9l7xMmGo+04jnPe5Ux4owLcgScWp+znpGpqGcMyr2pepAUjqVHTLv6wPZtJ2ZOiO
	 CFiqK3d+cC0q/C6hhcfsFcv41w7o3aRGvQSlLLc8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZC3hw2cybz9ZZ;
	Tue, 11 Mar 2025 20:28:48 +0100 (CET)
Date: Tue, 11 Mar 2025 20:28:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
Message-ID: <20250311.laiGhooquu1p@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
 <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Mar 10, 2025 at 12:39:04AM +0000, Tingmao Wang wrote:
> On 3/6/25 03:05, Tingmao Wang wrote:
> [...]
> > This is also motivated by the potential UX I'm thinking of. For example,
> > if a newly installed application tries to create ~/.app-name, it will be
> > much more reassuring and convenient to the user if we can show something
> > like
> > 
> >      [program] wants to mkdir ~/.app-name. Allow this and future
> >      access to the new directory?
> > 
> > rather than just "[program] wants to mkdir under ~". (The "Allow this
> > and future access to the new directory" bit is made possible by the
> > supervisor knowing the name of the file/directory being created, and can
> > remember them / write them out to a persistent profile etc)
> 
> Another significant motivation, which I forgot to mention, is to auto-grant
> access to newly created files/sockets etc under things like /tmp,
> $XDG_RUNTIME_DIR, or ~/Downloads.

What do you mean?  What is not currently possible?

