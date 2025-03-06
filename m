Return-Path: <linux-fsdevel+bounces-43379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BAA554D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CAB3B6D12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5327003C;
	Thu,  6 Mar 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l56sak6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC526FDB8;
	Thu,  6 Mar 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285173; cv=none; b=rbyzKOUWf/cjWYE/ALX+KV7rM57SFgrVD0f4AsZ2nT9ob/OgsZu+CJ/jKx30M4RYuo1tiJ6laTWTh4H2PbykoaWxtsZHUd+bDh//fYuj4n1bAbqoog0+0wgokasdZ/F06hZhzdE6MdWUR6F5BfDKTqpCEp6IEE4GnkgBRPfmjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285173; c=relaxed/simple;
	bh=fXtogJSChtDb1rz81OzDvFP7wp6LsIf9MgM1XgXZkH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YEzlggj51UkJKQTLLscT9j7TgmGHFCtQFexsKN41S62NcRjniB7l/H2WFYFK6zFBdoVPkdo8JV7k9ki7jYkqvWQ8Lj+w8svGaJ4ryXiWzt9IBN/q2P6YglLbSBS4lzu59Kg02KlK2mxKSdE/+276zOmB3eCJJOwqQj3iZRfeuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l56sak6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A653EC4CEE0;
	Thu,  6 Mar 2025 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741285173;
	bh=fXtogJSChtDb1rz81OzDvFP7wp6LsIf9MgM1XgXZkH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=l56sak6RgS725gNApT5nBp4QNMBzkeqYL0+ERapl/Y0GS5T6RzJ1zCJjYAX8SBJnX
	 0s4tMXPljT3Ozit8U/IsPvI+ake+xQM0AV+I2+dwEyxQpkmr1F8F0m9ySf+21wATp/
	 bUzn1nN1XKZptpf1/5EjGG/NVkCykpKBJU9B+Ei/R/Mfi9TjlwIydvIFBjKAn9mm3d
	 S0oMr4T3boppCedNXuv7XX0LnO3eM8175SSgbVNmk6yo6j8GlA/mE1DoGfuJigYt8Z
	 OF/x0RPYtmf6CoEOWcX/pCs5E+GoRAeHKAdVCRjpd5z2ZSDzvFmHOuS/UkKs0FEiH2
	 MP1CgkAsKS1fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344DE380CEE6;
	Thu,  6 Mar 2025 18:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250306-vfs-fixes-290b2e462d9c@brauner>
References: <20250306-vfs-fixes-290b2e462d9c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250306-vfs-fixes-290b2e462d9c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc6.fixes
X-PR-Tracked-Commit-Id: d385c8bceb14665e935419334aa3d3fac2f10456
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f0e9ee5e44887272627d0fcde0b19a675daf597
Message-Id: <174128520675.1698438.1406642121034950213.pr-tracker-bot@kernel.org>
Date: Thu, 06 Mar 2025 18:20:06 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Mar 2025 11:13:28 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f0e9ee5e44887272627d0fcde0b19a675daf597

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

