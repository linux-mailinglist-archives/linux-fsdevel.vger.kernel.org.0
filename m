Return-Path: <linux-fsdevel+bounces-44904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DCDA6E4E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31D73AF1A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F541F1527;
	Mon, 24 Mar 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhLTxp2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A51F131C;
	Mon, 24 Mar 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850029; cv=none; b=cpeO+fiK6Pb0lL+q7GIopF+iyWWxg00/xahc7iXtIMNXD+oO2ZhWvdi63hRZbbFQhscUs0H9j0dvY8W3lABTsaW3gznS9k15/jktAoAuNufSLNEjf2l80mWyU0q3wj61fN86d2pa4PdbXiPGnkElhxM1TT3o7nbOazWD3ytGexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850029; c=relaxed/simple;
	bh=QCar3oIu/+M7FaAbMHhng9atRd0Ih0q6UCoBaRVEV8o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S3EOwRc0Nm5I+Dl77wADKWXB5B6+nWXi3QvPjOV3Jw6YajLJYIOVCnQ3nj+n/7818LudDw7wrS/rycMxe0oX0iug6ww3d7lUfyUDOf3S1srMPpIzW2Od6O8xEF5xM/UjpQ6HHWCnCHjuVz8x6P4YYwCpOK8mlPt2L1Uultp5a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhLTxp2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D4C4CEDD;
	Mon, 24 Mar 2025 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850028;
	bh=QCar3oIu/+M7FaAbMHhng9atRd0Ih0q6UCoBaRVEV8o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mhLTxp2lI95V5LMBZfXNpQkg70pL6IEHT720XRfUF8KwFksU3mTM+DPZ7GJU/FFGO
	 5djnmZcRJW+X+H/W+ExYn2wNa5cwgzPB/3Q3+ol0yNpN2I6MFM3uw+mKbuS0USM1ye
	 RAXvLAHdTUKK6Y/aRUUEfquFmk/aF9zjIR+XQ3iRLNVwD9qaIYgXdi9z5YeSQB5Rrp
	 Rgbq5c0SxfnxtVB7fMbl+BbZG5K/+6sAkRgQV4m8FaFrkNgbjasXGywX4i/A/ycCO9
	 FKFg8171ToqPIlUhSX7iJVzbAr5KSozz0REsoexLCjIv6Ur6QDUH0ysd/VEVL4SIdY
	 dXhxz1cjL0+qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 427C4380664F;
	Mon, 24 Mar 2025 21:01:06 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount api
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250322-vfs-mount-api-04accc00c1fa@brauner>
References: <20250322-vfs-mount-api-04accc00c1fa@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250322-vfs-mount-api-04accc00c1fa@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.api
X-PR-Tracked-Commit-Id: 00dac020ca2a2d82c3e4057a930794cca593ea77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 448fa70158f9b348e71869cfe4a31988e07b20b2
Message-Id: <174285006514.4171303.10230384864254018916.pr-tracker-bot@kernel.org>
Date: Mon, 24 Mar 2025 21:01:05 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:14:34 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.api

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/448fa70158f9b348e71869cfe4a31988e07b20b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

