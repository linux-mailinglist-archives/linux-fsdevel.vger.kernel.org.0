Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C216AC2CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCFOQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 09:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCFOPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C525E2E
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 06:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F9E5B80E01
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 14:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E805C4339E;
        Mon,  6 Mar 2023 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678111912;
        bh=Ol5kTEXajHh7nN7pitu9gH0TwhorJTGazHlSpy8Eecc=;
        h=From:Date:Subject:To:Cc:From;
        b=Sv9QVigCB+uMlNsFhFUJfyDUz6TViWn85BjYbyN88f1DpE1O7K5Z9TV1IQbaIdAIn
         nA/6MvA4Ko1JwT8PhCpsiOcHcJwi7RElcTf3zLDvotdvA5arxPdBokR2dAYlA3ex5O
         26HjfdBaAwGMImqkYqyJh1uEFVP1b8GfCErVfCTygbCNYJxzv2nfYHUU2EVQm5x9iq
         6UTygaYglToyZCmTXkOZU3HpaL596p+6DOHMmgqAW8mGRnkkYDFuactWOuhuVERwaT
         Q5p1aTza1iov9R/Bb/hD+Dus84CTYWOwUZm9ugoyrjv4o4Ez0WRWPOiPN3kHPtBg4I
         RrQ4y3oC4Ddmw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 06 Mar 2023 15:11:42 +0100
Subject: [PATCH] Documentation: update idmappings.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230306-fs-documentation-idmapping-update-v1-1-29b4f43e6430@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ30BWQC/x2OwQ6DIBBEf8XsuWsQWpP2V5oeVliUA0gATRPjv
 3ftcWZeXuaAyiVwhVd3QOE91LAmCcOtA7tQmhmDkwxaaaOMGtFXdKvdIqdGTWDZI+Uc0oxbdtQ
 Yp7tW3jlW/vEE8UxUpSyU7HKZItXGpd/H3mCxw0Xkwj58/y/en/P8AUfyVWKVAAAA
To:     Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=17602; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ol5kTEXajHh7nN7pitu9gH0TwhorJTGazHlSpy8Eecc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSwflmu+OzMlRuiat5BodWvjFdulxOMKbY5ejb3rqqWck9T
 NotdRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ6TzMyfHyxdEHE4n0vNRcF+ru5xQ
 VE38nep3/msNHk6Kt/8+Tk7zP89ztuNLXoh7nc2SU11g4sJkWKmr7fP00qXGoblP9zhkEKCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quite a lot has changed over the last few kernel releases with the
introduction of vfs{g,u}id_t and struct mnt_idmap. Update the
documentation accordingly.

Cc: Seth Forshee <sforshee@kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 Documentation/filesystems/idmappings.rst | 178 ++++++++++++++++++++++---------
 1 file changed, 125 insertions(+), 53 deletions(-)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index b9b31066aef2..ad6d21640576 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -241,7 +241,7 @@ according to the filesystem's idmapping as this would give the wrong owner if
 the caller is using an idmapping.
 
 So the kernel will map the id back up in the idmapping of the caller. Let's
-assume the caller has the slighly unconventional idmapping
+assume the caller has the somewhat unconventional idmapping
 ``u3000:k20000:r10000`` then ``k21000`` would map back up to ``u4000``.
 Consequently the user would see that this file is owned by ``u4000``.
 
@@ -320,6 +320,10 @@ and equally wrong::
  from_kuid(u20000:k0:r10000, u1000) = k21000
                              ~~~~~
 
+Since userspace ids have type ``uid_t`` and ``gid_t`` and kernel ids have type
+``kuid_t`` and ``kgid_t`` the compiler will throw an error when they are
+conflated. So the two examples above would cause a compilation failure.
+
 Idmappings when creating filesystem objects
 -------------------------------------------
 
@@ -623,42 +627,105 @@ privileged users in the initial user namespace.
 However, it is perfectly possible to combine idmapped mounts with filesystems
 mountable inside user namespaces. We will touch on this further below.
 
