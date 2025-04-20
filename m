Return-Path: <linux-fsdevel+bounces-46734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E6A94783
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 12:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294327A23CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D931E3DCD;
	Sun, 20 Apr 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRfmr9sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D31BF37;
	Sun, 20 Apr 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146524; cv=none; b=EBEotuw2x8y5weeP3qlDi5sCe8t/GjT2BUQdX9lCUhVEY561f/JKC2V44HUa6cJC02JykTfZxriyTpmW0wjmLjrktYpfuA+MUntOdug8jQEVSiRUUUNMERs5yI1kfeR39EwdBmynlze64iPBIKAgKeu9AmNTAwO+7tBjdRcklGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146524; c=relaxed/simple;
	bh=JnxvrHfkRPZ/aF3Ett+En37YJDb+bJxbnYGGJW/fipM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXawv1aA1rE+QCKvsUvmrKdKWHwaVj6A6dJ4s1xng0WPtv2DEQBe5ggVsiZQ9X44cQm75JiM5WfCsAkMlYTl07bK7bFExwaxyaaQW+jFmu3f75aBRizJCt1df/qyGPygUZugdhpRqe1O8ITnjoGpmmvRAucNozB/dKmWpyK89gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRfmr9sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A9C4CEE2;
	Sun, 20 Apr 2025 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745146524;
	bh=JnxvrHfkRPZ/aF3Ett+En37YJDb+bJxbnYGGJW/fipM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRfmr9sdsja7Aoc1SiAZ/JHB5zy1GvSQaNbbB+rprHa3uCm1RodAJXkN5DaozT0f8
	 xRGLBuijVcFeN/7RqMgON9J9zQLs8vB7XMaUYOgSF9WznvKAAdEDGZfh3NYOrL6DQE
	 0WjuJaTqpb7tQG3mlO1uLHSsjuOUErkJS5p4uR4Hac3I1wVV0OacUnLYQEdKhV72qd
	 T1RkRfJHtHc1ahlJKEVN0kUvHlfI8WEAA/zy8txJAj09+9G9VuNtXLt8h0smrs0p0x
	 gZzQlxMiec0A/rKO08a7JE0cnjL8+19Xsw16nebceTbrQ1WGeIDW6Pm2HIWFAGBkVc
	 9Y4Zjtmx+KlAw==
From: Christian Brauner <brauner@kernel.org>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Slava.Dubeyko@ibm.com,
	dsterba@suse.cz,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	josef@toxicpanda.com,
	sandeen@redhat.com,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: add HFS/HFS+ maintainers
Date: Sun, 20 Apr 2025 12:55:16 +0200
Message-ID: <20250420-ansturm-hippen-47bb33bd2a47@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417223507.1097186-1-slava@dubeyko.com>
References: <20250417223507.1097186-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=brauner@kernel.org; h=from:subject:message-id; bh=JnxvrHfkRPZ/aF3Ett+En37YJDb+bJxbnYGGJW/fipM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwXJrKWyZe/Ylx1V6b+GtbDWfHnF9Q21hY5JD9xbph2 ox0j6iujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncU2P476y44rdUq6S/UA/3 108iaZLMM8P0Z4gksPvtTlr2eeqDRkaGjl+p247fLihZPO23+imnVL72hYH3hH6t+2Vgk2La9m4 tOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 17 Apr 2025 15:35:07 -0700, Viacheslav Dubeyko wrote:
> Both the hfs and hfsplus filesystem have been orphaned since at least
> 2014, i.e., over 10 years. However, HFS/HFS+ driver needs to stay
> for Debian Ports as otherwise we won't be able to boot PowerMacs
> using GRUB because GRUB won't be usable anymore on PowerMacs with
> HFS/HFS+ being removed from the kernel.
> 
> This patch proposes to add Viacheslav Dubeyko and
> John Paul Adrian Glaubitz as maintainers of HFS/HFS+ driver.
> 
> [...]

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

[1/1] MAINTAINERS: add HFS/HFS+ maintainers
      https://git.kernel.org/vfs/vfs/c/fc16ec278b6e

