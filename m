Return-Path: <linux-fsdevel+bounces-56385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF18B17030
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164B71893BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E4B2BE7AF;
	Thu, 31 Jul 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fspx8/Nj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0B2BE646
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960341; cv=none; b=hKGDAeNpjC51NOYIXNLAButuWr+hwhPAxwHpN86PpWAwFYfLA5A4x/0dhA6RCrTdaeayO4jM1lJSRFRlfOQZdCmpzEjTtgME3i3TPsgCg/x8mw0hdQdOhI0uFFQVRX/j84H8fe7QOhRvULQWHAaezUuwPFXpDXrC1nPGin3UolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960341; c=relaxed/simple;
	bh=tI0ocCtP/WXxCb9jIK/Xxai0/mwpERbye7yF3tPm8pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlPk78//o59MOBBNFudqs/Qe7SciIm3xeBS0IVOginKts0JXZCJVmM79slmAw2ZI5PshBmJNzFWRAOmLfUPxUnyVplK13XWWlmmrO43EL1fh225i1bUsIr7BPW8jdb32j3rhxuWZMW1/V0YMDxWlFMXtuWLNmQE03+pHTP973Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fspx8/Nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445DAC4CEEF;
	Thu, 31 Jul 2025 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960341;
	bh=tI0ocCtP/WXxCb9jIK/Xxai0/mwpERbye7yF3tPm8pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fspx8/Njx12I6saOIi30zYuuTnSSak777OLm5iqdYbNu+sd1cObG3GyswkUOfH8RE
	 g2yqsjZbSHBvEsHEE6YKPcpu7+d2+pFCBuCEY0pSByCee9NzDRVAij3iYgwXeW1c9h
	 X+lq7GcKFE1sDpwqgIT4aPpTmnvC3gPJN+Bpb7ZdbAZBI78IHyvwh4TRxwLnUFYK1d
	 uqTXTQnSLj4uqpFzJSH91UPWkobdBmxZlPmkiA7TsIWZY+TxcEXGDLRMzCVgOM6fZP
	 m3RJ0g8DQ4tSe186r+yjVO6SvEwFtNjDiO/Qx8O+NeBR8RBv1ZsYODnDndhE5SU8vl
	 takGLQSNmMrzw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	tbecker@redhat.com
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] locks: Remove the last reference to EXPORT_OP_ASYNC_LOCK.
Date: Thu, 31 Jul 2025 13:12:15 +0200
Message-ID: <20250731-amtsmissbrauch-voneinander-87b2906e57d0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724203516.153616-1-tbecker@redhat.com>
References: <20250724203516.153616-1-tbecker@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=brauner@kernel.org; h=from:subject:message-id; bh=tI0ocCtP/WXxCb9jIK/Xxai0/mwpERbye7yF3tPm8pM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR0+08IdCq/6fVsuVRwTsMMq7iNtYu3zp+5TeG+3nfJR vG6sA3eHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpcmH4n5jkfFdZ/1zMRLm5 Jltk5xyXv/qeP6zlondd/PGf/ZdeJzP8lalUZN70a4V807TA3jkZ2Q1z53JdP8Lf5HKC5S7/rKf ZrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 24 Jul 2025 17:35:16 -0300, tbecker@redhat.com wrote:
> Commit b875bd5b381e ("exportfs: Remove EXPORT_OP_ASYNC_LOCK") removed
> all references to EXPORT_OP_ASYNC_LOCK, but one lasted in the
> comments for fs/locks.c. Remove it.
> 
> 

Applied to the master branch of the vfs/vfs.git tree.
Patches in the master branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[1/1] locks: Remove the last reference to EXPORT_OP_ASYNC_LOCK.
      https://git.kernel.org/vfs/vfs/c/8991d5172a9b

