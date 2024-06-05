Return-Path: <linux-fsdevel+bounces-21070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799758FD5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 20:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EB31C23F14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525D13BACE;
	Wed,  5 Jun 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQdZepe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345913AA5E;
	Wed,  5 Jun 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612324; cv=none; b=kN/yf4Z7PRcA+WpLh+pL1W7VQ7fN2e036pB0eOzRt6qONgjPg4+7hVPh7GWzM5w4hPhapnADLOePlI7HcNImToXudWJvGE+WV3wfRNUYXJR+MTnTJz9PI2hV61eiB8SHkmHjQwM07FmymIpFCiv4Ffbtp9dX1I1G75qN18PYOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612324; c=relaxed/simple;
	bh=+L1g5GUcYq1VwF4g1m88YMsxeXzzoG1H9G362VLEEA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A4undr+JfJ81VPAbVaJ/PfgnG0E0KrMvNU/tUyYxM9RiFSCzatJi3vcEsLRS225vf35PeRW2jjdHNMWSH2x75mp5i3/0llPfc08kAkov3j1KpgJqL4Z8W2bWaeQUGIZou6IMXG5uxTif5C3Go0+p2mLflM1cTDFLCmQWJ0pB9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQdZepe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE24C2BD11;
	Wed,  5 Jun 2024 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612323;
	bh=+L1g5GUcYq1VwF4g1m88YMsxeXzzoG1H9G362VLEEA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gQdZepe5/bLATmf5ohyaRJBqSa8pgI952pzVqjU5bC2c6ywgaMrE4kvyzwMZdjICr
	 3StapkrI6l8MFfHVHjAJ4OJumelrpdwD/Yk3RgSr7MCu+nWyJi2BRt7psCRmHXzXlS
	 yW7Gp9Yxo9/Mre3qgk4A7EngVpq7ACNpLabqfWptpief2hY05FaumUoYviQN9KE+wO
	 GHyuf3o7F5S1h5fE3UYEL7iaQtay5EqHuarV5BcctCUBmSTQHGDEh1dDoq6tsfvzSN
	 2W2zCChFdEzNrV3wNSksVVK0ogL3htkPV2ouJ3roFuw23jlY7raC1RCgIN+v0/sICG
	 wjBLEq4VKLY9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4212C4332C;
	Wed,  5 Jun 2024 18:32:03 +0000 (UTC)
Subject: Re: [GIT PULL] bcachefs fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <4a4gssdsaohqqh33hd2i2tavvfsjixngyfsyddy73keqauh3yo@m4vtvrly275m>
References: <4a4gssdsaohqqh33hd2i2tavvfsjixngyfsyddy73keqauh3yo@m4vtvrly275m>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4a4gssdsaohqqh33hd2i2tavvfsjixngyfsyddy73keqauh3yo@m4vtvrly275m>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-05
X-PR-Tracked-Commit-Id: 319fef29e96524966bb8593117ce0c5867846eea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e20b269d738b388e24f81fdf537cb4db7c693131
Message-Id: <171761232379.20262.17923662480382375745.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 18:32:03 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Jun 2024 11:00:34 -0400:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e20b269d738b388e24f81fdf537cb4db7c693131

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