+Filesystem types vs idmapped mount types
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+With the introduction of idmapped mounts we need to distinguish between
+filesystem ownership and mount ownership of a VFS object such as an inode. The
+owner of a inode might be different when looked at from a filesystem
+perspective than when looked at from an idmapped mount. Such fundamental
+conceptual distinctions should almost always be clearly expressed in the code.
+So, to distinguish idmapped mount ownership from filesystem ownership separate
+types have been introduced.
+
+If a uid or gid has been generated using the filesystem or caller's idmapping
+then we will use the ``kuid_t`` and ``kgid_t`` types. However, if a uid or gid
+has been generated using a mount idmapping then we will be using the dedicated
+``vfsuid_t`` and ``vfsgid_t`` types.
+
+All VFS helpers that generate or take uids and gids as arguments use the
+``vfsuid_t`` and ``vfsgid_t`` types and we will be able to rely on the compiler
+to catch errors that originate from conflating filesystem and VFS uids and gids.
+
+The ``vfsuid_t`` and ``vfsgid_t`` types are often mapped from and to ``kuid_t``
+and ``kgid_t`` types similar how ``kuid_t`` and ``kgid_t`` types are mapped
+from and to ``uid_t`` and ``gid_t`` types::
+
+ uid_t <--> kuid_t <--> vfsuid_t
+ gid_t <--> kgid_t <--> vfsgid_t
+
+Whenever we report ownership based on a ``vfsuid_t`` or ``vfsgid_t`` type,
+e.g., during ``stat()``, or store ownership information in a shared VFS object
+based on a ``vfsuid_t`` or ``vfsgid_t`` type, e.g., during ``chown()`` we can
+use the ``vfsuid_into_kuid()`` and ``vfsgid_into_kgid()`` helpers.
+
+To illustrate why this helper currently exists, consider what happens when we
+change ownership of an inode from an idmapped mount. After we generated
+a ``vfsuid_t`` or ``vfsgid_t`` based on the mount idmapping we later commit to
+this ``vfsuid_t`` or ``vfsgid_t`` to become the new filesytem wide ownership.
+Thus, we are turning the ``vfsuid_t`` or ``vfsgid_t`` into a global ``kuid_t``
+or ``kgid_t``. And this can be done by using ``vfsuid_into_kuid()`` and
+``vfsgid_into_kgid()``.
+
+Note, whenever a shared VFS object, e.g., a cached ``struct inode`` or a cached
+``struct posix_acl``, stores ownership information a filesystem or "global"
+``kuid_t`` and ``kgid_t`` must be used. Ownership expressed via ``vfsuid_t``
+and ``vfsgid_t`` is specific to an idmapped mount.
+
+We already noted that ``vfsuid_t`` and ``vfsgid_t`` types are generated based
+on mount idmappings whereas ``kuid_t`` and ``kgid_t`` types are generated based
+on filesystem idmappings. To prevent abusing filesystem idmappings to generate
+``vfsuid_t`` or ``vfsgid_t`` types or mount idmappings to generate ``kuid_t``
+or ``kgid_t`` types filesystem idmappings and mount idmappings are different
+types as well.
+
+All helpers that map to or from ``vfsuid_t`` and ``vfsgid_t`` types require
+a mount idmapping to be passed which is of type ``struct mnt_idmap``. Passing
+a filesystem or caller idmapping will cause a compilation error.
+
+Similar to how we prefix all userspace ids in this document with ``u`` and all
+kernel ids with ``k`` we will prefix all VFS ids with ``v``. So a mount
+idmapping will be written as: ``u0:v10000:r10000``.
+
 Remapping helpers
 ~~~~~~~~~~~~~~~~~
 
 Idmapping functions were added that translate between idmappings. They make use
-of the remapping algorithm we've introduced earlier. We're going to look at
-two:
+of the remapping algorithm we've introduced earlier. We're going to look at:
 
-- ``i_uid_into_mnt()`` and ``i_gid_into_mnt()``
+- ``i_uid_into_vfsuid()`` and ``i_gid_into_vfsgid()``
 
-  The ``i_*id_into_mnt()`` functions translate filesystem's kernel ids into
-  kernel ids in the mount's idmapping::
+  The ``i_*id_into_vfs*id()`` functions translate filesystem's kernel ids into
+  VFS ids in the mount's idmapping::
 
    /* Map the filesystem's kernel id up into a userspace id in the filesystem's idmapping. */
    from_kuid(filesystem, kid) = uid
 
