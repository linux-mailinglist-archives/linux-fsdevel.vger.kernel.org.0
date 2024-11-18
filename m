Return-Path: <linux-fsdevel+bounces-35122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887E9D1931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D32832FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7901E5726;
	Mon, 18 Nov 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZePGBNaz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E28191F99;
	Mon, 18 Nov 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959332; cv=none; b=BpoCpAVZ/V5S2k37il8RmH8bCMUUCWhppw3sM7opW5VOjAk6O1LIRSXDlr9J02sl/3/AhM6KzwZb5CWBkMZbxtq3EgmpIFPkfJP0NT0Zk5JHofg5wb4kPweHx2J+uHw5/ZJ8Dnz7z2D3rD4QfpSoWkT4cVvj5VNIgbF3gHrv/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959332; c=relaxed/simple;
	bh=pCeb4gUF5vULlb8yMn5g4r+Fnmy/gdq4guszNhta4uw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ojyFEeS1j5SEZ6shS1RVjt7LK2SefMguGwXspqGX1WlERZAfByiXgBEm7MXZHy5fV2FitYgCALUmuWHBIrqaj3je7Hvp+9XMouY+5V6r7yDWl+jznb+Kshh8V8kSnrg4JAUt6Aq3dXQN7T1N5lro0ahcXxlzaUaODk9zryQSpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZePGBNaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9F1C4CECC;
	Mon, 18 Nov 2024 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731959331;
	bh=pCeb4gUF5vULlb8yMn5g4r+Fnmy/gdq4guszNhta4uw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZePGBNazhuTrIuGLTYNg6vNlxkpyK0wmOXxWvCPxyrHl8yrhbgmPBW+hDaSKiwLdL
	 Ua250S9Mjc738bKlbFd6wgtmJKD4hjgoapFmQtbuBXC/NJYyXj0jvRZ2fu5HiMzu7Y
	 Z8QPS5Z0KMHMyalpEvC4MwQxw9ls/IRfbTnyDY3yX1EsGs8EKj95wuHKZXyps/xExn
	 +sSAtixkiDpcNTuIflw56xWAvCxATKhlq1uhNs7sRD+1Xlye3UkCvhwH5Ym+seNUBc
	 sAi0hBaYcMyXFExPTEOwnw7n0i2iiEUorzNVrlpCcHJyakKHXGaEXt8cj1RcMwtKL1
	 CnxoXuOkz5pog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5EF7F3809A80;
	Mon, 18 Nov 2024 19:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] vfs multigrain timestamps
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115-vfs-mgtime-1dd54cc6d322@brauner>
References: <20241115-vfs-mgtime-1dd54cc6d322@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115-vfs-mgtime-1dd54cc6d322@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mgtime
X-PR-Tracked-Commit-Id: 9fed2c0f2f0771b990d068ef0a2b32e770ae6d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ac81fd55e8af8e78a716b4ba213c8c6381d94fd
Message-Id: <173195934303.4157972.16641633341033070598.pr-tracker-bot@kernel.org>
Date: Mon, 18 Nov 2024 19:49:03 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 14:49:52 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mgtime

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ac81fd55e8af8e78a716b4ba213c8c6381d94fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

