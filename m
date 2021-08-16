Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603713EDFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhHPW11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhHPW10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:27:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E19C061764;
        Mon, 16 Aug 2021 15:26:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i28so10741010lfl.2;
        Mon, 16 Aug 2021 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UtcWyxKanqewyEomH7eaNfuTOc6IlC0Xy1k7aGXlSE=;
        b=lcmw3r8FU2y1XXC9wKun2gZLoWzE7JpjpAtecByfo530tgsRxDOB8tgzGswBiNxdOg
         My4dP3IqasAamCFXowpoKM+/IZ5QzxvF9x05/7pLUUGty3nuoPG7lItd3Ul/5SRzjQMc
         0gqqzH1mMjVpACQetrx6Uj8BJ4G7U4Rv+ZjJuFHlMl3E57zw29z2Ox2jiMFZPpbJ05VE
         R2j5/lQkhARZNwJAUPswAoKLErqr8J7eJzPpEEp7jNhpurlZhadZ/dFcQ/DNGiTC6nky
         2CzYwSZrgREyJ4sLrrWMV54fQ6x/8sN8XFut1Y0WmBkCTIKWEayF3d7KnREIDQHejx9N
         tG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UtcWyxKanqewyEomH7eaNfuTOc6IlC0Xy1k7aGXlSE=;
        b=WzLbPmu0GznP0kvVGWAO36x+dDch/lO1GKzf72/SYb6H13zFeTWGjZgtDEw8g2wSFy
         He9wQrGQO1XOz20ZeUFuL8zG5aj+7NtBn+13leT+djo0UmgYISLihAvUUeRLPugh0fQE
         YlTZSx9fSTYoL2OLOSBArFxw26cn/1tv7F9Iqmr0yPCGwu0VNDZXF9zHgby1gTST8LVn
         yIqFQsO8+VTGlwORYtR3edgf6JI0pEOwLg2jE6bY/aEU8A7VUaY08Na1JnT6BGEjmTTb
         ZeCc0otegxDGH89fxPD8PP6hjaisjsHCVrM7e8oHO3rslgTWMPTuo8GWVwtUU+5fe/i8
         Cz2Q==
X-Gm-Message-State: AOAM531lWIWqMf/ulK8wPs8c95lMlw6jqR+iHeMVrkc699uqSBm07GAM
        nKLya4iKem8ET7I6VtDeNCp+SRiqqmh6LdCX
X-Google-Smtp-Source: ABdhPJyoJ6NSRGihDkLk201nJTRz2gF+IcdRIgJZG2YQ0PK67BT1MS4181R6iv0MD4L3OpHYDLrxmw==
X-Received: by 2002:ac2:5108:: with SMTP id q8mr41408lfb.334.1629152812907;
        Mon, 16 Aug 2021 15:26:52 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j13sm16563lfe.48.2021.08.16.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 15:26:52 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] docs: fs: Refactor directory-locking.rst for better reading
Date:   Tue, 17 Aug 2021 01:26:39 +0300
Message-Id: <20210816222639.73838-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reorganize classes so that it is easier to read. Before number 4 was
written in one lenghty paragraph. It is as long as number 6 and it is
basically same kind of class (rename()). Also old number 5 was list and
it is as short as 1, 2, 3 so it can be converted non list.

This makes file now much readible.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 .../filesystems/directory-locking.rst         | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index 504ba940c36c..33921dff7af4 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -11,7 +11,7 @@ When taking the i_rwsem on multiple non-directory objects, we
 always acquire the locks in order by increasing address.  We'll call
 that "inode pointer" order in the following.
 
-For our purposes all operations fall in 5 classes:
+For our purposes all operations fall in 6 classes:
 
 1) read access.  Locking rules: caller locks directory we are accessing.
 The lock is taken shared.
@@ -22,26 +22,25 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks
-the parent and finds source and target.  In case of exchange (with
-RENAME_EXCHANGE in flags argument) lock both.  In any case,
-if the target already exists, lock it.  If the source is a non-directory,
-lock it.  If we need to lock both, lock them in inode pointer order.
-Then call the method.  All locks are exclusive.
-NB: we might get away with locking the source (and target in exchange
-case) shared.
+4) link creation.  Locking rules: lock parent, check that source is not
+a directory, lock source and call the method.  Locks are exclusive.
 
-5) link creation.  Locking rules:
+5) rename() that is _not_ cross-directory.
+Locking rules:
 
-	* lock parent
-	* check that source is not a directory
-	* lock source
-	* call the method.
+	* Caller locks the parent and finds source and target.
+	* In case of exchange (with RENAME_EXCHANGE in flags argument)
+	  lock both the source and the target.
+	* If the target exists, lock it,  If the source is a non-directory,
+	  lock it. If we need to lock both, do so in inode pointer order.
+	* Call the method.
 
 All locks are exclusive.
+NB: we might get away with locking the source (and target in exchange
+case) shared.
 
-6) cross-directory rename.  The trickiest in the whole bunch.  Locking
-rules:
+6) rename() that _is_ cross-directory.  The trickiest in the whole bunch.
+Locking rules:
 
 	* lock the filesystem
 	* lock parents in "ancestors first" order.
-- 
2.30.2

