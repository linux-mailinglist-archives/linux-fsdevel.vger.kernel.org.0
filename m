Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F658406E90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhIJP63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhIJP62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:58:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8887AC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:57:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t19so4920961lfe.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=AJSI4FCotac4Xcu4sYqXiTgOTI2XWt52fLOSLiubfog=;
        b=Bsn9KtErRSZu4sUpKzmYnBytW9Hb61oMqvNqwzV+hmVv3jtBrfwRahPtCOv9XwlipP
         iDdQpQesLDOAtxkwH26/fXoqzVIflw8QRB0kYAp1Ay/YmDuCou31MNdV0aq4X8XuSQ1Y
         MhV5pWiPvE+6FegOJSW+jMcPb7s/9Io/ely5zUo8eYZWi7FWQDHBuxxnIm8Y2tgHcTPw
         no7z6eYhrX5Xf+zb5rTgnAEvdCV0ISBE1QyM9ZILknWdFTz0r3RaPmgwfXR3s/YXIeD6
         hREcSKCG9+Q/MfH6tnAw5Q7KQMVwaJtGBuKfqAvBHr967m6P9pvcV8EjVddRdbadg7cO
         UeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=AJSI4FCotac4Xcu4sYqXiTgOTI2XWt52fLOSLiubfog=;
        b=scRCBIt7o0tJFHizLBJzDoJzoSSphTNTXMOKkcUB8sbKx4IQtTfVd7qJIMZz0NcG90
         XaIPlFzxwDJHcO6tq/LwqA+ENWnE9YXrjoiBSVOLBWT2b7im4lzk2F9HRo3gTMi6plfA
         KMehZdWBQTx2N3Mup8xuvVNKMZs6PVseVs/5JuRaY3WAx6l2uCLXix2GYyzGN3bYwpkt
         NUzAz14o+cCwVs1LBRpZQX7/DzMqMfrV2ty96ZwL2a5Dtigv9VygNXeINjOvRZ+ARm9R
         vSsFFgKls0j4bbNDRyDwzKdT73S3i5Romn1BovrxYak1LhRt7T5xPHnxtSvVe/BoxrBV
         PboQ==
X-Gm-Message-State: AOAM533UG5gtrbKy88enkzOmmfQngcpSmD3HzTxUeFLILio91FK8L9B2
        x0ny3bKsxxbZQEeRKXyPDmyJG88KoI4nGg==
X-Google-Smtp-Source: ABdhPJzr1iK7gisfx6zFTIT2JVrtIUdnb5ChDGbDgFAKlr6Coor3j31B5VO+DVhoVCWSAXR8Mw44GQ==
X-Received: by 2002:a05:6512:90b:: with SMTP id e11mr4455260lft.593.1631289434535;
        Fri, 10 Sep 2021 08:57:14 -0700 (PDT)
Received: from mainpc.tinyware.ru (95-31-210-22.broadband.corbina.ru. [95.31.210.22])
        by smtp.gmail.com with ESMTPSA id z8sm591355lfs.177.2021.09.10.08.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 08:57:14 -0700 (PDT)
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
From:   =?UTF-8?B?0J/QsNCy0LXQuyDQodCw0LzRgdC+0L3QvtCy?= 
        <pvsamsonov76@gmail.com>
Subject: [PATCH] Signed-off-by: Pavel Samsonov <pvsamsonov76@gmail.com>
Message-ID: <0189aeb1-75f1-1e8b-71a8-ea6a7641518b@gmail.com>
Date:   Fri, 10 Sep 2021 18:57:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 From 07b6f881080fa18ac404054d43b99433275fe966 Mon Sep 17 00:00:00 2001
From: Pavel Samsonov <pvsamsonov76@gmail.com>
Date: Fri, 10 Sep 2021 14:53:39 +0300
Subject: [PATCH] Signed-off-by: Pavel Samsonov <pvsamsonov76@gmail.com>

