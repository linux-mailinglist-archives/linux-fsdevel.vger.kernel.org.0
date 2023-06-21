Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E17738D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjFURmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjFURmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:42:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB712122;
        Wed, 21 Jun 2023 10:41:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6686a1051beso3610832b3a.1;
        Wed, 21 Jun 2023 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687369305; x=1689961305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67RsiRkf7V/7CF4F5OqcQiUMN3aCyMIaXikCRwf0Jt0=;
        b=R59LXc7dG49D6BDqvOLv8GFhZv2D6DZ82JAvRkDEgOvlZ6JClcVZVxGGybx4+Ffb5z
         1+9lb3zlQdir/sdk0/Ajla4bsBmgEnNE2rxQcjTymuaoBcjgEYLAT+6sEqwgVDWy0hga
         rGmsZu+VGZc3P9vvQbraSGntMZj62M8KEJX1srUAOtc6Yb5VejGySLtueyPPMpd8bV8/
         oaQjrqidJSLUNQKory36TCvEnPg9/UuzoP6gjebAfwYXj6sO8vwix6dXyCjuw6723XXu
         vyVewTMvpocOynazlUcFH3FeJ4Xl5ZRYrHETYNqDHwJcHc8sixWUmsCugHbLfhG0JANp
         P70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369305; x=1689961305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67RsiRkf7V/7CF4F5OqcQiUMN3aCyMIaXikCRwf0Jt0=;
        b=bB/JRWXBFBiKm57886GE0wpdi//2spzGpPdmi0UhKHZfHM5Dk8OZy3WmF3zdoHINfN
         FuNcSFz4+SJkUjKKjTZSmePUYrvRkJ2ST7nNoORcb1Sl7JpEPXbgWI0m83/ow8hk1uzD
         lbD69HDLVGEDGpTi3TFNbbaebYgidzArCx+fMpvAM77pxP2qWMcEO5OJvR6cMNW+zCSy
         HDs9FCZVYYI60l2QZ9XZmC9u43OqckVVdwalNAoPQQyJWsecnLDXBawzjyPhZLsnypbt
         lmSAp3gsLX4BEkxygMofmf7DwoZ+CjOMe/DKsoDkkCqxexsw97DFAmYVGjXakjwcQ30m
         nmMQ==
X-Gm-Message-State: AC+VfDyG2NjiOPxrtU4VVUURkULpeD78qEA7IZikn++MS//TsGXSggk+
        yhUJSzSmD1GlQ0MF2UkOyyY=
X-Google-Smtp-Source: ACHHUZ6JlmenchXri4RPSn4XqTCoyIaoew1oOdBlDm8S9UjvE4XrVvZvToU0uZ51tZrf+IixGqqUAw==
X-Received: by 2002:a05:6a00:1a94:b0:653:91c1:1611 with SMTP id e20-20020a056a001a9400b0065391c11611mr19660672pfv.14.1687369304633;
        Wed, 21 Jun 2023 10:41:44 -0700 (PDT)
Received: from jbongio9100214.lan ([2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id j23-20020a62e917000000b0066a4636c777sm1246824pfh.192.2023.06.21.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:41:44 -0700 (PDT)
From:   Jeremy Bongio <bongiojp@gmail.com>
To:     Ted Tso <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: [PATCH 1/1] For DIO writes with no mapped pages for inode, skip deferring completion.
Date:   Wed, 21 Jun 2023 10:29:20 -0700
Message-ID: <20230621174114.1320834-2-bongiojp@gmail.com>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230621174114.1320834-1-bongiojp@gmail.com>
References: <20230621174114.1320834-1-bongiojp@gmail.com>
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

If there are no mapped pages for an DIO write then the page cache does not
need to be updated. For very fast SSDs and direct async IO, deferring work
completion can result in a significant performance loss.
---
 fs/iomap/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 019cc87d0fb3..8f27d0dc4f6d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -168,7 +168,9 @@ void iomap_dio_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->submit.waiter;
 			WRITE_ONCE(dio->submit.waiter, NULL);
 			blk_wake_io_task(waiter);
-		} else if (dio->flags & IOMAP_DIO_WRITE) {
+		} else if (dio->flags & IOMAP_DIO_WRITE &&
+			(!dio->iocb->ki_filp->f_inode ||
+			    dio->iocb->ki_filp->f_inode->i_mapping->nrpages))) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
 			WRITE_ONCE(dio->iocb->private, NULL);
-- 
2.41.0.185.g7c58973941-goog

