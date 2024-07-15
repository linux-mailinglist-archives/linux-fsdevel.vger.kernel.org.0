Return-Path: <linux-fsdevel+bounces-23724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC338931BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EA51C21983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E0144D3B;
	Mon, 15 Jul 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqaW2kkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779C13D262;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=tMgO2prvif+lkt5ETbQSorBoQYctI2YJCk2qpsuMYOcvvb671qTAdOnHM/ImwOqRLNfvfp2Eu9+ZfLNXkMPVOl/YQsveojaCx6LIY/hhTcKtnio7W+MudgFCG6M4KmbXQDMA3uKXplZGqnpObkq/07nFbXjydcXlHIxCnAKxbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=y6R2ROKNJ79Nempth6zD0yWou/hkVoNNrQeyu8kTkUU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=koUkunY1V7m9funrYwc+a2doWyf4BC7Cikl0Eu+Tvv4pK0aaLi5vdKUoEQkhWdMPL9TvG2JjmZUUXJM8fmwnN2ita6R2Pmg0y4JmwMbSTciPBcMR7nCnHqo+u8fQgvMy0ApIETd7kwxkmiLJKujcON5YTXdyLI/jBTyJK3hiK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqaW2kkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184C5C4AF15;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075684;
	bh=y6R2ROKNJ79Nempth6zD0yWou/hkVoNNrQeyu8kTkUU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gqaW2kkg6rQ7tDjBdKpNY9O1oHh1V9BMmF7uPQRhGf59iqC1r2UU1G9Xke3TFpkdu
	 byjj+nfE01UC2z9LiNql25POl5fjPzckS8pYMiwfEOjaohMSFpwNhu9KHLQ7ueXUKf
	 QO2zev7a8vAoCxW0Vowi/hSMSoThaj6gwEc/o2bZ/YaEg4hx1WY5mc8+svSGDzoX8L
	 O8QyZEO3qnTXCLOFb5BQpQbK/OaoAZAjRrbym1oiDquBUAB/6RTY+IXSmuyrseRvWl
	 HASJnFnmCbFSkr8rTt7ULHp004/9OTEEMtA6o732S74dMwSS5bOhjS2rzOPeNFXdtd
	 HMNG9Nc9f4zTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 040B0C433E9;
	Mon, 15 Jul 2024 20:34:44 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-mount-8fd93381a87f@brauner>
References: <20240712-vfs-mount-8fd93381a87f@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-mount-8fd93381a87f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount
X-PR-Tracked-Commit-Id: 4bed843b10004d9101b49ac7270131051c39a92b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f608cabaeda472887c008e42398e8fca14e8f411
Message-Id: <172107568401.4128.9921532734037869094.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:44 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:59:50 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f608cabaeda472887c008e42398e8fca14e8f411

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

