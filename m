Return-Path: <linux-fsdevel+bounces-46617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B2A91739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ACB3A791D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67343225A34;
	Thu, 17 Apr 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/H/kuP1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39420FA90;
	Thu, 17 Apr 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880662; cv=none; b=JhIUN9yztG+8TVLmBtQ2pfStN1CUuTd5l2qpWfUChPgAOBF6/kvvZvnC26MfRBPzaTHEwbrocSRy2AvwbvucWzGezLkCbm/YgLV61knjfYo/dZRYnY+rRpAt+KM/J4OVOA866i14vg+4ogxVoTLRO4vhfk0SMoWbLJs+cMFYa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880662; c=relaxed/simple;
	bh=2d1CtXoRQjhLWrKktJwI2PFys4x7qOwzgU4UBISZYFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqXFkY4rLnXCJR8Q06dYmzVonC11EYo/JEdore7deyyg6xdm2sedePa9vQWnvRLx83wreQZmZHlfgoq6CMxlqrO8gkfEeZ5q7cl6vITd3DEtXv+YfjOhM3+2Ac8oz0qG9ZGp5jcMz30V36riXAh08pH0r1QLu1u4C9l3f6FXvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/H/kuP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B106C4CEE4;
	Thu, 17 Apr 2025 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744880662;
	bh=2d1CtXoRQjhLWrKktJwI2PFys4x7qOwzgU4UBISZYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/H/kuP1Cc75TGFRAdd/uUZAh3bMzG1zwQBs3UKPbFCAMCZpO88REKAZktfKbspez
	 Vhojw7Ho95tC1yzOhb6nu2v2XiPCXhWEH3okWfBHiU6+w2smkG5skNY7JOhsxaNBSi
	 mWzYM2azdTHybLCYumueGJ6ydKzgvKILSU9G9yoV2741DiKUkz/DY2TgUl60SBLMBD
	 HRlkaF3XGq0UJvvkVpuikvms3GBDqD1Keqt5zhrten1jj0FZOaWsfEll7znWfjrk+f
	 c0GCkvCBrk0zDMJpyFSvmLTQbmqkdE5ykrb/EG5+rHfixdLZeRoHLZQFbXi0DKNmo3
	 oHNdduCbkPkkQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] two nits for path lookup
Date: Thu, 17 Apr 2025 11:04:15 +0200
Message-ID: <20250417-biomedizin-fragen-19b1c3871f13@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>
References: <20250416221626.2710239-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org; h=from:subject:message-id; bh=2d1CtXoRQjhLWrKktJwI2PFys4x7qOwzgU4UBISZYFs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQwHBG4bpqVc3KXu37jHeNjxktvGu3xfr/E+Jf79bslC 17xh32N6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIsiYjw1SZmgan3V5Xiz7M fffZ9KLQ+g9BJ4QXF+ZqNeveajB2e8vIMFvtthLL20ebuBlbvGYuPcmS3KLyUFmhzsapU/P22p9 RfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Apr 2025 00:16:24 +0200, Mateusz Guzik wrote:
> since path looku is being looked at, two extra nits from me:
> 
> 1. some trivial jump avoidance in inode_permission()
> 
> 2. but more importantly avoiding a memory access which is most likely a
> cache miss when descending into devcgroup_inode_permission()
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/2] fs: touch up predicts in inode_permission()
      https://git.kernel.org/vfs/vfs/c/305a4329d07c
[2/2] device_cgroup: avoid access to ->i_rdev in the common case in devcgroup_inode_permission()
      https://git.kernel.org/vfs/vfs/c/328ba0291442

