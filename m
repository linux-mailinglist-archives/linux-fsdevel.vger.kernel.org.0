Return-Path: <linux-fsdevel+bounces-32655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6EB9AC938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26656B23809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8F1AB505;
	Wed, 23 Oct 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx08t3gY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91021A7270;
	Wed, 23 Oct 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683572; cv=none; b=f5IC1pCpwnns2TsUZvpjiXJ41PvW37ulPk83XREI5dGLuM0+mj+WPooq1LAfmzG+Yl0SJRI8Jx2Fp1c2AowBm0JmnSqn1+gwwAVgfKai7yTGatFwjXsEnnL3FhlwiLvPpe/KSJJUfpqAc7/8FywmzLJm4lpHfBRwkJCEeZbDaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683572; c=relaxed/simple;
	bh=bDL6eDMtiWYBG/PDNAIbF9aHpR0tI4JPCN4Px8SOVdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2rAxMXvpPwntZ6ABczg4DanKZf+iLyj8Yv58NERzgPHMoPFieu+xTBsX6/THM6DAxcs1YLJ4BKz6l9AEJ3xQBQYq/NAgOYX4cZJzdfCPybYmunhISXeL4NNkJI+vFkhdZsnlPHu/E8NAxiFIAhy4I/OrPvJCcN5jonuFkCe8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx08t3gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D446C4CEC6;
	Wed, 23 Oct 2024 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683571;
	bh=bDL6eDMtiWYBG/PDNAIbF9aHpR0tI4JPCN4Px8SOVdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx08t3gYAckdmM5+lTYgtZMCNtrQye91E/DnFFuTPSPBi0IjttE/ZC7GvpXXLoLLU
	 9ju9+XcjrVYS8wKEKi4efhKl6LYXfSyLX7oiW+9DhUUVLyb7CZW3rMZaO6SXiB6HKE
	 okKWvIkYxg9NL75ivTNAkz15gwCu70KZyVe15caUTTdtTznx85yCwQnjSSbZIUvQkD
	 SBWgtzzVmy6FTrDB0qjqGFkrMHSU4eLhaz9NRjuoPVH2ftwjeBU7WXSXRTltiIHixF
	 XXzoPQXtNDt/GD64bHozkGv05Bk14htDuYW6A6n87ILRlldLbTZcLFZzxQ82cQfebe
	 VW2E1LseQGJyg==
Date: Wed, 23 Oct 2024 07:39:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <ZxjgcQPzpg1AnH6q@sashalap>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <202410221225.32958DF786@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202410221225.32958DF786@keescook>

On Tue, Oct 22, 2024 at 12:30:38PM -0700, Kees Cook wrote:
>On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
>> On Tue, Oct 22, 2024 at 01:39:10PM -0400, Kent Overstreet wrote:
>> >
>> > The following changes since commit 5e3b72324d32629fa013f86657308f3dbc1115e1:
>> >
>> >  bcachefs: Fix sysfs warning in fstests generic/730,731 (2024-10-14 05:43:01 -0400)
>> >
>> > are available in the Git repository at:
>> >
>> >  https://github.com/koverstreet/bcachefs tags/bcachefs-2024-10-22
>>
>> Hi Linus,
>>
>> There was a sub-thread on the linus-next discussion around improving
>> telemetry around -next/lore w.r.t soaking time and mailing list reviews
>> (https://lore.kernel.org/all/792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org/).
>>
>> I've prototyped a set of scripts based on suggestions in the thread, and
>> wanted to see if you'd find it useful. A great way to test it out is with
>> a random pull request you'd review anyway :)
>
>This looks really nice to me! Maybe add top-level grade ("B-") based on
>the stats available. You can call it the Nominal Acceptance Grade bot
>(NAGbot). Can so that everyone will pay attention, declare that it is an
>LLM (Large Linus Model).

This is something we need to figure out. If we do do this, then we need
to figure out how to score, and scoring should be different between
merge window and -rc cycles (heck, it should probably be different
between -rc cycles themselves).

>I'd include a count summary "(5 of 26: 19%)"

Ack

>> --------------------
>> a069f014797fd bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path
>> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
>> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
>> 3956ff8bc2f39 bcachefs: Don't use wait_event_interruptible() in recovery
>> eb5db64c45709 bcachefs: Fix __bch2_fsck_err() warning
>
>And then maybe limit this to 5 or 10 (imagine a huge PR like netdev or
>drm).

They should never have a huge number of commits here. I think it's
better to just let it explode.

>>
>>
>> Commits that weren't found on lore.kernel.org/all:
>
>"(9 of 26: 35%)"

Ack.

>Nice work!

Thanks!

-- 
Thanks,
Sasha

