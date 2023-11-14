Return-Path: <linux-fsdevel+bounces-2839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF077EB3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29CDB20E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B441ABB;
	Tue, 14 Nov 2023 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2yynsT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D441AAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:49 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D11BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f87b1c725so3979034f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976026; x=1700580826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft2LGKKVGThLTaqBJZNAonNUXY157MwkC9X0m9a0ncA=;
        b=T2yynsT77nWATDUtpZgW43IGI6kqvLUK4sSF45qm01Nnm2O6M0LsWDjT1V3LJ6sNEm
         C+NHqXm2hu7KomMM7n/1wFo8qubAP7hKIBVkf+AxUuhW9VvU/Ie/FwlGcYAGH3VKge50
         yit3kLErS7ozwwvJ+QRYbwPlZGPyZEiwdYRZkekQxAmlde0v3k31tJKb3CGsxO48qXeW
         b8eeBqXQWoa/Q+gte9cnq0tu43HbZA8GBH1rx28fAPfPOD5v6C1qjjAGxnAgX0u1MgnR
         lhjdDpxB6c4XoqEJ+aFWbmlnIDDuy1vH6ac1dhpMkiwkkATOIeV6nJr8gHxZ+WwlPudc
         sf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976026; x=1700580826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft2LGKKVGThLTaqBJZNAonNUXY157MwkC9X0m9a0ncA=;
        b=oC/nANO8qd/O6ED+FnjCcZ8gFKntOo2NfRo7DRAhyJFVmTqitlufrD25FaUzTcyMiK
         wLu3LHarum6U/cMmvWxclUA45leezPWvrylgrhFXuAXNmucYgJ1u6s30dD2bLr/ZNypP
         AgkqsHVgrgdyDnseN7CdGfMXlPt79JgthqRkV6cqAzczYC51CKxuHPl0EU+1hCHN3VEm
         7m/ynuYbO9KuKp1s2RfGLRhscnPAPt19JAqcaK8275f9GwPE0ILXfii5GAi0O6/6to5j
         i271QSrJg1tA5ft8yBsMkHVD7Gx1UJJ2ZoAuMcoeHrNn2gjofKQ/gu04T9SHsQpWtmJ8
         G2CQ==
X-Gm-Message-State: AOJu0YzU0unxHIhobOQCTny42L1XdCPiFDQUycNR6juwkS5FCsYt4UaL
	xh5SlttNiAiKBkvNbaKubs4=
X-Google-Smtp-Source: AGHT+IG07AK4UFudeES7LTwfLoeKcL7bLEic97x3fYmywmWrs4AAVNBqJadLlsxq/cUdkBkgbHO1WA==
X-Received: by 2002:a5d:61ca:0:b0:32d:8eda:ba65 with SMTP id q10-20020a5d61ca000000b0032d8edaba65mr7020086wrv.66.1699976026413;
        Tue, 14 Nov 2023 07:33:46 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/15] fs: create {sb,file}_write_not_started() helpers
Date: Tue, 14 Nov 2023 17:33:21 +0200
Message-Id: <20231114153321.1716028-16-amir73il@gmail.com>
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

Create new helpers {sb,file}_write_not_started() that can be used
to assert that sb_start_write() is not held.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05780d993c7d..c085172f832f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1669,6 +1669,17 @@ static inline bool sb_write_started(const struct super_block *sb)
 	return __sb_write_started(sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * sb_write_not_started - check if SB_FREEZE_WRITE is not held
+ * @sb: the super we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ */
+static inline bool sb_write_not_started(const struct super_block *sb)
+{
+	return __sb_write_started(sb, SB_FREEZE_WRITE) <= 0;
+}
+
 /**
  * file_write_started - check if SB_FREEZE_WRITE is held
  * @file: the file we write to
@@ -1684,6 +1695,21 @@ static inline bool file_write_started(const struct file *file)
 	return sb_write_started(file_inode(file)->i_sb);
 }
 
+/**
+ * file_write_not_started - check if SB_FREEZE_WRITE is not held
+ * @file: the file we write to
+ *
+ * May be false positive with !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN.
+ * May be false positive with !S_ISREG, because file_start_write() has
+ * no effect on !S_ISREG.
+ */
+static inline bool file_write_not_started(const struct file *file)
+{
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return true;
+	return sb_write_not_started(file_inode(file)->i_sb);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.34.1


