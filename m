Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65C4156867
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 03:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBICfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 21:35:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51640 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgBICfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 21:35:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so2632522pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2020 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1tEhQt8Yy+npScJtt3udz5U/rK+OT3WL7R5j1cYD7vk=;
        b=lqXBztzMIhJRoz9K5S18YV9DpMbCeQra7UORzLQ45/m92oExxq2tf9B4F0pf8V3DZP
         3K8yuWhvEQLYrB+8EYeVZIfuxTRPA/eBRJSg2Xy9eP6W5VQzJvS2LDlnPyGaVWezYgpF
         6gakNjabjh99s5iu6+K/nZrafC99dz8FV1RUW1ba3XCG4Le3w3LTbOpTnp0M8EtOc1m9
         OO1nXaP/2aDP+cFQpst3JjXr5Vm95JBmjAUHKLongV4Cl46+8UHrGZeusOf4iLGsXkoo
         05hF2SvC8TfJOBmiVg6F6m+YIccCGwASI1aMb6uE0Y/RBkbDxHqYVFlgxx0h//5vzI7b
         8AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1tEhQt8Yy+npScJtt3udz5U/rK+OT3WL7R5j1cYD7vk=;
        b=b07+Ud2mEqu411bA4yzBgUZbewmC+vsh43PR8jULGACcoXlRyi0C/AlOMqPN/q/y2Q
         D77kgvtWmsFr7s++EO4fP6nuOFX2L8h+I6vWozuM7Yy8ANfFp0XQtp+VBbqXtv86KcYn
         GuQrXE6iCMJOO9tAxSkcNlnpnaXhnBYeaC+LxUPYEdSfSb+a3nVryL8y7WT512ht+lgI
         +JtQmivxZ2P8mlEhBUX6ZETbiyvg4rxodDwXoMLhgEq01BsxALCmOtnJ5yIGlz98QVPM
         17OaWa+5ILHk9yDRxOIFqtEWIRsJL+ymsB0+8gnQH8Fgg7u12NvtAvSwN1NAnksKpZDN
         7hqQ==
X-Gm-Message-State: APjAAAVKU50B7jYYUX3ElvzhjOyO1DqoP4ECQDQmNAD0UtYaP61XB/A3
        9K12ENTlTVQoEmV1b5LmcUfRVRhv
X-Google-Smtp-Source: APXvYqwHFw7KUkmZmsQOh5iuHD67QPLu2O+2maMBchmA9YKhnkktdug9WWWaTMBxitXNERHOpXhKQg==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr13248779pjq.124.1581215718460;
        Sat, 08 Feb 2020 18:35:18 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id u12sm7475568pfm.165.2020.02.08.18.35.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 08 Feb 2020 18:35:18 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] fs: update comment for current parameters
Date:   Sun,  9 Feb 2020 10:35:06 +0800
Message-Id: <1581215706-30750-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Update the comment of current parameters for attach_recursive_mnt()
and propagate_mnt().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/namespace.c | 8 +++++---
 fs/pnode.c     | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7b..3332a9c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1975,9 +1975,11 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 }
 
 /*
- *  @source_mnt : mount tree to be attached
- *  @nd         : place the mount tree @source_mnt is attached
- *  @parent_nd  : if non-null, detach the source_mnt from its parent and
+ *  attach_recursive_mnt - attach a source mount to a destination mount.
+ *  @source_mnt : source mount.
+ *  @dest_mnt   : destination mount.
+ *  @dest_mp    : destination mountpoint.
+ *  @moving     : if true, detach the source_mnt from its parent and
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

