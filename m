Return-Path: <linux-fsdevel+bounces-20239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76138D0234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145A71C216F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD815F309;
	Mon, 27 May 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCCjdoOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CD15DBC7;
	Mon, 27 May 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817899; cv=none; b=rXesipdJxwJD+8U2o/yotWis7nIcJg34ifv7ZHdLqQOXfMJotN4LagZY1WEqG6tWWzcQ9grk40aRTnxdXDvfeI874hvriG+4XjkWYEokuDohDAwujkSzLieIijLIcWD6EZ5aYx54JCLlkkN9XfPJv7ujAYFT6odVvBPDIOWeIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817899; c=relaxed/simple;
	bh=i99uGTLxclktf5jnh2ZwVj/CRPdOxCoL34V4EZwfdtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN0+xbXVJiVqjQgPI+EknRsXhQ+lDfhIRmu6rJR6V4fjKynRNYb3jbN26lGyPoDrtlZt6p+s6bxt1X1HhH2FIyvGk238PFlSzhR66iHOTYPKVJ0ZSeZ07GzsGeM8AyxfDAdqQbSsMgZvQbwPcrznVJLU3wxjI4hOwF6BVxD5gJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCCjdoOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D20C2BBFC;
	Mon, 27 May 2024 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716817898;
	bh=i99uGTLxclktf5jnh2ZwVj/CRPdOxCoL34V4EZwfdtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCCjdoOqZt9n9XhWMmzNMVLM2CUbxptLvU4cHYHJhkUTlxWRz9Oy6rZGf1zQUcxFw
	 9ihFaR+1bjyEm6qTxQqGVjyNkruqYWnmDhi1efDhJFW3Au5jxgRCpwsLDPeM4rayvr
	 8DPySQTp0KcziheaM2fqZ40tRS/qLxUF4FrWB1yFU2FOoc3mibAeP+6eERhRQGqzJe
	 Vf0ZJkiKtVrmGw+B3xZuYMz4/2GLqKp1/LYKPz+DLkTunT45mTQL+hG+IVWUBmIfeS
	 DzLeXPgEzKKu9cbPYbDFvrA2fbD3mhVMJm4dp8qLZR6Xr1bnMkXp94nCIib82UKTgv
	 44H2+0werXGmg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: minix: add MODULE_DESCRIPTION()
Date: Mon, 27 May 2024 15:51:28 +0200
Message-ID: <20240527-eindimensional-bojen-eaa8f6bb4591@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525-md-fs-minix-v1-1-824800f78f7d@quicinc.com>
References: <20240525-md-fs-minix-v1-1-824800f78f7d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=brauner@kernel.org; h=from:subject:message-id; bh=i99uGTLxclktf5jnh2ZwVj/CRPdOxCoL34V4EZwfdtg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSF9D9SM4rOm1BcdUWEUyIm23hegvnJsj5pce9wHWUGe y61A186SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJiJWxPDfO7n2FcPu1TOOHE/X WNvfY6X1WsjuQ6H8uYdul4vjJOe/YvgfG/7EZyFfvUB89pULa+ZslL663XouZ+a7DtvlFwP/LX7 BAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 25 May 2024 08:25:56 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/minix/minix.o
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

[1/1] fs: minix: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/95f90dd0a954

