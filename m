Return-Path: <linux-fsdevel+bounces-29443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1046979C58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 09:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A09F2844E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193F13CA9C;
	Mon, 16 Sep 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjMxygTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4B140E2E;
	Mon, 16 Sep 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473570; cv=none; b=M3JFLU2NXvTiNnfRTqK7Yh5cUeRuox/jGCiMUViLq/9UoR1X7exVkJ/B7bXlliEZC1BuoTwGkfg7vK6Q2OSl+bE4V7gy3nQiDqA31nLaCtKojNH+/pXzpKhMjRnemkCHrblyNZx+mULtG75jhtKZZvp6GxGywRv123Y3THbRNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473570; c=relaxed/simple;
	bh=QmEiGuMpamILq327RD3yHYi/GSnreafapsXGqbUf52M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VoUf59y8cP6GZzKQHJAs251f/L/6rZR4y6XNrc4Y7q8LhWfmMMwyxtLboZCeVngKoR3zQUd2/JXLuf0ZizZ9i93NHhwTBlcNMTArEeGRDRjX+07t+v+B1qzv/p5chGZFjE/GcmEfrOsEuAx+g3s+M4jZkB4MxEFGLac4HebQT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjMxygTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCA6C4CEC4;
	Mon, 16 Sep 2024 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726473570;
	bh=QmEiGuMpamILq327RD3yHYi/GSnreafapsXGqbUf52M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OjMxygTz7/gXOK3NIXBm3FImAM/U/jkU/Penx43CTeLvIGjFBC8FEpkghYVn5HTR3
	 n2DqKmEsQx5N3mECFY5ebGn0E8y54uV/tUw/o6UFrlO8POxh2x/Ld5e2Gu6/TmgiDe
	 0RRHRI063Q3aEm9s5EiD4aiuQZsMYbFJmTYEcpSo1BRvD1XSuWLAVkvGsuUrlkby7J
	 QlWOeb8guI2yLppYoaMIhW6EaqKqSoPCqBirizK/STm2z4JTeUOVLRgiqcDqLJvtd/
	 C0vwZn/viAQ68cXDkOMcj+UrFgv5gfET0WsoOP0dqeif0OO9xgkY1+AOBIwUx5I6VB
	 UQc0yHYAIhjZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC33809A80;
	Mon, 16 Sep 2024 07:59:32 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fallocate
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-fallocate-34e5962f7372@brauner>
References: <20240913-vfs-fallocate-34e5962f7372@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-fallocate-34e5962f7372@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.fallocate
X-PR-Tracked-Commit-Id: 7fbabbb4ae2a7203861e4db363e3c861a4df260e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee25861f26e7a2213b97ce21ee1ccd98331a75b1
Message-Id: <172647357140.3298317.15876946284699532025.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 07:59:31 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:44:09 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.fallocate

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee25861f26e7a2213b97ce21ee1ccd98331a75b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

