Return-Path: <linux-fsdevel+bounces-54672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283EB021CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D6C3B3DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6102EF647;
	Fri, 11 Jul 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1QxiFWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151282EF641
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251388; cv=none; b=rW3W5RLnX4G8E4G/o3GMrBaSZIwYFJFbs6H7/F0XncdK+OYqSmJejTckXSd1IFAx64i2/6ogPEdJxvtvLypK3d6tcEpAsjkpqI2ftpjsZlehSxpkw8d00q5u1XPl5nVVMYDWo2GGDJmg3CMi//nkURsrhA569NJGi//EPKRLPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251388; c=relaxed/simple;
	bh=regUJwiUyUfYo9SilQRTdYXg8Yrk9zqB8WXtaKE8YEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AXLI8w3tQFUWJjX1hp4rePjQ7AMpuYHxfwO8KnQbTmgvCCICKg3yVs9/lZprnN4c6NQLoAGZljIjUPeSFMSP9rSF3syS3ns+7nA+bUEq0t+3/PXTy2DwQIiCD4hkfMKdWQn8zTTC7ZMh/9ZAXXbPXjwjTsCAWjJFvGEA3uVRmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1QxiFWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF05C4CEED;
	Fri, 11 Jul 2025 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251387;
	bh=regUJwiUyUfYo9SilQRTdYXg8Yrk9zqB8WXtaKE8YEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I1QxiFWn8Cps9GA/XNKxP/Vak59hfxVvIy7HrTMBSg96o0eTN+IGm8yinCpyW8qmu
	 OmKN4uYEHXZ5PmK126B24ZltGKkWVjRdqwNywTGJrfYfSqXy+4mJJkMfXdjDoEoCAc
	 4GzM9to+Xz8Pim6m/z68jA5EVgIgiiGzB0nsxWXvHV24+XCRvLghDn9CBVagMzfMPb
	 hCjH3LLs8BSzdhEZkLfqBZA8oaBZ/UpFgnreIMyfWQd4bxkCy32Qka+J9sLh2ZwAH3
	 YzYbtZLlDHIvyfyL6Ofcf4B3DPoHIfm6WBa2QKjai6Mbu/JCsgUWMUWFrHiWw0LbUh
	 PLpRaMD8kSBKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2C383B275;
	Fri, 11 Jul 2025 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/9] f2fs: new mount API conversion
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175225140924.2328592.1750911075772737839.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 16:30:09 +0000
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-fsdevel@vger.kernel.org,
 lczerner@redhat.com, brauner@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 14 Aug 2024 10:39:03 +0800 you wrote:
> Since many filesystems have done the new mount API conversion,
> we introduce the new mount API conversion in f2fs.
> 
> The series can be applied on top of the current mainline tree
> and the work is based on the patches from Lukas Czerner (has
> done this in ext4[1]). His patch give me a lot of ideas.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/9] f2fs: Add fs parameter specifications for mount options
    (no matching commit)
  - [f2fs-dev,2/9] f2fs: move the option parser into handle_mount_opt
    (no matching commit)
  - [f2fs-dev,3/9] f2fs: move option validation into a separate helper
    (no matching commit)
  - [f2fs-dev,4/9] f2fs: Allow sbi to be NULL in f2fs_printk
    (no matching commit)
  - [f2fs-dev,5/9] f2fs: Add f2fs_fs_context to record the mount options
    (no matching commit)
  - [f2fs-dev,6/9] f2fs: separate the options parsing and options checking
    (no matching commit)
  - [f2fs-dev,7/9] f2fs: introduce fs_context_operation structure
    https://git.kernel.org/jaegeuk/f2fs/c/54e12a4e0209
  - [f2fs-dev,8/9] f2fs: switch to the new mount api
    (no matching commit)
  - [f2fs-dev,9/9] f2fs: remove unused structure and functions
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



