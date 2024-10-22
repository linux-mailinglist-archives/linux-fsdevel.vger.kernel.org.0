Return-Path: <linux-fsdevel+bounces-32615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47339AB6D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B31F21D89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657741CDA3F;
	Tue, 22 Oct 2024 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJbzDQeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99D1CB313;
	Tue, 22 Oct 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625442; cv=none; b=qft9f0k1vw3D0CleZBFJ23qLYu404J7eCITmKaquEgVxEADJs49UQOGWvVoKo0e7WNrfjdcTnVJPnCQsh/tn9Lq43OmCP9FT2QJujIjrfEYRIWD9oatTEGlrKnIckYVovPo1kJGVQGUrfW8AAwTxEHOfhY6dYZ07wqvubme2Zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625442; c=relaxed/simple;
	bh=dCbDDMlar/U699XnQ2ErjEcbtjkZrBueuembTEYSNxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhoiFA+2OEq5diEBtPNFJ8yUg3K4GxjzD0bWn+Zhm5pqinwZNPjXikJJG4p8fiKACwwX4PhPUiRMhGrqOSErTHI6OijKcQlVy/ntlOW4QLqmohmS6VAhzQndbUHt6aukpeoHQy/Nsll5JqHV70h9a1vjrkggZzFDPUbFbynqE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJbzDQeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE79C4CEC3;
	Tue, 22 Oct 2024 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625442;
	bh=dCbDDMlar/U699XnQ2ErjEcbtjkZrBueuembTEYSNxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJbzDQeBjWaGAVBTFL8sr5atOmMKR9mcFM5S7WZUKQUTb9vxh1Kr/jvGxgk8vEAFw
	 VX6R9DkQMDRtywxI+FVcTmZteL3bSewa9lVmaMjr827oEYWGtNcbw86iGXLxDZ4Q/5
	 KqXy2R6I+p9IvJ6uE/Tw94U237k/54TBjT2+LI5F7BeINywjJefyFs/0k96bMNgpY2
	 1tS5Rc0KWEy0gc1aaSH1ffu79CnEIvPdh4ikNvGxRQ3Kpdn/cCo9bSmA30ZtQ9qzC1
	 ExClEZkcrIWdEtJSPQSyE6StoLBAPP5w1ZFirPITyUJyXTgcG5xY1Efwgcz45w8cef
	 nG46KTbX8it0A==
Date: Tue, 22 Oct 2024 12:30:38 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <202410221225.32958DF786@keescook>
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

This looks really nice to me! Maybe add top-level grade ("B-") based on
the stats available. You can call it the Nominal Acceptance Grade bot
(NAGbot). Can so that everyone will pay attention, declare that it is an
LLM (Large Linus Model).

> Is the below useful in any way? Or do you already do something like this
> locally and I'm just wasting your time?
> 
> If it's useful, is bot reply to PRs the best way to share this? Any
> other information that would be useful?
> 
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

I'd include a count summary "(5 of 26: 19%)"

> --------------------
> a069f014797fd bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path
> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
> 3956ff8bc2f39 bcachefs: Don't use wait_event_interruptible() in recovery
> eb5db64c45709 bcachefs: Fix __bch2_fsck_err() warning

And then maybe limit this to 5 or 10 (imagine a huge PR like netdev or
drm).

> 
> 
> Commits that weren't found on lore.kernel.org/all:

"(9 of 26: 35%)"

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

Nice work!

-- 
Kees Cook

