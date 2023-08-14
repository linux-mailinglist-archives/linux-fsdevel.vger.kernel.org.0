Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7377BEFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHNR33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHNR25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:57 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10583133
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:56 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51bee352ffcso3036900a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034134; x=1692638934;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smHHZUXo6xifLxvzSdFKZuUE8vzgs5PoROM2xnAb1UU=;
        b=MmICPA+CBs0ocp8vk0U5aDzxtXLls/Da9mjxg3tWq5UHM37KvQHj9TtYVrpEQ5dkfr
         BTJZesfkpmlWL5xX9gL9fD52AaWffPyLQ7ea0v9+TPgzmOJT4TsnZc/IzKirh6oEH50s
         K1OJpxQ3AbBfQzCHIBP98X6s8qCWxL+5Q+yXWMHMd9GRObLn3lZKWat9BAK21yWwgeyF
         JmcKT7XQn618XBmzaVjVoWBUjASU1q4DpOMHd8FPnMALqMDMjqRsPvaVQW8rnrmEyUNa
         c1qY+zbAeal3t5q13QJfbz1rYML33vj1OU6Cp6HMNbP7kr0DBwk0cMQhzCa69naHldxa
         lubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034134; x=1692638934;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=smHHZUXo6xifLxvzSdFKZuUE8vzgs5PoROM2xnAb1UU=;
        b=Rop33HTGpswb5AqMY9kRyxy9ckehhR9jILTRYzPsqdYfKBvCBSnWs693uG8Zq492XZ
         KurqWzW+xlMPw3bNlSRrvPrf85dXk42iwRd4w9NSyDl3ZcWK1bFwRDSenvIbIt5ReQrG
         ROnsS+Zqd7Oo1yCmy5rxlIPyN7gLa1t1iRXbOj55LcMqzn9rv7eKDe1x2hkKB6nROUKP
         XQMbWu3fiLOqkJbSLjmWjGtp3YSQzWF7ZYcGp02JzKDRist/u0em+xTJuMjh+WxeaikB
         tu4GHBXie0yyU+VDeUx+QXCD9tPCvLhbZvTaq8KkTOqiEcFzwb8sNp6QKzAybo9ANS4E
         G+iQ==
X-Gm-Message-State: AOJu0YxKFzwaCW0/ykZrn+h4ujB/qFiDfGoHjS82yi76kjdPbGtr7vae
        7F+FpoDVDQy0cavKQG5HbsUfdNRuUKM=
X-Google-Smtp-Source: AGHT+IHmqMu/X9mmCiJCAAI9Pit6YQDW4JrH5hSYyJasXbkHuB54lsl2W5ZNCk/WmrELpo/GXDLWDp8pH9c=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a50:9e48:0:b0:525:4afe:dd7f with SMTP id
 z66-20020a509e48000000b005254afedd7fmr41439ede.6.1692034134651; Mon, 14 Aug
 2023 10:28:54 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:16 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-6-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 5/5] landlock: Document ioctl support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the paragraph above the fallback logic, use the shorter phrasing
from the landlock(7) man page.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 74 ++++++++++++++++++------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index d8cd8cd9ce25..e0e35e474307 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -61,18 +61,17 @@ the need to be explicit about the denied-by-default acc=
ess rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_IOCTL,
     };
=20
 Because we may not know on which kernel version an application will be
 executed, it is safer to follow a best-effort security approach.  Indeed, =
we
 should try to protect users as much as possible whatever the kernel they a=
re
-using.  To avoid binary enforcement (i.e. either all security features or
-none), we can leverage a dedicated Landlock command to get the current ver=
sion
-of the Landlock ABI and adapt the handled accesses.  Let's check if we sho=
uld
-remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
-access rights, which are only supported starting with the second and third
-version of the ABI.
+using.
+
+To be compatible with older Linux versions, we detect the available Landlo=
ck ABI
+version, and only use the available subset of access rights:
=20
 .. code-block:: c
=20
@@ -92,6 +91,9 @@ version of the ABI.
     case 2:
         /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
         ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_TRUNCATE;
+    case 3:
+        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
+        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
     }
=20
 This enables to create an inclusive ruleset that will contain our rules.
@@ -190,6 +192,7 @@ access rights per directory enables to change the locat=
ion of such directory
 without relying on the destination directory access rights (except those t=
hat
 are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
 documentation).
+
 Having self-sufficient hierarchies also helps to tighten the required acce=
ss
 rights to the minimal set of data.  This also helps avoid sinkhole directo=
ries,
 i.e.  directories where data can be linked to but not linked from.  Howeve=
r,
@@ -283,18 +286,24 @@ It should also be noted that truncating files does no=
t require the
 system call, this can also be done through :manpage:`open(2)` with the fla=
gs
 ``O_RDONLY | O_TRUNC``.
=20
-When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
``
-right is associated with the newly created file descriptor and will be use=
d for
-subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavio=
r is
-similar to opening a file for reading or writing, where permissions are ch=
ecked
-during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)=
` and
+The truncate right is associated with the opened file (see below).
+
+Rights associated with file descriptors
+---------------------------------------
+
+When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
`` and
+``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly created f=
ile
+descriptor and will be used for subsequent truncation and ioctl attempts u=
sing
+:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is similar =
to
+opening a file for reading or writing, where permissions are checked durin=
g
+:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
 :manpage:`write(2)` calls.
=20
-As a consequence, it is possible to have multiple open file descriptors fo=
r the
-same file, where one grants the right to truncate the file and the other d=
oes
-not.  It is also possible to pass such file descriptors between processes,
-keeping their Landlock properties, even when these processes do not have a=
n
-enforced Landlock ruleset.
+As a consequence, it is possible to have multiple open file descriptors
+referring to the same file, where one grants the truncate or ioctl right a=
nd the
+other does not.  It is also possible to pass such file descriptors between
+processes, keeping their Landlock properties, even when these processes do=
 not
+have an enforced Landlock ruleset.
=20
 Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -422,6 +431,27 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restric=
ted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
=20
+IOCTL support
+-------------
+
+The ``LANDLOCK_ACCESS_FS_IOCTL`` access right restricts the use of
+:manpage:`ioctl(2)`, but it only applies to newly opened files.  This mean=
s
+specifically that pre-existing file descriptors like STDIN, STDOUT and STD=
ERR
+are unaffected.
+
+Users should be aware that TTY devices have traditionally permitted to con=
trol
+other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` =
IOCTL
+commands.  It is therefore recommended to close inherited TTY file descrip=
tors.
+The :manpage:`isatty(3)` function checks whether a given file descriptor i=
s a
+TTY.
+
+Landlock's IOCTL support is coarse-grained at the moment, but may become m=
ore
+fine-grained in the future.  Until then, users are advised to establish th=
e
+guarantees that they need through the file hierarchy, by only permitting t=
he
+``LANDLOCK_ACCESS_FS_IOCTL`` right on files where it is really harmless.  =
In
+cases where you can control the mounts, the ``nodev`` mount option can hel=
p to
+rule out that device files can be accessed.
+
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -451,6 +481,16 @@ always allowed when using a kernel that only supports =
the first or second ABI.
 Starting with the Landlock ABI version 3, it is now possible to securely c=
ontrol
 truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
=20
+Ioctl (ABI < 4)
+---------------
+
+IOCTL operations could not be denied before the fourth Landlock ABI, so
+:manpage:`ioctl(2)` is always allowed when using a kernel that only suppor=
ts an
+earlier ABI.
+
+Starting with the Landlock ABI version 4, it is possible to restrict the u=
se of
+:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access righ=
t.
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.41.0.694.ge786442a9b-goog

