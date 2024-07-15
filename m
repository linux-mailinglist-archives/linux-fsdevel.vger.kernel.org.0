Return-Path: <linux-fsdevel+bounces-23683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF9931363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 13:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346E31F23D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B318A94C;
	Mon, 15 Jul 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKOakvPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51936A039;
	Mon, 15 Jul 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044131; cv=none; b=phFCTSWXNOyqvw4PQNvZtU9ixKyFT8oT8o7fSBmRl3medACqcXw4kDHHREN7XyaIBZtQ8BBRIS8wgw+4Eihb/UgKckmRSjAhBtmb3w0A84o8fusPKPi2jsY3nF02w7wFewXz2u0d5pt5/ghleEUSG6aL+AoKRillbiE4BJxwz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044131; c=relaxed/simple;
	bh=//gQFsYwBWW1kMaHQ6xpz0jh8fgWViTigdtlaSbhC2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCa7GPA9coVPnSp9BWBMTs8DVSoFFuJrA4fI9CalXIwA1sZox6BSHq2UKAujAwELE647hvEg9YDJAdixiuBrZa8QDph5i0FwMGyFCQaVR03pVscLlDLede+Tel2tQhGNhcH8RRo/V6JJDqXvIjv1e/oZhi9r22TBOwB14TKessA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKOakvPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB8C32782;
	Mon, 15 Jul 2024 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721044130;
	bh=//gQFsYwBWW1kMaHQ6xpz0jh8fgWViTigdtlaSbhC2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKOakvPSY34XGVJ3Gxu6ySBrFxWJJS9/VC+dOiWaxnEu+8O2VcNjR0Sx7evI6NbVH
	 Ydvng06hCb/hm4PzLH+1CKBNZl4YgbDeSRdtpk3rkqKO+nrj4/DKqQQkaclwGIVKg0
	 VzSYkx86OOHuYaC6v8yAv5qCilP2re2GvmZnyOA74nxv81+mUnZJMsWn6a9/9xb7an
	 UMwg0tKl13YoIE6VZhxBhnXSc+wk4hhepUgnXWXPCHTohyUkiJCN0vT/QIHH0phUg1
	 Hswxemijq+lGhBKgGLAB1pU5qAjxElKvVfB7U4hjDNf3EkGzCuF3B/PGSMPHLLYdvy
	 ht/O89wU/N2lQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/adfs: add MODULE_DESCRIPTION
Date: Mon, 15 Jul 2024 13:48:35 +0200
Message-ID: <20240715-anhaben-ausmachen-2abf2d78742a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
References: <20240523-md-adfs-v1-1-364268e38370@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=brauner@kernel.org; h=from:subject:message-id; bh=//gQFsYwBWW1kMaHQ6xpz0jh8fgWViTigdtlaSbhC2s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRN5Zl9y2d19qayHbs4qhi2/a8q6z5ZpDTVuC/qwenTh r5yD++7d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExklicjw56Dwi4rll2pvclX 2Nugt+Z7XmOs35a1hp+OTmjsO9aR18/whzsuet80rzAVxR9zs4TMTU6v7I/R6fkyNb9bt+pz5lp HXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 May 2024 06:58:01 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' issue:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/adfs/adfs.o
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/adfs: add MODULE_DESCRIPTION
      https://git.kernel.org/vfs/vfs/c/330367c0700d

