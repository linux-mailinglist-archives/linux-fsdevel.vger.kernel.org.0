Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2063F34A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLAPCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiLAPCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:02:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D0D326D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 07:02:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o5so3149098wrm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnWb/wVSNdKj3pgyeMUpqSMtTHsefsQxEggI3iRte0I=;
        b=awhQR/IK5q42tm3jsJWdBfs/KzYDAI+a/+tgVKyWKK1usmdu83M7jvdpKEabsmzrw5
         YK0C91yT3kWLT0lY7lVsiBbNwP5EGN9FKFCusE1IrXxPDPJksIf9ATZ3W1uj+Wx/DVCh
         VIlv3WWwOSNokSkF5/OcgwaDI1dIIW+bnGYSWd3bVE0g2ihNxpp4S+/SvU2gXEnk/4sK
         INZVqVt7shp3t10QQIlcMg6UtGpO6WQR1dlDTjHsD5UICWArdBVmGTehzB5tAuMwTxbP
         4zpBvTvhaEOLhEdwNBnanR2zQjqhjE4Pb3iIIR5fo8LUyd90MRniQHkCxdZMJPmkSm2A
         MtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnWb/wVSNdKj3pgyeMUpqSMtTHsefsQxEggI3iRte0I=;
        b=fbHCUwjQDPy7CI9Pa32dJHXPeRNocNmZRqAelMwD3OwVjYCol/QLarXUusqFP9fcr3
         KwKCRIKqyobmKkcbqqYnvXrpDNPqDkmnFUv0gNvRu3uGnNoT5BE1+T6IoXi9YSd1u6sk
         WPrBLOKWX6/mLXlN8Xk9qkjE6lwcsX+Mf/ChYOd6vghTazeCklYw00smHMDEDN6IySX6
         flYEm7mMTS77kbTpIIKOO6LEXWBKxF3QdOGOkevcYBLsJMN6goQuZerOZPNcsR9gftpX
         JHNAa0d+e00gTwzTMq2k6LaOp/C/wPLReoEwSPSUAAiYEUw5AlDe3ZLq8CHoISOdo42K
         oYPg==
X-Gm-Message-State: ANoB5pl35CBOJ1BmRAYl+QigiqwaGSCsKor/DSjsneFy56D7UUdGkWCv
        LYgRXFa+O1iBc7f+z/DSHEZMTkwJEYAV5O8j
X-Google-Smtp-Source: AA0mqf6vbkbi36FpoDynrVXbxaE/yUvxBZldu8vEkUyqahsXnciixUJsDqpc9kt/trtxJbcGDfMo/A==
X-Received: by 2002:a5d:510b:0:b0:241:fe9d:fbf4 with SMTP id s11-20020a5d510b000000b00241fe9dfbf4mr22755438wrt.412.1669906950323;
        Thu, 01 Dec 2022 07:02:30 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:23b6])
        by smtp.googlemail.com with ESMTPSA id y7-20020adfe6c7000000b002423edd7e50sm906342wrm.32.2022.12.01.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:02:29 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, brauner@kernel.org
Subject: [PATCH] selftests: Add missing <sys/syscall.h> to mount_setattr test
Date:   Thu,  1 Dec 2022 16:02:18 +0100
Message-Id: <20221201150218.2374366-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Including <sys/syscall.h> is required to define __NR_mount_setattr
and __NR_open_tree which the mount_setattr test relies on.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..da85f8af482c 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -11,6 +11,7 @@
 #include <sys/wait.h>
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
+#include <sys/syscall.h>
 #include <sys/sysinfo.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.38.1

