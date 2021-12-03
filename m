Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8071D46760E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380344AbhLCLVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38566 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380338AbhLCLVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D4CE62A23
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC42DC53FCB;
        Fri,  3 Dec 2021 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530268;
        bh=ISeyKi0TlYCytSf/otrhkh1eSsD3brK2C4qa7HTUdqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKPWt4clX96jQPz6j2znXrt8k+yZ9oJr1szBF42rL9N3uo30MaiecVZSNSRkAP0lp
         b/MwGTIOFqjBZEv925hrtrFoj3qqbkHmTEr0agES8iatkQP04Gaz5hdv3yCOQfFnHd
         iDgP5s6yTuUkwYOcnVXyx3bV4kcAJqfbsSTv1DDCshvQ1xDvtJs96dVvNKxITNm9tl
         3lAH9ivMncEKyIIEzhP4X4A/hSTiiQz8wC/zrC4MtTep+ylIFUDMlkyy/eyJrkp4PC
         kbqkwOV9psgUEkaD/D1du/A6i9TgOjGJGfLbGSXYCaenqLglp0xj8fM3COPDUjX0BU
         NU3jOFQGfzFEg==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 07/10] fs: remove unused low-level mapping helpers
Date:   Fri,  3 Dec 2021 12:17:04 +0100
Message-Id: <20211203111707.3901969-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3101; h=from:subject; bh=VIGzUwQ+L6krDSdxgl4gAtMNmExzq5L3nL9nzwUK/7M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DPdL/nAF0fn2X/OHhDZL3/6ebn8F0njxy/mOvbyRatF X56U01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARDnZGhufeLG43mlhXsua21n3pjj m8f4f05VXXH3m9uOsQfiH5mB/D/4LPj316hF+6qdpcXf2mS2WHps/Vhkb1oyx55ZkTJ/TcYwcA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we ported all places to use the new low-level mapping helpers
that are able to support filesystems mounted with an idmapping we can
remove the old low-level mapping helpers. With the removal of these old
helpers we also conclude the renaming of the mapping helpers we started
in [1].

[1]: commit a65e58e791a1 ("fs: document and rename fsid helpers")

Link: https://lore.kernel.org/r/20211123114227.3124056-8-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-8-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 include/linux/mnt_idmapping.h | 56 -----------------------------------
 1 file changed, 56 deletions(-)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 1c75d4e0b123..c4b604a0c256 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -13,62 +13,6 @@ struct user_namespace;
  */
 extern struct user_namespace init_user_ns;
 
-/**
- * kuid_into_mnt - map a kuid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return make_kuid(mnt_userns, __kuid_val(kuid));
-}
-
-/**
- * kgid_into_mnt - map a kgid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return make_kgid(mnt_userns, __kgid_val(kgid));
-}
-
-/**
- * kuid_from_mnt - map a kuid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped up according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
-}
-
-/**
- * kgid_from_mnt - map a kgid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped up according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
-}
-
 /**
  * initial_mapping - check whether this is the initial mapping
  * @ns: idmapping to check
-- 
2.30.2

