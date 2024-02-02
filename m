Return-Path: <linux-fsdevel+bounces-10090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC93847A97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4964928556F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5F7D40F;
	Fri,  2 Feb 2024 20:39:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC627473
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906392; cv=none; b=Kbc37x+tiIPcu83l1OAVasiYCXK0XgSzGLk+xPryUQuT6OnTuZwlD1V48ZOESKuPY6zpTgAf8d3o75kdFVbIkDN1cMHBxHyw7P5xDRfBF/vQnoVLsjDbF6+vyQmGENKIGWwcWTERqbf/9jPuNTKZQpNNWEiASM2VOc6e3ftgdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906392; c=relaxed/simple;
	bh=S/P24wcTvrFOg4SsS4CeD+d5rBmERutoXicKIgS4CC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrjwE775J3pC/xf8mQlvn8l1fbATSU9dsxUInCRZxzQQ0oSOI8IBrHcQ9G0HXnyZ0us7HhkrZUjQY17HHPunanhlwpJ08Au+koLMmzsW7YNMT2oZUuFt2/0pQADxxk1pOSEtu4g5UelM128rq6gtU/nAN3P1PFZZWO8YDU6qK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2114177a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906390; x=1707511190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NnkzmgwtRA87qL5gc3Zv1AqjSPa8netVCv6+D4Bmn0=;
        b=pK4uEGrv3WJZOX5tjzCFybxZOt58/g4TVcY0m+nmqIo4zd1NEZ28eBcdmfeAd1dQaO
         G4ffk22KJ8NszXhb2frh+qS3TD5Hy4pO497+MDLEnV71D7Bp1DeyjRQuyZs2Gfebh3kK
         ydd7qtcvSwAhwEbY8oCQOfDuXGmgYWufNDtPFwrsgDCUQKZjz7t7xUOrk0ImBkQnxbyb
         BRExVnOAUr6YYL/sUy3qcmVoeswPwFRjlaQmkSHTyyNSO5rftYYD0rA4LtDJDPwXkeMh
         GMwLof4i3W33GLSuGesww1kq3eIZtr35cTDDLbmZc1hl7BDVq+7REoWpfnXRxLjiLYj7
         clrQ==
X-Gm-Message-State: AOJu0Yxs8t8zCS5nU9sgEiIes7vg+pA0G7eMZq/iUughPW3PDDe0uAae
	ETSaGBRcGo9pj/yYrTU1oTbRPYdw8rKw+o5N1j5qnQoO6lImR2gCryyc1zz9
X-Google-Smtp-Source: AGHT+IFdqP0z/gU3IvL8+rnfoqhKjtbvkS0EKyYR5LHDkyg6HMGJNj0WB1TpmUPN1RFpvYQwWdzh8Q==
X-Received: by 2002:a05:6a20:43aa:b0:19e:4457:ff59 with SMTP id i42-20020a056a2043aa00b0019e4457ff59mr7428069pzl.14.1706906390170;
        Fri, 02 Feb 2024 12:39:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4qh7hwpGA1mEauLIIv6VZT3Q/g5lecaVas5dbxZZpUBIpGgCC2SiTNqm8qB5OsYMXQN9iIrTdxo7w5TTvAvrgC/jgbdPcqFwuVrIp06fGf3t6fdAc039Y8whOXRQRIvPJxSQXYxGvUHf16V3X1DGTcz+rDjVNXwgzB29vNgn18yt860hxAz/Pw55TDZdY1/IYVf/4Bjkhj2MOD+Ksrvm21mAFC+CT2rzZt3UtRjWhA+tne09WoTBMyjBxp0SZDuYaHmxPGFALCj/vfZQFTbLT3q1u8cf4aFgZird3WgUfvsiparFvxlJEwKqD
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:49 -0800 (PST)
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
Subject: [PATCH v2 1/6] fs: Fix rw_hint validation
Date: Fri,  2 Feb 2024 12:39:20 -0800
Message-ID: <20240202203926.2478590-2-bvanassche@acm.org>
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
 

