Return-Path: <linux-fsdevel+bounces-31169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F7992AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E08B23013
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C001D26E6;
	Mon,  7 Oct 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYQPBEzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270F1D14EC;
	Mon,  7 Oct 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301775; cv=none; b=D9+OUJhY8thm4lT2jI7v1lJaBXU66Ubf+CPW+ckLuG0EY12oP1RD+qIH9KtOSodB0744lDwL6+7s93LAMrXyt8StHKUYlDaXc0rTfjK3RoQF90Yf5Vtuo8SXs2BHfs9Y9cC+bj7L9fcWeVLOotrQ1QjryFxkZGCT6kPtO6Vnc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301775; c=relaxed/simple;
	bh=aGGYf8UYYSR/s02xZ8SrkSTF1N7ddgHilx7hxwTjk90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STMpKCH1LWWIr5A1rd2XNGxU1S0nSRdSLlVlapkicg+t1RrSW+TjrGCg79duzEHy7FmmlehBzxS1zmQ1LFPx66gixymPvq76TQLU3rffxLAXe/QGRMRvPmLHBC3mdVpSpvAxcKVkJHH49F97nHvvXADGgx72K+0ZRjpgbbCY7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYQPBEzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D19DC4CEC6;
	Mon,  7 Oct 2024 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301774;
	bh=aGGYf8UYYSR/s02xZ8SrkSTF1N7ddgHilx7hxwTjk90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYQPBEzU/QZY12SEQQ3pRN8tjimYrarRhuFHwHEj/lORK66V6nee5jSaTYVuF6f+E
	 72c5I+fdYzlfW1WtMA80b+CiKENopg5vvf3rEaHPL+prALodbqjAV3DvwNmLm50VbV
	 MhjMYD7q3OpESwT/tP2LeOkfZr5Wl4hHyjmUfpwowOGX4+oUtg3geYLDy1UihBqgai
	 4CMZqc1BgTcwVIGSqRy4Zs1J68HAwX3Sp3OIP7DJerCkzqa/CPC+4e1Uh+xEfsUH7x
	 YIEx/SNIG1oStDcmrKz3b8nZ0cXfCU8DCca7CVHg2zO0hxcWkDufzKCyy3OqVWsHVn
	 /11g83CUTk0wg==
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] vfs: inode insertion kdoc corrections
Date: Mon,  7 Oct 2024 13:49:22 +0200
Message-ID: <20241007-kurativ-vielzahl-f60a49696005@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004115151.44834-1-agruenba@redhat.com>
References: <20241004115151.44834-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org; h=from:subject:message-id; bh=aGGYf8UYYSR/s02xZ8SrkSTF1N7ddgHilx7hxwTjk90=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQznzqZa3/66un1Dr9YbF+bNSh+uT5BSa/8yja+Oywq6 Zten7i9rqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiahsYGead33fDL4PpjIKw rBZ/tbXWUoUTzityfpe/yL2hbNq4x4zhn1KKqczDxrN8e5ZkfBKtcsq/9NU3uGLHLh/LNXG77++ dygwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 04 Oct 2024 13:51:51 +0200, Andreas Gruenbacher wrote:
> Some minor corrections to the inode_insert5 and iget5_locked kernel
> documentation.
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

[1/1] vfs: inode insertion kdoc corrections
      https://git.kernel.org/vfs/vfs/c/8ec74f7820ca

