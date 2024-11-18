Return-Path: <linux-fsdevel+bounces-35155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21E9D1B55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 23:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957F91F21D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2391E9060;
	Mon, 18 Nov 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgtj+tTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDC1A9B34;
	Mon, 18 Nov 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970649; cv=none; b=t3Q4P7+6om6RmQJXj4h+XA955V/mCCOeqiY2xBHAo7KGF7iB4c1wy7SxpHaIo1ihHTKp46h+hZxzcupNPGaBeIzVlx5uz5/7WMwyxalPgXerIYsVS+pxGIJZg/wS9cFYwYbxqbGGi0JdkE8vmSUYN7sntXM+Qpbcbcqmb918g8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970649; c=relaxed/simple;
	bh=Uz/Hn1oeZk/dUKL/QMmOUUd4s24ydB8ugtokCtOMNA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X946nSM3BOmOvj/JixWW85OPNdzoOAnGrKLsYSRVerQGN8irJHfHRfkHZIyHRE+wn2pdGsdzrjjYOpv2G/Tr/eJNooNiyrmQz80JCvhW+OH1MkKmt/a2udeGAus1qvosMhEZcLOAGggB4w/oHbE2RtOnN9M1pioX6acq9kcEpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgtj+tTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9721AC4CECC;
	Mon, 18 Nov 2024 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731970645;
	bh=Uz/Hn1oeZk/dUKL/QMmOUUd4s24ydB8ugtokCtOMNA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mgtj+tTWFt9T+i+aND4oovsJqcHGb/upJh2+Cc51uhRP2sssN8EOs+Fh8J2mbWOYC
	 XRJQwzgZbbZE34qlSEsgD0zsk6Zl4Xn1GJ6RsYCQYOY9OxD/WwwR26jyAH5Bnky6es
	 FBZkoGVC3AzKSd9UYP/DUCU/NblbL1IQCsBBtNZpYvQNdiQtVlhcCJfe8LVSEqe8r6
	 WD3lfyMOik/QaqbRhyNI9I13ZJtYhUHztCP0XOQyeJpLBmaVp0OhdwbcZdsTkjZMlE
	 Yg+C6HoMclX1N6PCttQNKxOI9LqYnOqJ4IC7eht+SfpjGc6VDubFS5k2Ius7p4XAfl
	 LkY+mmFo5SlkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D323809A80;
	Mon, 18 Nov 2024 22:57:38 +0000 (UTC)
Subject: Re: [git pull] statx stuff
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118213808.GI3387508@ZenIV>
References: <20241115150806.GU3387508@ZenIV>
 <20241115153344.GW3387508@ZenIV> <20241118213808.GI3387508@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118213808.GI3387508@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-statx
X-PR-Tracked-Commit-Id: 6c056ae4b27575d9230b883498d3cd02315ce6cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6d64479d6093a5c3d709d4cc992a5344877cc3c
Message-Id: <173197065679.11861.266001892588719446.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 22:57:36 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 21:38:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-statx

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6d64479d6093a5c3d709d4cc992a5344877cc3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

