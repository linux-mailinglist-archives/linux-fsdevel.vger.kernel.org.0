Return-Path: <linux-fsdevel+bounces-7627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AC82888E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA45B1F25301
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31839AE5;
	Tue,  9 Jan 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHskLzgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5D39AE1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 14:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1028C433F1;
	Tue,  9 Jan 2024 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704812109;
	bh=eJewJsUqUNQr3qtkSTp4efzJH83UsB/Um7+ZXsetkeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHskLzgUbL0eWaekOpFDP5YRfqyEHGCLa5JicKoSIsXz/E2qi0ELFKJ6LtOgiXOpA
	 gRGFQ0IiuGbkDWnwQzQDKJaKdSWVZSVT6ZLGcuunN/dZov4vkGJJ7/vExu4UbYbhOF
	 ckCRcnNWL7CBgCULHzB+GUx49bCq+Xh6r0HixPhwrSYMPTwcP9C7ZpW8QLfN/fdb80
	 XPTXgu6j/YjgVgCBLs5AvmJtZLP7+27Z2RRKADK8v6+T3Anp9Q8wvSd88RTl2B95DB
	 csLon9bEK1eFoqAEujd6/cIss/AkFjrWGTXuzXWUFQnlniEeTNPb2GYHDjBFPMht23
	 2YN0puLY2PxNQ==
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: Wrong function name in comment
Date: Tue,  9 Jan 2024 15:54:48 +0100
Message-ID: <20240109-backofen-turbine-e5838fc03687@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108172040.178173-1-agruenba@redhat.com>
References: <20240108172040.178173-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=brauner@kernel.org; h=from:subject:message-id; bh=eJewJsUqUNQr3qtkSTp4efzJH83UsB/Um7+ZXsetkeI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTOjXPlvSmjdzffjrHBun6zW7fiLj/L1C9RzwUcJnL3z Jb6KqreUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHdyxgZJs49xXia2dXj6F2l onUnmTd0Le+4sTmH262pcNnWq15BMxkZeif9s2RpszTz0m5tuvhW6u7dbwttpp2a8cP4SW5/11x XTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 08 Jan 2024 18:20:40 +0100, Andreas Gruenbacher wrote:
> This comment refers to function mark_buffer_inode_dirty(), but the
> function is actually called mark_buffer_dirty_inode(), so fix the
> comment.
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

[1/1] fs: Wrong function name in comment
      https://git.kernel.org/vfs/vfs/c/a9edccf32826

