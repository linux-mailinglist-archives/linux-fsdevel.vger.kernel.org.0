Return-Path: <linux-fsdevel+bounces-32543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCD9A9581
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45AC1F22D9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 01:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163B612E1CA;
	Tue, 22 Oct 2024 01:38:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CD2AE7C;
	Tue, 22 Oct 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561137; cv=none; b=RMofTQUzLZJiNGWAEewCsTRJI6fboQTY2SGSN9BUhIme5t6bQU3IHe8jhOErAGjJoKagCxL8YNL+fopv9IbIJWN3vS2gMKWziqpMdrZMmnmm0DBVbr/NuoGLVQoHINDC3GU17I0AnbcFW1LbHddkMcxzHRgUhSzJvO1U9lXiGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561137; c=relaxed/simple;
	bh=EAE6dlldhalsC3j55bduOLp/lHd3aELx7JoM3R38/Qc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUF2sbDq/T+tCWCOXgu2DJwXkZMQEkE3bKaEdm9HZ7vJP5CcHlw2+KsdQ+gbOIjl+vEbVFGlzmtdZBB1trcAQs1TfghGqVGHe57pn18X8RhyFuK/4UxXT1GUr/15gGea/Me4HcgWTAbEqWWd9Zk+R/EznURnx+qFgwOglpT1QVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXZXl0r7RzpX9R;
	Tue, 22 Oct 2024 09:36:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 506611800DB;
	Tue, 22 Oct 2024 09:38:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 09:38:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <dhowells@redhat.com>, <jlayton@kernel.org>, <corbet@lwn.net>
CC: <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH] doc: correcting the debug path for cachefiles
Date: Tue, 22 Oct 2024 09:38:12 +0800
Message-ID: <20241022013812.2880883-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The original debug path is under "/sys/modules", that's
wrong. The real path in kernel is "/sys/module". So we
can correct it.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/caching/cachefiles.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index e04a27bdbe19..b3ccc782cb3b 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -115,7 +115,7 @@ set up cache ready for use.  The following script commands are available:
 
 	This mask can also be set through sysfs, eg::
 
-		echo 5 >/sys/modules/cachefiles/parameters/debug
+		echo 5 > /sys/module/cachefiles/parameters/debug
 
 
 Starting the Cache
-- 
2.34.1


