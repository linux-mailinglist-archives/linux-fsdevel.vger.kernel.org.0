Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E93D08CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhGUFlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhGUFiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:38:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31348C0613E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t9so928642pgn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qqYSFs90UWfbPr+8AntkjceKVZzShraroJaRtBQmptk=;
        b=TDDyGKFaacKd/2Gov8MKczHtG2FHnvCv1Z0R3TSBoXB8N/Bn7+i8NADpfh+SQMIwNt
         Xfzjun9S4IqBhpr7enx94ldnEicjZyIcO/Wxv+DZf314zZZkWkvGyFOwhoyw/y/C0yMk
         hK/GbljvVOoEfqNWWdPtWSG6YJK7evY22QHqLPw9L6kM/eqgCOoH3bmr9i7/jxT8C84s
         GaAFVkecxkSJcnQO0cIN6h3srxl5y7qHry9f0AvVPglxdgh4w1U8Op+9aNRlonasPYt3
         3Vj7Bz6BnsaUlnMQ0MJmGqwWGjDsxbJSWWuRUO96KoV25wL3NPEmNJwYyW/XYRC2TBQu
         HvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qqYSFs90UWfbPr+8AntkjceKVZzShraroJaRtBQmptk=;
        b=adh/rPHMMP+YvmfF1txupixXByKFPadvrUhKiiXGe1pH7vMVvqB8IScGBh0XL+3R/O
         x9rgxuU8Nx6HVtofqWRGVP+WWej0P8MnGwz1ek17QbL40uWRLjkc1VQ6bm88JkjbG+A8
         Thb1G2jsu7pLEDZSr0w7QH7lbi5Fsv1Op8Ih8TSPayk2luizWye7mkLJXiSw4/qiQU71
         H6C/PhkKMIwjfxSZ6Ekl9SzgaWuYlHjykCFwzEablKJzOc53YG3JuZQU3qxxjCMJSZDX
         3NCWSC8l2y/axbBcWK+DqyTQY+7ZnZhmEnvs3q37RgfLDntLwmaIOXr1RMipU6TPv4ee
         a9wQ==
X-Gm-Message-State: AOAM533XqUGlH2N+8Lizne+H0MSI+AdjRKCdK9LrMhGbLCKMpYlsMoiv
        pFpW1pUl8CR9inuNvuOBdurcgsE7cmmqvA==
X-Google-Smtp-Source: ABdhPJwimfeb+VluKJhNgZBoZ/wsu2PAJdlF3tc7t9R1NJWk0fvw8c1FWj375xLQh7yP3Tk0apEd/w==
X-Received: by 2002:aa7:854a:0:b029:332:330e:1387 with SMTP id y10-20020aa7854a0000b0290332330e1387mr34411553pfn.67.1626848314437;
        Tue, 20 Jul 2021 23:18:34 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id q12sm25908269pfj.220.2021.07.20.23.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:18:33 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:18:22 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 3/5] fanotify/fanotify_user.c: minor cosmetic adjustments
 to fid labels
Message-ID: <8aa9b05ae5901f14a7d3043dbf81473bfc811fdf.1626845288.git.repnop@google.com>
References: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626845287.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the idea to support additional info record types in the future
i.e. fanotify_event_info_pidfd, it's a good idea to rename some of the
labels assigned to some of the existing fid related functions,
parameters, etc which more accurately represent the intent behind
their usage.

For example, copy_info_to_user() was defined with a generic function
label, which arguably reads as being supportive of different info
record types, however the parameter list for this function is
explicitly tailored towards the creation and copying of the
fanotify_event_info_fid records. This same point applies to the macro
defined as FANOTIFY_INFO_HDR_LEN.

With fanotify_event_info_len(), we change the parameter label so that
the function implies that it can be extended to calculate the length
for additional info record types.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64864fb40b40..182fea255376 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -104,7 +104,7 @@ struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
-#define FANOTIFY_INFO_HDR_LEN \
+#define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
@@ -114,10 +114,11 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	if (name_len)
 		info_len += name_len + 1;
 
-	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
+	return roundup(FANOTIFY_FID_INFO_HDR_LEN + info_len,
+		       FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(unsigned int fid_mode,
+static int fanotify_event_info_len(unsigned int info_mode,
 				   struct fanotify_event *event)
 {
 	struct fanotify_info *info = fanotify_event_info(event);
@@ -128,7 +129,8 @@ static int fanotify_event_info_len(unsigned int fid_mode,
 
 	if (dir_fh_len) {
 		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
-	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
+	} else if ((info_mode & FAN_REPORT_NAME) &&
+		   (event->mask & FAN_ONDIR)) {
 		/*
 		 * With group flag FAN_REPORT_NAME, if name was not recorded in
 		 * event on a directory, we will report the name ".".
@@ -303,9 +305,10 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
-			     int info_type, const char *name, size_t name_len,
-			     char __user *buf, size_t count)
+static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
+				 int info_type, const char *name,
+				 size_t name_len,
+				 char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
@@ -466,10 +469,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
-		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_info_dir_fh(info),
-					info_type, fanotify_info_name(info),
-					info->name_len, buf, count);
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_info_dir_fh(info),
+					    info_type,
+					    fanotify_info_name(info),
+					    info->name_len, buf, count);
 		if (ret < 0)
 			goto out_close_fd;
 
@@ -515,9 +519,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 			info_type = FAN_EVENT_INFO_TYPE_FID;
 		}
 
-		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_event_object_fh(event),
-					info_type, dot, dot_len, buf, count);
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_event_object_fh(event),
+					    info_type, dot, dot_len,
+					    buf, count);
 		if (ret < 0)
 			goto out_close_fd;
 
-- 
2.32.0.432.gabb21c7263-goog

/M
