Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64E847D14C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 12:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbhLVLvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 06:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbhLVLvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:51:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32420C061574;
        Wed, 22 Dec 2021 03:51:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id l25so2007350qkl.5;
        Wed, 22 Dec 2021 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krAEN6Zex7VeUxtUXXor7t+1Wwiow6aQFdDlf1o9eFs=;
        b=GAUNCaZ9VbBnxrS4hcy5iDfj1gNYrahOGJQJ5WEKsUqkp4PVs1SQGIe0SXgSIow1HT
         bsc4LC8A25HRyCbrerGN9LFGsQEB9aHae+GZ2GZofBMp4GrpKzxtXobZSoTGrG3paSab
         OcwFbGgnbHA+1mjUedRUQhkfuKZiCFIpxh2gNUrxiw20wb6HODqPJ6Hmgc2BJI3oDGSc
         Gk9JCdl8M7nZcr/mlr350iIRIM20KFxYx02MzoPDvqRP2pFVEJxwLUsXSloH+yp9X/1s
         kqHXspL+t4RpiZJhXj0c5dLuUd1NXYEqzpvJx6T17KAw3le3Wz342u/xM812+xWB2Nm3
         +tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krAEN6Zex7VeUxtUXXor7t+1Wwiow6aQFdDlf1o9eFs=;
        b=AS8K/2DfM3yZmIvUnzknutk8uKf2G53xJ0UsY3gBhyVY1DisvOCTpLTY4hzgcHjYTI
         ebQkkOD73oQv/X5bOHo79LD3E6spCkV1AIwuERx2J9HgT2X8g3MdY1rxwOVmm/00eq2G
         L1cf/2ooFfgcXmgz5GdWzChutBY/FEyfTCktzDTOUQlkEV1PpwFBZah0z0JEVddJlbUP
         k6lLPuSqaVQO55PXNl+z3Uyr0wmNedyG8fgEkzwoxF5aOvBprbGzB/YC1Dv6982L5Juc
         ae4He8haLJc3lmS4JVKzCh5VikqUNabbo3bQ3x4TpReh20BeVxDPlmJYi2+22qVg1Kxd
         QA3g==
X-Gm-Message-State: AOAM531Cj1kjzJqB8OZniA42JPPt7cdIh46ulP+a8qouXqvmGfpHFuYT
        SHeJ4y0xdpK6HOJH0hHkOKjgiYLr3fw=
X-Google-Smtp-Source: ABdhPJy8o062nCHl8EM3TZEgSArbs1gzLl4SrqyabF8ABZVIXyhdbshHi5gjgDR8CX8jCy9Hl9gahQ==
X-Received: by 2002:a37:88c4:: with SMTP id k187mr1616923qkd.718.1640173903386;
        Wed, 22 Dec 2021 03:51:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q21sm1585385qkl.52.2021.12.22.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:51:42 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] sysctl: add comments to make the code more clear
Date:   Wed, 22 Dec 2021 11:51:35 +0000
Message-Id: <20211222115135.485298-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Adding some comments for ctl_table is more clear.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/sysctl.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 180adf7da785..105b18a290c4 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -131,14 +131,14 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
-	void *data;
-	int maxlen;
-	umode_t mode;
+	void *data;			/* a pointer to data for use by proc_handler */
+	int maxlen;			/* the maximum size in bytes of the data */
+	umode_t mode;			/* the file permissions for the /proc/sys file */
 	struct ctl_table *child;	/* Deprecated */
 	proc_handler *proc_handler;	/* Callback for text formatting */
-	struct ctl_table_poll *poll;
+	struct ctl_table_poll *poll;	/* Support for userspace poll() to watch for changes */
 	void *extra1;
-	void *extra2;
+	void *extra2;			/* extra pointers usually as minimum and maximum of data */
 } __randomize_layout;
 
 struct ctl_node {
-- 
2.25.1

