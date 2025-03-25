Return-Path: <linux-fsdevel+bounces-45029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE70A7040C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331967A38A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8B25A350;
	Tue, 25 Mar 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XclqaUB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4046F31E;
	Tue, 25 Mar 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913781; cv=none; b=ijHVOWDliP4KEK+xwHA7tcxHikQP+k10aol2oYHsLL0S8wVum6+royK3pT/D10w9FH3kC8UCE1s7TJlIoqgrk9CMEOTsp4Nu9RirWjUTMNBLblYdkdl7Z/CvHL0tNet92cUiHUzWqBqRdbhK9rxRAExGLoet1Z/L47QzoHjgSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913781; c=relaxed/simple;
	bh=lmIrBROtKRFCCWLUgzAzJqkCXPp1Qx01fWTc2rvFYFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sp5woRGd0dMJptvLlPXPPjzlieJEayB9g2o0vhkkwvlWIIqfrJxgtsjyP7In74fzx+VrOS3fhDqAeT2b2/IbpM1Ug5Gt8J9sE5PwJfNpTFj49eRFwKI3yYLVznenKS/+QBzBZ0iX5nnJHpYlsfb3MIwxh3xMLl+OBwjxghToesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XclqaUB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6BFC4CEE4;
	Tue, 25 Mar 2025 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913780;
	bh=lmIrBROtKRFCCWLUgzAzJqkCXPp1Qx01fWTc2rvFYFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XclqaUB2rG4UNBogPMGQDviRUqnMR2uosSLTTYSi27oo9YrVe5oVhp+gwqHPmp/x+
	 JX30bRnWDmpfXxo2YKtHyYOcPwDSxGJJXNGVIPw9P0HbWuspbgTlVBVba36VLoZg61
	 Ky7AX7MTjMpwM/EAGfF4jdT6ZSW2ymLZ47v8mVb6CCXC5OXi0xIDBGWagawr+WsIaF
	 kYnlZyiqCkLPnI1ekSnv+bs92UJVBA720wtfUgCCk7wNXKmVf1cG0OIFhPt08CwHTD
	 n1Euqd2KYe/lZ81Ac40t4sOFv9lO4zCyzw94PXBhpS8pNPd4P8rNkKYXoQqtFyDT1t
	 tboArCEMXGg3A==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] netfs: add Paulo as maintainer and remove myself as Reviewer
Date: Tue, 25 Mar 2025 15:42:56 +0100
Message-ID: <20250325-badeort-biomedizin-2fa6a73ec24a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324-master-v1-1-e2dd2fdb15b4@kernel.org>
References: <20250324-master-v1-1-e2dd2fdb15b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=brauner@kernel.org; h=from:subject:message-id; bh=lmIrBROtKRFCCWLUgzAzJqkCXPp1Qx01fWTc2rvFYFA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/OvAp4uUP1o4lPdKnuM89cUjz0jU9XcH3Vcj2GP85z 1KPRc2+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5tZSR4fGlv6+2WwVd0Jhw Jvi2+A/Rec06MR9S7Sf7zGadK/fnPw/DX7meV91rpLcebK5dYHWn5ucmr0c+7tovWeU/Cu72eKq 1nBEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Mar 2025 16:11:03 -0400, Jeff Layton wrote:
> My role has changed since I originally agreed to help with netfs, and
> I'm no longer providing a lot of value here. Luckily, Paulo has agreed
> to step in as co-maintainer.
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

[1/1] netfs: add Paulo as maintainer and remove myself as Reviewer
      https://git.kernel.org/vfs/vfs/c/1243045c9448

