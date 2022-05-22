Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4F530116
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiEVFaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiEVFaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 01:30:20 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB940E60;
        Sat, 21 May 2022 22:30:19 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-f1d5464c48so14652024fac.6;
        Sat, 21 May 2022 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ll3dFiCaVSu/VJOI9Q3MLOjk4GHfDsNK91Om/YI5BQ=;
        b=Q9umBpEFhDyoOC3XrRrdCmFCbLeOzScKM8PXv93FKr+hby66C7IfwpTctZ0mzsj12J
         2GDUeeCRWp7tL/EBlGUv3MOearDhBanZ0XYDah8Jfd+y+5VsvlLWongD8ml8mN2eT3b1
         107UlDrnICSOxWCIC0xCMhqD0yZ8egfGwuPTRCpCCi2glCMt7YLwFV3LmW848B0rAC7Y
         I9Oj7fwGENpnoiDgxHtu1W1MRpxT/b+Dm2NUGeprrtsMuWM5LrS3oCtwExrhRABw2x7Q
         1efInIw7kzhXwtUEnukFk8TVAgsz3/tTR15nFpOJVNCHqLGyZAIv+W03e3vnpBjaKW9W
         emzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ll3dFiCaVSu/VJOI9Q3MLOjk4GHfDsNK91Om/YI5BQ=;
        b=vNjTwASaQoZLdcoSTApmlh6ozfhTUv2A5LDkJNUALUtBWlsno3ryr045quW4umcavn
         Y+qCRkI3Ahm7kps6BhYaW442YHbxBzicYw/Rw/45EQwWXUmbFA8I3C6EYdrZ8V/QlsQP
         izQfeVcGbOXZuekZd6dHvu6LiM36t29kOQGSzG/nUTK7GaQhjaYs5xrgBJVyxOIARTbV
         SmiBCnIshqcRONSGQ+uSTN5VLBo6pcDrS4ZLWJe3VLOMZHvVfRhe2V4BhmkkcEY7QL7g
         ZAcSxkWs6rVqPmPLt8ZTFa4U/VqGIU4DJ5BOdetUujjKkQ4l22ip2FmWo/O4y0oBP60Q
         i3NA==
X-Gm-Message-State: AOAM531yeZm1MSPLJ/XOFnl38nd4mX5YQL3GBme5VLScMJBfkynKPkXH
        0cFqnRUa2ir7buuJVB5VRNs=
X-Google-Smtp-Source: ABdhPJyd5GnojuL0nm4Dx1g2BQoWmYotSUHqvFhe41cy/6xcHCF85xHWERbDL2qGrFhMZ63rFAuHWw==
X-Received: by 2002:a05:6870:4184:b0:f1:97d2:6696 with SMTP id y4-20020a056870418400b000f197d26696mr9280660oac.148.1653197418539;
        Sat, 21 May 2022 22:30:18 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id q7-20020aca4307000000b00325cda1ffa2sm2975306oia.33.2022.05.21.22.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 22:30:18 -0700 (PDT)
From:   bh1scw@gmail.com
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] kernel/sysctl.c: Clean up indentation, replace spaces with tab.
Date:   Sun, 22 May 2022 13:29:33 +0800
Message-Id: <20220522052933.829296-1-bh1scw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fanjun Kong <bh1scw@gmail.com>

This patch fixes two coding style issues:
1. Clean up indentation, replace spaces with tab
2. Add space after ','

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 kernel/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e372c60..de8da34e02a5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1277,8 +1277,8 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
 int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_dointvec(table,write,buffer,lenp,ppos,
-		    	    do_proc_dointvec_userhz_jiffies_conv,NULL);
+	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+				do_proc_dointvec_userhz_jiffies_conv, NULL);
 }
 
 /**
-- 
2.36.0