The patch changes the argument of chown_ok(), chgrp_ok() ...
functions from *inode to *dentry. The setattr_prepare() function
has an argument * dentry; it is logical to work with the dentry
structure in the condition checking functions as well.
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
   * @mnt_userns:    user namespace of the mount @inode was found from
- * @inode:    inode to check permissions on
+ * @dentry:    dentry to check permissions on
   * @uid:    uid to chown @inode to
   *
   * If the inode has been found through an idmapped mount the user 
namespace of
@@ -31,9 +31,11 @@
   * performed on the raw inode simply passs init_user_ns.
   */
  static bool chown_ok(struct user_namespace *mnt_userns,
-             const struct inode *inode,
+             const struct dentry *dentry,
               kuid_t uid)
  {
+    struct inode *inode = d_inode(dentry);
+
      kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
      if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
          return true;
@@ -48,7 +50,7 @@ static bool chown_ok(struct user_namespace *mnt_userns,
  /**
   * chgrp_ok - verify permissions to chgrp inode
   * @mnt_userns:    user namespace of the mount @inode was found from
- * @inode:    inode to check permissions on
+ * @dentry:    dentry to check permissions on
   * @gid:    gid to chown @inode to
   *
   * If the inode has been found through an idmapped mount the user 
namespace of
@@ -58,8 +60,10 @@ static bool chown_ok(struct user_namespace *mnt_userns,
   * performed on the raw inode simply passs init_user_ns.
   */
  static bool chgrp_ok(struct user_namespace *mnt_userns,
-             const struct inode *inode, kgid_t gid)
+             const struct dentry *dentry, kgid_t gid)
  {
+    struct inode *inode = d_inode(dentry);
+
      kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
      if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) &&
          (in_group_p(gid) || gid_eq(gid, kgid)))
@@ -72,6 +76,27 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
      return false;
  }

+/**
+ * fowner_ok - verify permissions to chmod inode
+ * @mnt_userns:    user namespace of the mount @inode was found from
+ * @dentry:    dentry to check permissions on
+ *
+ * If the inode has been found through an idmapped mount the user 
namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
+static bool fowner_ok(struct user_namespace *mnt_userns,
+            const struct dentry *dentry)
+{
+    struct inode *inode = d_inode(dentry);
+
+    if (inode_owner_or_capable(mnt_userns, inode))
+        return true;
+    return false;
+}
+
  /**
   * setattr_prepare - check if attribute changes to a dentry are allowed
   * @mnt_userns:    user namespace of the mount the inode was found from
@@ -114,27 +139,31 @@ int setattr_prepare(struct user_namespace 
*mnt_userns, struct dentry *dentry,
          goto kill_priv;

      /* Make sure a caller can chown. */
-    if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, 
attr->ia_uid))
+    if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, dentry, 
attr->ia_uid))
          return -EPERM;

      /* Make sure caller can chgrp. */
-    if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, 
attr->ia_gid))
+    if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, dentry, 
attr->ia_gid))
          return -EPERM;

      /* Make sure a caller can chmod. */
      if (ia_valid & ATTR_MODE) {
-        if (!inode_owner_or_capable(mnt_userns, inode))
+        if (!fowner_ok(mnt_userns, dentry))
              return -EPERM;
          /* Also check the setgid bit! */
                 if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
                                  i_gid_into_mnt(mnt_userns, inode)) &&
                      !capable_wrt_inode_uidgid(mnt_userns, inode, 
CAP_FSETID))
              attr->ia_mode &= ~S_ISGID;
+        /* Also check the setuid bit! */
+        if (!(capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID) ||
+             uid_eq(current_fsuid(), inode->i_uid)))
+            attr->ia_mode &= ~S_ISUID;
      }

      /* Check for setting the inode time. */
      if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-        if (!inode_owner_or_capable(mnt_userns, inode))
+        if (!fowner_ok(mnt_userns, dentry))
              return -EPERM;
      }

-- 
2.30.2


