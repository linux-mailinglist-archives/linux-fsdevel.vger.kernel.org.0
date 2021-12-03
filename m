Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05D46760C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380337AbhLCLVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380325AbhLCLVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1BC06173E
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 03:17:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96D43B826A4
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2EBC53FCB;
        Fri,  3 Dec 2021 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530262;
        bh=Gi09/dGBZUuIw7aV5GXtyj4QqZWY8eFud7kBFP+gv6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMibSRtybtWalMvs76+c2aAbjxVZbjR7zY5rWcaEESn+nbl+crq2w3ReoEsZHe8zo
         l+mjcSozAqZtR8sMHBQwWB8hBMTX51kfkxFvu4ZFuZ3k+YVXOOes7LLAd9IdFIg580
         pZ0GhUt4HSIsZ+oIjLMivX2xvJeA0q5w+wQSqJ0j67YJfsGnl6oGxQXPQbIwPadxh1
         omt+3C9lJd34hFy/HjY7v3LDZHV9T4fRJGYvAjQKOzcUQXq+qr74okFHNLVXflJ400
         WUIegmB00bWYGJm35Loh8i1W8AhP8/PMgR8Ltl/t5VgUQjje4Ip8pIU3bl79Da0ACO
         znIdUpnvBGImA==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 05/10] docs: update mapping documentation
Date:   Fri,  3 Dec 2021 12:17:02 +0100
Message-Id: <20211203111707.3901969-6-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; h=from:subject; bh=Z+0WDhLfstZTq2Cn4vb6q3bQtHuo/gQxKu1BUX9ur3k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DOtbv8So/46GeNjyyydHyrLWOgkFYjG3Ns5QW/FtfKr ncpuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZMYeR4dck5ml3Q2UvuNnN3FK3K4 hp1Wyvh5/9HsdpnfLy2XLWuIbhD2/Cb+MnCrccLi6697ZSrr1phrBk2/njLnLO5kfL3ouaMwEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we implement the full remapping algorithms described in our
documentation remove the section about shortcircuting them.

Link: https://lore.kernel.org/r/20211123114227.3124056-6-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-6-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 Documentation/filesystems/idmappings.rst | 72 ------------------------
 1 file changed, 72 deletions(-)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index 1229a75ec75d..7a879ec3b6bf 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -952,75 +952,3 @@ The raw userspace id that is put on disk is ``u1000`` so when the user takes
 their home directory back to their home computer where they are assigned
 ``u1000`` using the initial idmapping and mount the filesystem with the initial
 idmapping they will see all those files owned by ``u1000``.
-
-Shortcircuting
---------------
-
-Currently, the implementation of idmapped mounts enforces that the filesystem
-is mounted with the initial idmapping. The reason is simply that none of the
-filesystems that we targeted were mountable with a non-initial idmapping. But
-that might change soon enough. As we've seen above, thanks to the properties of
-idmappings the translation works for both filesystems mounted with the initial
-idmapping and filesystem with non-initial idmappings.
-
-Based on this current restriction to filesystem mounted with the initial
-idmapping two noticeable shortcuts have been taken:
-
-1. We always stash a reference to the initial user namespace in ``struct
-   vfsmount``. Idmapped mounts are thus mounts that have a non-initial user
-   namespace attached to them.
-
-   In order to support idmapped mounts this needs to be changed. Instead of
-   stashing the initial user namespace the user namespace the filesystem was
-   mounted with must be stashed. An idmapped mount is then any mount that has
-   a different user namespace attached then the filesystem was mounted with.
-   This has no user-visible consequences.
-
-2. The translation algorithms in ``mapped_fs*id()`` and ``i_*id_into_mnt()``
-   are simplified.
-
-   Let's consider ``mapped_fs*id()`` first. This function translates the
-   caller's kernel id into a kernel id in the filesystem's idmapping via
-   a mount's idmapping. The full algorithm is::
-
-    mapped_fsuid(kid):
-      /* Map the kernel id up into a userspace id in the mount's idmapping. */
-      from_kuid(mount-idmapping, kid) = uid
-
-      /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
-      make_kuid(filesystem-idmapping, uid) = kuid
-
-   We know that the filesystem is always mounted with the initial idmapping as
-   we enforce this in ``mount_setattr()``. So this can be shortened to::
-
-    mapped_fsuid(kid):
-      /* Map the kernel id up into a userspace id in the mount's idmapping. */
-      from_kuid(mount-idmapping, kid) = uid
-
-      /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
-      KUIDT_INIT(uid) = kuid
-
-   Similarly, for ``i_*id_into_mnt()`` which translated the filesystem's kernel
-   id into a mount's kernel id::
-
-    i_uid_into_mnt(kid):
-      /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
-      from_kuid(filesystem-idmapping, kid) = uid
-
-      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
-      make_kuid(mount-idmapping, uid) = kuid
-
-   Again, we know that the filesystem is always mounted with the initial
-   idmapping as we enforce this in ``mount_setattr()``. So this can be
-   shortened to::
-
-    i_uid_into_mnt(kid):
-      /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
-      __kuid_val(kid) = uid
-
-      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
-      make_kuid(mount-idmapping, uid) = kuid
-
-Handling filesystems mounted with non-initial idmappings requires that the
-translation functions be converted to their full form. They can still be
-shortcircuited on non-idmapped mounts. This has no user-visible consequences.
-- 
2.30.2

