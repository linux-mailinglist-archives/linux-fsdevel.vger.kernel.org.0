Return-Path: <linux-fsdevel+bounces-47217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F83A9A8F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6E93BDDE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6D2356A3;
	Thu, 24 Apr 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdRFK1PL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8522128F;
	Thu, 24 Apr 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487887; cv=none; b=QfdX5u9Zro4mShnORvHFcXGQokQgKQZXpX8JBzGQVLJUiPNftnxHqTtdR7h+gBeW7L9zITEJiw7Q409NLGDlaLx8YP5aXV+zPrIasKtOiSw2CUKOyFzo/zTdDU1atYnvFAitaEsZSTx0wK+UQg91ZGLYPh7fC/7STy1L/iGp0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487887; c=relaxed/simple;
	bh=8jRSZqjbmdE01PoeHQIXSWpg7bgymSnumnNJpHBOUIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3V6baktYSgyXDa+HGPAGjnsA3L9kbVTOkKbF9q5N5X9F7B6SxEQi5/iPLJvvkeK9qOkuLLRFl5gYwZlFE8tXo+DGislvAtut+ItxSVxJ8EL1PBmxg8LEiCGxeyXWZwRyAow40O+n+i6KIGcC3o5Ftby0eOJ3I2+BrbF419eywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdRFK1PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84FBC4CEEA;
	Thu, 24 Apr 2025 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745487887;
	bh=8jRSZqjbmdE01PoeHQIXSWpg7bgymSnumnNJpHBOUIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdRFK1PLQ/xltWSF3DL6KnH5r0JiK646v1c6sLpqqic0B5Iz0fyJf6y6rjbJMRRzb
	 qzX5Uysj9YUm1w1vMXPQbVBlP5aNHi/7dlP8+n/YQkQNqP6yiR1iu4LYuFpUo4yV3h
	 Ptr2f3H7Ot3C2IfHtiIWn6D79HOM+m64+ZIXRsu4aSJ3uzur6ALgpKVzl82ewZ6zle
	 gZdJzgHLGm3el4tdMYr6AH2r3Jn3nfUjrvzk2JjvMF0XSslvoTwdwsFOJb+MypCafP
	 7CMVdanV7izDj1+hs3pThFlX2DVD7s8Lvy0L7BFScHzgco6wFw4Qvsz1rWVQg7tK/1
	 Yi+xRkfsouqVg==
From: Christian Brauner <brauner@kernel.org>
To: slava@dubeyko.com,
	Slava.Dubeyko@ibm.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	dsterba@suse.cz,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	josef@toxicpanda.com,
	sandeen@redhat.com,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH] MAINTAINERS: hfs/hfsplus: add myself as maintainer
Date: Thu, 24 Apr 2025 11:44:38 +0200
Message-ID: <20250424-identisch-artig-756caa667a9e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423123423.2062619-1-frank.li@vivo.com>
References: <20250423123423.2062619-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=brauner@kernel.org; h=from:subject:message-id; bh=8jRSZqjbmdE01PoeHQIXSWpg7bgymSnumnNJpHBOUIs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRwcXCcvOyy/HBit8F2BqetjeuPesqelHxs4+p2iX//N RV9qbjPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJ+MjwT+n2vSJh63+aAur3 HtT937zOXPPzmpYrzIv7lyRV9VrPZmBkuLxjVWfB1AbbW2H6jtuP/NrwqMiqZIrv37kPX/A9ijs cwwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 06:34:22 -0600, Yangtao Li wrote:
> I used to maintain Allwinner SoC cpufreq and thermal drivers and
> have some work experience in the F2FS file system.
> 
> I volunteered to maintain the code together with Slava and Adrian.
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

[1/1] MAINTAINERS: hfs/hfsplus: add myself as maintainer
      https://git.kernel.org/vfs/vfs/c/ed11344c2b80

