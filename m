Return-Path: <linux-fsdevel+bounces-36109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A49DBC6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1BD164729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182A1C233C;
	Thu, 28 Nov 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY1J/dVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DE3FD4;
	Thu, 28 Nov 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821561; cv=none; b=DJoKWk0KzENWHHNbfdM7dOwfr7H04nGPZ6kfIwoZnI0g8q5+XTjxOLtGwlt1XZHF5gX+RIO8lTv9zQflS3bJNMI+xc+wo60ZPZv2Ps6rscOhefAk98Z3mjpXfJrJuFTCG7vuRg3AWQ7qagUHoItp04QoU3h53UgX2UhpVcjroSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821561; c=relaxed/simple;
	bh=foEo86i4yVp9bxSjMHAl+mqNx9NzG7RMiYHoboHWtLw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lPXmVmwbPIWv3icmHhGyiuqirCsCERd9CQMlrL6+zResOOTMFhpvmkaxlbLAQpf+Ry5NCZ1WuCAP6zDrHOOed/zMGBmZDFjwX3owo+iRaZtOBKXcKKJMI2B9TngDW13d1HQJe2T3SY61yOK33vUBdEOKgb7hOkR3YdrnD6ubZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY1J/dVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F110C4CECE;
	Thu, 28 Nov 2024 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821561;
	bh=foEo86i4yVp9bxSjMHAl+mqNx9NzG7RMiYHoboHWtLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gY1J/dVCQizX1+6de6Invt881lsGBO4Rk0EYq7uiURBPEyQ5XCGiP8N+pbl8C/0fn
	 TWe1OGsKG2Mz6IyFN8zObDy38RZasU6OxH1DqNyDbqHRiGyllBJsj4Lh53ob8D+Cqk
	 kNakOaSOxMuEfSKysNILDOwn72tzfkOS+9OgpicxXzFeZngOKZGrvsRPqAVToYp72Q
	 buAB/+CS7xCT86f7f2cKpaBHOwn74zMYPIylR7nrrZCA/Bm4AqJhQCk8sWhi11lirj
	 QrHtb8MWfbmpJM5TZ0U7K1VhfrpR9hL6rLHFbjDD56hmtKuNj2rMtd2oX6xcDN+uKj
	 7AmDdlCzOrTJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3CD380A944;
	Thu, 28 Nov 2024 19:19:35 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241128113505.44406-1-almaz.alexandrovich@paragon-software.com>
References: <20241128113505.44406-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241128113505.44406-1-almaz.alexandrovich@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.13
X-PR-Tracked-Commit-Id: bac89bb33d91cdd75092e15cf59fe6be34571142
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fdae000a3db8569430aa9189a30f8a3b7480c58
Message-Id: <173282157421.1826869.16390150994688225596.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:34 +0000
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: torvalds@linux-foundation.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 14:35:05 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git tags/ntfs3_for_6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fdae000a3db8569430aa9189a30f8a3b7480c58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

