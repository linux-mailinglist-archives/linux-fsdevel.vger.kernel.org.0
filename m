Return-Path: <linux-fsdevel+bounces-40270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B6A215DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C6B3A735F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E218E379;
	Wed, 29 Jan 2025 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcPJm0KX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24A18B499;
	Wed, 29 Jan 2025 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112148; cv=none; b=M2lnQelQWp9acAsssoT+TBgNhL2abq69FkWjMirjCe8c0/xJt+8CG33RuF+ndipYB26DVGqZSrjYZsZc0WRxoVSN/pW2FEAgQakJwV1/uY5YkdG/wzVNTP+6symAbmTdrmKkSuEwwf0LzmyN2oGczvVkxFv3prCtLcg8pGrDhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112148; c=relaxed/simple;
	bh=fHQX4W65GyKIvsAVa0l454mFXY3/JQdzf77DNqOzYQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqvCtqpnqkxot04S4/egV2v5Xs8u/mdUSbjgECVxAGPTsE8nkMLECi1O5xglwQnzkJZCZJVxwjQF/o0cbSD00tQuEOr/p8v9Ovfm3irF4alMWjdCk3jhOLW7WK3N04QihlTmVRKMBTjkt0zn472Na4SV4nwzkTKQhXP41ADAnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcPJm0KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C85C4CEE5;
	Wed, 29 Jan 2025 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738112147;
	bh=fHQX4W65GyKIvsAVa0l454mFXY3/JQdzf77DNqOzYQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WcPJm0KXqHafFE1N+jb6xqiTvr74okKHA28WzssL52oxG/LC1LQO5KR4skEsgOAWN
	 sKn32sh2JY6iNqf5toA92jV2pp11kNk9cXQELTQqxPieLFLwtHe8b3h2DRZ7OIcTIl
	 zWiKBHsZKfWSDEnFH79jrsY3EwHWTVH+Bo+KXuBFsMoQmcXRJW14nYoW7HYTec0AO/
	 i77R6S6DU72BKytNFatgDTvqHIOuvqrMv8TcOeuq6hGPgVYr1GtHiDWlUCb24aPL/D
	 YsXMhFt21eqwkrFYGxnmofh1sO+IShmJK0mtg1ryUFFLXrSD1GK4cyRANoZjDSF1M6
	 x2QMIAS3zsBmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9B380AA66;
	Wed, 29 Jan 2025 00:56:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 0/5] data placement hints and FDP
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173811217323.3973351.17971976914892259618.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 00:56:13 +0000
References: <20240910150200.6589-1-joshi.k@samsung.com>
In-Reply-To: <20240910150200.6589-1-joshi.k@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
 bvanassche@acm.org, vishak.g@samsung.com, linux-scsi@vger.kernel.org,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, javier.gonz@samsung.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by David Sterba <dsterba@suse.com>:

On Tue, 10 Sep 2024 20:31:55 +0530 you wrote:
> Current write-hint infrastructure supports 6 temperature-based data
> lifetime hints.
> The series extends the infrastructure with a new temperature-agnostic
> placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
> send the hint type/value on file. See patch #3 commit description and
> interface example below [*].
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/5] fs, block: refactor enum rw_hint
    (no matching commit)
  - [f2fs-dev,v5,2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
    (no matching commit)
  - [f2fs-dev,v5,3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
    (no matching commit)
  - [f2fs-dev,v5,4/5] sd: limit to use write life hints
    (no matching commit)
  - [f2fs-dev,v5,5/5] nvme: enable FDP support
    https://git.kernel.org/jaegeuk/f2fs/c/2fa07d7a0f00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



