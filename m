Return-Path: <linux-fsdevel+bounces-26094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358799541B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4983B24224
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45E81ACB;
	Fri, 16 Aug 2024 06:29:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95134CD8;
	Fri, 16 Aug 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789759; cv=none; b=olP6OljEDzXqhYT/pJOUKhYdNGnwwkl3E1HAWHiGm6KGf8Sn9ig/vZ+VStKwFUZJm97wJW/KDUBOav7uEd513AH4OwUybMCiMNsYghsQeaX29WdAGJLBtlKNgP+SmmerPaTNFUaXFHca5/xh92qq9ygvpyhrN9MPs0e4SzpKWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789759; c=relaxed/simple;
	bh=Nk/oAJHeoR3UNAHXuf5d7XyKYVq6vYFewZVqzgeyxEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPI80x2pO7p8Pw2fXMTK7z1QE24gt8RVOzNqMUNvfzACrz78eRhEPnNDHb6XzyiQCbCwAgs4k1bFN/XFjQl3ssGtZBacKopreFMp6ZrmVyqAYI6GGTGYtHcwKd2EwfgexcX2ACokWI8WuRvdVlz7EAQtKIjTMEGEu+72V3IFJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WlX8f446dzhXsp;
	Fri, 16 Aug 2024 14:27:14 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A600114037E;
	Fri, 16 Aug 2024 14:29:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 14:29:12 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <sforshee@kernel.org>, <corbet@lwn.net>
CC: <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] doc: correcting the idmapping mount example
Date: Fri, 16 Aug 2024 14:36:11 +0800
Message-ID: <20240816063611.1961910-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

In step 2, we obtain the kernel id `k1000`. So in next step (step
3), we should translate the `k1000` not `k21000`.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/idmappings.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index ac0af679e61e..77930c77fcfe 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -821,7 +821,7 @@ the same idmapping to the mount. We now perform three steps:
       /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
       make_kuid(u0:k20000:r10000, u1000) = k21000
 
-2. Verify that the caller's kernel ids can be mapped to userspace ids in the
+3. Verify that the caller's kernel ids can be mapped to userspace ids in the
    filesystem's idmapping::
 
     from_kuid(u0:k20000:r10000, k21000) = u1000
@@ -854,10 +854,10 @@ The same translation algorithm works with the third example.
        /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
        make_kuid(u0:k0:r4294967295, u1000) = k1000
 
-2. Verify that the caller's kernel ids can be mapped to userspace ids in the
+3. Verify that the caller's kernel ids can be mapped to userspace ids in the
    filesystem's idmapping::
 
-    from_kuid(u0:k0:r4294967295, k21000) = u1000
+    from_kuid(u0:k0:r4294967295, k1000) = u1000
 
 So the ownership that lands on disk will be ``u1000``.
 
@@ -994,7 +994,7 @@ from above:::
       /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
       make_kuid(u0:k0:r4294967295, u1000) = k1000
 
-2. Verify that the caller's filesystem ids can be mapped to userspace ids in the
+3. Verify that the caller's filesystem ids can be mapped to userspace ids in the
    filesystem's idmapping::
 
     from_kuid(u0:k0:r4294967295, k1000) = u1000
-- 
2.34.1


