Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20CD1514CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 05:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBDEBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 23:01:16 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53812 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726924AbgBDEBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:01:16 -0500
X-Greylist: delayed 2198 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Feb 2020 23:01:15 EST
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0143OaqF022223
        for <linux-fsdevel@vger.kernel.org>; Mon, 3 Feb 2020 22:24:36 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0143OV5i021594
        for <linux-fsdevel@vger.kernel.org>; Mon, 3 Feb 2020 22:24:36 -0500
Received: by mail-qt1-f197.google.com with SMTP id g26so11425170qts.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 19:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=V0/IZKokpuyk/X3Vu3SualtRqH1dQKvBg/2kFPFAJ0I=;
        b=jxwYEm1e3ep2XgGY8WHf8Px6phg/BPplOLieRqH5ECEryqnS/3pJN2LdYcHZTCS+86
         /uEaQ7Zz8D3yX53s8NQsiE5OIY2OuqNyX4yzf7RpLvqRFwjh6LodhCJ3ciV9LJ8lBfkn
         sCGfs1SxLkTdq2ENYGwPMXpjYZNKD2hQV2nJaDFF7u8eGO6qQpR+DqLCZvadDFa1+nBk
         QVYBoST+nYhgYmpRfTM9ya91YE4P/QqPw26zAavc9gCgDVcVFaTn0S8tl/PhTOsJ+bUL
         QjVBRaTQLy9cw1pP4xZK3WfiX9rscRVlJDZcdmO2bYCx1Msip6viBL1GmhwmrqgC0jOd
         U19A==
X-Gm-Message-State: APjAAAWHBknFouxEqgm78voVJEsB3Z2EwodwmNwR7cXjv1iFEpszp+/X
        V0PB1KCfPgHyivVYJDtbI4y06R8F1zJGU7zWICsuPRJKv5tPz4lRDrOPCkhJkfj3FvDTTGH8I0f
        2jGke3wpSh+CnhM6CKyvivBovvjGNFeMdLXEO
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr27054840qkv.94.1580786671453;
        Mon, 03 Feb 2020 19:24:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqynlzp4F+A8uKELbLyu6AWOZzAz2UaDwcopLrdiLMlBxHlUbdeuosTBDbmuyLkGEK4SfzEj1Q==
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr27054821qkv.94.1580786671163;
        Mon, 03 Feb 2020 19:24:31 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id b144sm3302012qkg.126.2020.02.03.19.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 19:24:29 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <linkinjeon@gmail.com>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, namjae.jeon@samsung.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH] exfat: update file system parameter handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 03 Feb 2020 22:24:28 -0500
Message-ID: <297144.1580786668@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro recently reworked the way file system parameters are handled
Update super.c to work with it in linux-next 20200203.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- fs/exfat/super.c.orig	2020-02-03 21:11:02.562305585 -0500
+++ fs/exfat/super.c	2020-02-03 22:17:21.699045311 -0500
@@ -214,7 +214,14 @@ enum {
 	Opt_time_offset,
 };
 
-static const struct fs_parameter_spec exfat_param_specs[] = {
+static const struct constant_table exfat_param_enums[] = {
+	{ "continue",		EXFAT_ERRORS_CONT },
+	{ "panic",		EXFAT_ERRORS_PANIC },
+	{ "remount-ro",		EXFAT_ERRORS_RO },
+	{}
+};
+
+static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32("uid",			Opt_uid),
 	fsparam_u32("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
@@ -222,25 +229,12 @@ static const struct fs_parameter_spec ex
 	fsparam_u32oct("fmask",			Opt_fmask),
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
-	fsparam_enum("errors",			Opt_errors),
+	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	{}
 };
 
-static const struct fs_parameter_enum exfat_param_enums[] = {
-	{ Opt_errors,	"continue",		EXFAT_ERRORS_CONT },
-	{ Opt_errors,	"panic",		EXFAT_ERRORS_PANIC },
-	{ Opt_errors,	"remount-ro",		EXFAT_ERRORS_RO },
-	{}
-};
-
-static const struct fs_parameter_description exfat_parameters = {
-	.name		= "exfat",
-	.specs		= exfat_param_specs,
-	.enums		= exfat_param_enums,
-};
-
 static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct exfat_sb_info *sbi = fc->s_fs_info;
@@ -248,7 +242,7 @@ static int exfat_parse_param(struct fs_c
 	struct fs_parse_result result;
 	int opt;
 
-	opt = fs_parse(fc, &exfat_parameters, param, &result);
+	opt = fs_parse(fc, exfat_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
@@ -665,7 +659,7 @@ static struct file_system_type exfat_fs_
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
-	.parameters		= &exfat_parameters,
+	.parameters		= exfat_parameters,
 	.kill_sb		= kill_block_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 };

