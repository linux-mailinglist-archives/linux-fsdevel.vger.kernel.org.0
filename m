Return-Path: <linux-fsdevel+bounces-70392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5BC995A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF9AE34652D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18A2FFDF0;
	Mon,  1 Dec 2025 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtjVuDMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A072FFDC0;
	Mon,  1 Dec 2025 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627091; cv=none; b=CQU4rAXsgEO6zvCKnf59md93Oyjj8INPCRj+NCrmmq5LQiF+ENaz3Q/Rt+7w84oUqPdIRb6TlYKhgkRMsZQLyKWAaZd9nahbi8DWBE4+8HtWUeVcSVAqlFrZ1oOikLf7CPUewnDqYPnfgFu9S7FsA/uAVew2qGuehje8RHOsLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627091; c=relaxed/simple;
	bh=udYSLR4cFLg1TZkjR7Kpoqb3qR0PmZRpff611LztbEw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p/JV7ppD50H+6O+6beuZ+D/bKbmaflrMreqXundgLraq9h9UPD4sQZ8uOX8hJX6ILtwLUiBURxu6AoDiJHlJdk0iRAd6aMVU/Wm5SrDf5H8Pjcust6H/rihXGaIYgRyxefRldgRLB4wjMiQjEghxoYoFH+gFfN7yfjzV4CW4DLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtjVuDMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26ACC4CEF1;
	Mon,  1 Dec 2025 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764627090;
	bh=udYSLR4cFLg1TZkjR7Kpoqb3qR0PmZRpff611LztbEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NtjVuDMObCGhxzOgDbAqc4M2TiwbHb0O6itwNv1mEYBtntubmJvkbXu3hRnlpOLM6
	 Qc/piT0J1Dy+2sHoqHlipmhWgtuxMtBa9Jkt5qwlJBNGSLBdVVqwl8pBM40otcOhrE
	 hYKTGo/2UziziTCEFsIC22YY2AScEWq7St1S6VrVG6i9Q4HQssSehzVPrXN5HfEEWF
	 gZ6QL4icxOYCj8moyO4/CxiRjHn/knUREVjpk07YPVoe+r51W3yAFAgqJGW55OOC5m
	 P/BvTimUpRrm6Dwc+kn9VV2Q2NcLpZtFJVAU0NG4vgGR42tBtTGnpu3DCmoTnu14A9
	 FJYkaAwk70sTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B18381196A;
	Mon,  1 Dec 2025 22:08:31 +0000 (UTC)
Subject: Re: [GIT PULL 07/17 for v6.19] vfs folio
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128-vfs-folio-v619-e62bd8562ec0@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-vfs-folio-v619-e62bd8562ec0@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128-vfs-folio-v619-e62bd8562ec0@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.folio
X-PR-Tracked-Commit-Id: 37d369fa97cc0774ea4eab726d16bcb5fbe3a104
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2e74ecfba1b0d407f04b671a240cc65e309e529
Message-Id: <176462691057.2567508.5956802006125652479.pr-tracker-bot@kernel.org>
Date: Mon, 01 Dec 2025 22:08:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 17:48:18 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.folio

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2e74ecfba1b0d407f04b671a240cc65e309e529

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

