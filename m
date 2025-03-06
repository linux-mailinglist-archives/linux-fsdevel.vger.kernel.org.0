Return-Path: <linux-fsdevel+bounces-43319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D694A544D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A357D1889D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711672066EA;
	Thu,  6 Mar 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlyw5eqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACB205AB8
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249612; cv=none; b=r35NYaPlsdmpWt73k1jPgYeO4W578GuXJK5FKy/p8AYRZ3E3ik6QJlwiWqE5d1Q27xARC3bp4mIIReUqtIODw3DmzX+TaI/YNU1bRkqTH7+nF4Eykva0Hlusod8GIotp0hV5lgNmpkn8HsyXN+OAXq+nJ1GuNL/IHtdhpG0fslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249612; c=relaxed/simple;
	bh=dZ+5nsBJFU78pfv5qFEbN/FRcP0oNzAZl9iwLRb/mjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkOSZaBqBNqXd9rW080+JSvvGZP+W6/xhRo7MjzO3gRQeDFVcC8Y9f7VlErnkrSPhAokuCMgeWvCL9eU11AxzpA/FA3Fr02FWJyWHToMlcgOCAMhvDmgH87DyE6XmSX2fThNp6A73X+6Cr1cfvjqRKeaSr5yhlu4Aum7XrY6WvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlyw5eqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FD1C4CEE0;
	Thu,  6 Mar 2025 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249612;
	bh=dZ+5nsBJFU78pfv5qFEbN/FRcP0oNzAZl9iwLRb/mjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlyw5eqbJnBJnwMOkc4AQqHhqW6Ikwfzl73Nq+/hHRcufXTV68vgwZ5JYwKKoLd6t
	 ep1IhiLByUvD54pPVlrmQ9DGzXcnFvXzZkAoyhucRZsiqznh5MJcb/Q2rI4PofmBlI
	 v7LSZHhd1Clb9AJhpKwRX34udU+r6EiMN/ctsD+VcaJFHYP4BntdEh9ktIwFeWp63+
	 93koUJR4Q3epMiATf+DH/80MP0NFl5Dsg5BZC6OUmcftfAXEh39wh1xsG7FJ90JQBe
	 IG2PwffaI55fDdtPqt0S5xK0r5NL9CEcnluWuNmfb8Si1A15TM2+qWcOTGMGUx8AHl
	 rKhSZ4TSRu2dQ==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Orangefs fixes for 6.15
Date: Thu,  6 Mar 2025 09:26:43 +0100
Message-ID: <20250306-esskultur-bleichen-eb7b3651b8b0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=brauner@kernel.org; h=from:subject:message-id; bh=dZ+5nsBJFU78pfv5qFEbN/FRcP0oNzAZl9iwLRb/mjQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfjHH/YOEQ9D3Vtf/hiTYuVc8FrGUxq6ovO6wTzzj4f d20e/9XdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkjjQjw2LGlzaqWckqKeuZ tI/zCtc77MwvD35kc/lXr4ndxnmb3jMyfFlQYuS3ulvizvytjBPKjq/5ftH+U3PldaasC35XD/T 8YwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Mar 2025 20:47:24 +0000, Matthew Wilcox (Oracle) wrote:
> The start of this was the removal of orangefs_writepage(), but it quickly
> spiralled into a more comprehensive cleanup.  The first patch is an
> actual bug fix.  I haven't tagged it for backport, as I don't think we
> really care about 32-bit systems any more, but feel free to add a cc to
> stable if you disagree.
> 
> Patches 2 and 3 are compilation fixes for warnings which aren't enabled
> by default.
> 
> [...]

Applied to the vfs-6.15.orangefs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.orangefs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.orangefs

[1/9] orangefs: Do not truncate file size
      https://git.kernel.org/vfs/vfs/c/062e8093592f
[2/9] orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
      https://git.kernel.org/vfs/vfs/c/50fb0a7f43c0
[3/9] orangefs: make open_for_read and open_for_write boolean
      https://git.kernel.org/vfs/vfs/c/144fa8ae0830
[4/9] orangefs: Remove orangefs_writepage()
      https://git.kernel.org/vfs/vfs/c/506382dbbedc
[5/9] orangefs: Convert orangefs_writepage_locked() to take a folio
      https://git.kernel.org/vfs/vfs/c/40eca026bbaa
[6/9] orangefs: Pass mapping to orangefs_writepages_work()
      https://git.kernel.org/vfs/vfs/c/6420f17963f2
[7/9] orangefs: Unify error & success paths in orangefs_writepages_work()
      https://git.kernel.org/vfs/vfs/c/f9ec21357f52
[8/9] orangefs: Simplify bvec setup in orangefs_writepages_work()
      https://git.kernel.org/vfs/vfs/c/377afd97cf18
[9/9] orangefs: Convert orangefs_writepages to contain an array of folios
      https://git.kernel.org/vfs/vfs/c/73f233b972ce

