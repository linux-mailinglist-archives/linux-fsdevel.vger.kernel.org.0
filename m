Return-Path: <linux-fsdevel+bounces-9716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C9844930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11ED28DD7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2A338FBE;
	Wed, 31 Jan 2024 20:53:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73238DDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734391; cv=none; b=tEGOOxSqnW5MOAxGbvY9ynBLCdYwcqe6H7jTRFf4Y+J7s+NCNGJmnxw3tGe0NoNi0QXNp3JWGNjZdV1NZZgXNpJcMIAmbkCBVpCaXBdvKBs7oYXD9mMASunGXx8Zhftb44SIidLUefees2w3v2qmyaHFUnibA1/sV4vJuQINglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734391; c=relaxed/simple;
	bh=cy2v+uThw8Y/HPBCNLskDXnVfR9wp+PMesjqdm7xfMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGu64zqQpj//Oao8yMiVyMiXblHgeNiq5Qb0vAPjPr3W25ZBGqL2GMqSgzPF53fvWyBBohpaI9paXEXZIdKK9rMHSjolchcLQMYdhYwsFVW4EacH/Cs5m8pL/4WsUhgltGQ5y/VDBLpXDo2FYfpnWZXLBtXU0ur1RDv7w0o9n4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso111394a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734389; x=1707339189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+Bs4pKxgGTdzOZDEst+uV1iftPjS+z9tfcTtKkkLTw=;
        b=pVUKG9DKJ9MuDEZ4jEYKBq+IeLy6Yuqu+rO1sVLq1QglikWnfwDkPtRxtksFRBrwOn
         PtzI2lB2KwocYssD7P4jxf1M+kxcEQadSH3zLp40F6hM5tMA7kvnTd/WWSSHmdNu8rYo
         KueToFrk05f1MUWVmJASHw9IxLZv6SiZmcbc1G1QHBYrmhzwPfLBw9leOE7jyawOZemn
         HstXtVdj4fWriqleX7Q0rhMq5owxXqyycSaox1AskEYrtjyl0bPI/W2E7+xICMt+DCpf
         Awj//8+51WiycT6QMX9+4O4ev8L5wWO4pK5ZowR0yGv2veddZFllV0a54s/dLazrfxjV
         l6nw==
X-Gm-Message-State: AOJu0YwV8pSvvtFKN05HweNdTulmudaeCVe94Qe22PhWqrsgpRpbRDBA
	0LXaYkfCclYOBJ3lQiEsAdIXf5Gb595cssIfxejzNyC+2lYyPGzjP3nl9Xb/
X-Google-Smtp-Source: AGHT+IGvz4l8RQ/ic/j4ydN9LbepFI88Xy7ZivcBOPEGak97rysriBxp07XHremho1ALJ55p20p2zw==
X-Received: by 2002:a17:90b:364a:b0:295:c64c:fe53 with SMTP id nh10-20020a17090b364a00b00295c64cfe53mr2841696pjb.16.1706734388926;
        Wed, 31 Jan 2024 12:53:08 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:08 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/6] fs: Split fcntl_rw_hint()
Date: Wed, 31 Jan 2024 12:52:34 -0800
Message-ID: <20240131205237.3540210-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131205237.3540210-1-bvanassche@acm.org>
References: <20240131205237.3540210-1-bvanassche@acm.org>
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
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
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

