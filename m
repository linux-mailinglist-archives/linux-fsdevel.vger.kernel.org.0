Return-Path: <linux-fsdevel+bounces-2832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98B7EB3C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3621C20A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2FB4176C;
	Tue, 14 Nov 2023 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrHJ61R1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82B41A8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:40 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF473D4E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40a48775c58so34704205e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976017; x=1700580817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLj8uITMaHbDVaMNTE6BTJPGFIjLXPD3jxdcRTn/PUQ=;
        b=GrHJ61R1QLKk1ERlNJVDRh6S6sRiRV7r2sskR91ifCH6U/8VTXCeX9D7Eupo+qlIFp
         kYblDMWPb7vx+iesCyGiAxWRRUVJIsDcKXioPJqzTnlfnjn6FwKxV4qcuiCjpZ9zuoFA
         oUVIEhIqcglmuCMwc4lEXaRiFXdCgiLEKvr6aCfanE4G6V9pMx1ECD0jDU4t76+AJW/X
         nUfG/ihq99hY/nbgytqNjHXL8aJq84MA8G3GE1tfccYmiFKdpc5/I9Ku1J/iXWWioBO+
         l06LOlBhucSRh8AK3ft9ipE9dDdEzMNUEgpMdEENCQTq5kmG02m7u752kAeoGJwMFnm+
         ISAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976017; x=1700580817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLj8uITMaHbDVaMNTE6BTJPGFIjLXPD3jxdcRTn/PUQ=;
        b=RAmTSrwXS6Hg6v13ClkuTEHRJfVJ1AfoZv/iircn9udLPyUjpGA/ubn1rviYG0jZCx
         CS+AI2dNYfeLPApcUR74sxUljhnOfcGllqTWm8DoiIItYi2niCzB4WINvP8nHVFuHqID
         2O4Yd3Gc4HFYxMElX/ELUvbljVJ2hAlct5DjUPZ3UXANJ/LcmODmtalFtklug73+Y3ci
         ReP+d1/zh67w3Sm4VqMrcNrEk4ZBJX9lo3NKMp75bowffldhEL/PjIpbfx4k/u4ITInV
         YfNo1vmUgpm5VANvMvRzinrhyF4FrAsKliJAZZvPsN2qY5RSFJ2lstVyqX2NtvvVHpgo
         wMFQ==
X-Gm-Message-State: AOJu0YxBv78RVYIdk+tfLPAyUWoa/EARRjtqdFgjAFQlKZDpuZVp7M1q
	5iPnmAUF8CSFHdZ4pz8vjhg=
X-Google-Smtp-Source: AGHT+IEpNpsELvLtEcJxjqdtVUfftPNLrF/sXUfSwf84OW1TDrkKRILvpTxSBYNq0w8+x8/vNDJV4g==
X-Received: by 2002:a5d:68c1:0:b0:32d:90f7:ce4f with SMTP id p1-20020a5d68c1000000b0032d90f7ce4fmr6949257wrw.38.1699976017136;
        Tue, 14 Nov 2023 07:33:37 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:36 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 08/15] btrfs: move file_start_write() to after permission hook
Date: Tue, 14 Nov 2023 17:33:14 +0200
Message-Id: <20231114153321.1716028-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114153321.1716028-1-amir73il@gmail.com>
References: <20231114153321.1716028-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vfs code, file_start_write() is usually called after the permission
hook in rw_verify_area().  btrfs_ioctl_encoded_write() in an exception
to this rule.

Move file_start_write() to after the rw_verify_area() check in encoded
write to make the permission hook "start-write-safe".

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/btrfs/ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 752acff2c734..e691770c25aa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4523,29 +4523,29 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 	if (ret < 0)
 		goto out_acct;
 
-	file_start_write(file);
-
 	if (iov_iter_count(&iter) == 0) {
 		ret = 0;
-		goto out_end_write;
+		goto out_iov;
 	}
 	pos = args.offset;
 	ret = rw_verify_area(WRITE, file, &pos, args.len);
 	if (ret < 0)
-		goto out_end_write;
+		goto out_iov;
 
 	init_sync_kiocb(&kiocb, file);
 	ret = kiocb_set_rw_flags(&kiocb, 0);
 	if (ret)
-		goto out_end_write;
+		goto out_iov;
 	kiocb.ki_pos = pos;
 
+	file_start_write(file);
+
 	ret = btrfs_do_write_iter(&kiocb, &iter, &args);
 	if (ret > 0)
 		fsnotify_modify(file);
 
-out_end_write:
 	file_end_write(file);
+out_iov:
 	kfree(iov);
 out_acct:
 	if (ret > 0)
-- 
2.34.1


