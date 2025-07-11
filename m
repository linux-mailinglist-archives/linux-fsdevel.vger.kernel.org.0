Return-Path: <linux-fsdevel+bounces-54673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E0B021CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7B8A640BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8542F0032;
	Fri, 11 Jul 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TesEnwQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA2EFDB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251389; cv=none; b=HabkqTLr9pC0aQQMwlgLFqBQXs+65y2TvC0JWdQz1zlYd+4h0tF221jIGzddEF3kZ4pczB5kJj3M25iGD3Za0i4zfU3B5MZuEdmiqBxWWQwi2KnWcjikpBQNWSj1ypxr53lB3OrHbk68wv7BHyCsyvHgBEOaD/IWSGnp4wbBA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251389; c=relaxed/simple;
	bh=2OGQGgPpKvvNdMjGBIOmpAcS0bNRC4IugzOe+tpf3aM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BuUJf+iHTph4KgnYTvEnfkVBDtl6c+MXb3KfzJrHlM/n8I08IQkQeO+V16vriyA3h5bwFGKajeQnVW/7nSXrBZqANk6qWXuZv5qaSh/vgWqmDigQ3UiLAL0ArJWDVhcNYH+3r7xtR41R9mh8CMXn4SH1LqGVZjRSGn2jmrBnufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TesEnwQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB1C4CEEF;
	Fri, 11 Jul 2025 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251389;
	bh=2OGQGgPpKvvNdMjGBIOmpAcS0bNRC4IugzOe+tpf3aM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TesEnwQGrpHC2OLod6aPqiCZcNw8EHJmjNIYTld6j4TcvWVRRBaIOplawF1kwmfTe
	 dN3Ej7vKYpwMNT3/FduE/QB66bt/6tJtVaGOSqBqn3WvFaap8WwrCKAAlmfKlMTS4H
	 1F3IH95k4BqxyxczCDrU6yKtOtfzzD0kuNubS3R3X69XO9Ac/YDOCJdsVIZG08Wvl5
	 8S7rRMVoIe4ALFslCmykFy8slTL1raNM66op/h3I2TwlR0BF3h+JO6H7gm1zP5kvjl
	 k7+hiNO5ldIFRYbLCcafPxr/WINDn53qvOGWkIoKrm+bKwsa/R984NiN613TTc5/gP
	 ciNL0qXCzlW9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3402B383B275;
	Fri, 11 Jul 2025 16:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/7 V2] f2fs: new mount API conversion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175225141074.2328592.18102776950880358340.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:30:10 +0000
References: <20250420154647.1233033-1-sandeen@redhat.com>
In-Reply-To: <20250420154647.1233033-1-sandeen@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, lihongbo22@huawei.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 20 Apr 2025 10:24:59 -0500 you wrote:
> This is a forward-port of Hongbo's original f2fs mount API conversion,
> posted last August at
> https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/
> 
> I had been trying to approach this with a little less complexity,
> but in the end I realized that Hongbo's approach (which follows
> the ext4 approach) was a good one, and I was not making any progrss
> myself. ;)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/7] f2fs: Add fs parameter specifications for mount options
    https://git.kernel.org/jaegeuk/f2fs/c/a3277c98b64f
  - [f2fs-dev,2/7] f2fs: move the option parser into handle_mount_opt
    (no matching commit)
  - [f2fs-dev,3/7] f2fs: Allow sbi to be NULL in f2fs_printk
    https://git.kernel.org/jaegeuk/f2fs/c/405e5e00bfee
  - [f2fs-dev,4/7] f2fs: Add f2fs_fs_context to record the mount options
    (no matching commit)
  - [f2fs-dev,5/7] f2fs: separate the options parsing and options checking
    (no matching commit)
  - [f2fs-dev,6/7] f2fs: introduce fs_context_operation structure
    https://git.kernel.org/jaegeuk/f2fs/c/54e12a4e0209
  - [f2fs-dev,7/7] f2fs: switch to the new mount api
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



