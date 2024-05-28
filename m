Return-Path: <linux-fsdevel+bounces-20341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5CD8D19B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9FA287AB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0116D317;
	Tue, 28 May 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW7XZVeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33B16C87C;
	Tue, 28 May 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896164; cv=none; b=fVKn/y43/Vp42jEmejAB8M7WxTzYbsB1sTN1acamIrvSW1nrJXsAPnCgjJllVVXXfd2M6vxUKRdhP7GyInZad42ZyfCP2pfHFzGsXynqfA7oVaCe6d31CIfgwozDLkn/d1cu053DJ5DdxJ45WLxGbvEXhvzRGNd00VA7tucegOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896164; c=relaxed/simple;
	bh=U9gFCkMWya+ry4Kiu+T18mTeq5AtTLdpRjpaXQOZEes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heGMoSMk+nHWntia7PAi4aB0KD8Qu9ZFpgjTeCswymLmcb0tbNg0O5V3TCkdAci9x4YsF/muY1L8gF1RHxnmMVBhtealelJod8kSeiJOsbQhuSysMQSq0JrJblce+WvzfL7Fzg3wykpvu59GQSEdNTbAW9VMZQI2cW8ZFAj54xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW7XZVeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADCDC32781;
	Tue, 28 May 2024 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896163;
	bh=U9gFCkMWya+ry4Kiu+T18mTeq5AtTLdpRjpaXQOZEes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VW7XZVegE8FtPMBbS75NLk8DYqs++BK4z91RrBoZR9Xu7fd2gDOrZ8olygjjXfqEV
	 sxcNWBPYymECHRNz3We2E8ap3gjbikMQw1RdblIXZeW1M6D8Q7Bx+PTo6xqtS34Uxz
	 hyk6GXMoFOtBU1GDEJcWLnPM4I4wNMxuH64+V2v2w6dO7hhZfjw2LpoLN1M24KNjr1
	 kzhu+7wpluYL4eRLHNq+26YLOsm19KEo/wSSFK6ADmrGGxq/jn0dNnOVZf1T62VE2a
	 CqJX2dbCBLwARc8HaamWR6iLkVir4XVnTr1mu+T7g7xQOSbusSCPaLA/pZxlDPbMdN
	 jQZrjunq5fPCg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: hfs: add MODULE_DESCRIPTION()
Date: Tue, 28 May 2024 13:35:47 +0200
Message-ID: <20240528-massieren-rekord-0836253ed999@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-hfs-v1-1-4be79ef7e187@quicinc.com>
References: <20240527-md-fs-hfs-v1-1-4be79ef7e187@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org; h=from:subject:message-id; bh=U9gFCkMWya+ry4Kiu+T18mTeq5AtTLdpRjpaXQOZEes=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFHpyzzqf5kvO5+6a2Zzf/c3x8u/ORntnfypBjcp6eq g+UgtKndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE4wTD/6qXRb5TvzdsvXL9 h3OtcabJy4Mqk0vKvUsYzix1/rWnu5Dhf+lhyYOLp3rM4q0Tl3juV1Ny2SLYMLzniM1p9vq7RaJ 32AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 10:53:08 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hfs/hfs.o
> 
> 

Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
Patches in the v6.10-rc1 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: v6.10-rc1

[1/1] fs: hfs: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/7c50209f1e6a

