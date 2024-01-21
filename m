Return-Path: <linux-fsdevel+bounces-8377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C079835854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EE7281BF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A0638FB3;
	Sun, 21 Jan 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFdc0s9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839038F96
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876971; cv=none; b=kfY/oAq3KaypPgbGhwPGjLZipwUEpX5Hqm6tRr9XyAlZ3XvW4ftiShY+07yh8DVU2/MUkxNX8gmHwfmpymlL9asQxhu4nuGYKCxxwcKpl59rjziMSnnfJUKelI+2Vf3Q75lt8K51Ae6ixFu6QFemlp9nTN/GWn9wXjPlpRC3nZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876971; c=relaxed/simple;
	bh=mtq5Ct3DiF2+05ZYvmewRcHnK5+uLUY7o2GpBZ+pM0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBLQH5uWJOgNUOYya+CX8PdRXKQZSTg/CEouDxTBX9E9a+A9UFNd5WsBlTYISuRzpI2EJPe/sFjpqGlA/skNeW9bDFkq3YIFDf3MFHX8WdmD4sCk+gxQhGnfkLG+Jw1za/Qg05gMOWehbBf5YxroDnAsRtTGVghuQ1NuU5OcoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFdc0s9x; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Jan 2024 17:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705876967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8eHWGuuA6Pwmzz/CjhK4EVo4x2Z5WhhRU/5WA4RF1s=;
	b=WFdc0s9xUyn6nQEJNVxudMARxSnm7N014DcbqDkxHrMtM9UvqsxvsoscvY2tcL69HJI5ZY
	3ihZAy4JTDeY8OhP9K8ZjUYKdrEbFcXjirw0Z7ZZ0REAAWZ+zuselHFLqksUbtzB/sl+ic
	pHF42d6ehgj1JgxVpGpxROQgTZyFPfE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] More bcachefs updates for 6.8-rc1
Message-ID: <ianqurcjmgjvciii3k4dxr5bwargskiwspnfzzy4dqhbn2sdgp@r3v2ysfo5dqq>
References: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
 <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 21, 2024 at 02:05:55PM -0800, Linus Torvalds wrote:
> On Sun, 21 Jan 2024 at 13:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Hi Linus, another small bcachefs pull. Some fixes, Some refactoring,
> > some minor features.
> 
> I'm taking this, but only because bcachefs is new.
> 
> You need to be aware that the merge window is for *merging*. Not for
> new development.
> 
> And almost all of the code here is new development.
> 
> What you send during the merge window is stuff that should all have
> been ready *before* the merge window opened, not whatever random
> changes you made during it.
> 
> Now, fixes happen any time, but for that argument to work they need to
> be real fixes. Not "reorganize the code to make things easier to fix"
> with the fix being something small on top of a big change.

I thought the merge window was still open until tonight?

