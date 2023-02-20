Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CEB69D427
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjBTTiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjBTTiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FFB76C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:17 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 591E63F11A
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921893;
        bh=YuLEnjWYJ3ZScY+VoOmH9vHwx7aNhN3sNU3joAeNQOc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=EdUW7Ibc1jkTOD0nvqm1UoGc+Zbo1m2RNs9WDbPiWf4eHmSdECDqcffCYEuYvdYJL
         mLaGa7mimuwY3i2MaKbTcRSld/NFUN8JJHKx+m5MZ+d5uXlDDyQerpnxdpl+SozefJ
         rV624aUKl6cv3QIo0sgjqFonnFGDtV4KVDLdg8jwPmaJK21jccoyNpcFnWr3UB0OiP
         MSOdXO3RwFV8ovDMXrUQwvkELOlsA67TQCfgwE9bqC92TSXcVJ5OxIB5rGRF7A5jca
         kYsFg5ycVZoPE0DIjtQ3YTKvZJ1tojb4o/PyKe3tbwPbRhNkGk+PSIJ37n7TC99pAb
         nFlxIIrQp1DYA==
Received: by mail-ed1-f72.google.com with SMTP id cy28-20020a0564021c9c00b004acc6cf6322so2975412edb.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuLEnjWYJ3ZScY+VoOmH9vHwx7aNhN3sNU3joAeNQOc=;
        b=CdboVeJKIcwCZwh2pT95a7xtniZJV1bjplZCmwUllU6Gj/JH8ubrxF3wQSIJndc84w
         e1yW8p+AeoKcrRQ1LrVyjHEkkMo6MdQJR4IfJyCWC+nADCZPQbaHk+ieWGxszYdG0W8c
         GB9LaZV6QaqQn9kjs5mxyWfuC2I6uY5dOdRMu1T3CSlE/PZcd+1WMvVHWD0Efw4NqLLW
         fjAtm6HzEN9KNdX8zxluLK6UpNETZewPEe5jeOil+AfJw9ozdGIDlw1R5rHSYezElzmG
         bKq6t68dGZBiBWeeAMo3w0807z0ajEOU3HKs+8mATs1xvmVNYk+cMcGFEuasw7vodEd2
         Em2w==
X-Gm-Message-State: AO0yUKVe+oVNRFrm777HdFGv3rtGG2QcA7N6X7Z/yK16GFylZnut2BaQ
        M3TQpVQywMhimXY5fu5XltKE/w9mkvOBGPBowUavaoCZh+XarMCsjY/tqDMkiJLZOl0N+Tlg15h
        S4GHK4r2iusmy2G6KgITp/qBgiV/clrCteYnwm57YGfA5apwP51I=
X-Received: by 2002:a17:906:264d:b0:8a9:e330:3a23 with SMTP id i13-20020a170906264d00b008a9e3303a23mr9886639ejc.26.1676921892767;
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+dotV8WedmVXCpUfp7Rt1J+dl2VV8JXLR/YqSls60Skj61wTIhQpTDznIUMAwG11YbDKBOeg==
X-Received: by 2002:a17:906:264d:b0:8a9:e330:3a23 with SMTP id i13-20020a170906264d00b008a9e3303a23mr9886624ejc.26.1676921892581;
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 1/9] fuse: move FUSE_DEFAULT_* defines to fuse common header
Date:   Mon, 20 Feb 2023 20:37:46 +0100
Message-Id: <20230220193754.470330-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e13a8eff2e3d..4be7c404da4b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,12 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/** Maximum number of outstanding background requests */
+#define FUSE_DEFAULT_MAX_BACKGROUND 12
+
+/** Congestion starts at 75% of maximum */
+#define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 114bdb3f7ccb..097b7049057e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -53,12 +53,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 
 #define FUSE_DEFAULT_BLKSIZE 512
 
-/** Maximum number of outstanding background requests */
-#define FUSE_DEFAULT_MAX_BACKGROUND 12
-
-/** Congestion starts at 75% of maximum */
-#define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
-
 #ifdef CONFIG_BLOCK
 static struct file_system_type fuseblk_fs_type;
 #endif
-- 
2.34.1

