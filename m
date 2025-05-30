Return-Path: <linux-fsdevel+bounces-50249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A757AC980D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6C1BA7C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64F28CF4D;
	Fri, 30 May 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATVRpGCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197422192FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646990; cv=none; b=n5xM9P5u7rC35sUBJ1BGHrIFUrP1TRQymGESDage9gXJp7bqA9baDa2RF1+vI61YAGW8t+DBPsNqScGM7cd1m8TGrQT5Mq+qPjeAFTP3wAyTXE0idWqoLfOJVH3mqsixH9cJf3RzYYFtIGAtE+7fTOYxm0k65A6qSayWsXU1Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646990; c=relaxed/simple;
	bh=NQJBc27HyfmFEJa6qlXuU/sEgb0yxZ4qRbq0wJh7/nw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eWfu8m/jMTpapL058hd9Vzif5o+wHwRoNe59gsJA5IwQBj2gEuIsuSbuDidtwP7lkiRGcPKRNV0xXJTDdEvpTt8q80nu3PMi51cKLKDBV6bF2KYJ+hB9/bSYR6pQEvOxW14Xy2hqhltm0NjVNFnmDRmsYTxr0+xrJ0HxTpwf7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATVRpGCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF3DC4CEEA;
	Fri, 30 May 2025 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748646989;
	bh=NQJBc27HyfmFEJa6qlXuU/sEgb0yxZ4qRbq0wJh7/nw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ATVRpGCsrhqLTCTrTk0t1rsFzjR2hdTeQiZs7/01VF+0qM7Jg76Usg7sXptP1fP28
	 5b7Lbv8P7IR5qVdhRN8rte7E6df+9uymKvAy5nTLnLjWN9cmQ+8YUtA7eDJhbahQiE
	 DYy+h0oNZa2xTD8R5tKew8k894oWQvjXt2oLwgpTuoGeoGS6HHg5DEd/UYVqP1C9Qm
	 fHusdYKJzOYmcuhBUKSKc8gEkVa6jW85Cpur04l2eeHi6DCW0dlagu8/KdTIN8+dxS
	 3WuJ0CKosYXvGHtyrDp6Vaq5gstxHK+WKqk2LsABot7E1eZ7ikPH7tgPyEB6DHHRaO
	 CtqT8D403Jp2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8E39F1DF2;
	Fri, 30 May 2025 23:17:04 +0000 (UTC)
Subject: Re: [git pull] UFS pile
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250530191237.GB3574388@ZenIV>
References: <20250530191237.GB3574388@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250530191237.GB3574388@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs
X-PR-Tracked-Commit-Id: b70cb459890b7590c6d909da8c1e7ecfaf6535fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edb94482e9d6da6e397e8b1cd0400d673b24fd35
Message-Id: <174864702284.4165071.14973363382988040260.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 23:17:02 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 20:12:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ufs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edb94482e9d6da6e397e8b1cd0400d673b24fd35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

