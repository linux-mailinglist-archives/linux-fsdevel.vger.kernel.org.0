Return-Path: <linux-fsdevel+bounces-26702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDED95B266
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02B4B255D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFED17C7C1;
	Thu, 22 Aug 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiGnE4B8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848B1CF8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320373; cv=none; b=aYakJL4pakg3SvrpwVprqfWgnMRoMaz7nvzBrbO62dqCOlbT1MOJXLvKZtNLBySzJcvs80JflIwT1dYi7evJ/d6PR9H2EJgBj427I+3f5nPrLtShd8DSgT8LAuxzcQf11jGgKUSL3cYnBEzo3J7EZB2emBZiCoZ4Z0Q/qGmABIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320373; c=relaxed/simple;
	bh=qp37Tn+39PzqspjjHNSOY/MNTOIrYHTbf22AtF94CQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usH0DHxmcJRYZALnxRHEDiZ+14FKanoFcr3YndfyDoKqKXvn19cPrzqa8tIxuLXPuId/GWQ+tvm1NY2tCqQ4s8kYQ9Sdh30/sz5MoX/5kKzgV2LCI+cPSSKcCuBXcLZ2D+kEFFOqyzYgw0zlxaYhVW6oDo7E0tNzrebsmtQeEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiGnE4B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398C6C32782;
	Thu, 22 Aug 2024 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724320372;
	bh=qp37Tn+39PzqspjjHNSOY/MNTOIrYHTbf22AtF94CQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiGnE4B8bKwBrHFgxZABI7UkFG4U8lvIPlvKpXXVPbUrhDWG4xRcVLqhCJe5a88Q2
	 Kpe6LpzdPxWyK7Glcjqoglf4/qeg1ZsUJl8z8vYzsNSzVn2HN2XuJ5TYDHZ00t63zo
	 wU1T0x61vfFuXCu/H7abN3RPPu3/RvwpLxnpX3uEdqBzymTju2Co7XjXTJa8Y3a6AA
	 HyIG2+qy2gXDFhts7dx+P+CxJ99yAFZtxKtvJ1ge8BlHw/ClJ/BI73EzTAXkaV5ddU
	 ioIKai55WmfJDDn92ekMg1XJWH76hNt21NdUFZAE1wGJgNLUegpFebi1s31ddbaMQw
	 qeA+ewseMKvqA==
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add the VFS git tree
Date: Thu, 22 Aug 2024 11:52:39 +0200
Message-ID: <20240822-zusichern-plexiglas-b6c978527bae@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820195109.38906-1-ebiggers@kernel.org>
References: <20240820195109.38906-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=brauner@kernel.org; h=from:subject:message-id; bh=qp37Tn+39PzqspjjHNSOY/MNTOIrYHTbf22AtF94CQA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd58pVz3TZfS91m+fG3dYCZ35+LNsnsS7j6NRLJ2TL7 Zb4f/zwuqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/JmMDPf+Pp75mkU1R6qn 6vwdU56kxEP6nN/UtSfe+jP9eEPW/iCGf4bK/lvuyomFbva6cFH+7dJ5mjYtf+9NLrond7Xbey3 /C1YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 12:51:09 -0700, Eric Biggers wrote:
> The VFS git tree is missing from MAINTAINERS.  Add it.
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

[1/1] MAINTAINERS: add the VFS git tree
      https://git.kernel.org/vfs/vfs/c/abadcddedcec

