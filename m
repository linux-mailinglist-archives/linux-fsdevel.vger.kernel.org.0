Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6E406B41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhIJMQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhIJMQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:16:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66FC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 05:14:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g14so2868636ljk.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=Mm4PQ/IrlfLGixj1onn3OapJC4Qag7jhAlLEFGRB1KQ=;
        b=JGsVr8BRxJJWlH1rSR2mL/HXrF+xSCVWd2SMhHPKqCs/nn3MVIgU/rI11CttYdJnPE
         8nCN5IyI8zz4AcIOGrglmN+uB2zti+pAoXDJPeJedSj3qqYin7Rm4l80dw8fEeu1iFl/
         Vz8dYXaW7zcQizHUGESSNBw/FzuNPpjbM0jrCY++LWJW2qWIneqaHclRa85Rt64s0M5J
         G0tjRv2xBysIt7dwI3Mlq4azQ9mHoikdP3+WCU+nzgzN+COg0zKW8vNTXk3kjQkUSLxe
         B10bb6tihcasK9aTZR6SINnOyI3WswXN9LQsq+mlfi2Zpbpup2cOSpgeeqTfGKoutsl4
         MnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=Mm4PQ/IrlfLGixj1onn3OapJC4Qag7jhAlLEFGRB1KQ=;
        b=8OQEhedvcoR5YodoIy54YrlT/IePlU9ndQ3Nu7T6MrwF0SubMNNgVUusbH6ojhK/iB
         E/5+ZqaWDz0qonmwi63rGCwB/GreIqJWNU14VW8PyyyLyoIRTgyphTIyzHRgD71D2eO5
         kZMfpvCfZFaRTq/GeQgFYq+uxa4E4AKl2Ld6Wag8KJeXzoEzvGQw2FDYfE2WhiFcTLm6
         RjmfQC/LtROu3L21k0NDTvY/FZOLqGgRsr7FIojvvy1kTrNc6kxZrqp9qG6qRVYrp0Gu
         sd6G7QcmQmG3qpwXpwXkBqBTzKb+yXMK36Uj83qHW1xYsHN7HSnh/3LPpQv5YpIxPWvD
         Z4bA==
X-Gm-Message-State: AOAM531w25OqgRyrh3C1f/l0XWniK7FQP+HO6O5X61OlT6wmJ0KNhyJO
        bCU0yeo6+lJooxOXWPEiMZPeqfxZtobYlA==
X-Google-Smtp-Source: ABdhPJxsqe7gi1Tf5LG74XHOhCqwQYGJjTo1s3DH1hhnMNVslq1M+WlTp5ZpJm5ajSkHEGMGzjDHSQ==
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr3852429ljr.307.1631276086387;
        Fri, 10 Sep 2021 05:14:46 -0700 (PDT)
Received: from mainpc.tinyware.ru (95-31-210-22.broadband.corbina.ru. [95.31.210.22])
        by smtp.gmail.com with ESMTPSA id z25sm564700lfh.200.2021.09.10.05.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 05:14:45 -0700 (PDT)
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
From:   =?UTF-8?B?0J/QsNCy0LXQuyDQodCw0LzRgdC+0L3QvtCy?= 
        <pvsamsonov76@gmail.com>
Subject: fs/attr.c patch
Message-ID: <34c7bdc6-a057-e1a0-0891-757a0a493874@gmail.com>
Date:   Fri, 10 Sep 2021 15:14:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D99E4EE9E1655A3BD42CE7F5"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D99E4EE9E1655A3BD42CE7F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------D99E4EE9E1655A3BD42CE7F5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Signed-off-by-Pavel-Samsonov-pvsamsonov76-gmail.com.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Signed-off-by-Pavel-Samsonov-pvsamsonov76-gmail.com.pat";
 filename*1="ch"

From 07b6f881080fa18ac404054d43b99433275fe966 Mon Sep 17 00:00:00 2001
From: Pavel Samsonov <pvsamsonov76@gmail.com>
Date: Fri, 10 Sep 2021 14:53:39 +0300
Subject: [PATCH] Signed-off-by: Pavel Samsonov <pvsamsonov76@gmail.com>

The patch changes the argument of chown_ok, chgrp_ok ...
functions from inode to dentry.
---
 fs/attr.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 473d21b3a86d..de1898c19bde 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -21,7 +21,7 @@
 /**
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
- * @inode:	inode to check permissions on
+ * @dentry:	dentry to check permissions on
  * @uid:	uid to chown @inode to
  *
  * If the inode has been found through an idmapped mount the user namespace of
@@ -31,9 +31,11 @@
  * performed on the raw inode simply passs init_user_ns.
  */
 static bool chown_ok(struct user_namespace *mnt_userns,
-		     const struct inode *inode,
+		     const struct dentry *dentry,
 		     kuid_t uid)
 {
+	struct inode *inode = d_inode(dentry);
+
 	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
 	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
 		return true;
@@ -48,7 +50,7 @@ static bool chown_ok(struct user_namespace *mnt_userns,
 /**
  * chgrp_ok - verify permissions to chgrp inode
  * @mnt_userns:	user namespace of the mount @inode was found from
- * @inode:	inode to check permissions on
+ * @dentry:	dentry to check permissions on
  * @gid:	gid to chown @inode to
  *
  * If the inode has been found through an idmapped mount the user namespace of
@@ -58,8 +60,10 @@ static bool chown_ok(struct user_namespace *mnt_userns,
  * performed on the raw inode simply passs init_user_ns.
  */
 static bool chgrp_ok(struct user_namespace *mnt_userns,
-		     const struct inode *inode, kgid_t gid)
+		     const struct dentry *dentry, kgid_t gid)
 {
+	struct inode *inode = d_inode(dentry);
+
 	kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
 	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) &&
 	    (in_group_p(gid) || gid_eq(gid, kgid)))
@@ -72,6 +76,27 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
 	return false;
 }
 
+/**
+ * fowner_ok - verify permissions to chmod inode
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @dentry:	dentry to check permissions on
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
+static bool fowner_ok(struct user_namespace *mnt_userns,
+			const struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (inode_owner_or_capable(mnt_userns, inode))
+	    return true;
+	return false;
+}
+
 /**
  * setattr_prepare - check if attribute changes to a dentry are allowed
  * @mnt_userns:	user namespace of the mount the inode was found from
@@ -114,27 +139,31 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, attr->ia_uid))
+	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, dentry, attr->ia_uid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, attr->ia_gid))
+	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, dentry, attr->ia_gid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!fowner_ok(mnt_userns, dentry))
 			return -EPERM;
 		/* Also check the setgid bit! */
                if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
                                 i_gid_into_mnt(mnt_userns, inode)) &&
                     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
+		/* Also check the setuid bit! */
+		if (!(capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID) ||
+		     uid_eq(current_fsuid(), inode->i_uid)))
+			attr->ia_mode &= ~S_ISUID;
 	}
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-		if (!inode_owner_or_capable(mnt_userns, inode))
+		if (!fowner_ok(mnt_userns, dentry))
 			return -EPERM;
 	}
 
-- 
2.30.2


--------------D99E4EE9E1655A3BD42CE7F5--
