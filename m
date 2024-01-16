Return-Path: <linux-fsdevel+bounces-8042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888282EB99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD162850C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24D12B8B;
	Tue, 16 Jan 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO2AItRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0612B7B;
	Tue, 16 Jan 2024 09:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04642C433C7;
	Tue, 16 Jan 2024 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397650;
	bh=hmCmYEgqz59L8XvQn3RmH21Xr8NvEzN3ZqWmfeSuhRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO2AItRAwKSzZUnTc/U/CXtKR/QHWmKoSfiaW1stIwv01/U41sU07zK8tTtDghlI7
	 bxL/2KHjYqjWueMZEap6a2bSfExm2AoiSnYHOClyFQFsjfiJd3qRk5skrovupOPySB
	 fqFXvL3mr9XI22N9/iloCbQg0tieBc/L2056g/754TRCLOA+gZTkVqMIPTtU8ckmYd
	 P6FI0AnEBB6KiGwTNCDn+ynm0r5C8ktnhRIsMF1rzPz89X5pHzdhGqlUw4PIKd3YS9
	 +T8f+ZBjU1mvB8hS+OYZ3ALuPU4CtjAKGO3viL2y1CkMvTtGNkHhdSbeG6jUF5KRQq
	 sDvxmAAA12hwg==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	Anton Altaparmakov <anton@tuxera.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] fs: Remove NTFS classic
Date: Tue, 16 Jan 2024 10:33:49 +0100
Message-ID: <20240116-fernbedienung-vorwort-a21384fd7962@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115072025.2071931-1-willy@infradead.org>
References: <20240115072025.2071931-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=brauner@kernel.org; h=from:subject:message-id; bh=hmCmYEgqz59L8XvQn3RmH21Xr8NvEzN3ZqWmfeSuhRQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQu821+Y3k3N+zavn1r/H6ceFtc8MzkdWdE9gf9UquKB /JL7giodZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkoTEjw4EbMss+i66Nj1ma ZhO1YbXTu83PRVp/zd+3XE11raHt8wuMDA+rLt70zZhb6hh259ABOd0LQs3CO/kmx17lXBdcvHU zNxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 07:20:25 +0000, Matthew Wilcox (Oracle) wrote:
> The replacement, NTFS3, was merged over two years ago.  It is now time to
> remove the original from the tree as it is the last user of several APIs,
> and it is not worth changing.
> 
> 

I see no reason to not at least try and remove it given that we have
ntfs3 as a replacement. Worst case is we have to put it back in. Let's
try it.

---

Applied to the vfs.fs branch of the vfs/vfs.git tree.
Patches in the vfs.fs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fs

[1/1] fs: Remove NTFS classic
      https://git.kernel.org/vfs/vfs/c/9c67092ed339

