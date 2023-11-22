Return-Path: <linux-fsdevel+bounces-3410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F697F4629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E304281340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6994D59B;
	Wed, 22 Nov 2023 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg/P0nIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65F10C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4094301d505so30895715e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656051; x=1701260851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+50G3iSMGndzTNZtC9KY0NtlK4z/o7OD8UDWkOsgAU=;
        b=Tg/P0nIKolHrO5Ltm/Jdm4++OMrVeQvcuYbDt6BFDivyRhiIvztlLoYoLM0yyJPpwd
         Cyk9SyOTfQl0hmBjnpmW2e4N7bgJFLIr/HQ22xtZnlpj9jRjYvlzGIW4To9bzSYnGak3
         QO8KS097HjyNTIA63ZuXISDs0JYpVwMhDKy/QOHjhBa/xGhMZJRhvAgqsrwza6W/jMAM
         v1WNR6ObluX4PVUockwB9JidP8r/BOnQf2+1eJkIRpnHOwY6xlNZSTdLLHnSojRH/PqS
         m5eu9VZuGOFkHf4oTXCsTSIEaei2kyOt4xgTKWhDzgetZuRLBTeqkHOHpnvowgsqIMzW
         28tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656051; x=1701260851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+50G3iSMGndzTNZtC9KY0NtlK4z/o7OD8UDWkOsgAU=;
        b=U/J3rQcQLV73UUadtndw136OWHb6+a+XK+pxINyOnL6ON9Cscp1/gifI7qz8sN325E
         V+UzE2Ywm2bO0suh4WQZ4aLXf+HQqnxqavIytiHx6z+8mQYXQxOYYYbSRBOS8EtgHNJ2
         9bSVCHIurXh0XVL3KXYd309csliRlR6+GupglwuGuymiA+22gW2SHQj26hodskwJdG7n
         mwJ5EzVfItFHHitEy/f6ZpF3dE+4NVmfN/UfBO1Vpc/Jklqr8Inl60ppzk1fpWHVYd8K
         GlboILKE9y1XFhxkcUQKsmfG5tMeNctdIggxs6a3Ci/RcoQ9TnYIfg1SXk3+rmImLbdc
         H1SA==
X-Gm-Message-State: AOJu0YzYTpFKheT3QiGS0qqhKx0wsYdoxMzVa39fZaM67ULmjV9/5JUF
	e5iW7xNEUmuU/lzybndZC/k=
X-Google-Smtp-Source: AGHT+IFVHVnChtRTtC/irBPTGNet+PFAT5d9ZCbFekqyOa7VFb//Z69zu9igYLW5Ph/Dx5eyyxLA6g==
X-Received: by 2002:a05:600c:3b97:b0:401:d803:624f with SMTP id n23-20020a05600c3b9700b00401d803624fmr1950975wms.4.1700656051647;
        Wed, 22 Nov 2023 04:27:31 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:31 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/16] btrfs: move file_start_write() to after permission hook
Date: Wed, 22 Nov 2023 14:27:07 +0200
Message-Id: <20231122122715.2561213-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/btrfs/ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfe257e1845b..0a7850c4be67 100644
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


