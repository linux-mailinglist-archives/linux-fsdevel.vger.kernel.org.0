Return-Path: <linux-fsdevel+bounces-28924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E6C97105B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F91C22293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 07:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F81B1403;
	Mon,  9 Sep 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwgZgx30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB8171E5A;
	Mon,  9 Sep 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868422; cv=none; b=mjEe1o2r8Iw2Vo3CWTam9JPD066PiVk18gO+ChS7U0GsTa00xyM839inV9iIusGZ8Pk5MPSuiJQdhG/8CloieI4OlwBmRfwNJ5/be4joS3fOZShzOTDXUck+zHwNi78DgnjVV7QEEW/igyvibz1q65qABcWDtlpMxu3UeiZ84VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868422; c=relaxed/simple;
	bh=w36v0FrIQmVf2i9WlExfRmtNLSy5f3G9wFgNnUH6NWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCg4WQYAW9GSbRnjNRj01yhvcsQnNrhjI8veDpVRwkhLhwtRD/FM86GI851ptg6pOmkcdbaPxHPhZ2nyo3sDSLvjSCz6qeMLEffvPk5y+rCDiNQBt8iEvroHXEY77rqqlhBEbefIuA8tmhcfWH0Pjk/fWc1ZXxuzLhA2NHPfsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwgZgx30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED94C4CEC5;
	Mon,  9 Sep 2024 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868421;
	bh=w36v0FrIQmVf2i9WlExfRmtNLSy5f3G9wFgNnUH6NWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwgZgx300K69LHYfcC+E5jXdMx8t4CWC2u0UNFoOkiCYFdA4j1qCIJF25WKVRHzog
	 NlP8T9eJXF80rZFtdnUt3iDrdpeSlzmnpD1hJX6d2VUBl30fYW5V3NbYq8Is6AKZU0
	 Hs1If9cLy2dtNXOaasPFwnL031z2umJDuOVLwJoWjBsATaMYgqik8tKu70X/sVgCMQ
	 x+M0ls0sqUpaMB6iikmS5foj22pVc1F/Kl0cmKIckjddM8LilODPp9/6+TugVAex3c
	 +jxypfAZb8yxNlCybB6ICzzj5TwWzWko4iDSblV8/Swv/aSobuNekhTjXNxGQSExm+
	 2ClUJP9cee+YQ==
From: Christian Brauner <brauner@kernel.org>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes in iomap design page
Date: Mon,  9 Sep 2024 09:53:28 +0200
Message-ID: <20240909-frosch-klumpen-dbaee12c22d6@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240908172841.9616-2-dennis.lamerice@gmail.com>
References: <20240908172841.9616-2-dennis.lamerice@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=brauner@kernel.org; h=from:subject:message-id; bh=w36v0FrIQmVf2i9WlExfRmtNLSy5f3G9wFgNnUH6NWI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdW1mnez35c7vpBH/j9mOZ92eZzK0IaNTP97wj/z293 mwD51mBjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkE/mL4H74mybyymFfR8y9r feh79X0F7lO5Pkxb7Rq6R1+K1XXJbkaGx+kb7+1e0L2jtJDp+38+/vX7zOP0G++XsNhM7vu+adc 1FgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 08 Sep 2024 13:28:42 -0400, Dennis Lam wrote:
> 


Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/1] docs:filesystems: fix spelling and grammar mistakes in iomap design page
      https://git.kernel.org/vfs/vfs/c/b1daf3f8475f

