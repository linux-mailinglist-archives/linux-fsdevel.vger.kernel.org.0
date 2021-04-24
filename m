Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6365936A189
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhDXOOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Apr 2021 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhDXOOQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Apr 2021 10:14:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB8C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 07:13:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u10so537957pfi.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2go4ZhUKBgQJkNmk5IcNIUhscYWPDswUCH0o0+kcIT0=;
        b=HhpH91d+PxvHwij7nbQGdQmVF2rx8D5gSLLGQA+ytX0JXicASdrctYvbJc85CiBxbc
         gVPifXrzYW7DR05vvGZ/EBfZXCOPSb5Cbu/L9/bRtdtVFIcCTQ+zEANFt/8Xqy7ZcnxM
         vMVUb2nfkKLHNe2JNJZ9w4JXyp/1hH01RdDkCdRdhjB2ly31goLd425dviX9prvOGVUO
         FiUaNCMk8ZE1U7O/miJVGPAi0qj1jSq24H5hJNEMDjNQOY3fTLqqfTZv/A/Ny640vU5v
         jHnevh56BC9s0+ygQplsWR+w2iPCvkED3ofpKsaTLgtuHlp9kf+SpwTdbaOtgQkcb0CH
         yxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2go4ZhUKBgQJkNmk5IcNIUhscYWPDswUCH0o0+kcIT0=;
        b=AmRwvcEOrkyq85LK/nKfehMzO5Vhs+/noulN7OwSxnnGJXZLh2ak+qtY++s71V1pcN
         fms2QLTXJmY/chtbHn9giPLrzjhvDFb5F/h23M4VIDg57VXB2mODLwAvL6OOY15FnLpa
         qd9i6air1EZSWesNnB8Oo3YvOQLzVgq2pxIHugHCkC8TDn2k1WlbJAwSW3FWbluE49j0
         FC5khO4QOgz89T71HgIq+VKQ1DQMkM9gANAzNSVJCPnwHUw0e0umeif5KGjwe0FntMzs
         FIxOV3msxTcTcAjHqrbQsO9o+Uw8fxrtIE97SWFYZ8EfTJItLSnpQjSMUGiR1Vgh3Tmm
         sl7g==
X-Gm-Message-State: AOAM532Sk34CciC/QIKn8RuoKKUy25ItUIQInq9ou+VWM7/9UGv0TkTN
        3cfwc+VAGVF8/uJYrCNaiSxBrtoD9+NrPvWWn1E=
X-Google-Smtp-Source: ABdhPJx+WW4HPxRMtYOrwXrm7GCK5tIoCS9fepD4i7FAoPjdUc/sOWFtbUGN4gBAHI5GSNmn9rtBXA==
X-Received: by 2002:a62:ae13:0:b029:25f:41c1:e832 with SMTP id q19-20020a62ae130000b029025f41c1e832mr9110717pff.63.1619273616774;
        Sat, 24 Apr 2021 07:13:36 -0700 (PDT)
Received: from Tomwei7-A300.local (ec2-54-255-222-238.ap-southeast-1.compute.amazonaws.com. [54.255.222.238])
        by smtp.gmail.com with ESMTPSA id b7sm7177124pfi.42.2021.04.24.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 07:13:36 -0700 (PDT)
From:   tomwei7g@gmail.com
To:     linux-fsdevel@vger.kernel.org
Cc:     cheng wei <tomwei7g@gmail.com>
Subject: [PATCH] zonefs: add uid,gid,perm mount option
Date:   Sat, 24 Apr 2021 22:13:28 +0800
Message-Id: <20210424141328.73442-1-tomwei7g@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: cheng wei <tomwei7g@gmail.com>

Zonefs has no way to easily modify file permissions.
though we can run mkzonefs again to reset file permissions but it
also change uuid that case a lot of problam.

To solve this problem add permissions mount option may a good way,
we can specify permissions when mount and without zonefs userland tools.

