Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F116F939D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjEFSbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFSbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 14:31:06 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C53C00;
        Sat,  6 May 2023 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LfQNvT8H4D9rjb0SPnNWYAHLtyQ02TVfsmKU8Ox/okM=; b=lT4MqoKgZ/hrrbrvj+z8CyC1Iq
        L+GZI6lC/epdVrXrEwUzXsyyahHXXkTMtOJBQ1QewyL38nv4Xiv4GuS7UjlCYRSHWos7YfvN3JSkx
        UgbA0jdaP744HubPc+kFub6sNi2FQybTdfrfsk665FKc2/KjawgoFVdp0TG1YUMu2Ip63qa2vkGCk
        FDLYfwFsZwDKACjIxNyNjhfTcLxhUZ2lz/Pi0IVljPoR3Dfzdc7XEHv4INJvNm3tV0yOZSM3NZ/Kq
        OxdzBSUM+xDcoU0PsjAYX4tgaY5FT3iUagDzfaF6hUsoD0lEYlYA6/mm1ACFF8zCQOEUG99wKoerh
        xKHaemjw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pvMg8-006Idn-FK; Sat, 06 May 2023 18:30:44 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anuradha@debian.org
Subject: [PATCH] fs/open.c: Fix W=1 kernel doc warnings
Date:   Sat,  6 May 2023 23:59:27 +0530
Message-Id: <20230506182928.384105-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=anuradha@debian.org; h=from:subject; bh=MRs99HIyR+zaAgLmQG7AKOrC7Pt3I10oWZjroXWkqZw=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBkVpyIJES2GogU87hL5uzQKHFwaebfNS79m8XZ3 nJ846fnOlGJAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCZFaciAAKCRBjbbWh2Rhg /RY/EACKnoZ9qR6/hlJUVJEycxLf3UE1mXP2z+0+N7AVHZz1rn/9/Jr7moRuCmmp2OeSDQRKLbL jZie3E0ZLs7+YmvMKX+4SjVcmQqnj06q3H2n6otKH3xuxPI/WXo0GK3YNe3vXr+8jyOIA99Di8M +RQVA9Hnm++C1XTodSmAwHWUXsVr+O+9E94Wqdw5VzkRyQuRQq74SWrCWhjjCwbmi7N+BiDqAfX n/shlfZw9iZ9/G+FJ/CzIANdb8f9YZcDVYaDeLCJeQRpR6/OZ5+Y6Qo6jvsWYxfoiRlDTywx36h kz66tumIAl/OgiyFEmISWNlpgvwS4tBsBE5uBXUiA9JVv8XYLkPqTEZH5iMRlZ+2xuSDqT7upzn l5MAFsEs7PJbxS3j7Qgj9lwA0dRZCX6aFb0qoO7AafQoX1k9waGV5EhrORFUp8Hn0O68/hU+Vs3 ExINAu4NLzUh9KV3Nc0vx07H0U6J0JkCBYFzlk7ljFsNpIdpPnYZcOgyS9oQUgf5aah8HSKIhI5 J2mLpndtDBZ3uSBEmr3Se67JVQ0NdDgcFIrWZHrc8vKxiQ8BdQfGyLmnBk8GNdmVV6ay6mDRyF7 I4dnQJ5MfX2IYL68F2vPgtxsTeS6tSO4hAyrkb/nFVbySV4enSe/Qhr4I91eYWU1BoFwfUQID5g gPjZFvjWxAaY8Eg==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/open.c: In functions 'setattr_vfsuid' and 'setattr_vfsgid':
 warning: Function parameter or member 'attr' not described
 - Fix warning by removing kernel-doc for these as they are static
   inline functions and not required to be exposed via kernel-doc.

fs/open.c:
 warning: Excess function parameter 'opened' description in 'finish_open'
 warning: Excess function parameter 'cred' description in 'vfs_open'
 - Fix by removing the parameters from the kernel-doc as they are no
   longer required by the function.

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 fs/open.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 4401a73d4032..fd8fa5936b51 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -700,10 +700,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-/**
- * setattr_vfsuid - check and set ia_fsuid attribute
- * @kuid: new inode owner
- *
+/*
  * Check whether @kuid is valid and if so generate and set vfsuid_t in
  * ia_vfsuid.
  *
@@ -718,10 +715,7 @@ static inline bool setattr_vfsuid(struct iattr *attr, kuid_t kuid)
 	return true;
 }
 
-/**
- * setattr_vfsgid - check and set ia_fsgid attribute
- * @kgid: new inode owner
- *
+/*
  * Check whether @kgid is valid and if so generate and set vfsgid_t in
  * ia_vfsgid.
  *
@@ -989,7 +983,6 @@ static int do_dentry_open(struct file *f,
  * @file: file pointer
  * @dentry: pointer to dentry
  * @open: open callback
- * @opened: state of open
  *
  * This can be used to finish opening a file passed to i_op->atomic_open().
  *
@@ -1043,7 +1036,6 @@ EXPORT_SYMBOL(file_path);
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
-- 
2.39.2

