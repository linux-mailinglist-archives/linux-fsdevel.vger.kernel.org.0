Return-Path: <linux-fsdevel+bounces-36398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E79E3504
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FD6283306
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6019049A;
	Wed,  4 Dec 2024 08:12:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49919007E;
	Wed,  4 Dec 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299951; cv=none; b=UkI06YbnjCm16zccB25EUa5kDpxpyMptDG5hqEEYAwRsaZiHB8wy2YCtWPbnBsR9L8jSpRhmnCG5vmtTgL9Rryzx2qyzkYkTuZbQxB4PJLkdHu4XkoKjHHX5R5pjKWIeDmPewR6axUZHArPGkYnRrywSyYvXfhgd0m9TwheQCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299951; c=relaxed/simple;
	bh=GeFM/xH0tKNi94sU/+TfZ0U9KtfraaivXUrHpsX1vYA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ii00b+uUzb3pq66iTToeXL0xvKAK+dXpIKJHhxEGp0wYRXy+afQYcX38tP9AqPrdNw0UH02RcNN3JiEf0Fj0ftKgwiAJ3hFHtwDLeMQSKLd9d5CljEi4tI3r9yUGd+qoFHh8C/rzn4DHU80/bDfZ9fMTP8J0acknc+sYr4zykqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee867500ee168d-066d9;
	Wed, 04 Dec 2024 16:12:20 +0800 (CST)
X-RM-TRANSID:2ee867500ee168d-066d9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee267500ee37cf-62b8b;
	Wed, 04 Dec 2024 16:12:20 +0800 (CST)
X-RM-TRANSID:2ee267500ee37cf-62b8b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] fs: Fix typo in pnode.c
Date: Wed,  4 Dec 2024 00:12:18 -0800
Message-Id: <20241204081218.12141-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The word 'accross' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/pnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index a799e0315..eb343be54 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -611,7 +611,7 @@ int propagate_umount(struct list_head *list)
 				continue;
 			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
 				/*
-				 * We have come accross an partially unmounted
+				 * We have come across an partially unmounted
 				 * mount in list that has not been visited yet.
 				 * Remember it has been visited and continue
 				 * about our merry way.
-- 
2.17.1




