Return-Path: <linux-fsdevel+bounces-185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408877C7124
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AC6282941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7C266D2;
	Thu, 12 Oct 2023 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqBSSsaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C48BA3C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306ECC433C8;
	Thu, 12 Oct 2023 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697123714;
	bh=fCA35uXSn16SfXjIFY+Kildy7ZXikS93KIx0exHbeCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqBSSsaYOVij2d4bsKo0TR+Z8Z/FHCvT+JY8YJNcl4EXbBF0xca/pHXdWbc3NVks8
	 /o1ttjdpsfZ36A0s8fZ875zW9AWASshBSRZKQMdxhXjtKRXqGSvKmaxiAEu46gsYR9
	 fM47q+F0zJ3bkVt9eHExFBf2EI31d5QTyBrtBaY/hovGQW8glv9mgp0Zw/sv67lYe7
	 w06RSP8yC8xXVpV9Zt6MMXFvKVl1HdlmDVyvY9dQwZj6gO36lqe3gf/nrQNZ2JcGIL
	 hhSaLRbuoESiyTmsdFfvdiS1mPY0Doo0uYti35Q6VLco7pA9rXuRT8fN/RwGDz4/q2
	 vHXIjCZ0r5VSA==
From: Christian Brauner <brauner@kernel.org>
To: Thomas Weisschuh <linux@weissschuh.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] const_structs.checkpatch: add xattr_handler
Date: Thu, 12 Oct 2023 17:15:06 +0200
Message-Id: <20231012-karpfen-boote-83f11c904bcc@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
References: <20231012-vfs-xattr_const-v1-1-6c21e82d4d5e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=brauner@kernel.org; h=from:subject:message-id; bh=fCA35uXSn16SfXjIFY+Kildy7ZXikS93KIx0exHbeCw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRq8OZd/P8j7/Mttpe2e2uDuaJdW75d3V5eUaCbyqO0VdKg LoC1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJzaxgZ7vQIf9+95bzVgqhH3ppeDd u99O8qq+8uPHn/rHbTpdZfFYwMW3l0mnfde95ief38It533y9xTuyynmV13t3Ldp9WxYvPfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 16:30:38 +0200, Thomas Weißschuh wrote:
> Now that the vfs can handle "const struct xattr_handler" make sure that
> new usages of the struct already enter the tree as const.
> 
> 

Applied to the vfs.xattr branch of the vfs/vfs.git tree.
Patches in the vfs.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.xattr

[1/1] const_structs.checkpatch: add xattr_handler
      https://git.kernel.org/vfs/vfs/c/a640d888953c

