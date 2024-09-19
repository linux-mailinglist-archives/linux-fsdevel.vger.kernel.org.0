Return-Path: <linux-fsdevel+bounces-29685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F56397C3D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D23B23017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA61CA80;
	Thu, 19 Sep 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhF8CJ60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10981C683;
	Thu, 19 Sep 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723204; cv=none; b=fu0uX3kUcp0tIa2I+aFpDEsu14iP96T+5jjYvibU+lBnw6zNaJifD9KVg0V4iiyE/WmcGwr1pm+2GalG2MVxR2E5z+8fi9OCO6ur+q+qP+1jqqbNux0NIbDiplRB7WUwPzyvArFxJjzG+lQLFmI9mX5JtNoALfZuFVFhZKHXWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723204; c=relaxed/simple;
	bh=raWofrm8cDmPr7cF0FmrpAhhlBdl9rzid9Zy3N3WHnA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MmJ6qWDwMaqDYZBumTdIJ5JrESUKEBNq2zbmk86/ky0FanQSjdL5FJthxLTyaG9c+h6RyHzerwHAXqGJtQ6XGu7CE1amhTukYDOEnD96Fx2wNgQcrklbnBgZr0QqVihDpky8V4DOCLfDKVGwoxYaew2QHdpB9ifhhg3O82xxtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhF8CJ60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82150C4CEC6;
	Thu, 19 Sep 2024 05:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726723204;
	bh=raWofrm8cDmPr7cF0FmrpAhhlBdl9rzid9Zy3N3WHnA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MhF8CJ60ot/v2NToG+u7/yiofcRyrFUEBtqXs1I2rLCSKvHwC0tIrRDGpXZ9FtrWs
	 hjE3PPTcOjIUeolzTDItDpUtJ7GFJs0XrW1/hGVLpyYoY2P5gzxP1ERsXgeyoTggAs
	 akBMNjHNY73wFjv7ptzSwROK+35qHyNko0T79Q1Jpf69EDHv0loq5/rM5dj2VGgOqR
	 rOLYAgppqLY8UTEy6luDkEmJfjbV2KfQDiJqR2ZOqYkS8DIa0Kv/jSh9F15WQgrNA+
	 Vj+HKgjBpL+3I52wtETsAcQCaJ165BLj5JASPC9xTrz2KsktUnFg4SmCKsyZqzQbcZ
	 XpGV50ReQzkAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 982D63806651;
	Thu, 19 Sep 2024 05:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240916182608.1532691-1-amir73il@gmail.com>
References: <20240916182608.1532691-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240916182608.1532691-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.12
X-PR-Tracked-Commit-Id: 6c4a5f96450415735c31ed70ff354f0ee5cbf67b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45d986d11313ff2d8ed2cf6a34e2aefdc4639a99
Message-Id: <172672320645.1036593.9953504179216116966.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 05:20:06 +0000
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 20:26:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45d986d11313ff2d8ed2cf6a34e2aefdc4639a99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

