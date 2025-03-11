Return-Path: <linux-fsdevel+bounces-43736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3502A5CFEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7211F189EA33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70B264A6B;
	Tue, 11 Mar 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4eq+9g+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFC264638
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722605; cv=none; b=Zfjyo5plrr8Q8GhKQcxEjFCi02P6olFRnBg/zg1t5u/3HsYIDLI/zd3khYwT15lyKMxKjnNKbb3kroXEYmOEN48oQi645EfkhkYMotKepCxf5SveXmYihTvKJQbg/QwgY4H6izZG2r8vug+MsY/SkSVFYrcEpdj3QE2JE0NIaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722605; c=relaxed/simple;
	bh=NWDF5ErT0ort93GZcRV87fUQSw4ceuLFCLbVehXWlFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YgBDe7HGR0K1EU7VuAKEgM0O0oM0vtjwQRqpUwwgoLbp9JkIKuvxVtZZ4059uhdHs7aPFm1ftIeY8Nn7cqm5XmufGtASufzpf7arEtkfUzi2N+hZFliJASVPlCIgyDfDMFUhNvLSb9pQGFOTL3Ap38jdOPXqv7MdsVKcbUFcZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4eq+9g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784FEC4CEEA;
	Tue, 11 Mar 2025 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722604;
	bh=NWDF5ErT0ort93GZcRV87fUQSw4ceuLFCLbVehXWlFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o4eq+9g+7C4lVLnkxDZUUJFposQw4rJ2pbCWtKfEmMWTCGwQbnTqLQIDbpBst1M8D
	 le97bWIdZ5Q6ATlLwNhkUx3dTh1Ho4hVCF8BGPuBj56N6BC9hvuIPZ+BN++6BHhHPG
	 bbILhBXndI/z35JuPwjHlPukt3E1CDV9WdzYGDGK/vr3M9d/oGhp6e/Bb8ysBL4LFr
	 1bmMyf+UsLHaiKyt/1bg7wNCRZLFEBuww3/m9RxUUaUEHyFLdNFCxqvQBbxXCC1Cli
	 OvnnRv3y1yE74jpqQQz3EVpyad1AANqVwaHlRU4+xRwtoc4pXLR56c0tWsU5wYb0kL
	 aRITFCX4PbdPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD2380AC1C;
	Tue, 11 Mar 2025 19:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 19:50:38 +0000
References: <20250307182151.3397003-1-willy@infradead.org>
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Mar 2025 18:21:46 +0000 you wrote:
> I was planning on sending this next cycle, but maybe there's time to
> squeeze these patches into the upcoming merge window?
> 
> f2fs already implements writepages and migrate_folio for all three
> address_space_operations, so either ->writepage will never be called (by
> migration) or it will only be harmful (if called from pageout()).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: Remove check for ->writepage
    https://git.kernel.org/jaegeuk/f2fs/c/448a834f89ad
  - [f2fs-dev,2/4] f2fs: Remove f2fs_write_data_page()
    https://git.kernel.org/jaegeuk/f2fs/c/6ad3ddbee892
  - [f2fs-dev,3/4] f2fs: Remove f2fs_write_meta_page()
    https://git.kernel.org/jaegeuk/f2fs/c/3b47398d9861
  - [f2fs-dev,4/4] f2fs: Remove f2fs_write_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/7ff0104a8052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



