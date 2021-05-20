Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B166389B2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhETCMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 22:12:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81FC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:11:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so4577715pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FlVixfctKo7DyMwDNrXJB4AwLpO0OTcNLhhCvpWwexM=;
        b=tWxOzHcS13+ocG8+bbQQIKub3aTA/kxy6gp3r3olSmb8FG5w1uxPINLWn5fVqsZIQ0
         tLrYRbxk9Tdc31YebK0QlkLnfdPC5xVT2cEv7ODrep9N6AIU4uh0tt8MZuoErvgzHkVd
         JCwLWWh4urj2fiuWcullTzzV6bi7zJ3asUunSkYaBI93Th63MCFBdefK+vJZ3hfsBvh9
         RTBliatfDNYj4tnU9pNssL8xMqn2M+kwEmtpOTFGsPU9ZlpzM4F6wO3jnNLovo8fzpMh
         /vvLPkHPqYHgiFqPIEri8tbFo/rK03uYSdPGCGntCzgkbKYH+b9seBVAhHVI4tNWFBlX
         +ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlVixfctKo7DyMwDNrXJB4AwLpO0OTcNLhhCvpWwexM=;
        b=RPjv+97iKVM2ajuxjK07MVJ7HDY0CMupTLri7TeT0/n19SBCCHnxm3gMqBGyLMzpPC
         9vNPWL7V+mXTt8n0eamlAMuPWBGOOPajhZbQ9cWXywwJoF2SRUlD3IcWFHQJE/LaFp4K
         fTc4XnOspIqgWK5SI5PnKd7bicOcRJZsMY5u+RlmtCVJSWctbwX/Z7NZSM/WeEtqDM+H
         gBfhANAa/VejVkkYWfs7VCYSAxUmILz55Q/7iEhchWMqaVCdYzZVRGqPDg6CHo/eumCN
         M/v62dFwKufcvaTIa01K63hIH6GsIR36jtBHuyniq8qpmtDGhjzFm2xlJ4n02y6XmUeZ
         /QEg==
X-Gm-Message-State: AOAM530hKKOTnFwKms69nA0vOYmqPl81Xx2S4kQEw3IPvtzZ24Q/Bs71
        m5nbRWptiC6jmxHUIChdKP7CqQ==
X-Google-Smtp-Source: ABdhPJw9SpXuZNgZpEjmzi/KO+YV1R3uH9YVzofXkbt6NixWBRNm/9bkWP8P0BzyL1s/CNAI64mxvA==
X-Received: by 2002:a17:90a:b796:: with SMTP id m22mr2581096pjr.146.1621476685213;
        Wed, 19 May 2021 19:11:25 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id a129sm541016pfa.36.2021.05.19.19.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:11:24 -0700 (PDT)
Date:   Thu, 20 May 2021 12:11:13 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 3/5] fanotify_user.c: minor cosmetic adjustments to fid labels
Message-ID: <7072741f107cdaf4328500e1f11b4b99a8b183cf.1621473846.git.repnop@google.com>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
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
 fs/notify/fanotify/fanotify_user.c | 32 +++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 71fefb30e015..914ff8cf30df 100644
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
+static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
+				 struct fanotify_fh *fh, int info_type,
+				 const char *name, size_t name_len,
+				 char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
@@ -459,10 +462,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
-		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_info_dir_fh(info),
-					info_type, fanotify_info_name(info),
-					info->name_len, buf, count);
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_info_dir_fh(info),
+					    info_type, fanotify_info_name(info),
+					    info->name_len, buf, count);
 		if (ret < 0)
 			return ret;
 
@@ -508,9 +511,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
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
 			return ret;
 
-- 
2.31.1.751.gd2f1c929bd-goog

/M
