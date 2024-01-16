Return-Path: <linux-fsdevel+bounces-8050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53382ED4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488FBB231DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF101A70F;
	Tue, 16 Jan 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTL3dYTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC61A703;
	Tue, 16 Jan 2024 11:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04A2C433C7;
	Tue, 16 Jan 2024 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402913;
	bh=OW5ui9acYmX08mBAK1TBiABz9IsXMyumPQeQ6CC9feM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTL3dYTN4K/EeXBQN4eNysJas+JcTixt/se5xs0TmmiAP+g0ZV3rCzNWCpChAs4Ps
	 p6NL0Q/kkF5bnOyGpU2fUrUtFEGTfVbBrbdy+tTPkxFIjx6GUcE1dyQOFEfC5Qp71q
	 q50Qtb9UFSVSDv52trrOgMrxyQ0po30pLd8J+KpegNMQQKbaWMEzDTZV2qd+hc7HoW
	 GIWbcBILbWLIM+3XUeq4gaG0aRDZm9jeebKvHqrux0JhqL9ndXqmYftmR1yrlzAl0o
	 i9GIZUx2oudNgt459ka/9fytezLaY68/IoI4jLS+mJDDRmeNiKBcSKFEWgpEQ0L8pY
	 hlSrLChogHAMA==
From: Christian Brauner <brauner@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] buffer: Use KMEM_CACHE instead of kmem_cache_create()
Date: Tue, 16 Jan 2024 12:01:28 +0100
Message-ID: <20240116-aufsehen-stimulieren-e0216b01a6a6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116091137.92375-1-chentao@kylinos.cn>
References: <20240116091137.92375-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=brauner@kernel.org; h=from:subject:message-id; bh=OW5ui9acYmX08mBAK1TBiABz9IsXMyumPQeQ6CC9feM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQuSxLwct8QJKGsURcweUvf6VNaBxae8dy9yPzX5nvvJ s0z5FCU6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIdj1Ghl1eVrtZquuubXvb deHvVfvZ773f/9t499wRlc932gtl/kYwMmzduvLhMm7+V42qbEHzlT+uWuXSNcNWXi5fOfCGbE/ iAxYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 17:11:37 +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
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

[1/1] buffer: Use KMEM_CACHE instead of kmem_cache_create()
      https://git.kernel.org/vfs/vfs/c/c838cefc0d95

