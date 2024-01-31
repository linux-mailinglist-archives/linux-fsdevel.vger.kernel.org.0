Return-Path: <linux-fsdevel+bounces-9714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F293084492E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F321C21D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25038F96;
	Wed, 31 Jan 2024 20:53:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B538DDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734388; cv=none; b=M4WjDEpQDdVdd3MfN2br8+/hWpa1Zh3BLJanytwbu2JHt3uSd76VE4qh8HumTubSsnNzC0n9ddmob7NAsuXs+vMCCCRXMNztKBuqptNOEJRE52EZgPEuuBk6M618wiFzg8R3kh3NXqKCZKuW4D7XOavhc+Y/xZh0PpSzBha2jWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734388; c=relaxed/simple;
	bh=S/P24wcTvrFOg4SsS4CeD+d5rBmERutoXicKIgS4CC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7jXPigZTQRaGwXvLLzsLvXViePfcK8eD5JotWQ9Wdozc704xPjvpEvNA7u25HwuRWSn0K7gbYp3k09G0HSV+QXXQ5zd6MwY0gmU5syehM+hCwQz+QDxpwQFrvy/JRFa9Owj1ZlaYWuBcNtWfmwKgIrISujeyYcMwqb8F7QKShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so241377a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734386; x=1707339186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NnkzmgwtRA87qL5gc3Zv1AqjSPa8netVCv6+D4Bmn0=;
        b=jtaUOjcrC8W9aHzsCLR/XYPBjB3ygmm9ibH2mz+o5b/1QDyz6o+ZEwj/IgyDHwr9HY
         L6TFNX4Nnzw53Bqza+gy0ivf++V8fZYY52+svD4SRz090cXTvncWcqGKkzAP1ec6l+LB
         Vw/TIuSFqtHusMEUrJfWN+reV4NXZ//TZbV18QCXndI6LJBnwsLqitoDC78whImahcEf
         xChIzMq3baqgTPykLaynP+6HvYuTDMxSAyBNrHg4KBJLh3hljFNfzJ87m0VEuPNH0AXI
         XNgQE/9oCFyS40f8re3f7hp3bwb6DHT8VDfyag+TWxhPpCcJvyzQ1dBRoXPUzV6qSRnO
         eMUQ==
X-Gm-Message-State: AOJu0YzWYbeOwrnmkKHphQVMMvYY6MrflbLdKCDMh61WL1uwtzPTaS2G
	ZxQr0PNAq4Xr0RQ6pI2gxwUbdMcwDjpjgQI7iVGGUA+qgfcYVsv9
X-Google-Smtp-Source: AGHT+IE+UJJ0kLBHoXRlZXYYLitM5b9XaYCGpNRygRHhTLYzYjTQ+7VsN4XoL49bSlEV820gENvliA==
X-Received: by 2002:a05:6a20:8b15:b0:19c:5037:9d8c with SMTP id l21-20020a056a208b1500b0019c50379d8cmr172728pzh.14.1706734385929;
        Wed, 31 Jan 2024 12:53:05 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:05 -0800 (PST)
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
Subject: [PATCH 1/6] fs: Fix rw_hint validation
Date: Wed, 31 Jan 2024 12:52:32 -0800
Message-ID: <20240131205237.3540210-2-bvanassche@acm.org>
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

Reject values that are valid rw_hints after truncation but not before
truncation by passing an untruncated value to rw_hint_valid().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5657cb0797c4 ("fs/fcntl: use copy_to/from_user() for u64 types")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742..3ff707bf2743 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -268,7 +268,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(enum rw_hint hint)
+static bool rw_hint_valid(u64 hint)
 {
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
@@ -288,19 +288,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	enum rw_hint hint;
-	u64 h;
+	u64 hint;
 
 	switch (cmd) {
 	case F_GET_RW_HINT:
-		h = inode->i_write_hint;
-		if (copy_to_user(argp, &h, sizeof(*argp)))
+		hint = inode->i_write_hint;
+		if (copy_to_user(argp, &hint, sizeof(*argp)))
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
+		if (copy_from_user(&hint, argp, sizeof(hint)))
 			return -EFAULT;
-		hint = (enum rw_hint) h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 

