Return-Path: <linux-fsdevel+bounces-67378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F756C3D6E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88D31882E96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5773009E2;
	Thu,  6 Nov 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEymzIRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B52FBDE1;
	Thu,  6 Nov 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462441; cv=none; b=KEEShLBRVyrxUoj/K4xumyZRfFjZSirGWmO5ZCbVC5ink9bRECWobVfHrhJjwOvTAUOu1qIT6Pn/a7JtQ1UHxRA+m02LQ0frQo55tUGjh4JIBZfYP378WGtSQYqlCr9vjpxktZV06D0/kC1eqD7L4w9iKjEMM6Z/LHwMSM+1RZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462441; c=relaxed/simple;
	bh=WtUA3O+LfxM38U7u+HmmPM04mLhuvwGiIeTMdD4EmmI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V6JoQqmoGVaD/Haphk0ue7BCYGWtbk0kQn4aAyv5CTslvikGCevnJXKuyHrIpUre+xJTO2xOqDwGrW90fkTFF3MJBnwF7gk7r1QhhXRY85pfz3ezuAHo7KabnCyG6h33ljFn7UxCE+wMRD3kZ16QAh1FX1RarQ+/fwXxARqWQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEymzIRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B95C4CEFB;
	Thu,  6 Nov 2025 20:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762462440;
	bh=WtUA3O+LfxM38U7u+HmmPM04mLhuvwGiIeTMdD4EmmI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sEymzIRDufl6iChdOXFcHJiH1RH/jTLjNWtjBRF/K+Z8c8ntxkMS9/Rr4woiypW6q
	 JpaNgmcujCbuCI8XtPCIrhqyUP0XfHuCovifm8sju2CfhRf5mRfx0wMfnkGj9Zymju
	 mTMqdBSUKwkNY6lcdTaD1J9F69NUKsa3JUVhLRJVELIu9lHJUUpAUaE+LrD7Up9PTC
	 Emd9/5uWAnPQKesCi0J+dMxn3l2k+lcue1D6kY4YCluFHEiGF0QE/mutjQFsuARpIJ
	 rkvUj3n4Bg5J5bhNlCFctlYQoc8V7LqkSL4sfsEW8KyLTzdph12U9GOYRfZFZCgn7D
	 axxDKQhNEx6Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B8839EF96A;
	Thu,  6 Nov 2025 20:53:34 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt fix for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251106202637.GA7015@quark>
References: <20251106202637.GA7015@quark>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251106202637.GA7015@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 1e39da974ce621ed874c6d3aaf65ad14848c9f0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c668da99b923bc0527f19e361bb8496be087970f
Message-Id: <176246241278.354628.13333141710763776880.pr-tracker-bot@kernel.org>
Date: Thu, 06 Nov 2025 20:53:32 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>, Luis Chamberlain <mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 6 Nov 2025 12:26:37 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c668da99b923bc0527f19e361bb8496be087970f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

