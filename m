Return-Path: <linux-fsdevel+bounces-599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DC7CD8BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DE0B21347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B118B13;
	Wed, 18 Oct 2023 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAEvjrQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634D18654
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 10:00:10 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553EBA;
	Wed, 18 Oct 2023 03:00:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so2462513f8f.0;
        Wed, 18 Oct 2023 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623207; x=1698228007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpDN5TJtQWNiSAgsJjoFSpeVl5Mc6XEDfVWBIiGhfG8=;
        b=mAEvjrQJM3BaQvnHq332ssLG84gfDbky393awp3ZZVzTNxBN6ZcY+XX+i7TOi+zRof
         6emDPJzPN6pJUDhi1Ysewt9UrR9zpYI9gxL2soGv0RmhZ8RWLuL1yFO6HUy7cPGZgt94
         8UuoNukevrWF25zBjG4wSKDwYyKdQWFmJni2TbgDA0RY02jXpNm6wiOuMYqD39yDnM6T
         6VQXOG0axrBztrCm9TgxCry8Q4e1sr6wP9Ru9+AKb7GuNDtCQIuDTJsZOoE1aF9oKqpj
         sTwe9OpaQGQUjayFRnbdtoNNROjIMwm1xs103Qjg1YpVi4hACNnZq42b3LV62Thq+xCy
         W9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623207; x=1698228007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpDN5TJtQWNiSAgsJjoFSpeVl5Mc6XEDfVWBIiGhfG8=;
        b=oV9NZvWkmlTQLNNe1RAqJyww8LG6EamjEYxB2bimpVPt2F75GxFBWtL+U6yiPBU9qZ
         a3h/AffuYoaJg2qJ5LSyOLn418m4bo9xmjiBaqnyH+J1fuI6yxLXTP8Pxi5O3voQhKE+
         UY1WSLTGuAU3tOo4V05coIQ2Bsa2REsPTh43yWJNOxU0JPvUh6TNEm9DWdnwLs+/iUZh
         Pwu1MMeBWwdabKdjXl2OL/Bn2oWPSuX0DuudjLXNJyLUG1CmPJcjHdhcoSVRBL2AveWo
         KDgm8lNiH039qRIMcRVSQQA18LOIP65L6UGDUffIR1WahXr1O7sErX04aLCk3vZ0Uh//
         773g==
X-Gm-Message-State: AOJu0YzUnPRMIZHVzU9rmxqCQfNpSZs48cmEWdq0S/a89X1O3mPRe4t+
	CJCldxpsEV8ZheXEIoYBx1g=
X-Google-Smtp-Source: AGHT+IFM57tNvjUDTErp8Tg2QlcT3qIfdSIDjHwtaZ3d9FJgM4lGgPV9+40qcf3qgJdGD0/lB2zbpw==
X-Received: by 2002:a5d:46cb:0:b0:32d:c5fd:159b with SMTP id g11-20020a5d46cb000000b0032dc5fd159bmr5028168wrs.4.1697623206794;
        Wed, 18 Oct 2023 03:00:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] fanotify: limit reporting of event with non-decodeable file handles
Date: Wed, 18 Oct 2023 12:59:56 +0300
Message-Id: <20231018100000.2453965-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018100000.2453965-1-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
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

Commit a95aef69a740 ("fanotify: support reporting non-decodeable file
handles") merged in v6.5-rc1, added the ability to use an fanotify group
with FAN_REPORT_FID mode to watch filesystems that do not support nfs
export, but do know how to encode non-decodeable file handles, with the
newly introduced AT_HANDLE_FID flag.

At the time that this commit was merged, there were no filesystems
in-tree with those traits.

Commit 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles"),
merged in v6.6-rc1, added this trait to overlayfs, thus allowing fanotify
watching of overlayfs with FAN_REPORT_FID mode.

In retrospect, allowing an fanotify filesystem/mount mark on such
filesystem in FAN_REPORT_FID mode will result in getting events with
file handles, without the ability to resolve the filesystem objects from
those file handles (i.e. no open_by_handle_at() support).

For v6.6, the safer option would be to allow this mode for inode marks
only, where the caller has the opportunity to use name_to_handle_at() at
the time of setting the mark. In the future we can revise this decision.

Fixes: a95aef69a740 ("fanotify: support reporting non-decodeable file handles")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f69c451018e3..537c70beaad0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1585,16 +1585,25 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 }
 
 /* Check if filesystem can encode a unique fid */
-static int fanotify_test_fid(struct dentry *dentry)
+static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	const struct export_operations *nop = dentry->d_sb->s_export_op;
+
+	/*
+	 * We need to make sure that the filesystem supports encoding of
+	 * file handles so user can use name_to_handle_at() to compare fids
+	 * reported with events to the file handle of watched objects.
+	 */
+	if (!nop)
+		return -EOPNOTSUPP;
+
 	/*
-	 * We need to make sure that the file system supports at least
-	 * encoding a file handle so user can use name_to_handle_at() to
-	 * compare fid returned with event to the file handle of watched
-	 * objects. However, even the relaxed AT_HANDLE_FID flag requires
-	 * at least empty export_operations for ecoding unique file ids.
+	 * For sb/mount mark, we also need to make sure that the filesystem
+	 * supports decoding file handles, so user has a way to map back the
+	 * reported fids to filesystem objects.
 	 */
-	if (!dentry->d_sb->s_export_op)
+	if (mark_type != FAN_MARK_INODE && !nop->fh_to_dentry)
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1812,7 +1821,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		if (ret)
 			goto path_put_and_out;
 
-		ret = fanotify_test_fid(path.dentry);
+		ret = fanotify_test_fid(path.dentry, flags);
 		if (ret)
 			goto path_put_and_out;
 
-- 
2.34.1


