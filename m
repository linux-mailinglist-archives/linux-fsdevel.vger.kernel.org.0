Return-Path: <linux-fsdevel+bounces-62579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA172B99CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143D5176E89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2A3019AC;
	Wed, 24 Sep 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aUkSWYv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E492FF178;
	Wed, 24 Sep 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716533; cv=none; b=jJmyghnEMX4IcP4mU4IMbVsuyzjc3lGW86vZudX/OL3cNs/dtM5M5k0tBNjGO9HKNoDxmCI5BKE3Tghjp0ZACVJY4N+PCgghQbqL6jTp2v+eNHjQr5BBOj7xWmUzO52zGEVesF0sfOhwM85gRMaan10SzfNdApj8h+/9VvNBLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716533; c=relaxed/simple;
	bh=bqTKrflqoFKb+KvIzK7aHbTYzdFvTkRlEkTvMK3xmps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKlqEIErgRp1LXhgUT/w8hcKFRhvK5ZhonYY57SyNv4jc3qBpZyTkXRn00xjIuKDb6C1WijrqKX15fUn6p2pX4Xt7HXFFLanNFpqJOzXXulVE9YntmEonNFgxXXt05TNDIBMlQae0irmLLrOugRUcjbDaal1zEYto2KGxG56Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aUkSWYv/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z8
	2WjIETvp5eMahxiXZwu3eU3ZUHjjoSziDDqMHpAgk=; b=aUkSWYv/0RT59CqTkO
	SmS3XJ80PXPQbo89A2dWZlfzCRAGvZEcbclr4m5XO72aX0KmRJMasP45JBeaEMVu
	/6hQWzqvd3QcQ/D5Kd56Vq8Z2QbFthvkMEelkHB/db3fTknvV4Aa7S6b//2twQzz
	Um1ihf/LPKLRO7vfp+f6VY5u0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHC9Be4tNo3HSsDw--.178S2;
	Wed, 24 Sep 2025 20:21:52 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] fs: update comment in init_file()
Date: Wed, 24 Sep 2025 20:21:39 +0800
Message-Id: <20250924122139.698134-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHC9Be4tNo3HSsDw--.178S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45KF4xArW5tr48KFyUWrg_yoW3Zwb_GF
	y5KaykCFZ5Krs7Aw1xurZ5JFyvg3WUGrZxZ3yftF9Fyw4Fg393urWqvryI9Fn8W3y3JFn0
	kr1vqry3Cr42kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU84KZJUUUUU==
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYhfSJmjT3uhjJQAAsK

From: Zhou Yuhang <zhouyuhang@kylinos.cn>

The f_count member in struct file has been replaced by f_ref,
so update f_count to f_ref in the comment.

Signed-off-by: Zhou Yuhang <zhouyuhang@kylinos.cn>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 81c72576e548..d606a86a4695 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -192,7 +192,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	f->f_sb_err	= 0;
 
 	/*
-	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_count last. While
+	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last. While
 	 * fget-rcu pattern users need to be able to handle spurious
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
-- 
2.27.0


