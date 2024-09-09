Return-Path: <linux-fsdevel+bounces-28922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63897104C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06771B218B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C961B0107;
	Mon,  9 Sep 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2gHmBit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E323176237;
	Mon,  9 Sep 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868316; cv=none; b=YxEPDS2cVaA5fC7NT9WubfF+jnHi78i18JK9mtJEZ6Az6ZpaLSfd5wUpj7LA73058d1qpNWnoHVuJNEum71jUJnLwOyG+Q0iIli9x7m/pgn0ut51FdPCxZAywCTfxzRGDsdKzExHvHSkBOZtzwPbEXrGAD9xcSwsxYCc8RUTlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868316; c=relaxed/simple;
	bh=96c4c3wPOJU8suxg0eoF68+PUAPDXmd7MqAJkKJrjV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9bfjlSKuhbn7ZMrmu8E+SiXKqLnJzdWU44c5+VuB1Ms+OCMkERiydc8iMlkpSfNLXRMHLT/1k+80xktfU4hbNgFW3w4+BorVvanovmyTw0+eHbaHjNj3uJ0c860WlFqR9LYEw+Y4R8XJZ0Oqwyu6nnqZkLJrCczd2jwrK4g+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2gHmBit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B8CC4CEC5;
	Mon,  9 Sep 2024 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868315;
	bh=96c4c3wPOJU8suxg0eoF68+PUAPDXmd7MqAJkKJrjV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2gHmBitxf514l0xfai544a0kNK41duKcP83xv4FtdRCGg8wRrnxNNvYex2ydEaaC
	 u+xt+R0b45iR4iyloAC+HZUJlwfgra15lnqEs5rD8Zcq1duZturu2D6qROAZNeNR6N
	 ZJJI3pQePpLk9W9KHeXrfb0KedNdk26h13CgwXt2QQVvIFGaHHPX6rcV9CfrjYF03/
	 pC+vAPq6R+qeMtAIX1rQETwWWWnyoplRaFkq7iUJTYwqQxkwnyS3pMIeD4rRkob218
	 D83diNnSUfcicIeB6UYxMWVL1nVHfnkcJES0qoz1QrfASfx1rVV2LWrHAs/V9tUKl5
	 xYiAm1/3+lAHA==
From: Christian Brauner <brauner@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1] proc: Fix typo in the comment
Date: Mon,  9 Sep 2024 09:51:41 +0200
Message-ID: <20240909-frieden-yacht-7b67be6a8a3c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909063353.2246419-1-yanzhen@vivo.com>
References: <20240909063353.2246419-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=brauner@kernel.org; h=from:subject:message-id; bh=96c4c3wPOJU8suxg0eoF68+PUAPDXmd7MqAJkKJrjV0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdWymy45f8vtzNmd7CGa4m4qsCv4YsnG8fx7XEqF7g7 A851msNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxucHIsO70qb12Ql+7HWYd zjfpYJfS2lj3LKF8cnD8D4/5+dd/P2Nk+NThbnX7+cLk+1e2rRX7ESy88jcz6+mvLuUc2xfv50q azQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 09 Sep 2024 14:33:53 +0800, Yan Zhen wrote:
> The deference here confuses me.
> 
> Maybe here want to say that because show_fd_locks() does not dereference
> the files pointer, using the stale value of the files pointer is safe.
> 
> Correctly spelled comments make it easier for the reader to understand
> the code.
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

[1/1] proc: Fix typo in the comment
      https://git.kernel.org/vfs/vfs/c/698e7d168054