-   /* Map the filesystem's userspace id down ito a kernel id in the mount's idmapping. */
+   /* Map the filesystem's userspace id down ito a VFS id in the mount's idmapping. */
    make_kuid(mount, uid) = kuid
 
 - ``mapped_fsuid()`` and ``mapped_fsgid()``
 
   The ``mapped_fs*id()`` functions translate the caller's kernel ids into
   kernel ids in the filesystem's idmapping. This translation is achieved by
-  remapping the caller's kernel ids using the mount's idmapping::
+  remapping the caller's VFS ids using the mount's idmapping::
 
-   /* Map the caller's kernel id up into a userspace id in the mount's idmapping. */
+   /* Map the caller's VFS id up into a userspace id in the mount's idmapping. */
    from_kuid(mount, kid) = uid
 
    /* Map the mount's userspace id down into a kernel id in the filesystem's idmapping. */
    make_kuid(filesystem, uid) = kuid
 
+- ``vfsuid_into_kuid()`` and ``vfsgid_into_kgid()``
+
+   Whenever
+
 Note that these two functions invert each other. Consider the following
 idmappings::
 
  caller idmapping:     u0:k10000:r10000
  filesystem idmapping: u0:k20000:r10000
- mount idmapping:      u0:k10000:r10000
+ mount idmapping:      u0:v10000:r10000
 
 Assume a file owned by ``u1000`` is read from disk. The filesystem maps this id
 to ``k21000`` according to its idmapping. This is what is stored in the
@@ -669,20 +736,21 @@ would usually simply use the crossmapping algorithm and map the filesystem's
 kernel id up to a userspace id in the caller's idmapping.
 
 But when the caller is accessing the file on an idmapped mount the kernel will
-first call ``i_uid_into_mnt()`` thereby translating the filesystem's kernel id
-into a kernel id in the mount's idmapping::
+first call ``i_uid_into_vfsuid()`` thereby translating the filesystem's kernel
+id into a VFS id in the mount's idmapping::
 
- i_uid_into_mnt(k21000):
+ i_uid_into_vfsuid(k21000):
    /* Map the filesystem's kernel id up into a userspace id. */
    from_kuid(u0:k20000:r10000, k21000) = u1000
 
-   /* Map the filesystem's userspace id down ito a kernel id in the mount's idmapping. */
-   make_kuid(u0:k10000:r10000, u1000) = k11000
+   /* Map the filesystem's userspace id down into a VFS id in the mount's idmapping. */
+   make_kuid(u0:v10000:r10000, u1000) = v11000
 
 Finally, when the kernel reports the owner to the caller it will turn the
-kernel id in the mount's idmapping into a userspace id in the caller's
+VFS id in the mount's idmapping into a userspace id in the caller's
 idmapping::
 
+  k11000 = vfsuid_into_kuid(v11000)
   from_kuid(u0:k10000:r10000, k11000) = u1000
 
 We can test whether this algorithm really works by verifying what happens when
@@ -696,18 +764,19 @@ fails.
 
 But when the caller is accessing the file on an idmapped mount the kernel will
 first call ``mapped_fs*id()`` thereby translating the caller's kernel id into
-a kernel id according to the mount's idmapping::
+a VFS id according to the mount's idmapping::
 
  mapped_fsuid(k11000):
     /* Map the caller's kernel id up into a userspace id in the mount's idmapping. */
     from_kuid(u0:k10000:r10000, k11000) = u1000
 
     /* Map the mount's userspace id down into a kernel id in the filesystem's idmapping. */
-    make_kuid(u0:k20000:r10000, u1000) = k21000
+    make_kuid(u0:v20000:r10000, u1000) = v21000
 
-When finally writing to disk the kernel will then map ``k21000`` up into a
+When finally writing to disk the kernel will then map ``v21000`` up into a
 userspace id in the filesystem's idmapping::
 
+   k21000 = vfsuid_into_kuid(v21000)
    from_kuid(u0:k20000:r10000, k21000) = u1000
 
 As we can see, we end up with an invertible and therefore information
