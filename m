Return-Path: <linux-fsdevel+bounces-54436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22CAFFB1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42EF3ADDC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1328A40D;
	Thu, 10 Jul 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCr+4WYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12128982D;
	Thu, 10 Jul 2025 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133180; cv=none; b=GkGOYTO9tUFb/C5cJIhTgvwEQmZC7cPl+OeJQtSJfMzUtazu0OZTFi4Ljcpo+uHscwU9IrhdRetEvDtE9XT0RB9VDSqvsemrDUM+DFeQ5tBFI0FLbrTLVKto83VfGs7LWef7ODqo/X36oj1qC5EJvtxaHq5bF7MLDNhHBe/jfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133180; c=relaxed/simple;
	bh=8JPfNGHBDa0dopf0Zq7Rous3CrwqV1gjb+xsOTSkYKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjBcRob8zvDa35DtQ311lHo8rq4kQPLmRqYjcPZApuj5w5gjFrbCZ3cOkTzggcy2zF2J6mrqNbRlZ/8mVPPZ8Y62G8h+y0jaoXeuH7qijOtlO2o9K0fFb44r9kJRVirHFOOdizlg9x0lRurAcH6eC+t4XOvvMcZ+3kFFPAfx9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCr+4WYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ABAC4CEE3;
	Thu, 10 Jul 2025 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752133180;
	bh=8JPfNGHBDa0dopf0Zq7Rous3CrwqV1gjb+xsOTSkYKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCr+4WYvP4nzsyrxh6/hPYYBIJtDCG+WxbvX1bfdyV5BouLa9P0WJyFZc7QGy6wh1
	 JTpBPkmWczMP5bbhB+Qfl/GVdQVrXkPbKaT77LeC04zxNP54BpwLZd4NGyMAhAF2op
	 wSV8OhE12dW2unnEiSpm3/8t8mNDNkPR1NupY1uMHQsf6VNNzS3eyJZ/F5QJEMz8Uy
	 pbJBfqZRiC6HmTf78tMoc2lbPMaCXxblc5lp/RZn7Fw/s8Rr2OWQrx8/6wrgNibwKr
	 XWMyVpUmZaCnkHLYv9We/RiqtJi2IYZZsd6oJcAsjFCXqphQDUe42VkMh4XEwLxLRS
	 /hoal9QrvqyaQ==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] uapi: export PROCFS_ROOT_INO
Date: Thu, 10 Jul 2025 09:39:29 +0200
Message-ID: <20250710-visuell-joghurt-c76814720040@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708-uapi-procfs-root-ino-v1-1-6ae61e97c79b@cyphar.com>
References: <20250708-uapi-procfs-root-ino-v1-1-6ae61e97c79b@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=brauner@kernel.org; h=from:subject:message-id; bh=8JPfNGHBDa0dopf0Zq7Rous3CrwqV1gjb+xsOTSkYKQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTk55nPYij6/PfuT/tyxvu170tqbKZFtq+16XVbLLE2d qrib8+jHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPx/MrIMKmWa71tkJrSYi9V yyTxkNd8WUmPI1Uddto2LHsd7OXhzfDP+FfuhDIZXt/CVauM+SZxKCW2fW0Q46u74j/xE//Ue1n 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 23:21:51 +1000, Aleksa Sarai wrote:
> The root inode of /proc having a fixed inode number has been part of the
> core kernel ABI since its inception, and recently some userspace
> programs (mainly container runtimes) have started to explicitly depend
> on this behaviour.
> 
> The main reason this is useful to userspace is that by checking that a
> suspect /proc handle has fstype PROC_SUPER_MAGIC and is PROCFS_ROOT_INO,
> they can then use openat2(RESOLVE_{NO_{XDEV,MAGICLINK},BENEATH}) to
> ensure that there isn't a bind-mount that replaces some procfs file with
> a different one. This kind of attack has lead to security issues in
> container runtimes in the past (such as CVE-2019-19921) and libraries
> like libpathrs[1] use this feature of procfs to provide safe procfs
> handling functions.
> 
> [...]

Applied to the vfs-6.17.nsfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.nsfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.nsfs

[1/1] uapi: export PROCFS_ROOT_INO
      https://git.kernel.org/vfs/vfs/c/76fdb7eb4e1c

