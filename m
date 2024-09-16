Return-Path: <linux-fsdevel+bounces-29456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58A97A00C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712951F22E5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608115855E;
	Mon, 16 Sep 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGvsDAfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DF156880;
	Mon, 16 Sep 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484992; cv=none; b=nK5KYwAK1eoBa/MrW2tnjFEHYV1mCzMcizHyESQy28ZC25RPjgDJ5icl70tDY2BlttqOECzZkZ5LtQnkH7T9P1OphPt4zpx4Moc/XAlfInEoSmO1LvlhLkytITAdZ2s8nqtSOJ/VanUpRt/yv3hn9/Hlgm3ILdF5t/90CjAnVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484992; c=relaxed/simple;
	bh=BZ5kgsi8htM5PzdZMROoo68JZDp20VmrEgCDYXY1iLc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UdsGS9YzXrwdOW9YerQDu+BJBlJzjzPSDTdqJyhbPTsXoRJgj5hoSkWGyL2RSdvwg52n0jRMwXalddCODO/GrJBvswYMKXkbeqik79q5j6V8V7e1FLttDSZSV167DuccAGeASsPr3OTBjCvKITRfCHxVP3aWwLPNeazCcqowKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGvsDAfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7008CC4CEC4;
	Mon, 16 Sep 2024 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484992;
	bh=BZ5kgsi8htM5PzdZMROoo68JZDp20VmrEgCDYXY1iLc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZGvsDAflL1ile19Oz8uyBz63geETbe9NNofZdANotQuXFygtJ+ZXLtIRzOFQYEPEO
	 g5lJZAPJ9+UHj7xUJ7ksefgqvkkhYU6hINZK5DX+LY93j2EHiSr1PNRL1PcM0KNlWf
	 1kH741zlv7URt1O9gx4RB36vrPOJj5qgV5FPdjKdHIXq5Ch/HJ4p9uNdyg9MQ9PePC
	 RbRq/9dlQtZe+JfAZ7q+eGMA4MGZIIIXa0hRRPRRYNeNygzYgVRvsIeGLJMqlb2GI6
	 t0ElWcLWngq+1Yk8SRX4dTmW4VNKuTSJiNWMfdrMpSgDuT3d3tdyGZ097pvrtaEg85
	 9vRHE5vY4fwvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3413E3809A80;
	Mon, 16 Sep 2024 11:09:55 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240913-vfs-mount-ff71ba96c312@brauner>
References: <20240913-vfs-mount-ff71ba96c312@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240913-vfs-mount-ff71ba96c312@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.mount
X-PR-Tracked-Commit-Id: 49224a345c488a0e176f193a60a2a76e82349e3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9020d0d844ad58a051f90b1e5b82ba34123925b9
Message-Id: <172648499374.3648068.12784728682209297567.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:09:53 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 16:41:58 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9020d0d844ad58a051f90b1e5b82ba34123925b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

