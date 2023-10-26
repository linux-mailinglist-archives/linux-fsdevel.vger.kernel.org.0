Return-Path: <linux-fsdevel+bounces-1236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE87D81FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC11DB2140D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71E2D78A;
	Thu, 26 Oct 2023 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW3JxmYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B72D784
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 11:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F5C433C9;
	Thu, 26 Oct 2023 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698320713;
	bh=2rKVJWmmi1F4DNOT5jynrO7RMtvnFJ5jxJhwoxo5hs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW3JxmYltkMoKaju8fiGIB7A/t0VGnw8MzWpK+HW1jcBRdzASSY4iHByuHW4YXL9e
	 V6OQ2VOEwiHJEa0rV5CFQTO23pFs3TqpnXUjmrQdIYjWHFG2Vr0/eFzVdmD+n5fu26
	 9X1mS/liDEgzJRI9od/vdeOqnsh4cBh4bSb0imB8Bytvc35rP9hqb1w6YgvVRqGxR8
	 AIgpWGBHcNc0SKY3tjqI+9w89DBYLLgghafWjO7OZQEmhOuTgDujiQP6RyugAD1WAJ
	 rS6WOGcvN8SslR7B+DfpCiF6OgtNvOx+fZznGDjvUO4PomTL3H6TgQEII1SGH7XT/B
	 krDYYDor6SJVg==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Implement freeze and thaw as holder operations
Date: Thu, 26 Oct 2023 13:45:05 +0200
Message-Id: <20231026-unkommentiert-kultserie-60df05ed0ca7@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=brauner@kernel.org; h=from:subject:message-id; bh=2rKVJWmmi1F4DNOT5jynrO7RMtvnFJ5jxJhwoxo5hs8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRaBVpbrPjFt2FJB6NnudTnrfdzX518sunP0SB7z/+fQiyX C85d0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRJi5GhpO7NjEmLFK8I5R6rKx/1Y oDC+KS7m86yRRWHyauJulUK8bwk/G/752qxBMq5X+m3ryzwTjxnG7F3jeV00LElwedDuRuZwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Oct 2023 15:01:06 +0200, Christian Brauner wrote:
> Hey Christoph,
> Hey Jan,
> Hey Darrick,
> 
> This is v2 and based on vfs.super. I'm sending this out right now
> because frankly, shortly before the merge window is the time when I have
> time to do something. Otherwise, I would've waited a bit.
> 
> [...]

for v6.8

---

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

[01/10] fs: massage locking helpers
        https://git.kernel.org/vfs/vfs/c/eebe374c4824
[02/10] bdev: rename freeze and thaw helpers
        https://git.kernel.org/vfs/vfs/c/48ebe79e5e5f
[03/10] bdev: surface the error from sync_blockdev()
        https://git.kernel.org/vfs/vfs/c/7cb1d5f9e92c
[04/10] bdev: add freeze and thaw holder operations
        https://git.kernel.org/vfs/vfs/c/bd05ce12dd8d
[05/10] bdev: implement freeze and thaw holder operations
        https://git.kernel.org/vfs/vfs/c/8246b9ef23c3
[06/10] fs: remove get_active_super()
        https://git.kernel.org/vfs/vfs/c/085b0e223302
[07/10] super: remove bd_fsfreeze_sb
        https://git.kernel.org/vfs/vfs/c/36d253481290
[08/10] fs: remove unused helper
        https://git.kernel.org/vfs/vfs/c/350e08366980
[09/10] porting: document block device freeze and thaw changes
        https://git.kernel.org/vfs/vfs/c/c3e5c6b60a75
[10/10] blkdev: comment fs_holder_ops
        https://git.kernel.org/vfs/vfs/c/15d2068af6f4

