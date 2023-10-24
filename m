Return-Path: <linux-fsdevel+bounces-1037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC07D50FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C69E1C20B95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F42AB4D;
	Tue, 24 Oct 2023 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chMjXc5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64A2AB34
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797B0C433C7;
	Tue, 24 Oct 2023 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152787;
	bh=MkC7wweWEr/Q8U6sMQJlPfRF4r0D9Znipc25YUVbu/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chMjXc5dWDcQ/dETq+4LXmcMPoe/JYnzifV9cbuLC9z4O35uFgX+o3AU7dWVgoEKR
	 3BP9doFFk386Vsfp6iSPpV8XLI0x6iqq6F0KstQ3TJe9jVcMdhYnjzW617DMQVz1tz
	 278QUUoDpTl72T6bVGfs9BNV92tEp6e5xsIRiWwH80QTnN8e2YP3LlJ4DwO9ke2tWH
	 GfUiqu5VLoiat9mU5YA9HAl00SmJCYNQu1Id1wJH/oJaE0rSnftk+3Wu/P5dphVLBO
	 DpZK9Wncy1XsG9XKzzrM6CWcPKccaDOPBJLoIMVUBRlxVSa8K+1wwEMwt3Q7N+nt4A
	 yu4l8ruH2jq2w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:16 +0200
Subject: [PATCH v2 10/10] blkdev: comment fs_holder_ops
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-10-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MkC7wweWEr/Q8U6sMQJlPfRF4r0D9Znipc25YUVbu/g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3TcOoXLkcf8xrPYFu/qb3/+i13Z3MLOti/zJtv9jU4c
 d7VSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSeJnhf/KRLSxmWhy//JqVK/xl3l
 dxfFmy6LzCD7VN95yiz6i962T4n26v0KR0NI+NO7iHsdIkcualtCu3u37F8POXHZO/UrCLHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a comment to @fs_holder_ops that @holder must point to a superblock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/blkdev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1bc776335ff8..abf71cce785c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1480,6 +1480,11 @@ struct blk_holder_ops {
 	int (*thaw)(struct block_device *bdev);
 };
 
+/*
+ * For filesystems using @fs_holder_ops, the @holder argument passed to
+ * helpers used to open and claim block devices via
+ * bd_prepare_to_claim() must point to a superblock.
+ */
 extern const struct blk_holder_ops fs_holder_ops;
 
 /*

-- 
2.34.1