@@ -725,7 +794,7 @@ Example 2 reconsidered
  caller id:            u1000
  caller idmapping:     u0:k10000:r10000
  filesystem idmapping: u0:k20000:r10000
- mount idmapping:      u0:k10000:r10000
+ mount idmapping:      u0:v10000:r10000
 
 When the caller is using a non-initial idmapping the common case is to attach
 the same idmapping to the mount. We now perform three steps:
@@ -734,12 +803,12 @@ the same idmapping to the mount. We now perform three steps:
 
     make_kuid(u0:k10000:r10000, u1000) = k11000
 
-2. Translate the caller's kernel id into a kernel id in the filesystem's
+2. Translate the caller's VFS id into a kernel id in the filesystem's
    idmapping::
 
-    mapped_fsuid(k11000):
-      /* Map the kernel id up into a userspace id in the mount's idmapping. */
-      from_kuid(u0:k10000:r10000, k11000) = u1000
+    mapped_fsuid(v11000):
+      /* Map the VFS id up into a userspace id in the mount's idmapping. */
+      from_kuid(u0:v10000:r10000, v11000) = u1000
 
       /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
       make_kuid(u0:k20000:r10000, u1000) = k21000
@@ -759,7 +828,7 @@ Example 3 reconsidered
  caller id:            u1000
  caller idmapping:     u0:k10000:r10000
  filesystem idmapping: u0:k0:r4294967295
- mount idmapping:      u0:k10000:r10000
+ mount idmapping:      u0:v10000:r10000
 
 The same translation algorithm works with the third example.
 
@@ -767,12 +836,12 @@ The same translation algorithm works with the third example.
 
     make_kuid(u0:k10000:r10000, u1000) = k11000
 
-2. Translate the caller's kernel id into a kernel id in the filesystem's
+2. Translate the caller's VFS id into a kernel id in the filesystem's
    idmapping::
 
-    mapped_fsuid(k11000):
-       /* Map the kernel id up into a userspace id in the mount's idmapping. */
-       from_kuid(u0:k10000:r10000, k11000) = u1000
+    mapped_fsuid(v11000):
+       /* Map the VFS id up into a userspace id in the mount's idmapping. */
+       from_kuid(u0:v10000:r10000, v11000) = u1000
 
        /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
        make_kuid(u0:k0:r4294967295, u1000) = k1000
@@ -792,7 +861,7 @@ Example 4 reconsidered
  file id:              u1000
  caller idmapping:     u0:k10000:r10000
  filesystem idmapping: u0:k0:r4294967295
- mount idmapping:      u0:k10000:r10000
+ mount idmapping:      u0:v10000:r10000
 
 In order to report ownership to userspace the kernel now does three steps using
 the translation algorithm we introduced earlier:
@@ -802,17 +871,18 @@ the translation algorithm we introduced earlier:
 
     make_kuid(u0:k0:r4294967295, u1000) = k1000
 
-2. Translate the kernel id into a kernel id in the mount's idmapping::
+2. Translate the kernel id into a VFS id in the mount's idmapping::
 
-    i_uid_into_mnt(k1000):
+    i_uid_into_vfsuid(k1000):
       /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
       from_kuid(u0:k0:r4294967295, k1000) = u1000
 
-      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
-      make_kuid(u0:k10000:r10000, u1000) = k11000
+      /* Map the userspace id down into a VFS id in the mounts's idmapping. */
+      make_kuid(u0:v10000:r10000, u1000) = v11000
 
-3. Map the kernel id up into a userspace id in the caller's idmapping::
+3. Map the VFS id up into a userspace id in the caller's idmapping::
 
+    k11000 = vfsuid_into_kuid(v11000)
     from_kuid(u0:k10000:r10000, k11000) = u1000
 
 Earlier, the caller's kernel id couldn't be crossmapped in the filesystems's
@@ -828,7 +898,7 @@ Example 5 reconsidered
  file id:              u1000
  caller idmapping:     u0:k10000:r10000
  filesystem idmapping: u0:k20000:r10000
- mount idmapping:      u0:k10000:r10000
+ mount idmapping:      u0:v10000:r10000
 
 Again, in order to report ownership to userspace the kernel now does three
 steps using the translation algorithm we introduced earlier:
