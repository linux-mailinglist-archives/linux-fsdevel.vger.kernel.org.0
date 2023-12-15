Return-Path: <linux-fsdevel+bounces-6185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21143814A0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFD41F2478F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABC30CE1;
	Fri, 15 Dec 2023 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1IdZxtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C872F857;
	Fri, 15 Dec 2023 14:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC9EC433C7;
	Fri, 15 Dec 2023 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702648998;
	bh=6I+tZqA9ch6WxuAFBQOGxaiJPRbXsOQNpusVepckU6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1IdZxtt7Ct6yoK4K3ctoW5GHzb3Kr96SkB7w1mcbvsvb0zlB3bSL3E+iN9TyLdyH
	 kPToRxtZ8WGV433DDROY38PfxdFw5Vdiu1zbiC0qh1U7+9YTEfifp2wVPa9DpxgNeN
	 nfw9bcFe7t9JGhSv7XNmzd7OvajYDxykvEpMEVGC7KUtOm2swOFeuid/G3a1lTgilK
	 2ZWDzCpFFCawJ4+hjVbzjeC17LG3IhY0tdVd6aXP529iuv0n5l0OBeVMHqRnoCeF1R
	 0f7Qh9ze3gHjifLqrREc50I3EHl4/gc9fBGVDiuU/VoXMZhoEQsGSIA0B+Zg1lj2xC
	 j2NFXDuAVly1A==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix doc comment typo fs tree wide
Date: Fri, 15 Dec 2023 15:03:09 +0100
Message-ID: <20231215-farmen-pudding-1829b33a8e80@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
References: <20231215130927.136917-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=brauner@kernel.org; h=from:subject:message-id; bh=6I+tZqA9ch6WxuAFBQOGxaiJPRbXsOQNpusVepckU6U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTWxMyJ9I6KWDZD+dqMKZYrjU56S7yo0wwSeBtftdI9t ks0bvqxjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMPcPwk7Hv7C3PLt6durPr 6/mc5Gbd/ndz/Y7ZOtmTTrTdWOGmpsHI8Or07aKiM7pWmpMOrzB/Jff5yWyhs/zb4+ID3b0+f7M yYgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 14:09:27 +0100, Alexander Mikhalitsyn wrote:
> Do the replacement:
> s/simply passs @nop_mnt_idmap/simply passs @nop_mnt_idmap/
> in the fs/ tree.
> 
> Found by chance while working on support for idmapped mounts in fuse.
> 
> 
> [...]

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

[1/1] fs: fix doc comment typo fs tree wide
      https://git.kernel.org/vfs/vfs/c/beb158fd2708

