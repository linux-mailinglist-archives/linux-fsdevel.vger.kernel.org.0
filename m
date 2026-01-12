Return-Path: <linux-fsdevel+bounces-73230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3F2D12B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE8130ABCD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C3358D07;
	Mon, 12 Jan 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSkdLr0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1730B532;
	Mon, 12 Jan 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223559; cv=none; b=mbC+60qHqcQd0HQ7h7slGxlDGkcneiM/LsBmBqpAtooTs4F63pUdVBXbOWSALlTjI0Qc+iWQHf3qp4gBQRL30OdalaFgwrBiUaY5oWzs4YjAvsh1fGqXl2WX5dAG15VdA5ni9Bo/M1P/bwfwgKWLM9MXcYkITJOycS0ZxqcIr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223559; c=relaxed/simple;
	bh=O19fT929is4XKI2ExqIJ+DNwG/NgJODKJdMhTNajUuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwASSnpyJnTigot9Kq6dQxCK7VxIezNFCz5HOtlbFPphMaAHuD7W48g4++lhKNItgFEyuN2Qh3U//16CHfoidDtICA0v+AZHjNYbupqyJ3eqJ1tZaesZyWDPwP3r3e4Etzklmn9FLz2UcqDdI1ggzjc9B9Am45T9Aa21zLZNKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSkdLr0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA766C16AAE;
	Mon, 12 Jan 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768223559;
	bh=O19fT929is4XKI2ExqIJ+DNwG/NgJODKJdMhTNajUuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSkdLr0QmL2HPUC1Cxj8tLAUcxKyYooRDPBwkkRe2CiPzigDVEEJ5fkQN5nWnBcGx
	 Wz7KqP8yfyn8iDFzav/B5k3fz6NMugeMz1B3PtMBOy6HydkHdWrPapmepU0LKvDpS5
	 Uzw+0COHlY8V4cNXjIPuT+DMnaCj2CLIBldqglE7ORc+7JsfjIW/fUSyCT648Sj+/l
	 e4s1f8ruodBDBDPMg+ZilM7tp/usAWpVWAJdD3FLUA0EivEhjitC75+rLFfJEs0wO+
	 ZkobPfKHxW3+O/nB505+JowYGdJBsUk+d6qrUVwodSZwwYRwz8127kVP5j5BTFBoYQ
	 lsH4sCLoxGonQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	jack@suse.cz,
	brauner@kernel.or,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: add <linux/init_task.h> for 'init_fs'
Date: Mon, 12 Jan 2026 14:12:34 +0100
Message-ID: <20260112-klappen-demut-cae90c37943c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108115856.238027-1-ben.dooks@codethink.co.uk>
References: <20260108115856.238027-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=brauner@kernel.org; h=from:subject:message-id; bh=O19fT929is4XKI2ExqIJ+DNwG/NgJODKJdMhTNajUuE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmfHauj1jJ+8D4h/P0M64HVk9V/75E52nlIpsDAZdN5 gk+WT+rtaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidaKMDC+c9+tvWhfDYnOz 7sOSZA2+bbxvtskfzw7evO0wc8Tm9+2MDB1xK4/4LHbl4y7flp705hhrn/qMu0eT17Xbt03aOm2 /GCcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Jan 2026 11:58:56 +0000, Ben Dooks wrote:
> The init_fs symbol is defined in <linux/init_task.h> but was
> not included in fs/fs_struct.c so fix by adding the include.
> 
> Fixes the following sparse warning:
> fs/fs_struct.c:150:18: warning: symbol 'init_fs' was not declared. Should it be static?
> 
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs: add <linux/init_task.h> for 'init_fs'
      https://git.kernel.org/vfs/vfs/c/dc162e4d6be9

