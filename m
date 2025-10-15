Return-Path: <linux-fsdevel+bounces-64324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47855BE0EF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 00:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED5F4855CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DC30E0F5;
	Wed, 15 Oct 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDlUW+Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5B30DECC;
	Wed, 15 Oct 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567448; cv=none; b=Izk5K5HoYdCjEmEsa2FOmui5cGtQLFlz91RHrM69hRMbcn/Cqrn3z35xyEwr5QS0Mt5VM1jd5XvIbwDU14SRV9V5+R19OOVPU8/LevU2VGU43qb3RWq4ELXmquFID/vTqzldO83QAFRlIeYkqSiCvv0WewrSEi2Hj9eF6ttsRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567448; c=relaxed/simple;
	bh=idFRT4aAwurbzfBnNAFK4x8KgwPt9+2DsSTQ/viVB7k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IC7OM+7jAvmtAdRrJzqbyrshCO8Z+HcYfIJEBftKpo1o9xfy50pJKYKt5F+razk+ruTdLwxdU4cjiJ7VjhRMRDJRDzgaaeM9YwM63L7GHgIKhjyX/JN9/Gf6yJpCMzw/SOQJ+0DNtd8bJLZTJCWFBglh0MLO6fupOar/qLdfKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDlUW+Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29B6C4CEF8;
	Wed, 15 Oct 2025 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760567447;
	bh=idFRT4aAwurbzfBnNAFK4x8KgwPt9+2DsSTQ/viVB7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lDlUW+LqFRZ1SRqZIit6tzSVkbChdraBkuYKGkWGiG/bnA4gXMWeljqs9yDL25xY6
	 06+04kusKfCYTfiJ5n2nOxfoyrOs5UWjjQg6hq1xNgU//5s1EXgOZa4USjwKgocE8h
	 ZYdqDUnlqlHv3Hxc1W0tUr7nATCP5Z+738YLYJXbvLufU28qvn5qAdjNzd65yGaPHp
	 2IvNUczQPwSmwL2kZzNCzwLF9kTKafpHq2yL7eNDA4Q7D6CYrU69FhlsB6DldKQpkn
	 G9zcHqDjYMPwe5W9GblXfJEqZqkFJ5doMsfu6gANGdo1i59+5CsloQ5zIkzNKM4GJB
	 tfdJ2IHF/8jTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE13E380DBE6;
	Wed, 15 Oct 2025 22:30:33 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251014-vfs-fixes-1b72fbe7e505@brauner>
References: <20251014-vfs-fixes-1b72fbe7e505@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251014-vfs-fixes-1b72fbe7e505@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc2.fixes
X-PR-Tracked-Commit-Id: 7933a585d70ee496fa341b50b8b0a95b131867ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
Message-Id: <176056743235.1076240.5555408465514552366.pr-tracker-bot@kernel.org>
Date: Wed, 15 Oct 2025 22:30:32 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Oct 2025 21:34:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc2.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ea30958b3054f5e488fa0b33c352723f7ab3a2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

