Return-Path: <linux-fsdevel+bounces-54827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD835B03A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C6189DA73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE524291B;
	Mon, 14 Jul 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7bKE20C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513C23BCF7;
	Mon, 14 Jul 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484318; cv=none; b=thAFIaxZpchqXg37VASkJtRqKcss2rhTiscMNYXCNdGWR03uJ0I6kX47ZK+2lkTAfgxFIKiRhqdjERG/nGQzMO5RVZJheVZfL/ox0taMZazeb/hRKD/TWB2lNiO5OoA3pOxSVwg7lzYH1QiG1AuVhPYr8v1dYqA8OFy2IXg4oZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484318; c=relaxed/simple;
	bh=nBAAdS/h14HP9PCoH6AZ+SV1+KPCQ3mc43HpXEsPKvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThI7PFKFp5GjBZSxjUwXUS0uZpo5ZY7oKP6iTlaGELEk39RRX0D0JJB6LfcHzsZYc+XOx7E3WdribDovszjVqudBKU3rK3RKJYggDqYNHOcXZYo6Fj/dKa6i+sDL+BT10RqLW+VmkIpKVulfHwoz7y8xwLnrkoSwKUR1lBho75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7bKE20C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6403C4CEED;
	Mon, 14 Jul 2025 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484317;
	bh=nBAAdS/h14HP9PCoH6AZ+SV1+KPCQ3mc43HpXEsPKvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7bKE20CDPlKcHI0e/TC6KGBJLrWFb6B/a2488r6tyIou5DTxTnLIABvmNvKLFpXa
	 7ihWDKxdO+vv/6dxAFhP+KNmK7biaOatcxOCFGnogbNAFbLIAlMfDckEtLV2ItloNd
	 q+sgzKQhx9CjxrP8q9qMnwsebgfC2xO65g6gAWZtgvzGGgarDWPO+UCj1ATob1DSYy
	 hB0b5IXoIRePk5yKXTPmpQl2MnaS+xpxe/mC4fHAMsZmTxp6rVoD6nDOCT+DHyi51T
	 4PGbMRz/p7FqCOWASMEOE/MMeQNI6ZYPxHwhKlsQeEecnBP7GF1NJ8nqpzOWCDgaYb
	 VWjmAtYCQd4xw==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?=E9=99=88=E6=B6=9B=E6=B6=9B=20Taotao=20Chen?= <chentaotao@didiglobal.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chentao325@qq.com,
	frank.li@vivo.com,
	tytso@mit.edu,
	hch@infradead.org,
	adilger.kernel@dilger.ca,
	willy@infradead.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com
Subject: Re: [PATCH v5 0/5] fs: refactor write_begin/write_end and add ext4 IOCB_DONTCACHE support
Date: Mon, 14 Jul 2025 11:11:43 +0200
Message-ID: <20250714-tolerant-begreifbar-970f01d32a30@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710101404.362146-1-chentaotao@didiglobal.com>
References: <20250710101404.362146-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=brauner@kernel.org; h=from:subject:message-id; bh=nBAAdS/h14HP9PCoH6AZ+SV1+KPCQ3mc43HpXEsPKvA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUnLzKYeyw62Dl9TVnpl9493JFlYSRQmE0u5D7zYaTH VYLqhZndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkpQYjw6KZcwvUGF5FPO6s 6GaL7nsjfX+TyxvnthUTtT43P/Z4kMLwP1l6jpx52reoUxda313fE28u3GfckRy1UKN5s9+nyff /MQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 10:14:06 +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> This patch series refactors the address_space_operations write_begin()
> and write_end() callbacks to take const struct kiocb * as their first
> argument, allowing IOCB flags such as IOCB_DONTCACHE to propagate to the
> filesystem's buffered I/O path.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/5] drm/i915: Use kernel_write() in shmem object create
      https://git.kernel.org/vfs/vfs/c/110ae5fb48ed
[2/5] drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter
      https://git.kernel.org/vfs/vfs/c/dd09194ff58c
[3/5] fs: change write_begin/write_end interface to take struct kiocb *
      https://git.kernel.org/vfs/vfs/c/254a06118b31
[4/5] mm/pagemap: add write_begin_get_folio() helper function
      https://git.kernel.org/vfs/vfs/c/ff2219c021c5
[5/5] ext4: support uncached buffered I/O
      https://git.kernel.org/vfs/vfs/c/2677497bc6f4

