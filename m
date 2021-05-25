Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D829B3903AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhEYORU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhEYORT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 10:17:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78BBC061574;
        Tue, 25 May 2021 07:15:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u7so7851673plq.4;
        Tue, 25 May 2021 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7paX5pQtdRcKci/3W+wcYLEJPlSnAsnPdHVHTh/LRs=;
        b=kZPYJZ2NriOTxsBJWsFwZD5m3eB72ohfiBtGOIygKTvBAi71wXk/LaofKxL8E/Cmmp
         /9WIG2KdR7v/AIyrstAH42UFQLVqGOoq12HccXDTCgX/J6HyaX2QHuVdjPDE/s/jbldl
         co7drts/PmPPNhRheVVd/vNw44LfuuxaPXXldZKu2OR4TQ//jvGkz4HNjokaI5x222Vv
         U9Oz5q4eqdU7kk5IV/AnRiKy2lOavB/vWb2P6tpk0txl+wieW53+wiwV1ISUq2c7kJyg
         ut6QPBVgeZhhS8vyQNgP1lCoieD+qmxDEh8K4LFMEvJGgdSCAHtLP05zxEHiOhsWQQ7X
         miNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7paX5pQtdRcKci/3W+wcYLEJPlSnAsnPdHVHTh/LRs=;
        b=lmQjW5OrQwfBUNWYpQH9PJfU/EDE5pPWl0/1qQvH8eDrkLuqeUjvg8N0N8yGs4/Wd/
         mYKgUaNUEWCnjNYRf3KKrBQQiVXOUC3d8P0I5c3Qr+W3jFCeqfz3tMuT6s8xS+OtanjS
         MFGAPLDf7+6q12D3Oh5FTYNyM1zuhazOVubyTAuHcg1EhRj+0Q5W+XcCpJ0IvOAlzZUz
         +80KVV9HaophFY0AkJaDiNAUcjaB5KH6Y+Vz+bacHaEUsJV6ydiIIBmpqch2SXA6ISlV
         F/T9UELqsYje3+5I2d6TS9Z73ntUpqNPE+M9hQyYf5CtBcvMExoXZ8EXZfDaeWUAVwR0
         WyRQ==
X-Gm-Message-State: AOAM532aHEALPBK2rLk9mMdh/pAih3LVZbt0Yhe/DF0PzX+yzlsc5h36
        cKOJocGBDzoUeobCIGWHgHM=
X-Google-Smtp-Source: ABdhPJzrVPjpB4mQHlYIzhvYjyB97jdU6BH0RKj1WI24txL8A8w2JSeu/zutAQrPsW/68V65B++0gQ==
X-Received: by 2002:a17:90a:6b4f:: with SMTP id x15mr4924419pjl.25.1621952148403;
        Tue, 25 May 2021 07:15:48 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u1sm14606242pgh.80.2021.05.25.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:15:47 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeyu@kernel.org
Subject: [PATCH v2 1/3] init/main.c: introduce function ramdisk_exec_exist()
Date:   Tue, 25 May 2021 22:15:22 +0800
Message-Id: <20210525141524.3995-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525141524.3995-1-dong.menglong@zte.com.cn>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Introduce the function ramdisk_exec_exist, which is used to check
the exist of 'ramdisk_execute_command'.

Add the flag 'LOOKUP_DOWN' to 'init_eaccess' to make it follow the
mount on '/' while path lookup.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/init.c   | 2 +-
 init/main.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..a1839fdcf467 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -115,7 +115,7 @@ int __init init_eaccess(const char *filename)
 	struct path path;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DOWN, &path);
 	if (error)
 		return error;
 	error = path_permission(&path, MAY_ACCESS);
diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..1153571ca977 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1522,6 +1522,11 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(void)
+{
+	return init_eaccess(ramdisk_execute_command) == 0;
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1568,7 +1573,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist()) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.32.0.rc0


