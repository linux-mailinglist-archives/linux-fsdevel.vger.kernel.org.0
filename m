Return-Path: <linux-fsdevel+bounces-37512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BA9F363F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BBB1650FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D791C4A3D;
	Mon, 16 Dec 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS4uG8O4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EB14B086
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367222; cv=none; b=K8VIMR9oL+BBn1tH2wJWOjJ3qP9xfQAtkYh65Q/HcMYYY4lYgYl4Z38IMPb9nKpLDx0AFtK41OuSW86Nj2DOKeeHGDm6YGHYYz5geNnl2fdnGF3ztfBkEB/rBDTBOYw4QT88k1DeF1oMc35+tOWBKAlLQUqscx92NwmeeqxP4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367222; c=relaxed/simple;
	bh=XSMGgsdv+y5WcMVcf7eiqLkRr4rAybqXS0N+f/k9ZnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ChjDYd13Xsqta3YajD15X/8VBRLnl/LZxRFVCcPN0B7pQZ71/H7iXzq7GeQ9gjD0o5d8QYSpPVzOuAXjPB+cymdleB4TV1tUzguvVWSy8+MnxRRaJp9yQr78uQO1KX5IuaU0o6AEnbod/9+FMH07kXF8Ktzwl4XRP4qh6W9CDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS4uG8O4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD3EC4CED0;
	Mon, 16 Dec 2024 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367221;
	bh=XSMGgsdv+y5WcMVcf7eiqLkRr4rAybqXS0N+f/k9ZnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XS4uG8O4s7IJHqrXwK3nBROBYJYA/lWrjwx7LQWsg/zzqywMOAv+r7hlY8mbbAg5T
	 pUi8G5yOywY1jft5pk9eCEAAtDx8BdF9HC/97dMoXdmPUysBTTVr+6k94fTS3RQd3J
	 QBfWR34eV0fRbb0I1NLrChtnFuh8fALAbgCVDGkn8f4P5U3c2fS/6zONd/6ajvaWCx
	 afwMj5zl5MhrU4QxYe9hboFPA0ADUicT5tQA/idrZ8/lMb+F9TzlvNCjVoTT01MaE1
	 l4iKulblNyzKz9n3APrJ4S9dUsj54UsOwWxtsteNeMA8Gma0XmYR4sr+BI+ly9gBjn
	 B0B/h/JF39xiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6D93806656;
	Mon, 16 Dec 2024 16:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: ensure that node info flags are always
 initialized
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173436723874.272389.6295491443575015321.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 16:40:38 +0000
References: <20241212175748.1750854-1-dmantipov@yandex.ru>
In-Reply-To: <20241212175748.1750854-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: chao@kernel.org, lvc-project@linuxtesting.org,
 linux-f2fs-devel@lists.sourceforge.net,
 syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 12 Dec 2024 20:57:48 +0300 you wrote:
> Syzbot has reported the following KMSAN splat:
> 
> BUG: KMSAN: uninit-value in f2fs_new_node_page+0x1494/0x1630
>  f2fs_new_node_page+0x1494/0x1630
>  f2fs_new_inode_page+0xb9/0x100
>  f2fs_init_inode_metadata+0x176/0x1e90
>  f2fs_add_inline_entry+0x723/0xc90
>  f2fs_do_add_link+0x48f/0xa70
>  f2fs_symlink+0x6af/0xfc0
>  vfs_symlink+0x1f1/0x470
>  do_symlinkat+0x471/0xbc0
>  __x64_sys_symlink+0xcf/0x140
>  x64_sys_call+0x2fcc/0x3d90
>  do_syscall_64+0xd9/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: ensure that node info flags are always initialized
    https://git.kernel.org/jaegeuk/f2fs/c/76f01376df39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



