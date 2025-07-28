Return-Path: <linux-fsdevel+bounces-56199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634AB144D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 01:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B0A1AA0FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2627E04F;
	Mon, 28 Jul 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbzgJOlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6227C84B;
	Mon, 28 Jul 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746032; cv=none; b=IF1Sa5VqIqIhC7JEnylnKjYNWYW9bQp9lIy3eyb/QeWZL3ZdkPD6GBSBu/UbwkFd+n7qZIPSYXQPPMtuRu3I/JSnYaT0yGpytugR/sjK4rn8aZ1vIIv8mK0clDFhBC1C+hYzJE21pqYuKxY2PASV/7Dd4L0ot9C18tGeN3tWayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746032; c=relaxed/simple;
	bh=HfkkZf+PR7IkvBv/7lSPhdq3MQ8iXI3JxGVA0r47Prk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qx8hq60Gv16z26xobDa8r+w8fyfPE6xRbZmOWJJKr7GnKA69GX+EnJFwA73bKIpe0aeqVl5iHl1HiEQmo+IQHU5vC1ONmbracVOvvqg85pjUd9rw21A6dsKQeWBcwQyBVGPBqGjJO3cHdtvGEwYakIINJgy4sdNDeiN06iIEELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbzgJOlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291C3C4CEF7;
	Mon, 28 Jul 2025 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746032;
	bh=HfkkZf+PR7IkvBv/7lSPhdq3MQ8iXI3JxGVA0r47Prk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZbzgJOlH7QLNN5qh5pbyIUgMfml8i4o5QQv2MyrN3SQ/wwKrlg/k152pmShNCz7aX
	 Xa2mpujYja4/7j2kXZOl1w4YKTuV7m41eu9OahT1yO5VO2RFvmYfolacJmA0AS2hrF
	 mBjRTeWBAXWJCHr5HKzIZC4Qp9RgX7rXStzsNM8ISeoxwU3D2zkDrqdr+++Fi4c2fb
	 5aa9lVzEG5PSwQq8cSc9cMgP7IV6CgXP47fAHBnuGEObK/VBCTgrax0qRHzohVvp0A
	 UGwZEhjZIDX0d7BKqPsXKYxlxqkBCV9N7YgTlPI4G09qDbSlUPXPgqa97EyyTWT+0N
	 eXU7oqH1z6sjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC0383BF60;
	Mon, 28 Jul 2025 23:40:49 +0000 (UTC)
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725-vfs-integrity-d16cb92bb424@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-integrity-d16cb92bb424@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725-vfs-integrity-d16cb92bb424@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.integrity
X-PR-Tracked-Commit-Id: bc5b0c8febccbeabfefc9b59083b223ec7c7b53a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cec40a7c80e8b0ef03667708ea2660bc1a99b464
Message-Id: <175374604890.885311.7453761743685643921.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:48 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 13:27:19 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.integrity

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cec40a7c80e8b0ef03667708ea2660bc1a99b464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

