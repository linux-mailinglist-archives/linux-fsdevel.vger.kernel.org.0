Return-Path: <linux-fsdevel+bounces-1366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972587D9997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79CF1C20F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B41EB33;
	Fri, 27 Oct 2023 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PExWIOgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864651EB22
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 13:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926BBC433C7;
	Fri, 27 Oct 2023 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698412813;
	bh=ynGr84yTGGF9/gJAR3OQsPXTeVng460AC5JqZcxsnpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PExWIOgSZotTyc4Z2Of9v5971k2CrLjvfIm57CliR4zVCV35RIMKvubK+Ub6/hz+X
	 sGCZjLggiQ4ImEm4h0pejx+ReoKuCRuZzgsws6Y5Yy59VRQlTcOfqcXOdPjrqCXcnQ
	 mfT1F3UArhyoxCg7lrUEhhB6rjL41cmdg196uvY/B1VPdlaYcezj1u39W2DmowZxqZ
	 0Cxwz0qeT+RSUNUWlxtPcgu9FG5EmTrMALGC6xAGbu3b/A6rHQbNCnBd5Gkx13DJW0
	 f0DHAeVTqKO3l/VxnNPU4EjLknv+wntFDkjz8RjsJB11GKb3x+n5wz+vHUcG9IN26F
	 CMyOcYm5j2r2A==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: streamline thaw_super_locked
Date: Fri, 27 Oct 2023 15:20:04 +0200
Message-Id: <20231027-widmen-seefahrt-09d2dfc8d44f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027064001.GA9469@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org> <20231027064001.GA9469@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=brauner@kernel.org; h=from:subject:message-id; bh=ynGr84yTGGF9/gJAR3OQsPXTeVng460AC5JqZcxsnpE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRa72Rk+uficOBwkPICZ6mbqbMjbi6Z4OoZIV/5zafWtfhG fN3pjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwAbnzYrZcTXS6XqMw5Xb2+ttXnr d8rmWxvxpQF7ageOPXJWs+Mvxm+btLxjqeW7DLSexUM9+i3w0u57vvBDdO82A4UFy5oIUZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 27 Oct 2023 08:40:01 +0200, Christoph Hellwig wrote:
> Add a new out_unlock label to share code that just releases s_umount
> and returns an error, and rename and reuse the out label that deactivates
> the sb for one more case.
> 
> 

Applied to the vfs.super branch of the vfs/vfs.git tree.
Patches in the vfs.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.super

[1/1] fs: streamline thaw_super_locked
      https://git.kernel.org/vfs/vfs/c/6d0acff564f2

