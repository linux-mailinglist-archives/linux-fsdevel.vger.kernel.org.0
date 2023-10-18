Return-Path: <linux-fsdevel+bounces-621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA07CDA52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD49C1C20ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61441F176;
	Wed, 18 Oct 2023 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+yp622a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF31772A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3312C433C7;
	Wed, 18 Oct 2023 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628481;
	bh=d7KMTswEJFbw29MM0oVn+hRSoGQ+XyawIjEi6ipJ6iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+yp622a7ptW5fJZntOu2GmLe1y+buFR87R4B7j6I602pP/yh17V8Tn8O9ecoHo/4
	 gVLNRK4F+rm/u3t9YggtKoK7f9xRQab/Z4eSTMxD4DJ3b/H3gv2FQvU66sk4CQf/md
	 n8UkQ5FIDnJeAdeavvsiNM0hW6cbz8rkrwB30DnILI1sS7PzgLZ0fkykglRWC+BBjg
	 BoLekJ1CAOFiYFtyxZwCVMNaoD6u4VNAT8K1TshUdtwynBUhnf2z1nUvUygoihTLvz
	 iED9FQos1lUmkqmtoGfDFqTGvsCNt9N6i4Tk1wlo1Y2FUtg5UBqmFLnEmIIGQLsNMD
	 /tBunWCvvMbaA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Klara Modin <klarasmodin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
Date: Wed, 18 Oct 2023 13:27:55 +0200
Message-Id: <20231018-ineinander-gaben-8a939fa0a180@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018-amtime-v1-1-e066bae97285@kernel.org>
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=brauner@kernel.org; h=from:subject:message-id; bh=d7KMTswEJFbw29MM0oVn+hRSoGQ+XyawIjEi6ipJ6iA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTqHzRhvR5pWfny23NeO4fYg9tuXmObI/N98irhqXs3l+fV 9JSv6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhnCG/zHfnn91/r3a1XfHpJqSYL GjFQ+ePL+0RmfKv7g/7N9UFsxhZJh0LEDko9ONXcrBVgntTrKzG2yVQjmir1/4cs54T1+WGx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Oct 2023 07:15:40 -0400, Jeff Layton wrote:
> Klara reported seeing mangled mtimes when dealing with FAT. Fix the
> braino in the FAT conversion to the new timestamp accessors.
> 
> 

Thanks for the quick fix!
Folded into "fat: convert to new timestamp accessors" as requested.

---

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/1] fat: convert to new timestamp accessors 
      https://git.kernel.org/vfs/vfs/c/07b7351751a8

