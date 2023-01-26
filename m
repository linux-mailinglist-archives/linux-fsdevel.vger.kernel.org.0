Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2167C877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAZKXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 05:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjAZKXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:23:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7534009
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 02:23:31 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DBD63F519
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674728607;
        bh=91cMdy/ERUQzt1P3vEtiD/XuVXRUxgUmYBXc4oG5b0Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=btYrumih+9fDBu7TkMl2uvkT/GAJ1V/rzpvVYcWbwi6oqzuklw2K4GZHi+I2JQEfF
         MCoszRwI+yOfvBJKSpgecwPyOL2qc9xwf0tN1EfGx3mVgP1ZNI+rs+uCBd/apgjH6c
         +xNHYyOAY7ebwyJGmk9qwEm0YwSQ/fBFoCsGz2Dp+vhKXVcTRhMGyyjrTN4+XyHJpE
         DGbfv5d3noE3O6ygn7vjIoIDS/4T1n0ouy01u5DIqK8tIB9ztU/+pkp5+VSGBzsc9U
         KwQ991mR4T9M5wjrxkwqFDOW11UoDqvnH83FH9biE2qancdNj59wrAuoHXAYn1LHPn
         z2jy0NKsTaOoA==
Received: by mail-ed1-f70.google.com with SMTP id b15-20020a056402350f00b0049e42713e2bso1158897edd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 02:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91cMdy/ERUQzt1P3vEtiD/XuVXRUxgUmYBXc4oG5b0Q=;
        b=aFzuOLAPX6IMKVMNvks7+NMvfLtMpHLFcG1DIpbb6ATnUUYcAh3rB7DsazqFyqkw7F
         IUFuOO/qYq0tnLd8oNxuu7EwU3fX0oX8aU3pinXCUtyDt9FC4iE+jAoxTaIMaRZ8v1pV
         QLpO1Nkmr28V7QNXR8WyxCi2Azh09ZsWJ8Z2Wsoz4yQIoOUlta1UkwCGVhzOL6QKzpML
         PjXFR/q55x8VzSF9HIORHsV9q9/9QKxM5wnwJtcwtgP5Cm4Ga+8tYVIF2nJZWJiRMTXQ
         1pv00bDwo65J+ONbzKnu3p1w1UPHfwCyaYHjnoSNXlFm3TpCRL7THdMFAPs1zTtBh18H
         nEkA==
X-Gm-Message-State: AFqh2kopxYDqrjaEl6K91L3D7Zib7CBngvMFo4BE0LlOhoTB/mhAQI2f
        esHjpi6aOm/VKAuaBP6PZREVPgFL7HbmO2SDN5SW6vZ6kmBKA4cwrnA2TWj/pZbt577fP/J6p69
        euwid6VgH3NcvT71TNsDIxHjBcfVs41oYo7qElz1msOY=
X-Received: by 2002:a17:906:bc58:b0:872:2cc4:6882 with SMTP id s24-20020a170906bc5800b008722cc46882mr39340654ejv.58.1674728606929;
        Thu, 26 Jan 2023 02:23:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtCtGCknzblV1uqycJqUePaBU478MWemDnq/tGBpwurKaVL7o8uJYrhjcZORSmU7TqiDTUZKg==
X-Received: by 2002:a17:906:bc58:b0:872:2cc4:6882 with SMTP id s24-20020a170906bc5800b008722cc46882mr39340646ejv.58.1674728606787;
        Thu, 26 Jan 2023 02:23:26 -0800 (PST)
Received: from amikhalitsyn.. (ip5f5bd0c1.dynamic.kabel-deutschland.de. [95.91.208.193])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906861900b008675df83251sm383877ejx.34.2023.01.26.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:23:26 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: add inode/permission checks to fileattr_get/fileattr_set
Date:   Thu, 26 Jan 2023 11:23:18 +0100
Message-Id: <20230126102318.177838-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It looks like these checks were accidentally lost during the
conversion to fileattr API.

Fixes: 72227eac177d ("fuse: convert to fileattr")
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 61d8afcb10a3..d2cd3469b9cc 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -419,6 +419,12 @@ static struct fuse_file *fuse_priv_ioctl_prepare(struct inode *inode)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	bool isdir = S_ISDIR(inode->i_mode);
 
+	if (!fuse_allow_current_process(fm->fc))
+		return ERR_PTR(-EACCES);
+
+	if (fuse_is_bad(inode))
+		return ERR_PTR(-EIO);
+
 	if (!S_ISREG(inode->i_mode) && !isdir)
 		return ERR_PTR(-ENOTTY);
 
-- 
2.34.1

