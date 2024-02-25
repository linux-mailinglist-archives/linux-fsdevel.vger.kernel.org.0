Return-Path: <linux-fsdevel+bounces-12728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C6862C6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 18:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3423E1F21305
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 17:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95021B80A;
	Sun, 25 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMndJoyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5F1AAD0
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883890; cv=none; b=MLc1tFC4Z9pC3lwjykbCRTtC8HIa0/2JCQaReLchnhjGFISc4FaKLWXpIRRuhAF9czxFRmEUBKV7cdJuvZ7umjLWQRuPe6ey6/9idojTcDoVmd4qWnpMD/HTKfIiEmkrPXuDyChT7DePMiC6gUyJWNdxCWePpFC1rvGo+UM3OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883890; c=relaxed/simple;
	bh=CrSsExnJoF1vN4uRXMI5qvxUBoa8y/xYymgrkfEavAg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LDWjUg1OS9voCONOf8MaM+HpTkML26Ka1ZzF9QaFhxmengfDxms6SX407dVO1R7PDK47FWZMXT22mi/efHEMRi87gIjnB0Xuyjp8t926Xh62HQQGzcWNCWJtIiZafXIPmEC5sUUv7g5a8GyhRVIWaImkMamEqzcKYsa7JGTKK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMndJoyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4DB4C433F1;
	Sun, 25 Feb 2024 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708883889;
	bh=CrSsExnJoF1vN4uRXMI5qvxUBoa8y/xYymgrkfEavAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RMndJoyWLAJlDgC9vKbZMBo8CF1gxYYmWnK8sB4ies+kYOgsimAY3xpLue5OSbB4L
	 rP4OmAD/JuuRDsI44jnAGED/xi9RvRQAqmupVgvXj7E4lrxF4tJtY1GkSPFB3N6o6P
	 f8zvJNh3LgEPCOTMuNt1lNdUwoQ5/E2DmEEf2akcFA+ICWYohywgLJnNkYHUx4qzcy
	 X5xyV7nM4p9xoIRrI0R49mNN2LR3AQcjjYCtEFOeFT2PQEBX+4sg6gqZ2DjBO+AQ+B
	 rTJRi1j7LbDBn91CvMU1+M5rTrFr7unUmKN5XGbsPL0i5ncA7Ub5itoOKucYY4vloW
	 1OKsXzET7VZ/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0A30C04D3F;
	Sun, 25 Feb 2024 17:58:09 +0000 (UTC)
Subject: Re: [git pull] vfs.git fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZdrlRJQOzKnaXh7d@duke.home>
References: <ZdrlRJQOzKnaXh7d@duke.home>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZdrlRJQOzKnaXh7d@duke.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 2c88c16dc20e88dd54d2f6f4d01ae1dce6cc9654
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b24349279d561122d620e63c4467e2715bcfb49
Message-Id: <170888388984.1439.1213439762456604301.pr-tracker-bot@kernel.org>
Date: Sun, 25 Feb 2024 17:58:09 +0000
To: Al Viro <viro@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 25 Feb 2024 01:59:16 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b24349279d561122d620e63c4467e2715bcfb49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

