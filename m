Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFF4633EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhK3MO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:14:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36638 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhK3MO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:14:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAB7FCE1870
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 12:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E4DC53FC7;
        Tue, 30 Nov 2021 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274266;
        bh=6Pr8lzDqzC+up5thj0Su/Q3b5q/7i6Jqx96VC8hoG0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOI45RfEEBCpjvhj1dX8Xz7md3jwPcxJvupY2oL8GxQcbmz+czmtIx0GifugNrQeN
         ScVrMX9juMalZleoHlKywYHWXrPF/JIeDHVUAIBzAhEh4sh1OIJ90C64KNr6GnZgoy
         5IAGMYbcF6RadzSd6EWaKerX2sd7ht2ia8IWClzZIEf+L0+3NjUQAPZcGi3PHdgyqs
         6rDTAFFHJv08c05YKAYmpA+l7HlKcrnIt+6+89psq632ipKFUjuz4MiqSizxwsw5F1
         yfEl6Dp2kPS6DWZv0cMdaf4CRJAgv+Q5Tko8fWITa0EECFly9AxzAcsGu5yfeDxKeP
         YagxXy8McJibw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 07/10] fs: remove unused low-level mapping helpers
Date:   Tue, 30 Nov 2021 13:10:29 +0100
Message-Id: <20211130121032.3753852-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130121032.3753852-1-brauner@kernel.org>
References: <20211130121032.3753852-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; h=from:subject; bh=v04sINyrbgwhwwhDbRSkinK01PBvpw4KmFBDYnF2EUU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQuE1mVv9DOZot5n0n91X+79jgzCv1cZcxuXJA73aTtiK2z 8vfUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkejMyXH173dTjr7GkPuu1E/v7at nLXLrZr9k845i9oOamoFPZTob/HsELCwVFo/M28l0J2BH39NJtXTH+Z6xXpi57Ozm7KsaBDwA=
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
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
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

