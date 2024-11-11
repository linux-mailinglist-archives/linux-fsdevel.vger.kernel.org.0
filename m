Return-Path: <linux-fsdevel+bounces-34235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE49C3F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D531F2282A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58F19D891;
	Mon, 11 Nov 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyYRYbfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570A185E53;
	Mon, 11 Nov 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332223; cv=none; b=OflcV7nB95pIsBBmd9fEExJWtWU7sMwq9pJOv00Ty4UhoJwaQQ9YRnOJbUgw+bE6E4U0/RQ7JC1Is2lV2zLDXcWVkjKoKBuncxzrOpGlV58KbkIWrAS89qKy8R6nJw4HjZjR2wm5zSEL7t6APwM2q8ykq3odzYtuROyXc5QHzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332223; c=relaxed/simple;
	bh=A5CG6usmJNcoG1nt5QQKCrQDep0s4f7nVGEcg/qKBSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3QqDs4wVaHp525/0bLElzj0btyVUlN0MAK6vqOWtolLppmHAc6PCke0o6xaKXic5ABaEq5xAlQ4UUH4axcunxVE3hpHX2txKDZaQ1asudqMn3Uapu3GTKSRwVU+UoyH7EL/XqdllO2jELnOOpsR59QdA9vQR3+RufTqtg7CJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyYRYbfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA174C4CECF;
	Mon, 11 Nov 2024 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332222;
	bh=A5CG6usmJNcoG1nt5QQKCrQDep0s4f7nVGEcg/qKBSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyYRYbfclfmbrr/E4ZTLuBq7N+uXSHAG460VRUNwngj2yRfB8iM/EoxBdnN3yx5CO
	 nZQxmbeTITxVn/eVMxwpCvTYf3mMq1GXaan9SrcAL1R1RziPwVldQCG6XGAD7vJ9yL
	 yjJXCfGSVGhv4OnysyiM3spQiBkhFVT8tpVOnVYF25k/wLQxpH4AOkm0TbRpgPPfIM
	 /PGcg9phHjV6OLMG+OOr6D5phiyziQ6PLsv2L2m3CJ0YEcDWlm8zLA9lpoalWZifNk
	 1Op233lbJcwIXLgqYZDXWM7GsF9NcVcc6WUi0ey47wsMfYcGtl2l1Jbk/Zc83Ql9Bu
	 vbxaLyMGr4AWw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: drop an obsolete comment in iomap_dio_bio_iter
Date: Mon, 11 Nov 2024 14:36:52 +0100
Message-ID: <20241111-unpolitisch-stutzen-a925132be48f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111121340.1390540-1-hch@lst.de>
References: <20241111121340.1390540-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=brauner@kernel.org; h=from:subject:message-id; bh=A5CG6usmJNcoG1nt5QQKCrQDep0s4f7nVGEcg/qKBSw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbcZTPF+7qVzz4XfzDz39P5wgerwss/nN0YzRXcL7E7 s/nbD4d7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIQAEjw28ekc5Azs3HPYR/ rlh95KfxsiMclzU3acuuyEuY6TOR8Sgjw3fnJZNMP3X6MiyMF+vWM34yq/f7i/hZzBm+e/c9Cbi 9kB0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 13:13:40 +0100, Christoph Hellwig wrote:
> No more zone append special casing in iomap for quite a while.
> 
> 

Applied to the vfs.untorn.writes branch of the vfs/vfs.git tree.
Patches in the vfs.untorn.writes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.untorn.writes

[1/1] iomap: drop an obsolete comment in iomap_dio_bio_iter
      https://git.kernel.org/vfs/vfs/c/54079430c5db

