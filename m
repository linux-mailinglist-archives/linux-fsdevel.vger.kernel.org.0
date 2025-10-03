Return-Path: <linux-fsdevel+bounces-63394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA55BB7E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C60F44EE9E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AE52DECA1;
	Fri,  3 Oct 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZaWNI0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E42DE711
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516919; cv=none; b=tMX+jsre48+l16TUaVv0qPtm9yzglH4mgD6m8jAhEBO4Wb5EdMIgH2dHdsuCdLehAl2JmjXay4X16lKhDA/OH0IwWdCTynQtIM2UMuVQaPMuix3qysfxh3MrAEf1K9bjSF6Et6TBkmWXsVelSycYkDTIrIOEZ4Kpx6Fx3PMIX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516919; c=relaxed/simple;
	bh=dThrLwugT+huvrkbEVagvyVJirVB4sPf+iVlBOSapSY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uw4rBmN2qMJgag5BYEcUn93HNJI2THcaGtTI2UftLBjA6x1BMxrXRlRWnePDQYRay22qjx7Gl6X7sSDz5sjR0EsvwXj3vHYaYZVsKVcawTGDvnOpX/icrBirFo3w+xnOBIuBoJxnNxrxAY+hFE2mAsHdpiUW3nCrCtM+/bdfIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZaWNI0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6225EC4CEF5;
	Fri,  3 Oct 2025 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759516919;
	bh=dThrLwugT+huvrkbEVagvyVJirVB4sPf+iVlBOSapSY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IZaWNI0p+8oXqcTZ6gn0yeAM2i58HDUBabdSDkNwWJhOVU0i3sJTR0o4K8rXUOVrZ
	 kbcrczO/FADtYsPsB1EXBZ2NAxt9ugY+bMwnpjSUEqgGZ4ZZWaT1k7FAbjmc4ffZs+
	 CuYek2VDwSk+/eCo3yLqSRYmExr0dKHB0aRbmTpsqgpaP+XqpkV6XTmf50o/zw3kfI
	 nRUWhbT5fHNliZMC0BoX66aVf+Hsxr3Iyehq+RSD8jJ1IJandlJBDdHtlgFcEidcge
	 BSSxwJ7TKH05JS50X5A6rIG8OH3Zutv4DOs5hqKs6bFlVVcNPYYkKSI+DdekfxsmQD
	 NMVljDCCPMZVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB239D0C1A;
	Fri,  3 Oct 2025 18:41:51 +0000 (UTC)
Subject: Re: [git pull] pile 5: simplifying ->d_name audits, easy part
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251002060944.GK39973@ZenIV>
References: <20251002060944.GK39973@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251002060944.GK39973@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-qstr
X-PR-Tracked-Commit-Id: 180a9cc3fd6a020746fbd7f97b9b62295a325fd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33fc69a05c50f00f1218408a56348bcab95b831d
Message-Id: <175951691050.32703.3599484810385853025.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 18:41:50 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 07:09:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-qstr

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33fc69a05c50f00f1218408a56348bcab95b831d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

