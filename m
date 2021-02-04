Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8141D30FACC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhBDSJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhBDSC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:02:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8374C061786;
        Thu,  4 Feb 2021 10:01:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a9so6985828ejr.2;
        Thu, 04 Feb 2021 10:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ycqCB5lhDgOyExViWx7c2qxoC1Oozd3PzC9HlvqUzOA=;
        b=IhpDb14KzDrahZay4bo/I64oiTqq2UGZcjApRkcDjKxTSGeVEPJOaHd7z04YVHVSdd
         JBcwMEuqpF6QfMFEOTfKPZOzp0AH+0uEfiXjT791DzHXQudOWrfUCGznD1LzTtl1XRAI
         IRGEvO3d3KZ/LOzvAKSt+uhRMmhjipcumlkLe2Vvd30OxXI32HO3OOYAi4tKOsXRjGPT
         O5X7qXWQPOFvUGYGuouAWp2ZfE5fhM16rqrqhPpcE3Lg3prB8IsrI+040fd+QyHxJlng
         0CiZh9kVkHGQLF7AulZyI1GJvgTBtq1pVjbGLXoXQ0odqgFBwXiSo2mNg+WWBqkzMghq
         pxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ycqCB5lhDgOyExViWx7c2qxoC1Oozd3PzC9HlvqUzOA=;
        b=hrpT2CsRxvSVnaLi474DCZM8pG76U6aF7iguKh1/sXF14M+r8vtT13buAJQk0vaMPr
         MOaYomjHB+IYcO32oB41W4UoOjnM4l+jUYumU93cJrcoZqb2t/6UYHTYjbSnsdGeJleo
         /56g0lZKwIvNBnbtB/velWHtnLoTGLbB300lVlEW6KnyLDZ3lXvcklNoqLyy4khZ4DMP
         f0lWt2PVz3QT1n/sCap1ISAUIBRmPYUk6C3yqdNCisEHjAopvcVOHigODRUN+YGl6f8c
         rqTiVAHcmfRUO9QLvHc8IVagyqueyGbun/bX0/thntLicQrG+7pHk6HqKBTf+ej7nqZc
         goDw==
X-Gm-Message-State: AOAM533AXtF1XzUfixOo6ldCPEJzxmMRSFWdzWe/Rv4WrDejSs0oX18A
        pdYeIi7Y2CqOYe4khuqoips=
X-Google-Smtp-Source: ABdhPJxS8B1brEDZbFjn1Q5Sc9mnoYzFebnjExRT7ZoMbr5//AHwGfGlQZM4EGYghO/uKqSeb1UE/Q==
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr246401ejc.545.1612461683532;
        Thu, 04 Feb 2021 10:01:23 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:22 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] fs: update kernel-doc for new mnt_userns argument
Date:   Thu,  4 Feb 2021 19:00:59 +0100
Message-Id: <20210204180059.28360-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 549c7297717c ("fs: make helpers idmap mount aware") and commit
c7c7a1a18af4 ("xattr: handle idmapped mounts") refactor the inode methods
with mount-user-namespace arguments, but did not adjust the kernel-doc of
some functions.

Hence, make htmldocs warns:

  ./fs/libfs.c:498: warning: Function parameter or member 'mnt_userns' not described in 'simple_setattr'
  ./fs/xattr.c:257: warning: Function parameter or member 'mnt_userns' not described in '__vfs_setxattr_locked'
  ./fs/xattr.c:485: warning: Function parameter or member 'mnt_userns' not described in '__vfs_removexattr_locked'

Copy the existing kernel-doc description for that new argument from
__vfs_setxattr_noperm() to the other functions as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/libfs.c | 1 +
 fs/xattr.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index e2de5401abca..61c684014392 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -481,6 +481,7 @@ EXPORT_SYMBOL(simple_rename);
 
 /**
  * simple_setattr - setattr for simple filesystem
+ * @mnt_userns: user namespace of the mount the inode was found from
  * @dentry: dentry
  * @iattr: iattr structure
  *
diff --git a/fs/xattr.c b/fs/xattr.c
index b3444e06cded..57f47f0caf22 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -242,6 +242,7 @@ int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
  * __vfs_setxattr_locked - set an extended attribute while holding the inode
  * lock
  *
+ *  @mnt_userns: user namespace of the mount the inode was found from
  *  @dentry: object to perform setxattr on
  *  @name: xattr name to set
  *  @value: value to set @name to
@@ -473,6 +474,7 @@ EXPORT_SYMBOL(__vfs_removexattr);
  * __vfs_removexattr_locked - set an extended attribute while holding the inode
  * lock
  *
+ *  @mnt_userns: user namespace of the mount the inode was found from
  *  @dentry: object to perform setxattr on
  *  @name: name of xattr to remove
  *  @delegated_inode: on return, will contain an inode pointer that
-- 
2.17.1

