Return-Path: <linux-fsdevel+bounces-10092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D464847A99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CF1F25516
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF808061F;
	Fri,  2 Feb 2024 20:39:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA764176D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906395; cv=none; b=uZA+21VLtI/5FUSz3vUA+hvtt3Ulxlj3W1VVT6Bc1zj4cjhA+stw9RM5O2a01OBuRSZiDv6e0f7eRq8lapgpUbIS5simZJIEh9LuuLmztO2fsw9mfOH9RwfaqCN/XUGe7TrE2jgRIqnXI6ESj2Kl/cwju06rV0QJnfuTPdADRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906395; c=relaxed/simple;
	bh=rOsuHbgIOOOfHazZ42+dHSV3q4tvgcje94XQjRipquc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovDwRPrjWD9L39leW+I6xkQI/qTLGymtyn7smg89NVYGuS3DBiDhkLlTRVYCQfTHojO+jkwIBGOGNQ8p5uVLNizcs5LNegsnMLf6wDg6/qPYTnaqjTyi+oFEkaOvDnJgJXkhefWtPM2OTTdN2Exl9Kk+69kV3w9rOGU21cyEbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2280367a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906392; x=1707511192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6xn9gMKxEoulxlALoe13cShfItbIgtXnuWDbuTfeiU=;
        b=lAI+KIOYh8VXggC9NIH7hLd2LOJPllCpAE1xQ8CHlxgHY5BKRHBbpRgbtheiJIB+wy
         QE1nSJjW8lgxYSiRopkaWAgf7CymqK4Z4WcrmOUxhg7SJppKoKGMWgiZvMCp6ldvponq
         GCimMdXTSen/ATGVJnISXf16Qv2bcZHgIfe8DjKtBMlXI8jS9EhchPG8srTxWHoznRaV
         SZFe6ILTy/quq+inpAnFaNlp5jtx/H45FhBRtcXCIClzG2vdFaKv9amjUt2g8qBdHe+y
         sb4YIs1TJQSZ3iUvh7eAfpWnF+XgNa5/ayHqS+KMTzrnIKKHERFug1325z8BoRYMx6tw
         8b+Q==
X-Gm-Message-State: AOJu0Yz4HpI1NUztWMhntouRXXRXhIboXZldy3E34p75N89RWwTWMFaD
	o5heVfetT2AbcUwBAlKWaVyq36fUPJlrlMu/D0dogNky5FqpBzle
X-Google-Smtp-Source: AGHT+IEZDixWzZ0iCXGrhtYC+N/N919scyzl/ixWGrMkT46jSUoF3uaTtrbr23cv6ZyV4pPzd00yWg==
X-Received: by 2002:a05:6a21:3a87:b0:19c:773c:570e with SMTP id zv7-20020a056a213a8700b0019c773c570emr4673899pzb.39.1706906392468;
        Fri, 02 Feb 2024 12:39:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUncaRIGzBeayQh8fiBp+SxQxHGTUEfegUh7SCbIlitaVd/mk1Uddsy/CWQ4dcwxXC5xjEgFcTRUKqfSsqC3mGP0rOMFjMmDPrhJnlTfeB0prp0LanME+VAzkobIfEbCZEdEYSwoHxR5mLYvMkohip4k18evnyR4DA+UnZCkuVgsCIiaJAO91YgIs43KgVNkTZiPg68v8VyJArpif2GYBibc+sKeh+I4PvaSZZQVWFrcSU6fxTfNm7qm98DbyHqd+dsjy2URgmbjUnIMi+Hq14BufgJSlkBQ9gzm/w3olQqLNYNt9V/Tg2n72rl
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:52 -0800 (PST)
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
Subject: [PATCH v2 3/6] fs: Split fcntl_rw_hint()
Date: Fri,  2 Feb 2024 12:39:22 -0800
Message-ID: <20240202203926.2478590-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split fcntl_rw_hint() such that there is one helper function per fcntl.
Use READ_ONCE() and WRITE_ONCE() to access the i_write_hint member
instead of protecting such accesses with the inode lock. READ_ONCE() is
not used in I/O path code that reads i_write_hint. Users who want
F_SET_RW_HINT to affect I/O need to make sure that F_SET_RW_HINT has
completed before I/O is submitted that should use the configured write
hint.

Cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f3bc4662455f..d2b15351ab8e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -290,32 +290,33 @@ static bool rw_hint_valid(u64 hint)
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
+	u64 hint = READ_ONCE(inode->i_write_hint);
 
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
+	WRITE_ONCE(inode->i_write_hint, hint);
+
+	return 0;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -421,8 +422,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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

