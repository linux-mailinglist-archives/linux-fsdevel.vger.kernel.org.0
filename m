Return-Path: <linux-fsdevel+bounces-11105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE018511A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7681C23664
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDE24B57;
	Mon, 12 Feb 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttpzBqQE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663F17752
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735352; cv=none; b=qXeYeTu+5dQqc6hCjbJxSCKpZ+jCt5MGg+Z2L8m0bYShaI1AOAjJQsps3fF+forMx7R4zytkwxka+vydZo386t+GJydUlYU2H0fBKsvjEWdxj6OqOza0alXwhj2LttJ0yocHiYEM+KjJIsmYt5rjJmxInZL3fKC0Wq83788TqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735352; c=relaxed/simple;
	bh=jKIEZ0l+ATQ11uaAvluSldwIbx/sxw+vMOSJigKtPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbf6tHNubLCcpSRH5dGWdV9/DssrN7LIw7Znn31S+fy8Pssm7GVasqz4VpgAiRB4wrDuavtN0uGQa6S8FBpcrulTXiamRkncU/U5u1Wvcim5qLT6CIzrHCXXaoc2Gr6pzKfyadiuf8qnu7PAz8CxyubuTA1bI2OxhhdeHHzk3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttpzBqQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A869C433F1;
	Mon, 12 Feb 2024 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707735352;
	bh=jKIEZ0l+ATQ11uaAvluSldwIbx/sxw+vMOSJigKtPFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttpzBqQEDTHt8snGIInNpzNL3Tf5FPjcO9v4xaT8F9OFh5IZo43rCe9OocgpOI/CT
	 ljwD+M2lPF/VSRERA3X0YLc8JxPEP93/vJGi6nKWmov/eLtdi7uEaeXHaEgeAIVznZ
	 NDH/dAJJFsbJApp29yJH4KlxQxZ8ldbKpdKzmHx3qByOu28hbKVXQEh4NYhKQf+IsQ
	 v3xe6mJKWakJDeaD99MGmNohkSAjEdQMCouw+SpWlue56ox9TvlZSKKWLhz/sWaoaD
	 gZvL2ADYCbNHVZReAuN/aN1YKLiNkQbCBxZB3Shhs1qVqa/6lAG3h/Os264+BxxOoH
	 ak9MPslcc7hoA==
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/hfsplus: use better @opf description
Date: Mon, 12 Feb 2024 11:55:44 +0100
Message-ID: <20240212-geeicht-fernverkehr-8fe03db41cc7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210050606.9182-1-rdunlap@infradead.org>
References: <20240210050606.9182-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=brauner@kernel.org; h=from:subject:message-id; bh=jKIEZ0l+ATQ11uaAvluSldwIbx/sxw+vMOSJigKtPFc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSe/GmoeE7vS+BGi5qj/fsf7Tfd9ObRl6J7MyyVVqd0C qRWfPl7vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiX2QZ/nsesVNsK9a0ml4e 3rbzXLNjTF7Sc4u6jOybN2Zn9lxd2sfI8MTrQFZ1nOLbipOPFr84sthOboH2EbsrwnkhlpMrj7Y zcAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 21:06:06 -0800, Randy Dunlap wrote:
> Use a more descriptive explanation of the @opf function parameter,
> more in line with <linux/blk_types.h>.
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

[1/1] fs/hfsplus: use better @opf description
      https://git.kernel.org/vfs/vfs/c/c4effe1da938

