Return-Path: <linux-fsdevel+bounces-38008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783769FA54D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73A316646F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520318A6AF;
	Sun, 22 Dec 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFWHGkMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFA170A1B;
	Sun, 22 Dec 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734864442; cv=none; b=OoZxbvZqIcG65IB8ZLS2PvtHX1DU5FcZJfVIdv0WP0cCoqGf3eEUGdmPjTXyz+XGpYUsHonKDpflCVWbYrvlJL/ng2aac/w2wnq+Ji6wei8JUj70nHMslVcpxn3Kvt7YH7fx437J5pQYLL62XZAhy9EVd/zoanZKwm47kqybTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734864442; c=relaxed/simple;
	bh=6EMSslUEddoHu+IpDHBvGx+zzFKAlyrR0bJRVdY1Yx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVTKDxfK6cMKHwhdhi0Y0M0+O6A3JrB+g5ekT2S+Bmk1DLy5OjuqspsLKpjwlgmixNShnER50zADTsdm5rJ9TOKBMz2gbkLYbTYwUeNvW5ybd674U6NSVQfoZHx/5jQWgOBqyr/JgFenzoZa6t0s9QCrmj8205hQPc9Mu6q8cx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFWHGkMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3668C4CECD;
	Sun, 22 Dec 2024 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734864442;
	bh=6EMSslUEddoHu+IpDHBvGx+zzFKAlyrR0bJRVdY1Yx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFWHGkMK/aC9gf0Qwx0SUIVYdhBhOLQlF+T/Z351uR+NTTGfIj32EJo0HPDerUtCx
	 7sGpf+HfdKVOwBMNFdHrr7QwD1Bzama8WP28612YzsEceFAK9nd0rGrqoIf8fGPV+q
	 q5RRgP1bR33mW34AGcEbPE7GCRMJsE8eRKKwjCABiEbLZ7DCBw8XMK+EaBMo7fx9Qe
	 ri+G7/s1CPk6/Ub2Sg8b9vE205OWU3mpOvxG2wQQ5RPgbwg/P/BULvIrAKUHhs3P0k
	 WZMxHfyZByCn6FFNqx+YlstbCU+gZGsvZj4DPHNmovhw+npYWW5FbjgYB4NqBFLMFf
	 +0eV/56oZCWiw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/vfs: add __SANE_USERSPACE_TYPES__ to mountinfo program
Date: Sun, 22 Dec 2024 11:47:15 +0100
Message-ID: <20241222-bagger-laute-70409cd196f7@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219-statmount-v1-1-9fd8eab3cf0c@kernel.org>
References: <20241219-statmount-v1-1-9fd8eab3cf0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=brauner@kernel.org; h=from:subject:message-id; bh=6EMSslUEddoHu+IpDHBvGx+zzFKAlyrR0bJRVdY1Yx8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnvzMW+PrsftS2qwxW+zS/Bjo8SRf7nfBOKvajTjzno sfz3V72dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykKJuRYWG0kuG+ZNbeiTp+ K4V1JO9tWn3xqNVT6b0X3m4Jrmi/783w30XpEde7SwzCk8OtAlSXr+arq/SNDtjmO49bIf3i9YP dfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Dec 2024 17:11:40 -0500, Jeff Layton wrote:
> mountinfo.c is throwing compiler warnings on ppc64. The comment over
> __SANE_USERSPACE_TYPES__ says:
> 
>  * This is here because we used to use l64 for 64bit powerpc
>  * and we don't want to impact user mode with our change to ll64
>  * in the kernel.
>  *
>  * However, some user programs are fine with this.  They can
>  * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
> 
> [...]

Thanks! Folded into the patch that added the mountinfo program.

Please also note that I moved the series of which this was part from
vfs-6.14.misc to vfs-6.14.mount as it makes a lot more sense there.

---

Applied to the vfs-61.14.mount branch of the vfs/vfs.git tree.
Patches in the vfs-61.14.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-61.14.mount

[1/1] samples/vfs: add __SANE_USERSPACE_TYPES__ to mountinfo program
      (no commit info)

