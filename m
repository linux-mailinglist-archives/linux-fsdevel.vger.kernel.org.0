Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0653E390B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 07:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhHHF0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHHF0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 01:26:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24AC061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 22:25:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso24449985pjf.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 22:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aq4vZyea5NClVIVzLon7PowZYyC2bO5mgBlBJu/ScqU=;
        b=AC74fFZbLuYFp68YoUGmIxYWSAit0xbzxpjbUoBpkbDKpwkRuMvbPv8luEMTERjsNQ
         5pfrSS/U5ODo3Mj/yI+L94cjYy3rB0gTXjOht83agXvmBTePyYarJHPfZx7HJr/6eZlz
         4845Qp6gcvSWu8VEMZMIqFERgAWvdDKxnFewiLDg8e4Ux9pb0ndfZSb8k/gbSU5J1taU
         rAT87Ug1qcaPVUFUTFmfJcdr/tqLdnwCcFkU/+k+oq500HnDfWE/9pdXaefPcioO+YBI
         5gQqkuqxNsrr13+hbP0NTER3OVOJDTolkcF3gE8bfVAOtNlYbPDvQspBn46iC37LfBQ8
         QWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aq4vZyea5NClVIVzLon7PowZYyC2bO5mgBlBJu/ScqU=;
        b=Zyapd1ipGD6yXZW3i5JrVF64Fp7+qYimMnDPL9ee6gdxO41bHa3GNHHDhZhqll3DhT
         IEo+pj2LWOlwiWXQK2na5lWheL4DoN/F0eiVtD2rHHId81/udwtomNrKQEIs3zJoNj80
         IQuFCzCXQYpx8J8tTKC7Ln0OXe/6DflelClIE8Mi+nbkeR0x9qe08FZHBK44B0OiznQq
         mOiI/13Z+p4mwphUoIMhHMGG5TJeMG1RB7woqgONd6qW/M5ZL7dymYO2+yLm9gWBtho9
         ESB5IAxa+b/MqSAQ/cWuZvhFGzB8aTvVWGMOlExyKIbzSKYPfL6DMW7wTpyVO1lA9jDb
         /XnQ==
X-Gm-Message-State: AOAM5334gy77vZ7hRhA7lpr4JN1A9exstNWRIZ2rHHXsCRgj7wyY/paY
        doQXblfc7aawJV/6JVx/0co8jg==
X-Google-Smtp-Source: ABdhPJxI6OdVGq5N7n8tYVL/WE75TclzJorcGB7fAmEvVOPcVsMAUe1EK/0YywE/mptwIog21yMMEQ==
X-Received: by 2002:a17:90a:ba0b:: with SMTP id s11mr18257052pjr.10.1628400344623;
        Sat, 07 Aug 2021 22:25:44 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c29e:146d:490d:33cc])
        by smtp.gmail.com with ESMTPSA id g23sm16809592pfu.174.2021.08.07.22.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 22:25:44 -0700 (PDT)
Date:   Sun, 8 Aug 2021 15:25:32 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 3/5] fanotify: minor cosmetic adjustments to fid labels
Message-ID: <7c3ec33f3c718dac40764305d4d494d858f59c51.1628398044.git.repnop@google.com>
References: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628398044.git.repnop@google.com>
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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
2.32.0.605.g8dce9f2422-goog

/M
