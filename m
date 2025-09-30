Return-Path: <linux-fsdevel+bounces-63067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D91ABAB28E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 05:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA0119224F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 03:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0821234984;
	Tue, 30 Sep 2025 03:33:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D858145B16;
	Tue, 30 Sep 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203208; cv=none; b=OaPdamL9IQMOCfiJMnt1QoTG66J24GTb5SIdWr6leydJbMfaHEBlSlJyDFFD/b26esjx/ClFNvVKPjFV+Gyepcz88td/G7kCVeQeVK+1EpKvy+IGUJragFFjEM8XdinIv863WCprZaho2fEvuZENYE+Av+Jvr3Z19GTfZvvUWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203208; c=relaxed/simple;
	bh=CFEoobQDWm/M0bpbWEo+5KfpmvxqWuqu9AoEET/7dXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLhaKMkZpqW3cyDgzPyl9YACn+eDY5s19TaOAcdk4NEmnzHxNkYFmlDi+Fa86sUW3AbGCO/eQXohue8mTyCOorzqKMFbwGLECi8VsDIfkujggD9dJxJ3y6qLl5Eq5zOiBgc/TQqIWz+lEaXP8O/kO6p8GDYFeDAda9umGL8N0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202509301133107999;
        Tue, 30 Sep 2025 11:33:10 +0800
Received: from localhost.localdomain.com (10.94.8.225) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Sep 2025 11:33:09 +0800
From: Chu Guangqing <chuguangqing@inspur.com>
To: <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH 1/1] fs/dax: fix typo in dax.c
Date: Tue, 30 Sep 2025 11:31:54 +0800
Message-ID: <20250930033154.1083-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 Jtjnmail201618.home.langchao.com (10.100.2.18)
tUid: 20259301133107c9b2836e74e50552f46e3bf6bf2ab5d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The comment incorrectly used "percetage" instead of "percentage".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ac6d4c1064cc..8f6a8bc1bc82 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -25,7 +25,7 @@
 #define FUSE_DAX_RECLAIM_CHUNK		(10)
 
 /*
- * Dax memory reclaim threshold in percetage of total ranges. When free
+ * Dax memory reclaim threshold in percentage of total ranges. When free
  * number of free ranges drops below this threshold, reclaim can trigger
  * Default is 20%
  */
-- 
2.47.3


