Return-Path: <linux-fsdevel+bounces-2837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9137EB3CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A59B20E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1841AB0;
	Tue, 14 Nov 2023 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFU5KVAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809741A9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:46 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8571125
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f70391608so3310005f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976024; x=1700580824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/NtyG2csDvfekP/QlGFua/QNT8LSYgZ+R+0ttn+W20=;
        b=CFU5KVAec+jvKFR354SkFSJSb6pihnEUpk2TERMlWvQNMzbnHyl/6TSbJFv7WAwrOw
         TAJIEtQkZexiayOa0ryk1V0GM+5orYDuC7kje5xgrVGDd8PWhfRbSoq+0v9SmMp8Od18
         P8/IpI9YOyoDdRa31FpGVPy4Jke0isbH7yGb9s9Lne3dpXfKUcxmw8gmN/w3k01XDoKU
         nRu6CJsiVRLQ+PLuKYWtaa//ahXAA9zvM9N+clcQjAshGyTBtFNX/JG6kOJxiTi60Ejm
         d7r/VDmFNiuZIWSdb9ZJYSVD97LUUykU93Yg5xTMReOj51w1R2QkyZtzFSXGCZJPYNvu
         ywew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976024; x=1700580824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/NtyG2csDvfekP/QlGFua/QNT8LSYgZ+R+0ttn+W20=;
        b=rw4fMgY3VN6gU09KJ1uq1LAsVzCPaCKuCjq08jAEmTUu3AQwUwUm5iu7N9koXjT1KK
         ED4IP4NyA3pptFNj7ttG9YcPNqVnR50QTmNe5AHK7qE9sQHLbugwXLzdJymFJqOsVThG
         8zwHU5aLirB7cR6ZJNbxiRob+zgX825dDBjB6aZDsRp+WQlz60RsJlv0U0d+2ujJRogu
         jv/I4FdYK6PiJvyhOWbhQNZlWVqfcScFRAe0wpXPhURNEM09xPCtukVrF0VEMT6ZZqJi
         802P7H1ZE8H7bUriNCpPFI3GQ1OrSe3ejIP9KytG3QrIqs4uQXHf9T0PQ8bCbYHwLDce
         lZLg==
X-Gm-Message-State: AOJu0YzVlaXJ42n+6IKkXIXpY5Am/h0pubMtIr8iJRm1xWDbl+PotvvE
	C/a9scLL+h9O0lL9FKf/7X4=
X-Google-Smtp-Source: AGHT+IEihqTjI+r91mJTVBwN7rnBfbqwX86e1l1Ha/rtO9ETz/GeEg5SDp7OimI6U06dHE/X40cmHw==
X-Received: by 2002:a5d:64af:0:b0:32f:7cba:9624 with SMTP id m15-20020a5d64af000000b0032f7cba9624mr7762493wrp.54.1699976023756;
        Tue, 14 Nov 2023 07:33:43 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:43 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/15] fs: create __sb_write_started() helper
Date: Tue, 14 Nov 2023 17:33:19 +0200
Message-Id: <20231114153321.1716028-14-amir73il@gmail.com>
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

Similar to sb_write_started() for use by other sb freeze levels.

Unlike the boolean sb_write_started(), this helper returns a tristate
to distiguish the cases of lockdep disabled or unknown lock state.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..e8aa48797bf4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1645,9 +1645,22 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+/**
+ * __sb_write_started - check if sb freeze level is held
+ * @sb: the super we write to
+ *
+ * > 0 sb freeze level is held
+ *   0 sb freeze level is not held
+ * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
+ */
+static inline int __sb_write_started(const struct super_block *sb, int level)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
+}
+
 static inline bool sb_write_started(const struct super_block *sb)
 {
-	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
+	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
 /**
-- 
2.34.1


