Return-Path: <linux-fsdevel+bounces-24971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E079475B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007D91C20D65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B51482F0;
	Mon,  5 Aug 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCR4JOaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805871109;
	Mon,  5 Aug 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841494; cv=none; b=oKGr85GKpQa9SCZfLDa3UtwkcqgRCBSqio9+Frt3QTFIEbYlpRJB31rq52xPP0DQnGcdT0WzmDY3rsmfE0mkMiS44JjLwa/lORuieJCCnNgMoFN1epi9BEMCdmbMUpbVU4PjdPJpdy+T4DRD2V4vpfxFybqHgf7JgEflCu03hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841494; c=relaxed/simple;
	bh=mGNJli9yRK+L0NgOI1Yl4SoXIpHFd6nDFXIOFtXTris=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rld/udnqYysf2GtEipYX+FVFtyTXqVR5BWstmuk+62Osm8vOdXGytfoeqn7zW6cUKXJGgRjKuYBRw8dohHL4Hw0b3BPLYZfyGyWuOLE+JL00uw5Uz24/UYr0ia+3haq5gukGv7wGsHpTQgmOKkT/fMP2SGiYpKakvWA0XWrHFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCR4JOaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C5EC32782;
	Mon,  5 Aug 2024 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722841494;
	bh=mGNJli9yRK+L0NgOI1Yl4SoXIpHFd6nDFXIOFtXTris=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCR4JOaMEUBntQWE9ae1fn6jNzLkv5ZT2hAe3HqNlhfBuEduN5QrsgZdcGGDhYqfx
	 2AUq3NvvYAbholzqH7t4qt35mB7NqIbjkcm6n4V5p123jZCI9EfQeE1XAh5y54Dj84
	 ElN+79IW24Wi559WRx4LJZY4pF3jM/WKdqhrYmPqRcw1AHRRMuFpz7OKDF2DvajHgt
	 5uwM+B8WgXwkTWILKbdeclO6BpSEfI00dKqHNDRvrlV3eNAo4sEU86WV+M6jUkmPJS
	 +z43d9t6Hbcfyncz3VCcbfC4tq5O+Ffr9GIKeChlS9Wd1ukw94N6CxPpsbbCiBaS+P
	 GarBDy910r/oQ==
From: Christian Brauner <brauner@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	mszeredi@redhat.com
Subject: Re: [PATCH -next] fs: mounts: Remove unused declaration mnt_cursor_del()
Date: Mon,  5 Aug 2024 09:04:37 +0200
Message-ID: <20240805-abwarten-gewischt-9a931ea34343@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803115000.589872-1-yuehaibing@huawei.com>
References: <20240803115000.589872-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=brauner@kernel.org; h=from:subject:message-id; bh=mGNJli9yRK+L0NgOI1Yl4SoXIpHFd6nDFXIOFtXTris=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtqOyZt60suvJ0irjEfh5Hb1Ppz/kBGXauNoqhN5r2b 5DaxKXTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBFbb4b/sSc0FntI+kw6GcFZ oZZ4suT/pe8Kf+7bpJs9XG/I8ywzk+F/iuWBrWd2qZkvSb1mqjHp75WTGlsOWbzSc9VXiT96cU4 fLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 03 Aug 2024 19:50:00 +0800, Yue Haibing wrote:
> Commit 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
> removed the implementation but leave declaration.
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

[1/1] fs: mounts: Remove unused declaration mnt_cursor_del()
      https://git.kernel.org/vfs/vfs/c/de11c86d68ba

