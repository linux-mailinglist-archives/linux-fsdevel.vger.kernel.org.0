Return-Path: <linux-fsdevel+bounces-19907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF78CB193
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD072823D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA8147C99;
	Tue, 21 May 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHv2t4bi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB8147C6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306302; cv=none; b=e6vEfG+SujDNZoA97GKMSYHY+PK01S59wmsyeHf3e0mBJTO3E9/VRt3yPPkqMN5bAzjJMYeyewkcOFPH3urJ/j4n6ybeyl1W4mivMZJuLzUOQvcCm77YqWgezdzzkXJPfxZX5H8ZQu2vm3lYyvtJgPSFZrvJmawPfpegZnkacok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306302; c=relaxed/simple;
	bh=wtZaqsRGkYt3hg7xC3jcLQvNSfh/pb+MexnrbVHCGmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lyjHHGA1Rzsq9mquoA+JL8TsvVz6RFczOCQsQZFOSpDkZWoyxrcbLFnkoNELTqbaRTQEarPXTG0VpbA+WGOGi26PuyirZ5K8nFhoHzTpAd+jCj00UcjFlQYhJ0VA2EGaU1gIx1wsdv62SYU0XN1HtmfJ3Jfh5ZP0EAKCzXVAiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHv2t4bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAEF9C2BD11;
	Tue, 21 May 2024 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716306302;
	bh=wtZaqsRGkYt3hg7xC3jcLQvNSfh/pb+MexnrbVHCGmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DHv2t4bi4ZYNzty8O2QI4RnBJVCoqI4K7GrzPP9brSOiSXjv11vp8eWPsfP6UdQXv
	 Wx3v4U3oUxFmar3V6zHsL7+2mrBYzxicfi6oTprLhvTUd3rwDtR5uPZrZHMwSsW/DF
	 4dGy+gU3iJ4lvlXYD8RQAJf6riB2iySFgozTwgsR6OVPzGM8VdlRbJE0pwjFv8USfv
	 000UrZdaiewkLiEPDZ/y3ium2+RHGm0mY8kEFBzjxGOk8qlmflQFwxaz76Jhjkiz/H
	 g8YUEJfmJG+T5BBHQVB+UYYpSveg0Ye2uoNbdEel00henXsd9T/G+FpmE+5C1FITr1
	 faB5W803RXPgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E31C4936D;
	Tue, 21 May 2024 15:45:01 +0000 (UTC)
Subject: Re: [git pull] vfs.git set_blocksize() (bdev pile 1)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521043731.GO2118490@ZenIV>
References: <20240521043731.GO2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521043731.GO2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-set_blocksize
X-PR-Tracked-Commit-Id: d18a8679581e8d1166b68e211d16c5349ae8c38c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad8b6ad9a08abdbc8c57a51a5faaf2ef1afc547
Message-Id: <171630630184.24901.5575711146212509917.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 15:45:01 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 05:37:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-set_blocksize

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad8b6ad9a08abdbc8c57a51a5faaf2ef1afc547

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

