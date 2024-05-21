Return-Path: <linux-fsdevel+bounces-19918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F608CB292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2851F1C21B89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9612FF76;
	Tue, 21 May 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REVxkS+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024322F11
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310861; cv=none; b=gSVrl01w1KoGJv6CMf1KBTjQ7D7oGhP206HNrzwZ419I2Ymbvwb8Jczp+V399+1K48GJ4l0NotbyVuZMUrC6IyZFMlnjtW7pXrcXZ9UjJaOoeul+J0//aSJRbAnInfp9hH8yoZniAmtnrk25k/i45nacnD/VcL/6m2+/NmxO2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310861; c=relaxed/simple;
	bh=mMNl6Ncj4A+tETpcPApZRZ3iF5+ioYAzoYibR1yT4A4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IqpELa+1G6BjbD+zX06cPsR25C8DKRxc719UCPzXIqwnN3mXsuRg9i6zJCTKNiY3I4ZkzcA0J8exXSfeiqFIGSIhq3s0/+E7iJo4nINk+08R3fRuOa9YZ4g6GAKGii9uJx5oHOgb5yso29xK765JzPQ3VI8dts7KGqk/PRSTgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REVxkS+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29AAEC2BD11;
	Tue, 21 May 2024 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716310861;
	bh=mMNl6Ncj4A+tETpcPApZRZ3iF5+ioYAzoYibR1yT4A4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=REVxkS+Ju6o3PJSvl7SMJPZ2oVnifhVEGysQKz90nww/vDxHDSyrCpSwV/djnmJ6n
	 cjWv8Piqd7r4xO3YnEm96pfjHB+TxrNBq7iMv49Kf9AvLd75yb5kkPhYTA5oHKZQ3L
	 o57B6xHGjy5Wq4P4agtSgMOQbNv6uKdVE71RGhNu6qsf675ptQFy+GRjXyv4DaUZEQ
	 0wCOPGKOFfYZEhloVj2poufUO4l90jOzliVCbH2aKn3IPVe01URRiHB7fXZFELUjhG
	 oOTiVZ8wpTbXUOgfzrHD6XeuQ8G05xJNtZgLLuS5Pm9WFEMY9sU1hKCJ4n/OwN47Zr
	 gS/xMUtRQHKww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BC70C4936D;
	Tue, 21 May 2024 17:01:01 +0000 (UTC)
Subject: Re: [git pull] vfs bdev pile 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521163852.GP2118490@ZenIV>
References: <20240521163852.GP2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521163852.GP2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_inode-1
X-PR-Tracked-Commit-Id: 203c1ce0bb063d1620698e39637b64f2d09c1368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38da32ee70b876f5b8bea7c4135eff46339c18f2
Message-Id: <171631086110.9508.6180516350582766524.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 17:01:01 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai3@huawei.com>, Gao Xiang <xiang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 17:38:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_inode-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38da32ee70b876f5b8bea7c4135eff46339c18f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

