Return-Path: <linux-fsdevel+bounces-23721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F83931BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 22:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438EC1C21DE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E341448C7;
	Mon, 15 Jul 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkA+mWv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500A13CA93;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075684; cv=none; b=CpZPqrj3s2wj5QhlCrhoCsO8k4UGx/j2Qa8L+vJpuUoOSNuOcMS2Khu7H7coAF9YpL1UuUZPjEkl4aRDYTuoAO5zG9QUv2inNKoSq8vV3lv/hDwNnRxNAmpHNoHWMG2PqSFMNONMgtdp8V9yPfi5HvFO8QSiAu19tD8alDoViTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075684; c=relaxed/simple;
	bh=a+x9MA1HiDfTnQucsHgh8IHqSj6/0s29AOmDbbHdYiU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iypkKaX3+CTEVQH2fiJEfIWKDqeRgUrfDAHrkxJyhM4YYIWuPL86s4y03Eru+y3x1DQRA/3UheFbvR65KHI5X4h/JObNK7GSknhTBdfObMb4+PkLxBKgRg93ZwpkgBiKRMxc0qTx/6m7/pCQEM4fbmrZAZX0taXaMNMD1s48ImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkA+mWv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF232C4AF12;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721075683;
	bh=a+x9MA1HiDfTnQucsHgh8IHqSj6/0s29AOmDbbHdYiU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IkA+mWv9IC+fpzwHtu8IxqeZyi69gpGpwTlZenLIDPgcVegQfN61l7/9IRYr9OHO9
	 oLmPjnBYkunF+LO49KFS+jqOhzBIhaEGZPhD3ccrMKsWdL4SoAliQMknUTVwkkzFOu
	 +pv7ZXNh4FxdtB2SEKJYFJK74Yg5nqDuf/0xHWnlEYGuiFI1wENEbf+nHgXU4iJ+XA
	 xssVp/M+scjUcpxJY57XbgbOd3uZxm9PWhZY1KB7QBQZyOxLDAHnPfqwvhsHb+YDh7
	 nx1vxiqjzxcME5zgkseCJp3TBMBBMbPkp4R5P79goYy8FroiYNSVSGpQQJafq8JJLl
	 VodewTqCEI1nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA457C433E9;
	Mon, 15 Jul 2024 20:34:43 +0000 (UTC)
Subject: Re: [GIT PULL for v6.11] vfs casefold
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712-vfs-casefold-816b45ce2d57@brauner>
References: <20240712-vfs-casefold-816b45ce2d57@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712-vfs-casefold-816b45ce2d57@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.casefold
X-PR-Tracked-Commit-Id: 28add38d545f445f01eec844b85eed4593c31733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a051e4c21dfb1c65ef54c44a7a4d0e6845e24f6
Message-Id: <172107568375.4128.5751013439751993372.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 20:34:43 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 15:57:15 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.casefold

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a051e4c21dfb1c65ef54c44a7a4d0e6845e24f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

