Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2A3D08BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhGUFhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhGUFhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:37:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF90C061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:17:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p9so1066351pjl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6QYYHJjhoIpVv76xIsxKpodZsk8XzBP63hLlbxhZOE=;
        b=Jp1BjRixmA4FoZXLoDV1t0aLVx5Lz93Dn7G+x5nJrtmPEmr7Pv61rpFB87xcGTAF0z
         iLOA7mbeyJLceP2MpOGn+nLPojlPlvMgI68vsVK2jO1m4KUw/tC91oAu1MdXoWz5Bfym
         6LxuM08T+AvlqQjJAGrC+mYSk+uhVapbPYoiAJO0x5ITsIG7eM/FhsVW9Ov9CMdONdGv
         RKvc2qobaB95nghg8RvERQNq+bgk3swUwzrn4gUi7uYDh+Y2d07OtiEzj4/txCwZF0G5
         S+ruyxP/XqtGas4+qytRktrEopDFKkiFbMHthzbqTjyRnBNF4UhjEAAyBE9BBi9cuJ1N
         oG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6QYYHJjhoIpVv76xIsxKpodZsk8XzBP63hLlbxhZOE=;
        b=Mpuz/4P6uKRDMw7/SIxlFaR1CWXnvZDUbiQCEBxUqS7ADHEq7TB4FAmhA8q/fXY0kG
         ulF3kGoPApO7KgNUSqSGmNOVEyjHaMGZrSU3ZJ2LPdS4W3Bg27uv9KJeNsYqZprBx0oV
         TRn5o9a70hwdP9VYbFvycTd9JfQcuyknu7kTSY+iUWRaCillLk0RiwppeMeDibY3YYBY
         bFbBR7esHzEkD1T9Xek9OQFMG/W9jbzV7B7r5hssMaPJQmBxmLduJrn6r3aKtCtyIEtI
         X2199hfwtJpUxXb96ryKJ1AF/relfPghGhVXzaVLEEwH0f2XfYrmeQ6xTSUpjieZMI+p
         8XMQ==
X-Gm-Message-State: AOAM532Qn8xMAUFjQvDDpSpv6wVCllZZaIxm60fg0hNy+ctUGPA5rJOk
        lGB4IUz9Ixqz1PPOL8pE4tNz1JeZf5VrBA==
X-Google-Smtp-Source: ABdhPJzogjTzZcg/NM+/PvPUz4Yxgt6eJgu21rrChDqRg63HdDoGrsei3wCQly9WI6mFy1wniNNcOw==
X-Received: by 2002:a17:90b:1215:: with SMTP id gl21mr2273966pjb.73.1626848265693;
        Tue, 20 Jul 2021 23:17:45 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id v31sm21214540pgl.49.2021.07.20.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:17:45 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:17:33 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 1/5] kernel/pid.c: remove static qualifier from
 pidfd_create()
Message-ID: <76a9bf30ad8bc0109b9a2d7ce4cd234dd9618c6a.1626845288.git.repnop@google.com>
References: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626845287.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the idea of returning pidfds from the fanotify API, we need to
expose a mechanism for creating pidfds. We drop the static qualifier
from pidfd_create() and add its declaration to linux/pid.h so that the
pidfd_create() helper can be called from other kernel subsystems
i.e. fanotify.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb8d6a4..af308e15f174 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..d3cd95b8b080 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -550,10 +550,12 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Note, that this function can only be called after the fd table has
  * been unshared to avoid leaking the pidfd to the new process.
  *
+ * This symbol should not be explicitly exported to loadable modules.
+ *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.32.0.432.gabb21c7263-goog

/M
