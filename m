Return-Path: <linux-fsdevel+bounces-7019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D281FF09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 12:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33861C22365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804411184;
	Fri, 29 Dec 2023 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QJvn+Ikd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D410A1B;
	Fri, 29 Dec 2023 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703848181; bh=IWLItomP6GEXQZbCwu1A31BjXLnz2T16xYfN+yaLlRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJvn+IkdOAsfSxK8m39N+yRtFLYxVqIHzWBqyj6n14fVL+q4JAUW7PmiUnfShmzUA
	 jR6C+I2qw6yQgKK+dtmmugRUcM6uY8l9ITgBXpNF1dGRPmqX3DPNzvbe0pZufsJDOo
	 z9P/GizC5IL0BN5PcGyTFWBAgl9FhUvHWaoKo8Dc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 266AE21D; Fri, 29 Dec 2023 19:09:38 +0800
X-QQ-mid: xmsmtpt1703848178tler3y48n
Message-ID: <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH39IW5HizR2sWu+zJcP3A71yxExmFmhU/mUvv0aGo++xNpfn7PSz
	 H0JdlsXhnCdg4V1KzL6pRBg7xd7kL7/AxPr1KYTqzA65gJjwcp+tczR3xCtMYStXSX3M6BJ2UELk
	 ynGqHqPXvkUTwWRwVRvGCphwYqBF8vS7dxaXTFrWJfBPS1DQleBFYVI4W4d8A5qH0mPpjKWbeLdr
	 KSc0J/wSRsNEsrTvJWwz9gjGf1OaSUdv0EQabUK/7QhqKtelMwrvcMdFAzeap9f+jcAb9aVem2Xg
	 WhpCpM/wV0wqhnbTOvInTkUOTJhMCCriMCiCji08CIYg/NCEGMZsRG+B2U7VmaydfSJJqbMubUFB
	 XabmIqXi9BDpce7JuVMoWLdxY6PXkI2IzM5zRAAYusI5oXBWsFtCSzoSiOe6AHJ9SbKI4IgBwjWw
	 F1ZlT8HEoHgmW4HqKeJvUVl9daW1wtoi9A8f9clR16R/cmJWPri1Uca+sVVNBU984s/WO8eB8Gib
	 BLyOgKANBQYIbdIAZmxstFzHe6tzUk2hLFjFqVMLqn7A8/3vIlURrul+l5OWrtISAopif4YJywDP
	 sLUiVXxo9SmyzNe2xjAZjUq5HgVBuXotNdWD9Wqp5MgERLGNzoiFz/bONnKhRDyKbH5vchdqaRev
	 vSxDA2LOvEeyg60sHMUb8CLw2ppZz24JvqRA9lmqNn0au+F1jww4WqFVaNp+z64U/l0Hqir6f/W7
	 vzM875o4UWzFBa0TvL1EA9G8vjSXW5E1pxw8kL7Gv69VtZ676B21KzFvs+TSmwHHMLTj9JUkpVkN
	 2Xm6EW/hC0usa1YPs5bnJomcYOmm1CD5VU49SkphNlysdKDlYTA7IVr3jKylTFHO/5DEHVVK2ZlR
	 SM1w98xfLlAmrpSaR3gBHsOb/WG5wbE+R6vRMqqXntmII7wXQuxErQTqIft4eaAg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org
Subject: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
Date: Fri, 29 Dec 2023 19:09:39 +0800
X-OQ-MSGID: <20231229110938.1157837-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
References: <000000000000321c24060d7cfa1c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When LZ4 decompression fails, the number of bytes read from out should be 
inputsize plus the returned overflow value ret.

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..8ac3f96676c4 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ? 
+			       (ret + rq->inputsize) : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
-- 
2.43.0