@@ -838,17 +908,18 @@ steps using the translation algorithm we introduced earlier:
 
     make_kuid(u0:k20000:r10000, u1000) = k21000
 
-2. Translate the kernel id into a kernel id in the mount's idmapping::
+2. Translate the kernel id into a VFS id in the mount's idmapping::
 
-    i_uid_into_mnt(k21000):
+    i_uid_into_vfsuid(k21000):
       /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
       from_kuid(u0:k20000:r10000, k21000) = u1000
 
-      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
-      make_kuid(u0:k10000:r10000, u1000) = k11000
+      /* Map the userspace id down into a VFS id in the mounts's idmapping. */
+      make_kuid(u0:v10000:r10000, u1000) = v11000
 
-3. Map the kernel id up into a userspace id in the caller's idmapping::
+3. Map the VFS id up into a userspace id in the caller's idmapping::
 
+    k11000 = vfsuid_into_kuid(v11000)
     from_kuid(u0:k10000:r10000, k11000) = u1000
 
 Earlier, the file's kernel id couldn't be crossmapped in the filesystems's
@@ -899,23 +970,23 @@ from above:::
  caller id:            u1125
  caller idmapping:     u0:k0:r4294967295
  filesystem idmapping: u0:k0:r4294967295
- mount idmapping:      u1000:k1125:r1
+ mount idmapping:      u1000:v1125:r1
 
 1. Map the caller's userspace ids into kernel ids in the caller's idmapping::
 
     make_kuid(u0:k0:r4294967295, u1125) = k1125
 
-2. Translate the caller's kernel id into a kernel id in the filesystem's
+2. Translate the caller's VFS id into a kernel id in the filesystem's
    idmapping::
 
-    mapped_fsuid(k1125):
-      /* Map the kernel id up into a userspace id in the mount's idmapping. */
-      from_kuid(u1000:k1125:r1, k1125) = u1000
+    mapped_fsuid(v1125):
+      /* Map the VFS id up into a userspace id in the mount's idmapping. */
+      from_kuid(u1000:v1125:r1, v1125) = u1000
 
       /* Map the userspace id down into a kernel id in the filesystem's idmapping. */
       make_kuid(u0:k0:r4294967295, u1000) = k1000
 
-2. Verify that the caller's kernel ids can be mapped to userspace ids in the
+2. Verify that the caller's filesystem ids can be mapped to userspace ids in the
    filesystem's idmapping::
 
     from_kuid(u0:k0:r4294967295, k1000) = u1000
@@ -930,24 +1001,25 @@ on their work computer:
  file id:              u1000
  caller idmapping:     u0:k0:r4294967295
  filesystem idmapping: u0:k0:r4294967295
- mount idmapping:      u1000:k1125:r1
+ mount idmapping:      u1000:v1125:r1
 
 1. Map the userspace id on disk down into a kernel id in the filesystem's
    idmapping::
 
     make_kuid(u0:k0:r4294967295, u1000) = k1000
 
-2. Translate the kernel id into a kernel id in the mount's idmapping::
+2. Translate the kernel id into a VFS id in the mount's idmapping::
 
-    i_uid_into_mnt(k1000):
+    i_uid_into_vfsuid(k1000):
       /* Map the kernel id up into a userspace id in the filesystem's idmapping. */
       from_kuid(u0:k0:r4294967295, k1000) = u1000
 
-      /* Map the userspace id down into a kernel id in the mounts's idmapping. */
-      make_kuid(u1000:k1125:r1, u1000) = k1125
+      /* Map the userspace id down into a VFS id in the mounts's idmapping. */
+      make_kuid(u1000:v1125:r1, u1000) = v1125
 
-3. Map the kernel id up into a userspace id in the caller's idmapping::
+3. Map the VFS id up into a userspace id in the caller's idmapping::
 
+    k1125 = vfsuid_into_kuid(v1125)
     from_kuid(u0:k0:r4294967295, k1125) = u1125
 
 So ultimately the caller will be reported that the file belongs to ``u1125``

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230306-fs-documentation-idmapping-update-b420fdde0f59

