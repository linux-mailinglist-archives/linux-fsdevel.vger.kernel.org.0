Return-Path: <linux-fsdevel+bounces-23998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F4937771
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B9282FF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174812C814;
	Fri, 19 Jul 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqnAVlI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83C74079;
	Fri, 19 Jul 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390765; cv=none; b=p2089ZpIvzMqYuOsa6zNltCy34ou/pH9pg3luUVC/xRuUM5Ja9xGg5o0U4pBMeDmkCg/5zdvObPlqMFMu5WHXDEiJkX/NBKZItgkTKjwjyKWlw5PM3qPrsdOyPbIWxoAz3q3BCdAqVUMFU2ZylzHgxiwDe+SrTYX8mkro2eIJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390765; c=relaxed/simple;
	bh=pXPmQ5fxWBxZ4qMyWInm6h5U5o+UITisMkLT6dPaUhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQFiZpulvQmBmyG8Pc9Br6eNNrwC2rQHeuWwU3/63jgQLlCQG86zipSg1lKrkLRsWHY4h/+hAp8JTyShzWndLFE/PVU0Jqflsh9Gme15u/wUzZInL2b1GAb/OlZwrde2qhCfXaeL5XuH05AlBpF0lj7NAaopVer6hr8PatjYstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqnAVlI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B0DC32782;
	Fri, 19 Jul 2024 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721390764;
	bh=pXPmQ5fxWBxZ4qMyWInm6h5U5o+UITisMkLT6dPaUhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqnAVlI1/tqv71/MPNLPAHxkySX2M9evlLqzm/vfou13owF3zUAaqNgS+EVuka1Vc
	 i9wRSY1YdDRPbd8oM38z05+FP4PwzTrTQIYAszhGbHNUmRpjIToHy1ybze8sUSZPAr
	 wZKvHfgnc2q+8U8V9Yw6iMmFiY/Vd46/RBM9sbjpW5ai/es2Z/40htSxKBqJq77hjP
	 Dmb5VHs+p2FFO4U65JJ5w4PPK/sU8qJ1to3Gw/NZHjDKU/DsbTw+6qqbjtkhtxCWI4
	 JJoEQuWvZ+zQoj+OCqR9wC/37sQQaZ7xsfGPc6Kc90ecB2EQwOEmTVL2VctdFw7oOx
	 9ypFrrWeqr2Wg==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Congjie Zhou <zcjie0802@qq.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v4] vfs: correct the comments of vfs_*() helpers
Date: Fri, 19 Jul 2024 14:05:56 +0200
Message-ID: <20240719-kernaufgabe-gediegen-c08676d0c82e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_2FCF6CC9E10DC8A27AE58A5A0FE4FCE96D0A@qq.com>
References: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com> <tencent_2FCF6CC9E10DC8A27AE58A5A0FE4FCE96D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=brauner@kernel.org; h=from:subject:message-id; bh=pXPmQ5fxWBxZ4qMyWInm6h5U5o+UITisMkLT6dPaUhY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClu+5f6WM31c8aEb/dOXBM1YIinuOvWwf/Z59/R+b b3KvtZPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5vYGRoc90R7dPlO2Pnfmd 65O1vEw8SkX4GR/f6Q4773NR1JxpMsP/ijjbS+0eD759L/x9a1VkRGOxTc6NAAX/XwobYt75bdz LAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 00:25:45 +0800, Congjie Zhou wrote:
> correct the comments of vfs_*() helpers in fs/namei.c, including:
> 1. vfs_create()
> 2. vfs_mknod()
> 3. vfs_mkdir()
> 4. vfs_rmdir()
> 5. vfs_symlink()
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] vfs: correct the comments of vfs_*() helpers
      https://git.kernel.org/vfs/vfs/c/284004432c83

