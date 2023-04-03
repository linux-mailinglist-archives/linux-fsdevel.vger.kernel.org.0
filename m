Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4758A6D4A68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjDCOqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjDCOqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07134D4F85
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7127B3F241
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533138;
        bh=jf893Mr1zYfCNeUs9dWOENLdN29rryafRcjFVjzmYec=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=eCq3NwXmcQ+rj3YxAF9NeovFVyRLHMHqpEwk36O58poscmOSDnBbURKIf+96sPeff
         kDuOo7eUWZdyXlTjvHSo6J4wY1rwo7mcQSSagaLGorLHPve2WnS5CPgjbXVaAVjce5
         xpf/jqDrU9hWtZ3gGQhrYH/83Upx69ppL08wI4h0MMcTiPWNKNWafKfMh2CLiTc9ft
         hqDJKUdUxqG+Id6EZxJVUiKEWFgID+Yg3LazRmuhDXykI2NfVnPktuUTGae4X0ZCC7
         ne8Cnxh/adgZqP/bxcEtHxvDmxTuCfs6qmpXfQZrhFcqxLm+BMYsh213/pyjQGtYJK
         9yXDVahlDta7g==
Received: by mail-ed1-f70.google.com with SMTP id c11-20020a509f8b000000b00501e2facf47so41750537edf.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf893Mr1zYfCNeUs9dWOENLdN29rryafRcjFVjzmYec=;
        b=5IcF7l68AtYtUJHajVJgsGdidbP13EN+7rsDaj+05hXnc7uY0qma2Vqd0I+D1LpmXf
         WMi0Ou4mgmc9t27Dw/M7pis4fQCmQj2+a8zXYPuBLlBs6FdlLPoYHCbUE+r5uwxIE1BR
         qGCmNgIUitimCASniHQplMP4PTQs7vTowCrOosmp+j0AbLprCne7qWUQlbl14HJTHeYM
         fFs6YCrqV8jhpMZqXVJalwxMARabIrbPfNWn9ojGO3TEmHIgOCmfc1XOlioCY010qhZI
         iZuAFfFUs0CYjViTa5ntjk6Q8oYfcypjMlHmYqnodXpY2o18hUo7pxipwmB4LHKbuz9V
         guww==
X-Gm-Message-State: AAQBX9dZ/wRwCduTtOR5OFnXZdS3KXm2w7tV7pEqRFf/kv8tKHT7Qoea
        pKZ1gFzSqMCm1aNVeSCpGjZJC2ncdtrWZ/6O67jJeGICH4+qkwW5W6azHF9nu4E8NMKsqB+PNr8
        Kvrzv1ZEDw1BMNVP9+nl0DpJr7zaKnPzwz2Lh7ToTJSY=
X-Received: by 2002:a05:6402:411:b0:502:251b:3a4c with SMTP id q17-20020a056402041100b00502251b3a4cmr30174836edv.20.1680533137391;
        Mon, 03 Apr 2023 07:45:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2rjRNMEkLgRsNMhCzFqQP4n3HXkdsPLW/Km+pP6VRt/Ch2WbGOlygJD5M5eF9DG+YVUx8kw==
X-Received: by 2002:a05:6402:411:b0:502:251b:3a4c with SMTP id q17-20020a056402041100b00502251b3a4cmr30174814edv.20.1680533137108;
        Mon, 03 Apr 2023 07:45:37 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:36 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 1/9] fuse: move FUSE_DEFAULT_* defines to fuse common header
Date:   Mon,  3 Apr 2023 16:45:09 +0200
Message-Id: <20230403144517.347517-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..69af0acecb69 100644
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
index 660be31aaabc..3de950104f15 100644
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

