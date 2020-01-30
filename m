Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C514DCC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 15:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgA3OZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 09:25:21 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39198 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3OZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:25:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1406213pjr.4;
        Thu, 30 Jan 2020 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yk6qeDRk9bsU8rZcHl5rGYUeaQ0Nm0LWhFjeUIifTCg=;
        b=ig4AfFwlEW+d5fbFaH+GgYqVzP0YFZXTCoswJrMx0kJSjC4fA99v9z7j3LFfVU+jxp
         asMpi1UYRcVqfx1SjwmQ//C1T31rtF65AyRgBZKz3Bpo/ujlLlvTfpfdRpTmUFArmK5m
         iWzBgHgIGxlMIq7FgfG05AYM3Qag7AzGcWPd5ncpbqugMhePyCjRldM+6Z3rIwaGXCrr
         fLNFzshWXFBqJdRnQKXzOJTQdtoAfMDjpg1aYxDkBfqhFp9jnl79yvBZQFqsJ1DVr6kn
         xq1dyP2jmm9hBVK8119UZT02p6W5+eSXdxUy6j4d6qWZ0sldFQ8F3IignkKBJnBp0XRz
         sA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yk6qeDRk9bsU8rZcHl5rGYUeaQ0Nm0LWhFjeUIifTCg=;
        b=fV0V33Eo+KcOKKH/73m/cc9Sc3krqYUihxk7RQv8dPyX4Dfe/YUqXUTokAO5v6b38k
         1AeZKDnRRBcqaYAHDJi34bj3UJHxptG/FSrXMHVgkjco6U2MPFucWO8X3/unkDGuo4oZ
         8IgL+g8BTkfjBeDPwj/6fCRP66hMXYND9JGgOasFHtMByIlxULBxoCrPivuRmQe5GD7h
         aEXKh+4ttuZvTD54xBEnBs1Ir2434/L9dN+S7+P1aR3DTSLMhZLwYxXZ0ni/KuJFR5Ri
         B8hDSSCIQSysTeBwnve/pnhLOBgFA8lE4bsOA3ZTnD2b8R6l1EqHCMyE6Tc51O9gr/5c
         Mm7Q==
X-Gm-Message-State: APjAAAXfkzx5Wq9sxvBUy/rbpURmevvS4ETM0P/fZC/S5FKu5KMs9OJM
        UnR3ku18165lwPaD7AMeLPA=
X-Google-Smtp-Source: APXvYqyqIS+XYq1I0HTTRAOscemOLsmgOadI9AArHOtu2fEs5qsnq67NH6uW4eQBgn9M/eO3pw3uRQ==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr6405780pjb.43.1580394320899;
        Thu, 30 Jan 2020 06:25:20 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r2sm6669642pgv.16.2020.01.30.06.25.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Jan 2020 06:25:20 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] fs/namespace.c: fix typos in comment
Date:   Thu, 30 Jan 2020 22:25:05 +0800
Message-Id: <1580394305-28573-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Fix the typos of correct parameter description.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/namespace.c | 7 ++++---
 fs/pnode.c     | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5e1bf61..cb9584f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1975,9 +1975,10 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 }
 
 /*
- *  @source_mnt : mount tree to be attached
- *  @nd         : place the mount tree @source_mnt is attached
- *  @parent_nd  : if non-null, detach the source_mnt from its parent and
+ *  @source_mnt : source mount.
+ *  @dest_mnt   : destination mount.
+ *  @dest_mp    : destination mountpoint.
+ *  @moving     : if true, attach source_mnt to dest_mnt and
  *  		   store the parent mount and mountpoint dentry.
  *  		   (done when source_mnt is moved)
  *
diff --git a/fs/pnode.c b/fs/pnode.c
index 49f6d7f..bc378ec 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -282,7 +282,7 @@ static int propagate_one(struct mount *m)
  * headed at source_mnt's ->mnt_list
  *
  * @dest_mnt: destination mount.
- * @dest_dentry: destination dentry.
+ * @dest_mp: destination mountpoint.
  * @source_mnt: source mount.
  * @tree_list : list of heads of trees to be attached.
  */
-- 
1.9.1

