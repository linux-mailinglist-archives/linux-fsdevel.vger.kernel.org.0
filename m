Return-Path: <linux-fsdevel+bounces-48800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79FAB4A71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 06:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4978F3AA8FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 04:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6401DF982;
	Tue, 13 May 2025 04:21:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568DEC5;
	Tue, 13 May 2025 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747110081; cv=none; b=aMVgbv2a5GA3rZuRqomYO/CxyUSAdACVaQjb00rmCdGBxHYNwnk5Grfi26r9b33iYrbUP9z/xFxE6G9f7nDBut9rJ/D1Fr6s8iWT4lKtNwj/Jn80JJ4aJW+C9eNLjsi5vbuC0bRiTpDQqHx8PuYBYwhyIJTmEF04nOPYb8tI7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747110081; c=relaxed/simple;
	bh=gTn5otOlF5zzTL0QZkLNT3+sYPnG0uXEst0Vi5LwMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJHsMRhIGu9bHxk+Ds9c+MCm2ievyUEHisn92GarDnW3hXw7zfwmCv1yixAoYhoFXpq+SKyo9zpRTGFynE26EQXk9KFHYPZ2mDaB+JYK52XpbCDyFs5XC75A003l9HR79Qgya1PJZt1QTvUD89uP0QOm0mm9JKSVUrgcRAH3R1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0ad744811so38635166d6.1;
        Mon, 12 May 2025 21:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747110079; x=1747714879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8mYW0RnmDcLh17FI+aP3QrrUcTS+Begkvc+CS+eRgs=;
        b=kmUNT9r9bXTmg/fvbbgcttLWKED5JXPURGpwetRJhHMuSyh3L4qlUJhYuhfdokRD0z
         h2bsVAVUI9BkamM/1THIspD2i0q4OzP7ACJMlrA8Byr8smfNsrtcUQipE/GVQy6ClVYi
         PludNpRPMhSjZa242R5RG8B6lA+uwWF/FPBHUFXPhcZ3KIpymVhTrcGBD4y3x2B7Qzh/
         gFNTb+eB+JztxisilR4l/upt/XhBfaA2P5B78/TXWp+Wu2aDKu8nIst3rEApOnlVEu8/
         +shmPicKYZB9Jcsa2dSncVvGm83LfhsMINUgRDMhe2J0YLF5AduFTVTkjvC58Qr81P9L
         XB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY0VlYs0y5w5OS99HmZ+zMbwacuzJoBAy1imfeDIRY/NDsvyk4mOozGz1zzdPxOUwninGZFJtVnfW9YpT6@vger.kernel.org, AJvYcCWtxaDG65B4reUAHlrhpL9/0NjNUXEPYs2NEfUYJjMk8t0m5zBeMzGfVxDQtubOpyphJHXVFyqYxMyGwBWy@vger.kernel.org
X-Gm-Message-State: AOJu0YykseSBtXs/NLHMvFodQgovxgW+RN1W9uZ2DWlUu9RYYrPLZnpJ
	WbzECfIDHxwphtOrCNYrdrS86qnJyfr/NozbXvjyuLZNas1heGWxZ2SH9YQj/os=
X-Gm-Gg: ASbGnctf8pGpKQUAllDVHrvwFryJj5e96/2eVs1yni1q0S4FXS2qB82OSHthZGTgpXK
	lqiWApcQQeihlsDUzs2wZe4K+JapwEl8knRTpyZMe2BRy7P1kmt4xikhYfwmEwSOj91onBcq5mg
	n6amsajPMLY2nPop9HvpB9loG3lGuUpvpTb6mR4rDi4HGPh8LrE/II5+4quZR7f9OL90qYUpDo9
	Y5W6AAC30XD23mg1iYdCunrl6QdjF2U+oklVA0tRtrXoW9f3wO1Fvf80R6fk1ZV4rCE1rhuxtMs
	/l59VBBN2ZezU1OF0kqs1JeEaMnkHNJ+o6NOuIKM4+Z+xWtACKyS3apzc4uWLhjFOFthd0im2R6
	5+JMveGqOCAw=
X-Google-Smtp-Source: AGHT+IEMRo7qBz5//4T9GrsxwmMP1n5e0zNtrKtuKvtrb/LLpJS8yyM9kvKuhVWRK5plPkrokp+gpg==
X-Received: by 2002:ad4:4528:0:b0:6f8:8df1:64e with SMTP id 6a1803df08f44-6f88df1074bmr12479736d6.9.1747110079196;
        Mon, 12 May 2025 21:21:19 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a0c593sm61934686d6.64.2025.05.12.21.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 21:21:18 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fuse: add dev id to /dev/fuse fdinfo
Date: Tue, 13 May 2025 12:20:49 +0800
Message-ID: <20250513042049.63619-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit add fuse connection device id to
fdinfo of opened /dev/fuse files.

Related discussions can be found at links below.

Link: https://lore.kernel.org/all/CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com/
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/fuse/dev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6dcbaa218b7a1..a36c244e1a0b0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -2602,6 +2603,15 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	if (!fud)
+		return ;
+
+	seq_printf(seq, "fuse_connection:\t%u\n", fud->fc->dev);
+}
+
 const struct file_operations fuse_dev_operations = {
 	.owner		= THIS_MODULE,
 	.open		= fuse_dev_open,
@@ -2617,6 +2627,9 @@ const struct file_operations fuse_dev_operations = {
 #ifdef CONFIG_FUSE_IO_URING
 	.uring_cmd	= fuse_uring_cmd,
 #endif
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= fuse_dev_show_fdinfo,
+#endif
 };
 EXPORT_SYMBOL_GPL(fuse_dev_operations);
 
-- 
2.43.0


