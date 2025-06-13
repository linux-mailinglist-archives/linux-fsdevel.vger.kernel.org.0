Return-Path: <linux-fsdevel+bounces-51601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E61AD941D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEC11736DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE0230D1E;
	Fri, 13 Jun 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJIOaPIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4522F74E;
	Fri, 13 Jun 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837856; cv=none; b=AWVEV5u3xjk3JBgaQ4Kz+rTfYlffRR0HJaOuka6HgI1HR5qmYBPJHQmy1DwmHWcqvU5mFl2Kmb36B6DfTmZJ3nAj6TDwMx1N9aGGXMBasV5CejwxufeoV8FhBmL1FGcoG2ppQIxwHzzlUtstVtM49lrCn9wweA1Hozg50DJDm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837856; c=relaxed/simple;
	bh=awmGs/G1uuOr2gVdRFAa+vntAr5ud+P2AGYvPK7PzsA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=omDXsPkhMOMwEXCsatgUNLYjKPCs7VVn9XrWUJmVj8KTysgTQC1Cmqyn4CoVpi7mJ5TLpsZChLtF9nTb9BEw1QPtaMPJ3bpDguUpZYaIamPfXkYrLBXgjEQi27oUy1GlctPILuTvrzX3tY5cf2RS+q/xjxAUaD75JHhzDKD6zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJIOaPIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F171C4CEF0;
	Fri, 13 Jun 2025 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749837856;
	bh=awmGs/G1uuOr2gVdRFAa+vntAr5ud+P2AGYvPK7PzsA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EJIOaPIlO4raw9W8nvdhPSa8AZWg/Kp479O3bNS/UhXn0gFjxuJXL3u+e3LQtI2ww
	 XEGVNm8wGrouV/a5UAQ/4yn0IhHZwXV4rC95my3Y4xb+h4D4n48M8rWoCpX0j5Jklk
	 HNY5E+odA0RW6g5M/pc8aRiPzb38klIWmfmZWRqbXQjqu4NOpLCbiPbu5j8g20NvG8
	 ngDG2aSkXy/hUVboue0pHd31EQ47G6NhpThKGbdb3TL3J2GzMk0NcG6zPwTD3XJ5Mn
	 Z6r0PoRM2Rg2SyUM81EJQNgXr7xHKvdwtoxLgxQY0VHscK5mJC5ROJ8N4MZ5hbO2Ld
	 fVQXaK6mzRI8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F16380AAD0;
	Fri, 13 Jun 2025 18:04:47 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <oxjgqivjmn43zo5dj2u43u432gmfexxjc6xxqcig5jovna3fe3@youegmmszsip>
References: <oxjgqivjmn43zo5dj2u43u432gmfexxjc6xxqcig5jovna3fe3@youegmmszsip>
X-PR-Tracked-List-Id: <linux-bcachefs.vger.kernel.org>
X-PR-Tracked-Message-Id: <oxjgqivjmn43zo5dj2u43u432gmfexxjc6xxqcig5jovna3fe3@youegmmszsip>
X-PR-Tracked-Remote: git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-12
X-PR-Tracked-Commit-Id: aef22f6fe7a630d536f9eaa0a7a2ed0f90ea369e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36df6f734a7ad69880c5262543165c47cb57169f
Message-Id: <174983788606.834702.11959336957057351937.pr-tracker-bot@kernel.org>
Date: Fri, 13 Jun 2025 18:04:46 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Jun 2025 22:10:42 -0400:

> git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36df6f734a7ad69880c5262543165c47cb57169f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

