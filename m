Return-Path: <linux-fsdevel+bounces-32619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2F9AB7FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308EB1C23059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109601CCB25;
	Tue, 22 Oct 2024 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/pl3X5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657861CC156;
	Tue, 22 Oct 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630174; cv=none; b=Njp873TPwqvOYvA41u573vkHURemTI1kF6QecGZdCJMFGdxTlfkZ2f0ZfIn5qLHeNfg63SSrqcuBpxdmP9bclx3m4JS/0U/3ie/RS6DCA3epkcpH3LkvqOCpJquNbq/g0imP6WUBWIM21uVoR/5i1f2eMuhhF4Bo5bWJ0MHjeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630174; c=relaxed/simple;
	bh=4VGjKCLzilV7dqELrN8bWqYOVQXNIfEmFdVw0bFlQf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/mDXjk+TA4BUqZdmUU0h7mWiuOlIa3lL+h5PzSVHOwWtKgEYMcjxpaHofPXgtXMqME6ovUorpe7iUFSfuXE/OL0bqFjL2o2UZEoy04f2aaI3w21YHX0nWdvy598h9lirf/7POcAqY3r81f45bXLZ6zP+aRJgHAIrjfaqxAecM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/pl3X5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7BDC4CEC3;
	Tue, 22 Oct 2024 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630173;
	bh=4VGjKCLzilV7dqELrN8bWqYOVQXNIfEmFdVw0bFlQf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/pl3X5mBfGW5pzZMysfAYWOQCfGZXNSSdwmU9RFNdmu7QSFH1wtccw6/Ztlus+0M
	 HL8DM5rNccJcKSQpWzoF6UZCmx2BQ++RNp7bYQxMgnYANecw2TjukJsERLU5LUfuHg
	 UR4vPLbCxaCPC2nyjBApS2OwVN58DvVeia/yA8gvwBzXavBiaN4ZIRi2D8QzxaiTK8
	 PYhHBlJF/f0alxIw91pL/xgdG9DFcT1nReKhz43wBROjmG8VSKUoFtse4Ph6dKpl7h
	 pBg6www/SA0wnpfkqyVmn8Vy++cReK7qxnzVg6gB6Qbn8WujFSuwPo03YX5SVApkIG
	 0J/P207J8AXZw==
Date: Tue, 22 Oct 2024 13:49:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, hch@infradead.org,
	broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <20241022204931.GL21836@frogsfrogsfrogs>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zxf3vp82MfPTWNLx@sashalap>

On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
> On Tue, Oct 22, 2024 at 01:39:10PM -0400, Kent Overstreet wrote:
> > 
> > The following changes since commit 5e3b72324d32629fa013f86657308f3dbc1115e1:
> > 
> >  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)
> > 
> > are available in the Git repository at:
> > 
> >  https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22
> 
> Hi Linus,
> 
> There was a sub-thread on the linus-next discussion around improving
> telemetry around -next/lore w.r.t soaking time and mailing list reviews
> (https://lore.kernel.org/all/792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org/).
> 
> I've prototyped a set of scripts based on suggestions in the thread, and
> wanted to see if you'd find it useful. A great way to test it out is with
> a random pull request you'd review anyway :)
> 
> Is the below useful in any way? Or do you already do something like this
> locally and I'm just wasting your time?
> 
> If it's useful, is bot reply to PRs the best way to share this? Any
> other information that would be useful?

As a maintainer I probably would've found this to be annoying, but with
all my other outside observer / participant hats on, I think it's very
good to have a bot to expose maintainers not following the process.

> Here it goes:
> 
> 
> Days in -next:
> ----------------------------------------
>  0  | ███████████ (5)
>  1  |
>  2  | █████████████████████████████████████████████████ (21)
>  3  |
>  4  |
>  5  |
>  6  |
>  7  |
>  8  |
>  9  |
> 10  |
> 11  |
> 12  |
> 13  |
> 14+ |
> 
> Commits that didn't spend time in -next:
> --------------------
> a069f014797fd bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path
> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
> 3956ff8bc2f39 bcachefs: Don't use wait_event_interruptible() in recovery
> eb5db64c45709 bcachefs: Fix __bch2_fsck_err() warning
> 
> 
> Commits that weren't found on lore.kernel.org/all:
> --------------------
> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
> bc6d2d10418e1 bcachefs: fsck: Improve hash_check_key()
> dc96656b20eb6 bcachefs: bch2_hash_set_or_get_in_snapshot()
> 15a3836c8ed7b bcachefs: Repair mismatches in inode hash seed, type
> d8e879377ffb3 bcachefs: Add hash seed, type to inode_to_text()
> 78cf0ae636a55 bcachefs: INODE_STR_HASH() for bch_inode_unpacked
> b96f8cd3870a1 bcachefs: Run in-kernel offline fsck without ratelimit errors
> 4007bbb203a0c bcachefS: ec: fix data type on stripe deletion

Especially since there were already two whole roarings about this!
This was a very good demonstration!

PS: Would you be willing to share the part that searches lore?  There's
a few other git.kernel.org repos that might be interesting.

--D

> 
> -- 
> Thanks,
> Sasha
> 

