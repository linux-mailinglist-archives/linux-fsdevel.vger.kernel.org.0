Return-Path: <linux-fsdevel+bounces-9570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF81842EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472191F25D39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057878B78;
	Tue, 30 Jan 2024 21:49:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD77869B;
	Tue, 30 Jan 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651368; cv=none; b=JDDViuAc9uKhwcHZFxIReJgeATDqvY+aK1ACElRPsVq72HNx8bsSFwp6FxIOaokP9p5vWvAUR1feNBZooA7vFMDyr358zwRl4xv+kzkm95QolBLzWN/IBF8Rj30XOGykshveqwi4g3Qj804RavSE4QfqTkknOCpyahtr0iJl9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651368; c=relaxed/simple;
	bh=aUraGB4nf6Uln9eeyFRUAy89ikuMJcNKcTUbVm5OCLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSt9MXh/bS4y5bL/NhUyxU9lqB8uUa37stMZS0Nc3WDv3E7Vklxo5RR3KvDmryHmUnUX3UevTtNm6lYsfE2x/dG9an4oM/+Oexqim1s7LaKPXTpE0kIeNdtjAv16Yxo56nouF7dOK7/UHVEddnLcw4WruXD/Zt2z1mgyAr1q37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6de24201aa6so1902892b3a.2;
        Tue, 30 Jan 2024 13:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651362; x=1707256162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzYzr0Z0IGgZwCtLxDVA46/3tUMtgECaHnFhkVRnpJE=;
        b=pzYrKhKW2XfzhIktcXPComLlAyWEtGWeIzdbYwb1prNE4POrth9CoFRxsS/0A+I38O
         lOl5C2aJf0S/z2KITATTVEBrYNhnqXFIZsFhCmcv7LWOtDoqbNgwxuncE9HIz6CwHO9t
         wM2EoqSuekmH5keR2vlqA7qLt4qcEiR+2MYVh5fCJSUjNcNjkdNA9y8qcbSGb/P6Q94l
         /tBkQ9f5/0T4SovSHpj7OYKSnyL4YymNdZ65hpoUNcuvtj4VjGNWEejTMdbk3QTiDEcK
         9lZ7WoGE9EmZhzkh5VRAG0NfSrmh0j3B0UhHp1YYeCd7mcL+9CRKdzga0rX96Ydn5AcN
         R/0Q==
X-Gm-Message-State: AOJu0Yyb71TGSmypO10GzGCMX3l6G6WmnSCyYT8nRFgF1onzPfHLjyi3
	HnqIPmviB/269iU5ysx8o/42RyR6xGPYO2QimiFeEkrFvY/+iX4q
X-Google-Smtp-Source: AGHT+IH3Nyrm0ik/IWEOIz+yJjTthTcTqKU2AyKN2ne26b1yBqsGyZ9JYK3POGhiWCPOGt0qj2II5A==
X-Received: by 2002:a62:cd04:0:b0:6dd:a118:9082 with SMTP id o4-20020a62cd04000000b006dda1189082mr5899527pfg.29.1706651362382;
        Tue, 30 Jan 2024 13:49:22 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:21 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v9 03/19] fs: Split fcntl_rw_hint()
Date: Tue, 30 Jan 2024 13:48:29 -0800
Message-ID: <20240130214911.1863909-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split fcntl_rw_hint() such that there is one helper function per fcntl. No
functionality is changed by this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f3bc4662455f..5fa2d95114bf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -290,32 +290,35 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_rw_hint(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	u64 hint;
+	u64 hint = inode->i_write_hint;
 
-	switch (cmd) {
-	case F_GET_RW_HINT:
-		hint = inode->i_write_hint;
-		if (copy_to_user(argp, &hint, sizeof(*argp)))
-			return -EFAULT;
-		return 0;
-	case F_SET_RW_HINT:
-		if (copy_from_user(&hint, argp, sizeof(hint)))
-			return -EFAULT;
-		if (!rw_hint_valid(hint))
-			return -EINVAL;
+	if (copy_to_user(argp, &hint, sizeof(*argp)))
+		return -EFAULT;
+	return 0;
+}
 
-		inode_lock(inode);
-		inode->i_write_hint = hint;
-		inode_unlock(inode);
-		return 0;
-	default:
+static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 hint;
+
+	if (copy_from_user(&hint, argp, sizeof(hint)))
+		return -EFAULT;
+	if (!rw_hint_valid(hint))
 		return -EINVAL;
-	}
+
+	inode_lock(inode);
+	inode->i_write_hint = hint;
+	inode_unlock(inode);
+
+	return 0;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -421,8 +424,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
+		err = fcntl_get_rw_hint(filp, cmd, arg);
+		break;
 	case F_SET_RW_HINT:
-		err = fcntl_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
 	default:
 		break;

