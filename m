Return-Path: <linux-fsdevel+bounces-23681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1249312ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0138B227C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A534188CBA;
	Mon, 15 Jul 2024 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUH0xjt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7A1F608;
	Mon, 15 Jul 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042266; cv=none; b=IWdxTM+AxuWMpdriWf4QC+hxfxydr9mSycmoSDZEnuFbPyYRsRxElPF57xMa01n5G71htXq3gJj+B4VqHDatkow6rG6uw9X4yrFuMn6sUpgHc8sAWySUgYQdBRx6w3DfkcGtXsvqBQaqRHnz9r7PA4TrhJOkKpBTGRjnxv0qw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042266; c=relaxed/simple;
	bh=fCsSADAmC76MZfAtmdlnHtczqWiZgd+HqCzEQfSP00w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XguvOSpgLMPRFtiy0MJe83genumGcFlyHwhEFv72jY1KtYcLQr40WoucLPEPw2Bmd1X+tEAIs4lpteGW4ThWc6zplwkFQqQ4KHGhmJD0niVvoaTVVWkD+AJa/dbBgO8fgiIIPK/DGWRe+M9nL5s3DPCtbkpYsJZGNu5Obw6JwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUH0xjt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0911C32782;
	Mon, 15 Jul 2024 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042265;
	bh=fCsSADAmC76MZfAtmdlnHtczqWiZgd+HqCzEQfSP00w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUH0xjt+dP3MPZRMuPgpri5BwC/9lez8FpjS+SVFnecoa2FCRQ6q7XEkZcSf6d19W
	 fnB3WR8xB5qcSLiD4o+p2z5B0BlZcRSoOEItY8Mq22Af45s5YNLMFrhVZF7iexpOPL
	 0UHa59NSuCwEmT6KvmMccO16rLXKx9NZbcrGXJxMoCmNR7H9OSp+AlMoxxJjv9pOfB
	 HngDckT64yARsGYbljy3Iyu+EoMxyoBqa/5WK+p+luVComcAeSxdMOm+R8yKYKWkRB
	 qlPnX+ApGYDhEph3ebj4S+mLKAPgmDXbon9GuVotMReYVTrkPfwzeFD01b3omeZVwx
	 x389IjdtoVA7Q==
Date: Mon, 15 Jul 2024 13:17:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.11] vfs procfs
Message-ID: <20240715-absprachen-siedeln-858a949e10f1@brauner>
References: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>

> years various exploits started abusing /proc/<pid>/mem (cf. [1] and [2]).
> Specifically [2] is interesting as it installed an arbitrary payload from

Sorry, the two links were missing:

[1]: https://lwn.net/Articles/476947
[2]: https://issues.chromium.org/issues/40089045

