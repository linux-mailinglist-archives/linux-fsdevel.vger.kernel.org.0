Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9A561CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiF3OKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 10:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiF3OKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:10:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1A7B34D;
        Thu, 30 Jun 2022 06:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC59CB82AF8;
        Thu, 30 Jun 2022 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661FAC34115;
        Thu, 30 Jun 2022 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656597325;
        bh=n6pCRpxRo1ejolie+HwU9V9duHfbqPeFU7Zrwi/AZt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXG8VpV5r34mtYYBUDk6FuRXKXKOZiFgU+0Hh8mtsIUKDKgZgVj77H/dvaPckOYsp
         GypL8nqyj97UJiOaQREneOYzXSrPCuDl0BTS7vdKozTlxGun7a0xym8sNqVhLy7LsJ
         gN7QDH0Uj13znq4+ZIxmeh+iOY2+mquXH12Wj0cI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
Subject: [PATCH 5.15 17/28] docs: update mapping documentation
Date:   Thu, 30 Jun 2022 15:47:13 +0200
Message-Id: <20220630133233.434921899@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630133232.926711493@linuxfoundation.org>
References: <20220630133232.926711493@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

commit 8cc5c54de44c5e8e104d364a627ac4296845fc7f upstream.

Now that we implement the full remapping algorithms described in our
documentation remove the section about shortcircuting them.

Link: https://lore.kernel.org/r/20211123114227.3124056-6-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-6-brauner@kernel.org (v2)
Link: https://lore.kernel.org/r/20211203111707.3901969-6-brauner@kernel.org
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/idmappings.rst |   72 -------------------------------
 1 file changed, 72 deletions(-)

--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -952,75 +952,3 @@ The raw userspace id that is put on disk
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


