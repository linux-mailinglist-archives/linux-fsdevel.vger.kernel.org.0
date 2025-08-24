Return-Path: <linux-fsdevel+bounces-58887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC8B32CCF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA741B67369
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 01:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AA13D503;
	Sun, 24 Aug 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="luZ0m6kE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311923CE;
	Sun, 24 Aug 2025 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755997591; cv=none; b=pCmNT++scIlTZTmkinqbgrpZBrQSLDUlcWJa05TUCYnqnm9PV3BgoIBWc//4inmW46smFCuwkhgaosnoIe0WFz5gymPMVXt+hR62NHI5Mad1Fu8w6/Dwi+gyvWDnNsF5vmCqw90H8m+eZqbSHr7OPlYHqLpEG0gbQKMM4g70I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755997591; c=relaxed/simple;
	bh=/lja6jJTmTSGusLUTyt4Qyv+mpP9FOiytbBhnZ/bjBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUvCEDEyC9AfHxA+xxXkikyEuAx7BG7/aevtcjLPJFjsE34WoxUVHpm0tJ3sb4gQaq+VCyD/lksqjyCVrX5TVGOG0U8Kz4XQRl4DxP1L2d4qDSl0QWYNCSoPflak9NeMdN0CIXJciW6ZJ294IJAeTeN8eU7EXd0M/rVwIezuj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=luZ0m6kE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HKAtpjmOKvvT2XFymHLvvZsfMsNBeBaBPgqQORjUgbg=; b=luZ0m6kEHOrFDRgMrD0c7hQLOS
	twgBKiC65Twcb4QvEapn0nwmFUR3xtX+5NbQdEF5ZndFZl7zskNn30kU4d+r+bGyjvKVCCUIw9s0u
	2OuFHeDxbXplCMzH9VaYA1377p3OojHNZRaM+JiLakzOShKkZiHBJrO8d4zoVVkXsoM9qrM5+SXnG
	zBTdP/Kj5ZbT4H2zrZRCTnGXW2sr9h7o1ha8nmVssxWf7mX10H2ccVCw4ftY7dpZpG95P7i12T1DH
	Q9XJc/xZ/lqSn5ROHp6AEkBa/JAkMo7D13uH990DTdYk7f2lHnyja2g2zniiCohUZVqmzm/8jCjVk
	SPS19n7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upzBf-00000002zoh-3h3l;
	Sun, 24 Aug 2025 01:06:24 +0000
Date: Sun, 24 Aug 2025 02:06:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: skhan@linuxfoundation.org, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Document 'name' parameter in name_contains_dotdot()
Message-ID: <20250824010623.GE39973@ZenIV>
References: <20250823142208.10614-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823142208.10614-1-activprithvi@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 23, 2025 at 07:52:08PM +0530, Prithvi Tambewagh wrote:
> Add documentation for the 'name' parameter in name_contains_dotdot()
> 
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>

Out of curiosity, could you describe the process that has lead to
that patch?

The reason why I'm asking is that there had been a truly ridiculous
amount of identical patches, all dealing with exact same function.

Odds of random coincedence are very low - there's quite lot of
similar places, and AFAICS you are the 8th poster choosing the
same one.

I would expect that kind of response to a "kernel throws scary
warnings on boot for reasonably common setups", but for a comment
about a function being slightly wrong this kind of focus is
strange.

If that's some AI (s)tool responding to prompts along the lines of
"I want to fix some kernel problem, find some low-hanging fruit
and gimme a patch", we might be seeing a small-scale preview of
a future DDoS with the same underlying mechanism...

