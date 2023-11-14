Return-Path: <linux-fsdevel+bounces-2838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33EE7EB3D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C12812CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5941AB6;
	Tue, 14 Nov 2023 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORV6wvIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4741AA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:48 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C818A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d81864e3fso3384863f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976025; x=1700580825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3hzPtBdsw/JTpL+pwCdFyv6BBtN1iJxhAVTSYsCgPw=;
        b=ORV6wvIpUKVmdoTb4ThUnmEeiYpeltcXrFEuYaFDq+U98Wvp4SjCkpfDcyOauJtACo
         iMFvpygrMdRKKOPdlyAvdD5BCjBlszAQr4lOUG819uqejslhj/uNSVtxUUgVi8BjlLNO
         MnKl4Rz6PAmeMwX27tTWoIHHBjzjyZV3rLm+BL5RrSbi3DmqHnblMcKDP3BwmPTXKt7X
         Rtt5L+j8C8g9fdgYdSNA5w9Vbnk9oo71gkK8YEcrHqt8JfOCgWOpuE69mYx2kpw7RH2W
         bRIdNI3U3/pem0bj0+3QuUs5hY7/60FIpFPJPCSnbZb7icUOvwJyhCFtRX05CwaFefj+
         83lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976025; x=1700580825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3hzPtBdsw/JTpL+pwCdFyv6BBtN1iJxhAVTSYsCgPw=;
        b=Qee8fpRrC7qCIg2iu/A3zdxW9aFbgK1kFHAFoBIJSD4ECPXyV3S87TZuDZWeYRM/N0
         00K32230UMFEklzb153A2rN1cMx1ra4ZB2rOHndFM3qJekJwy5V17zzxOP5W7udoREOn
         JzLywxcOM2X0hY3xorHfZs1/YTSmNzkf7wY2ojZRYWTJYKAU57it8XKXP3V7jgyuGm7+
         3qxl9OnuwFu9FXhbgrRMpo4YBv/TfD6eZDqIcsK5Mvn8eAu7bXKg2krBHxH2wMq/J6tX
         U9f5XEJqBEibGR4yics5X0c5fqm/NBNt3hnByKYVbWcRcJDPbmAybpg9Bpa9J+zB3Z4X
         muow==
X-Gm-Message-State: AOJu0YwpLVNoSa44IkWYj7fVhxWBq3Vynu3u3QB00l/PDSIu2E/ebq6e
	nhgwcxRs6tJ/H/NHc8yHDgA=
X-Google-Smtp-Source: AGHT+IGK0whVY+Vvsao8ij48zpxgP0gHJQFYOAl1Y1meqHRxZNXB/8ZE5D4JNXLSDnUMGQpX9dzrnQ==
X-Received: by 2002:a5d:4d86:0:b0:32f:7901:c462 with SMTP id b6-20020a5d4d86000000b0032f7901c462mr7824950wru.3.1699976025098;
        Tue, 14 Nov 2023 07:33:45 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/15] fs: create file_write_started() helper
Date: Tue, 14 Nov 2023 17:33:20 +0200
Message-Id: <20231114153321.1716028-15-amir73il@gmail.com>
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

Convenience wrapper for sb_write_started(file_inode(inode)->i_sb)), which
has a single occurrence in the code right now.

Document the false negatives of those helpers, which makes them unusable
to assert that sb_start_write() is not held.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c    |  2 +-
 include/linux/fs.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8d381929701c..87e1256d0a67 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1437,7 +1437,7 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
-	lockdep_assert(sb_write_started(file_inode(file_out)->i_sb));
+	lockdep_assert(file_write_started(file_out));
 
 	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
 				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e8aa48797bf4..05780d993c7d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1658,11 +1658,32 @@ static inline int __sb_write_started(const struct super_block *sb, int level)
 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
 }
 
+/**
+ * sb_write_started - check if SB_FREEZE_WRITE is held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
 static inline bool sb_write_started(const struct super_block *sb)
 {
 	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * file_write_started - check if SB_FREEZE_WRITE is held
+ * @file: the file we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ * May be false positive with !S_ISREG, because file_start_write() has
+ * no effect on !S_ISREG.
+ */
+static inline bool file_write_started(const struct file *file)
+{
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return true;
+	return sb_write_started(file_inode(file)->i_sb);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.34.1


