Return-Path: <linux-fsdevel+bounces-55157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18CFB0761D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99E23BE775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DC2F5480;
	Wed, 16 Jul 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHptseyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7A85626;
	Wed, 16 Jul 2025 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670044; cv=none; b=cZXntmocfu5T826+mKvXgysnKJbPGieuBOUsXhtgr5WIYbbKdPxdDxiePNXde46bnekB+lmAe7WAaJmPEXoRhFXgtSO1Bq0UXHKROg+0lzXurFg8hDem2gMK7C562ZH0tN9XLa8lb1YEDa3501XrMNpZ/mXHzk/AiTkUQtSVbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670044; c=relaxed/simple;
	bh=IKPDkBRjXXGkx7WnOUAMXDgzSZ1VViiNvV27SspUSBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rmf1A/FNZ+xAu5sy2lpCdPVpuZIVkWpNjVPKD7UWDrHoYkeOW1/zWQhKacghsVwHtfsk5roqSC9EPZDgSNX12suDwKtM271uH3zSKn2FDhug1jBduvwEYvG63WffPdoQ+BUBOqpKJl9t6C6nc1fYfN0/5TONhytq87/tRbyhytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHptseyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52799C4CEF0;
	Wed, 16 Jul 2025 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670044;
	bh=IKPDkBRjXXGkx7WnOUAMXDgzSZ1VViiNvV27SspUSBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHptseyCY9KVvHpywNiZ32TkMLq9DH4hgBlDVrqMPRhV5g7vrRXdeRqzgH6CafByE
	 xjK/yvFw3OPLDvlotbwEdt3LVydpA3udtHJ1E2sGa2gEFXOMo89pbdZ+SkbC2APAst
	 veNo8Ju0EL5YDn7Oi8wgzNjUBcjUdec4l4HsC2CcmQKbUESikMozOS50YidcZJnJBQ
	 vvB5MVuDul3udcYdX1XmXtS4t0gLvlWo4fDq04aKmqaW6o1fXb0eqE7my3wYNNxwOZ
	 jgEhov5e+mT7FsbdpZtmVbhIxvNnymucdUDPHOiRCIrMdvmwLJZC+CPrxX2I8uWvp1
	 /RO+NFGC+BXaA==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCH] MAINTAINERS: add block and fsdevel lists to iov_iter
Date: Wed, 16 Jul 2025 14:47:17 +0200
Message-ID: <20250716-filmwelt-vergolden-f21e85d86274@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
References: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org; h=from:subject:message-id; bh=IKPDkBRjXXGkx7WnOUAMXDgzSZ1VViiNvV27SspUSBk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUzw9LENV89Vcged70ENdrC6U7r1yelbck7WG+U0QXj xx3wrK8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlovGb4X5p443Gkfortgv0L l5xo9P307uG8heUHXky6tCF1b8TZ1uuMDH0xy/v0dh5lCRCQ/OSs90taafm3hg/PpuY08t/+KxH 0lQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 10:40:45 +0200, Christian Brauner wrote:
> We've had multiple instances where people didn't Cc fsdevel or block
> which are easily the most affected subsystems by iov_iter changes.
> Put a stop to that and make sure both lists are Cced so we can catch
> stuff like [1] early.
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

[1/1] MAINTAINERS: add block and fsdevel lists to iov_iter
      https://git.kernel.org/vfs/vfs/c/a88cddaaa3bf

