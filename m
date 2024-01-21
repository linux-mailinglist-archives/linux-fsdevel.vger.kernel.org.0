Return-Path: <linux-fsdevel+bounces-8376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DC83581B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE728B21222
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127F38F8C;
	Sun, 21 Jan 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzjwKgJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389F38DF9;
	Sun, 21 Jan 2024 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875835; cv=none; b=pA1rvuXVND1AwBoIa3KBp8K7FT4Uf0ZbEKp8Y2tqknPQFfOK4bF1tzIlyhHNtqjZPS8K8T6zrB+TzKJv7feoQ4OlOoQoyds6J7et495ftUcH/2qk0SW93hJr6r8c+QU/IuBwr46Q3D272SOJI5gZOkHi0mJoyWOCzG6baL3yGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875835; c=relaxed/simple;
	bh=xAds2pXHVZSmfZj/XJ/cxloKWSR1UFfu3kPTCn0RmQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nFjtdF2Qew4KlAt70QhyAmyZEAke0MaT/hDMtevsh/nBK/lNEIIAcJUd2YM3EAT7/gyPIKUIHHUG9+cRO/sLZqt0C6M7fnCSPSKAeHmwuFPNrPCIjfJ6GdWyQ6hhe/7F0cn3Z6KA81rj46PAwvmUYMtSp5c88C3LE0ude28+2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzjwKgJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E119BC433F1;
	Sun, 21 Jan 2024 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705875834;
	bh=xAds2pXHVZSmfZj/XJ/cxloKWSR1UFfu3kPTCn0RmQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UzjwKgJMrS1kDL5oKnDUy5LDXRv8O4R+q+d0JnsHsu2i6FkFSEY+w3ewy2abMstL0
	 iYdGD0GCPwehuKIC2b2XwfLuvYvg4hKEfDHWg0iJOhW6W8LI980WkIUQVPFvJ2G9hL
	 QGfkI7M+bzZFA+p1IapjGDcHsTUjq20GjnIeX/EAqiG8mlokRVUCG/xoVIkQ+aan2r
	 vekGBMzVQB7/DNzei2I+sMmaY363DiuqLXkthLZ+zjVcyDd3EGGLshpBswu8pAcWKe
	 E9VbWSAunj/C8J0MW4QVkndlCoROJp2eBGv3HmKc6lQbYwco7i/LoKnizKOrZ26nlP
	 lKHJEhHveDEpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C433ED8C970;
	Sun, 21 Jan 2024 22:23:54 +0000 (UTC)
Subject: Re: [GIT PULL] More bcachefs updates for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
References: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-21
X-PR-Tracked-Commit-Id: 249f441f83c546281f1c175756c81fac332bb64c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35a4474b5c3dd4315f72bd53e87b97f128d9bb3d
Message-Id: <170587583477.27364.7964231928269674267.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jan 2024 22:23:54 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 21 Jan 2024 16:35:06 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35a4474b5c3dd4315f72bd53e87b97f128d9bb3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

