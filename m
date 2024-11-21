Return-Path: <linux-fsdevel+bounces-35471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB519D524C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DA91F21C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E301A00DF;
	Thu, 21 Nov 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLQp3WI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1B1A0721
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212284; cv=none; b=EK8C2pdCGDTMW6kAzAnE+gQuDHmp02RnIXqz9O7Qxs27jGMTpAvN4BPILSYkwmGqZnx8g/fBstD5Q+eEMFGgrHL+LcVex4hL+REGdpDTIZEhEgSfVN9twhlRU4oBQwDHQSDg9bQfU0s9mFKzyssqitCf3qakk6/zWcB200205uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212284; c=relaxed/simple;
	bh=/E5zI3uoug+6LOumPUcZ0loz3JojXCIhQ8RKo5E6kYA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mwzZ5HzY7B5eT2TN5Uf/+ZGxunvOMyKFmLEh2pQBfxnG+809hC5JDbd/jr1RZOD+U/urqG459f0ek5wiucAXg8du414XGc2BZFdcnEIRvvXGDlIeEcGchIebLej7zhIl9TqSFkBAskH9qzPy9cXWNHaF+OjxifLzqy8KTMISdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLQp3WI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3757C4CECC;
	Thu, 21 Nov 2024 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212283;
	bh=/E5zI3uoug+6LOumPUcZ0loz3JojXCIhQ8RKo5E6kYA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QLQp3WI5TJwytzDpAs/vq5qsD4RObbsY+1lSZLybjMxLEc6OQ068VNf8kw5L5RHcL
	 1uKYCqDAt2t4Q8feP0qiekNs2jNXoGByNE2str0muTqE9pXmnKH68IGi2GTSQcQEdS
	 vIBUnDJD6oDSRUH45Y5D2HkVByz/HDgjfJpfdbpJ/3mqcia8/Oylg4+3Qac/C6kGD3
	 pZKbrFYOpmFWI79azvSsYpZcuItgpfKCQxgTbp1Lb32C7LSn/50fRWL+gcdFyx8Mjq
	 dGAp4ByKWrMOcx1nZDDpoUlSd3+qqXIqt/7eB9UInFGgay5TNc8EyJcFigTAUcZXNM
	 5ulaNkIl71bRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC073809A00;
	Thu, 21 Nov 2024 18:04:56 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121160828.xlapwqicwo745kpa@quack3>
References: <20241121160828.xlapwqicwo745kpa@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121160828.xlapwqicwo745kpa@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.13-rc1
X-PR-Tracked-Commit-Id: 21d1b618b6b9da46c5116c640ac4b1cc8d40d63a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dde263d81dc6ded2df086bf9db05396c7c215ee
Message-Id: <173221229542.2032550.7991276976718921558.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:04:55 +0000
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 17:08:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dde263d81dc6ded2df086bf9db05396c7c215ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