Signed-off-by: cheng wei <tomwei7g@gmail.com>
---
 fs/zonefs/super.c  | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/zonefs/zonefs.h |  3 +++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0fe76f376dee..188a2e7bdda7 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1136,7 +1136,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 enum {
 	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
-	Opt_explicit_open, Opt_err,
+	Opt_explicit_open, Opt_uid, Opt_gid, Opt_perm, Opt_err,
 };
 
 static const match_table_t tokens = {
@@ -1145,7 +1145,10 @@ static const match_table_t tokens = {
 	{ Opt_errors_zol,	"errors=zone-offline"},
 	{ Opt_errors_repair,	"errors=repair"},
 	{ Opt_explicit_open,	"explicit-open" },
-	{ Opt_err,		NULL}
+	{ Opt_uid,	"uid=%d" },
+	{ Opt_gid,	"gid=%d" },
+	{ Opt_perm,	"perm=%d" },
+	{ Opt_err,	NULL}
 };
 
 static int zonefs_parse_options(struct super_block *sb, char *options)
@@ -1159,10 +1162,13 @@ static int zonefs_parse_options(struct super_block *sb, char *options)
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
+		int arg;
 
 		if (!*p)
 			continue;
 
+		args[0].to = args[0].from = NULL;
+
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_errors_ro:
@@ -1184,6 +1190,32 @@ static int zonefs_parse_options(struct super_block *sb, char *options)
 		case Opt_explicit_open:
 			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
 			break;
+		case Opt_uid:
+			sbi->s_mount_opts |= ZONEFS_MNTOPT_UID;
+			if(args->from && match_int(args, &arg))
+				return -EINVAL;
+			sbi->s_uid = make_kuid(current_user_ns(), arg);
+			if (!uid_valid(sbi->s_uid)) {
+				zonefs_err(sb, "Invalid uid value %d\n", arg);
+				return -EINVAL;
+			}
+			break;
+		case Opt_gid:
+			sbi->s_mount_opts |= ZONEFS_MNTOPT_GID;
+			if(args->from && match_int(args, &arg))
+				return -EINVAL;
+			sbi->s_gid = make_kgid(current_user_ns(), arg);
+			if (!gid_valid(sbi->s_gid)) {
+				zonefs_err(sb, "Invalid gid value %d\n", arg);
+				return -EINVAL;
+			}
+			break;
+		case Opt_perm:
+			sbi->s_mount_opts |= ZONEFS_MNTOPT_PERM;
+			if(args->from && match_int(args, &arg))
+				return -EINVAL;
+			sbi->s_perm = arg;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1204,6 +1236,12 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",errors=zone-offline");
 	if (sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_REPAIR)
 		seq_puts(seq, ",errors=repair");
+	if (sbi->s_mount_opts & ZONEFS_MNTOPT_UID)
+		seq_printf(seq, ",uid=%u", from_kuid(&init_user_ns, sbi->s_uid));
+	if (sbi->s_mount_opts & ZONEFS_MNTOPT_GID)
+		seq_printf(seq, ",gid=%u", from_kgid(&init_user_ns, sbi->s_gid));
+	if (sbi->s_mount_opts & ZONEFS_MNTOPT_PERM)
+		seq_printf(seq, ",perm=0%o", sbi->s_perm);
 
 	return 0;
 }
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..234b203b7436 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -161,6 +161,9 @@ enum zonefs_features {
 	(ZONEFS_MNTOPT_ERRORS_RO | ZONEFS_MNTOPT_ERRORS_ZRO | \
 	 ZONEFS_MNTOPT_ERRORS_ZOL | ZONEFS_MNTOPT_ERRORS_REPAIR)
 #define ZONEFS_MNTOPT_EXPLICIT_OPEN	(1 << 4) /* Explicit open/close of zones on open/close */
+#define ZONEFS_MNTOPT_UID	(1 << 5) /* Specify file uid */
+#define ZONEFS_MNTOPT_GID	(1 << 6) /* Specify file gid */
+#define ZONEFS_MNTOPT_PERM	(1 << 7) /* Specify file perm */
 
 /*
  * In-memory Super block information.

base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.31.1

