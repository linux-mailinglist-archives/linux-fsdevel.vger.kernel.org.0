Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B214D63ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiCKOmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349857AbiCKOl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:41:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1C9AD9C;
        Fri, 11 Mar 2022 06:40:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so11211253edu.1;
        Fri, 11 Mar 2022 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6bBLgCZgh0VQ3FiDVqjw/OukOofGYEtfzJRk02RBM7o=;
        b=gY/yIqlH3OgvuFjrktmlEFwOsbONmlnlNbX+FuSeohPTknZWmyBmI2Zl7nZxPFdJ4X
         ttO8wJYlBiwlW2uTD3y53K/0mpxcey7ORYV8RY7E6+4E59BuE5HfBykd8XdFRf4pf0OC
         8kOk0Yx4MHDJxTMQb/n+/nY62aQCspVizCb0pfxgXaMMCAChLosPK2BdiIon8CXTtz66
         xyhDicp5gdFLpnPy9f+fVMhc4USmymLeeskvw4ueAXa7Jj8f5R+taHwdJoStM8WkOEjT
         i0TBzWc937PSkKUUthz+rn7Nbx6rKnkYroOdH095vz8o0JEawpvqYBsWXNwuX5C7PAUI
         YgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6bBLgCZgh0VQ3FiDVqjw/OukOofGYEtfzJRk02RBM7o=;
        b=J8bqkCpzNH9A5lP5585PPLNMYW8uSuwfDJ4m6fvA+eeuELxL1CVxwdNOZa+pr8AnMx
         wffJC37lVzNsCg+aYeIsxTvtMmFsNr2O5hLELgjJhzyyYOSG16SqydeI/3/7Dr5hQV6x
         4pM004HWHgtxKTiqP9mA4NKZ2PVCz0ka+m2ZbVpj+SKU0GdGkbmAd2Qf5cOqGpV+qdpM
         4rBA0ACbcaBomIjENdTwYVJm9ihhE/2pOZUktnKLr22wVAW8D0JKkTBPh32rLgp0pwkr
         Am+EdDpwd9OKMGf3o5W/RE/7J0QjCkyz2P/dQdxPzuws4xRba1peuL9aSardYXPCZrBp
         Tp/Q==
X-Gm-Message-State: AOAM530UGS7ItQ+gE/Q37/vn+dQAN7rGr7C6/nRpQ+kYnfvxRZM2lV+v
        WyLpy33t5qNykfqwg/49lTzRXQVsKYs=
X-Google-Smtp-Source: ABdhPJx6wABjmYegKi4YgVH5rutTffU4pxGVLltDmYlM4H7/jarWaxh3CL1PYSblSpN226tNEjgPzA==
X-Received: by 2002:aa7:d5d9:0:b0:416:1dd3:7714 with SMTP id d25-20020aa7d5d9000000b004161dd37714mr9225263eds.256.1647009628632;
        Fri, 11 Mar 2022 06:40:28 -0800 (PST)
Received: from felia.fritz.box (200116b826a9a900147fc2a0771e144b.dip.versatel-1u1.de. [2001:16b8:26a9:a900:147f:c2a0:771e:144b])
        by smtp.gmail.com with ESMTPSA id bq23-20020a170906d0d700b006db0372d3a2sm3045117ejb.20.2022.03.11.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:40:28 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fs: remove reference to the removed config NFSD_V3
Date:   Fri, 11 Mar 2022 15:39:41 +0100
Message-Id: <20220311143941.9628-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 6a687e69a54e ("NFSD: Remove CONFIG_NFSD_V3") removes the config
NFSD_V3, but misses one reference in fs/Kconfig.

Remove this remaining reference to the removed config symbol.

This issue was discovered with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Chuck, please pick this quick fix to your commit in linux-next.

 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7f2455e8e18a..ec2cf8ccd170 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -344,7 +344,7 @@ config LOCKD
 
 config LOCKD_V4
 	bool
-	depends on NFSD_V3 || NFS_V3
+	depends on NFS_V3
 	depends on FILE_LOCKING
 	default y
 
-- 
2.17.1

