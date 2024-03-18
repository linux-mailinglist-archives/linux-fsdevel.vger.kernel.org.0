Return-Path: <linux-fsdevel+bounces-14772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF187F17D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90741F2214E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C55A4E5;
	Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyFjlQSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5959B54;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794733; cv=none; b=oM6aCo249uA2bflRGTA32u3O01M5iqzILQ93gQpKI496OhpAc+LzHUH+8QQnm9diHR9Ar6PWDS0BEs9c40j8+QytKtSUqWVcbQF/NHoYfI2I8z716pbGfJBMChU+Ddl4vzebSPJ3zlgii0L27pneKjdpsvVEji73jMozJ/C5GtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794733; c=relaxed/simple;
	bh=RA7YG9SxvBNH0HzRjB4rflPOx+FpSXM4xEmiICNLvcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I8CZwjJOvXNT7lI0marR0gFNKAV7O81AH23KzB7oiRETCfLKRO7xVOQICK3I6R42KtFpetvoZQsonwnLAG/ZfEz2Vc4loMVTBixv0gQwomLUvrjy2YcXyqmMCGRzxLJ19VAjt/cf9rBNO1iRG3AMQ+iHp3jIgggpNf4KvGCerjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyFjlQSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E0AC43390;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794733;
	bh=RA7YG9SxvBNH0HzRjB4rflPOx+FpSXM4xEmiICNLvcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KyFjlQSNxf74Oqy7Vk41Z9wIUXqjnooZpsxTmo8JSxgThzYTCwHWls0FF4kzamlkc
	 BlUnEdjGJSg5ibhkZUC8lt2Xeel4gl61vL89noc5We60f9m4H0aWRCbEggOM63FrzT
	 U1A8ZyDACddoeXAkXK1+9VK8ib5U8ZT0jbstEuF+R64RXuhWsc0+MKGFuei8pq2JaP
	 ExIXX0oF28y6mNxHposHwr0sC7JB71EKrozyr3MdNIBhBxgYeeV4gsGh6iS4aQxzwL
	 2hQ0TTKB2vLUf8IIclhWDz0+927nPTxLVGQ3oVViWPszlA80Fb4s07T232h/EFw9uT
	 NK7/pbaFd1cZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2AE0D174C8D6;
	Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 0/5] block: remove gfp_mask for
 blkdev_zone_mgmt()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171079473317.25373.4387818669796784248.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: dlemoal@kernel.org, naohiro.aota@wdc.com, jth@kernel.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, jaegeuk@kernel.org,
 chao@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Sun, 28 Jan 2024 23:52:15 -0800 you wrote:
> Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
> I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
> it is only done for zone management commands and can be removed.
> 
> After digging into more callers of blkdev_zone_mgmt() I came to the
> conclusion that the gfp_mask parameter can be removed alltogether.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
    https://git.kernel.org/jaegeuk/f2fs/c/9105ce591b42
  - [f2fs-dev,v3,2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
    https://git.kernel.org/jaegeuk/f2fs/c/218082010ace
  - [f2fs-dev,v3,3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/d9d556755f16
  - [f2fs-dev,v3,4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/147ec1c60e32
  - [f2fs-dev,v3,5/5] block: remove gfp_flags from blkdev_zone_mgmt
    https://git.kernel.org/jaegeuk/f2fs/c/71f4ecdbb42a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



