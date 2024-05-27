Return-Path: <linux-fsdevel+bounces-20242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09898D0241
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3F1C217A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5D15EFAB;
	Mon, 27 May 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdyFiVr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC31640B;
	Mon, 27 May 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818247; cv=none; b=VUbmRc22qCNG4YTH5eii0+Y7B7ugJg8BXyOaG1AvuK2vKU60HoQoRs1Z2xSj5yoLK9bx4lbzWgbYERI1e78Zg06HAHmrJnGTJ9BkHAKQJLsKmhXn6/R3ifem6zYqYpuSiEHhAgYLfQqQR3xekJ99eFwUFEYKOB+1kA/aeZ5FAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818247; c=relaxed/simple;
	bh=A0qVX0hsnypmH99YmkNbK1qdmHtka+sAA4FGMkzOSy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZ5ispsK3mh8ih4HX+E9sCbXiQIKZ5JcSPtNBaxmQIlsgXRM5JRobeAtOZ9+igL0OxL8HX/heoKsVDghTaJ39HSbnd9uhAcvWlNquMU7bZnKxyDkoF8gapSoWjdOd6myEmHcG35N+osjWG7Pa8vZ3phVumQoSrsfIyaR0BKqufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdyFiVr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F8FC2BBFC;
	Mon, 27 May 2024 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716818247;
	bh=A0qVX0hsnypmH99YmkNbK1qdmHtka+sAA4FGMkzOSy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdyFiVr68IF/bpoRVwgOABhm2hrSgUJlqOgJbCtTJGmuff1v7/xYz1OBOTfMa+ocL
	 gXyaZ1qbxrln6e3SwYiV0jRLQ+gwop8zAPNCa90nGspjz5uSQEKMxSz8TfKM2WyDme
	 Uxblw+9rQ0cy3Q660N1CjXHqfsPK+Fm3UHJFPLvGhXZZ/EbTsiyVH/YO2IuuXgxKsu
	 pVEnJrnP5XBGhsZDmJCE+62O4C8uw2KIof92mmIvmg2sGlaDEXprgmvgasDMaC62H/
	 k2069UDvQy2zV3kTL5twhUoeKFCuCzQOVfleQLsLrC2A5dRwsxsckA3ILG4gkJNPjp
	 y9g0cAAdQ/fZA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: sysv: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 15:57:13 +0200
Message-ID: <20240527-hymne-entpolitisierung-c33c5065786e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524-md-fs-sysv-v1-1-9ebcd4f61aa5@quicinc.com>
References: <20240524-md-fs-sysv-v1-1-9ebcd4f61aa5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org; h=from:subject:message-id; bh=A0qVX0hsnypmH99YmkNbK1qdmHtka+sAA4FGMkzOSy0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFTLS3uZPryjZf6U6hwFOzpx9mh5/fyRtlPsXchcPSL efKmUO7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSkczIMOvJbi/mlopsPpv+ S++5dwrc7ki+E6pyxqUqYv20m8keRowMF43L50++5P/1p4X5NtN//tM82i+3xWybulHpl9SxPa3 5TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 14:11:04 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: sysv: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/9a38bf0a79b3

