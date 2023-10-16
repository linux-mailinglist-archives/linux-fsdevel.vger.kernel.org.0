Return-Path: <linux-fsdevel+bounces-427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4D7CAE7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6243BB21089
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB930CE3;
	Mon, 16 Oct 2023 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jio2YlHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303130D0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:19 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA583
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so4067400f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472556; x=1698077356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1N1OrLMa6t8qMkOD0BLoblqhbOaLOnVx09FMW3MOGg=;
        b=Jio2YlHjwoI3iLPfjs0HUCGLwK/jF38OIZL0LVEEc7P3wkUzYjC6sbPnToGHfyDdN/
         L4AelHpyCFIqB7zb20xI9CbRvlrGpCyW40ik9DBdq2uzxgSnkKU3zYjTxcWKxfrUtFWo
         xhedtn5YVa0MxY5u3vxwMr+oMu6yn1Q9jcD11gP00DsPWZhAquwS20oCZajU+p57RRsf
         iVT1ds9JZLbDtYcF2uDt7frIRPxVUXxX0Ok5xFFZkiWO6tKFzeBFA1MIeR+2FJcap8Ei
         kgBXiVhcgfWXpFBTYVY3OLoVqE3XocS4TTQvHVCLLepqdd3tH1OgWH0YxvOe3dJ48FUz
         tJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472556; x=1698077356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1N1OrLMa6t8qMkOD0BLoblqhbOaLOnVx09FMW3MOGg=;
        b=pRAkPzxJHHOTcQuel7zVjQ84Eb7l2ZyGa8I8Oj0aKpORiKDviqpeOSVE/ISuNSD1HG
         Z4zEKdoyzUbY3cgJb7vzX0IvgSmV6GiVdI/oGDkaiDfkoUwNgRIZne3UaIEaduFsch7x
         wcekv61ixLSOfhEko3bP4n2uGODJIgziSUI/Ip1hMdCGY9inFgI+1Zh5g8oVkEfOC+r2
         wreolDIfQH75/GYisvIcY8Gb8uLfJz+aAvbTST3t+8eFOmKJS1XRSuBlPLLkhtucYP7S
         V+tULAx8bvMHdYOrEwTuhOKX7uI7Kuk/DQgnxiyOc8Zy9ocNFwud9cYd/GLPh3M/K5fO
         gs0A==
X-Gm-Message-State: AOJu0YxshbwY3Tg1GpSqx/p/v4gLTbCIw19sRmOl8mEDNUIfLUdCoZjV
	R86FvHWauXLwniNS+seQKVc=
X-Google-Smtp-Source: AGHT+IH1VbIK5nASmREGa+PC81Bcos2E3kSV0vkRnQtSjC/5EEluRn63pxhApHxkpy3Okr7sJMoO1g==
X-Received: by 2002:a5d:440a:0:b0:32d:9f1b:3a1f with SMTP id z10-20020a5d440a000000b0032d9f1b3a1fmr6576365wrq.31.1697472555953;
        Mon, 16 Oct 2023 09:09:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 05/12] fuse: factor out helper for FUSE_DEV_IOC_CLONE
Date: Mon, 16 Oct 2023 19:08:55 +0300
Message-Id: <20231016160902.2316986-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation to adding more fuse dev ioctls.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dev.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..eba68b57bd7c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2251,43 +2251,50 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
-static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
+static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
 	struct fd f;
 
+	if (get_user(oldfd, argp))
+		return -EFAULT;
+
+	f = fdget(oldfd);
+	if (!f.file)
+		return -EINVAL;
+
+	/*
+	 * Check against file->f_op because CUSE
+	 * uses the same ioctl handler.
+	 */
+	if (f.file->f_op == file->f_op)
+		fud = fuse_get_dev(f.file);
+
+	res = -EINVAL;
+	if (fud) {
+		mutex_lock(&fuse_mutex);
+		res = fuse_device_clone(fud->fc, file);
+		mutex_unlock(&fuse_mutex);
+	}
+
+	fdput(f);
+	return res;
+}
+
+static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
-		if (get_user(oldfd, (__u32 __user *)arg))
-			return -EFAULT;
+		return fuse_dev_ioctl_clone(file, argp);
 
-		f = fdget(oldfd);
-		if (!f.file)
-			return -EINVAL;
-
-		/*
-		 * Check against file->f_op because CUSE
-		 * uses the same ioctl handler.
-		 */
-		if (f.file->f_op == file->f_op)
-			fud = fuse_get_dev(f.file);
-
-		res = -EINVAL;
-		if (fud) {
-			mutex_lock(&fuse_mutex);
-			res = fuse_device_clone(fud->fc, file);
-			mutex_unlock(&fuse_mutex);
-		}
-		fdput(f);
-		break;
 	default:
-		res = -ENOTTY;
-		break;
+		return -ENOTTY;
 	}
-	return res;
 }
 
 const struct file_operations fuse_dev_operations = {
-- 
2.34.1


