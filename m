Return-Path: <linux-fsdevel+bounces-35133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403D9D1948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B58B242D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212521EF0B2;
	Mon, 18 Nov 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjHldmob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D91EF0A4;
	Mon, 18 Nov 2024 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959348; cv=none; b=mvZAZUqg465kqi7tJqZ54mtjS6/j8FDaVwU9pK7kstf4H83hAYRapAJ5a/Lf97jrIlcckHwXTO/T37j8Gk+z1i9rPsskqzuYRLyFjos4Lu4mfhkGXbaKCMe1zI1zGhAAPw5AxswYJxG/ik4CVpjZgbyX/GGnVHLqo0SaGd7O1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959348; c=relaxed/simple;
	bh=glSA5oxW01KCfaKN2RlVyLwVG93A1hHell9SNPJswJ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LFSiXlFlMdd123Rd7Ph28Hmhm91NKEL9Qs3pq05LPln34mV5qx3dlDXFC0lTxxVDGaOHRmJawlw9gRkK6dN7jZXY872jGNPYGar1qwzd1PstfYRsCovdhErsUR/zPYCBoLVQt6lqRU1h6UW0FmQbjo9VVztkN0kjynZiSWlkZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjHldmob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1632FC4CED6;
	Mon, 18 Nov 2024 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959348;
	bh=glSA5oxW01KCfaKN2RlVyLwVG93A1hHell9SNPJswJ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mjHldmob4Y7lTJxLzDKfOwb9MzchzkBHsZKFzxzxr/7Yskk5zza8byCDrNPFRA500
	 7g5BVywlqeFWrRpu/mk1nU+FuBXCzgZG26SRsggGsgCDi0zfAt+hb8GIcgnrajUon1
	 RXz+ZECuPX2dCJl9HCxRgsBCzsDY5NKU1aXk4F0qZyh1hHFP6GMfvLHr714r2dm0Bw
	 neClzIlAn58E+mhyJIWEraXQSkqsFTShm3p002kKDLUPdeqy0xzT7LnmgFwXbtYGYs
	 Hgy6um18sjSGwj2Hpe4/QD7WI5e3/Xo/JiFYJ5qWS6pme9z0uIIQ/Uo01k0BGgSj79
	 Z28RaDQPJ/Okw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB893809A80;
	Mon, 18 Nov 2024 19:49:20 +0000 (UTC)
Subject: Re: [GIT PULL] vfs ecryptfs
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-ecryptfs-e1d0f86e210b@brauner>
References: <20241115-vfs-ecryptfs-e1d0f86e210b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-ecryptfs-e1d0f86e210b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs
X-PR-Tracked-Commit-Id: b4201b51d93eac77f772298a96bfedbdb0c7150c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23acd177540d7ba929cdc801b73d15d799f654f4
Message-Id: <173195935933.4157972.13994557622966573875.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:19 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 15:08:10 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23acd177540d7ba929cdc801b73d15d799f654f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

