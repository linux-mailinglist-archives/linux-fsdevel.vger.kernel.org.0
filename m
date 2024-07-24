Return-Path: <linux-fsdevel+bounces-24172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6993AB25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 04:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD50B23AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773749658;
	Wed, 24 Jul 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy74heXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289073D982;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787408; cv=none; b=jglkybHKzwZZuPK4oa8FDwTurvlSf6daVQNDpk5jSQfIFcLIVcT18xY/yp5Ae0zFhc9TcbrohXKVZXsgrMXMfsFu05kjKa4C826It13Frccfzi3+Dv+jnlLNJxPk1vN1DJpEu39o1jSXfEsHoWBVoQlzuV4cAX84DV3CKJdpbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787408; c=relaxed/simple;
	bh=O256qwtoDTt0sY2c2+MzY4GWbDYIhg2GsSCQvSOSG3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZ76qBqMRvySVYCwpwOGN3fxS0QlOCuadsmw0lYS5eyG7yXX+ixTzuvvuq9pPsJnTciHKZl/Lz2yONa6ckAkn4b0NJn1jhyxNftrcl92amQTqgfvHQnCn50ZmaVcheuM0gDAEIfgEyNmuZoj7YYJLX2ynVagPjbX7pfZR02xk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy74heXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 917B4C4AF17;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787407;
	bh=O256qwtoDTt0sY2c2+MzY4GWbDYIhg2GsSCQvSOSG3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uy74heXSn+D07XnF3R7c6mdqtDnzVu9CAtvod03+tYzstNr8UXR08P1aE1NQOB3SC
	 f5w1R4OTju7HY+MNt5MsPB9P6seXhz8pUnGGEwuYSFFeIe5nZVWSNkbMvXd87pnN17
	 vMphm1DOLZVnKU8b0/ZxKEKGojQD4ojUSWCfWXl7ka/PXNMMkP4zWzqb7LuxJR07h1
	 P6xP+3qUzJFP6+D7p4Qog/EbCizDF6KZDOtbc2Mbg5VbjwjdxylAPQq7vo6WPDZkEO
	 yLCKW36puUFVpLvQaLVwxXzYaK/MBErRgwNIygyhhW+ju3OZIuAbgQqLbsEOmXuD4x
	 MJ0AGFsyM9UuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 799F9C4332C;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] fs: Export in_group_or_capable()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740649.17759.11088131748657824514.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240620032335.147136-1-youling.tang@linux.dev>
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
 chao@kernel.org, miklos@szeredi.hu, tangyouling@kylinos.cn, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 20 Jun 2024 11:23:33 +0800 you wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Export in_group_or_capable() as a VFS helper function.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  fs/attr.c          | 2 --
>  fs/inode.c         | 1 +
>  include/linux/fs.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] fs: Export in_group_or_capable()
    https://git.kernel.org/jaegeuk/f2fs/c/9b6a14f08b48
  - [f2fs-dev,2/3] f2fs: Use in_group_or_capable() helper
    https://git.kernel.org/jaegeuk/f2fs/c/8444ee22adb0
  - [f2fs-dev,3/3] fuse: Use in_group_or_capable() helper
    https://git.kernel.org/jaegeuk/f2fs/c/153216cf7bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



