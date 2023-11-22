Return-Path: <linux-fsdevel+bounces-3406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5977F4626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706281C20912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11D4B5A1;
	Wed, 22 Nov 2023 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy1gHmSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA299D52
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4079ed65582so30967695e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656046; x=1701260846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfKpdV7Y9JZ7C1ARJf/yitGgvxxXUHvlJXKQ56trtC8=;
        b=cy1gHmShEje0Vcz+rEx6trUjQX5lPxXqVO+qLaMSIaesI+gTH+7+CAB4nHnpSMDqbt
         1+IomMpcQhSJojwUrRkdujM5d/bKbedVZvH6UPsmVZF1yVsIyDz567E1yFi0rDV6BRKt
         WTtX7ZSfMvCjNwkWAsvKbhaFTpI26Q/3h9iwLMpBDPDESVKij+FRt1L/Cgff+IrNNATy
         8KiiEaCG5tRaOH6NJKEaiXYAsj1atMKr0JK1ZEeWCoNoKSaGbR2Pf7HvjtlLaJ0civhp
         Nzxzpt6nH5ZYgjRaq39Es342IQvKXSQHau2W4H8W/czUQu3za3hDahkoXqXatkhuCRo/
         Di6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656046; x=1701260846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfKpdV7Y9JZ7C1ARJf/yitGgvxxXUHvlJXKQ56trtC8=;
        b=ihuou/Qk60/2co96QIS7Ohv/rlRFfJgamuL6W4Y+GuOBankSJUF/5f7Roh35+IK5PO
         2pb/u2RBk9y8a9CoQ5SRlWbBpEKxlahrpaKBANgdkQ2v2cMqRsjQbAYrYH/RhxbQd2lZ
         ipQBr7MBKd/5dp6+TkuuGhlRRa2lT0GEqqzM3lS5HYzVA5gjPfXiFzlAy3sff21uMQOE
         mgzklYBXhz9guY8gm6dSfoJ5hBKvKX+J8FOGdJna9mEImdGkmGHsT5rhtiWdB0Xom+Nx
         K4NSCZ9YxYwGGWAMlWlkOTusthendK4fAZDgsrBt3UzO1p2/Q6TzmvRVuuaChKPP/BiW
         ftwQ==
X-Gm-Message-State: AOJu0Yx46Y/WzY4eQ+FDxnJiygN3T/p6ZiC0Dao2zKt41q9s9uGBpqPc
	mSQ5Ac+Jb0u/1Ht0cENCKRY=
X-Google-Smtp-Source: AGHT+IG9OdLYHRegT9C7+YhO1QJR9u/Dq2J6OOhylKhi1mMiSnTnYChjbhq84OUdvMTbJzq5BcHeCg==
X-Received: by 2002:a05:600c:5492:b0:40b:3369:d797 with SMTP id iv18-20020a05600c549200b0040b3369d797mr928199wmb.21.1700656046141;
        Wed, 22 Nov 2023 04:27:26 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:25 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/16] splice: move permission hook out of splice_file_to_pipe()
Date: Wed, 22 Nov 2023 14:27:03 +0200
Message-Id: <20231122122715.2561213-5-amir73il@gmail.com>
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

vfs_splice_read() has a permission hook inside rw_verify_area() and
it is called from splice_file_to_pipe(), which is called from
do_splice() and do_sendfile().

do_sendfile() already has a rw_verify_area() check for the entire range.
do_splice() has a rw_verify_check() for the splice to file case, not for
the splice from file case.

Add the rw_verify_area() check for splice from file case in do_splice()
and use a variant of vfs_splice_read() without rw_verify_area() check
in splice_file_to_pipe() to avoid the redundant rw_verify_area() checks.

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/splice.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6fc2c27e9520..d4fdd44c0b32 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ long splice_file_to_pipe(struct file *in,
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
 	if (!ret)
-		ret = vfs_splice_read(in, offset, opipe, len, flags);
+		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
@@ -1316,6 +1316,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 			offset = in->f_pos;
 		}
 
+		ret = rw_verify_area(READ, in, &offset, len);
+		if (unlikely(ret < 0))
+			return ret;
+
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-- 
2.34.1


