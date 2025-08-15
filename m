Return-Path: <linux-fsdevel+bounces-58022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDCB28147
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA03AD6EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972201C2335;
	Fri, 15 Aug 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHj2/ko/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADE2BCF5;
	Fri, 15 Aug 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266820; cv=none; b=FuFbr6qR6gSGayaF+8Xgzt5f/ttNTX7Wf3vk6L553QkciSTPq9Ci/8zWhppAtwLY9g7Nesa0/6pbtw/My6rC3fRRcYVfhnt4lTvu0//CL7rocLLK7//ouZGymjrb9DmQ6njcGYYpj3IKXJHvO2hcQzVby9NeVHgcXsLIqPh2yXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266820; c=relaxed/simple;
	bh=fbnBQbxQ909B7ZX6B9N+UG/d4i7Fa2qhsIxVqRHu1rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8hYWIyyfEPeyWs61coGOPQRwtr/3ulVvNtpY5LUd6GFNXNLwykVoJFj/OhqBeaFYRjyaMj+nR4OA4HLi1M5dJkHIGRRCe7ofU0dhlI6mz+1WlmHSRfMHbffVpNddRsWsK+/WpboEz57dJJ/Jmic88DfnLuzjAJ6pTwYVHJtij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHj2/ko/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5239C4CEEB;
	Fri, 15 Aug 2025 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266819;
	bh=fbnBQbxQ909B7ZX6B9N+UG/d4i7Fa2qhsIxVqRHu1rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHj2/ko/ewYvJfzQJ8N8JJ2PStuIfxA+VSWZ7zD3UmtxqtEQwVbbyGLa6XQsCqis/
	 CjvMJqlHTqhAmIT/CKDev2ow7nrJfY2sT6KXjsFP+01L557AIsgFdmjX7TavFmYYhW
	 2RWRfyb42tRNn/l1w2droYzOS7BRZYU7bSdHtZdlklOPeY3B+287HAutaxdB67Qa5Z
	 vxiXobbkVy9HAI5vUb8wY4KZRv6mbeyYXjKFkZBsipRUMdA2pTqFA/jqlvR9cUFiae
	 5fnFSUuwnSe1ab2YhcogRNS70/Fwq+zdoSLtfWkPyKYZo3RRRUvmjhzU36LwP3pLzy
	 ly35+9xJxhixQ==
From: Christian Brauner <brauner@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 4/4] fs-writeback: Remove redundant __GFP_NOWARN
Date: Fri, 15 Aug 2025 16:06:49 +0200
Message-ID: <20250815-ratifizieren-steigen-f650f28b190c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250803102243.623705-5-rongqianfeng@vivo.com>
References: <20250803102243.623705-5-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=brauner@kernel.org; h=from:subject:message-id; bh=fbnBQbxQ909B7ZX6B9N+UG/d4i7Fa2qhsIxVqRHu1rE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMt/tnWfEvp2KZj9ghm5ogP5Vbzs+bv1xsubImuOeqW Yq7o8X9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlc0WD4X8zArvzCr+ZgQuFU w05vg9l8CmU6J+aHSpv4r5u1JXXpKYb/qYorb7ldZWuWW/+j6FiQ9uTZ9x/tn1ckpWAd8cXvsqA /AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 03 Aug 2025 18:22:42 +0800, Qianfeng Rong wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove
> the redundant __GFP_NOWARN.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[4/4] fs-writeback: Remove redundant __GFP_NOWARN
      https://git.kernel.org/vfs/vfs/c/15769d9478bd

