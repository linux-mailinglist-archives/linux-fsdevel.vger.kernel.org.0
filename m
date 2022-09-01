Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AB35A90D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiIAHoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiIAHnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC105125BAC;
        Thu,  1 Sep 2022 00:43:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h188so310531pgc.12;
        Thu, 01 Sep 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bHV5ouZifV/jcwNOTNxjisEeKz6ACGz2OJcHGOBwl+A=;
        b=O8My5ZUfglGldxoE5TU9Z4/cLx6KOSf+Zqg3yAsgEZt447wueyM2TNfnvo0y/tQrq5
         ECbCehiGfKz0Rng39PXFSeD2yz5jRj6w73bCGT3mD800BWpYCPpyhhgmKIvWkx3kPcRF
         5qcOz8RqSilp3LWMrXMqD/RbbWPOgMwVVjLyQACys95YZmxYLqSkZHNNvhFVSquhTWMK
         46tb6AOpCGvFAiLpeRwpHT+INxcz7xXAdvXoC9weBWxvia1zouuWiD85ScDtwbItKJAa
         HoqaM3Twx4ks4SvtmCt+fhCKHxjZMHEbX29N518ovwwuql81xlUEX0oY3rWedEXg7FFo
         O/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bHV5ouZifV/jcwNOTNxjisEeKz6ACGz2OJcHGOBwl+A=;
        b=giGcVsVowlUhhXr39zlyDOa7gNbqfwNdHtmMGHTI4mTcovRdfDi3TOBdLp0NzRXAAu
         gpyPGlc7CaGl7Llj5TFK5pcZEU+ofUo0MpJJuAsYOD1P/WBv6dLz1eRoJaMiqMNnfUUs
         rsrkPBZJ4leXI3DPpd9VYAHgUR/aIfwOpT1h7m2XYHdNCFpRlAon8QX330xRzKWfX3US
         kplGe9ody7sVz0kYcOeB7eM/zPsDcj0esd9FgxZ71K0pHLlhdc+dQGkLPqHg0HSfIyk0
         CRko/yC+BiFVb/9/ZGh1FDZtCSr4b42gaTg/i4U0+F58+sEJuxdo5nZZ8aOZT//94Zdd
         h05w==
X-Gm-Message-State: ACgBeo1CjhFH2pS2FISXyloLxgHihClM4i/dn12gw35Gf0KwGt8R25pC
        5HGiI/4f0ibaVkWx+FWTsNr/WwMTTyE=
X-Google-Smtp-Source: AA6agR7WE2VsK4EzSu4PSFqO/PYkg9RDnbC8duVg/ZZphtIPEZOiQtTFszLHs9JOF2amYqlGlR7GWw==
X-Received: by 2002:a63:8b4c:0:b0:42c:65f5:29c3 with SMTP id j73-20020a638b4c000000b0042c65f529c3mr12581184pge.397.1662018183584;
        Thu, 01 Sep 2022 00:43:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a85-20020a621a58000000b00537bdc9c2f2sm13041642pfa.170.2022.09.01.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:43:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fuse: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:42:59 +0000
Message-Id: <20220901074259.313062-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value fuse_dev_release() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/fuse/cuse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c7d882a9fe33..a06fbb1a8a5b 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -545,7 +545,6 @@ static int cuse_channel_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = file->private_data;
 	struct cuse_conn *cc = fc_to_cc(fud->fc);
-	int rc;
 
 	/* remove from the conntbl, no more access from this point on */
 	mutex_lock(&cuse_lock);
@@ -560,9 +559,7 @@ static int cuse_channel_release(struct inode *inode, struct file *file)
 		cdev_del(cc->cdev);
 	}
 
-	rc = fuse_dev_release(inode, file);	/* puts the base reference */
-
-	return rc;
+	return fuse_dev_release(inode, file);
 }
 
 static struct file_operations cuse_channel_fops; /* initialized during init */
-- 
2.25.1
