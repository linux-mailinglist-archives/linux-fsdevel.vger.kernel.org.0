Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735B95B4F5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIKOGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiIKOGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:06:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0D3718D;
        Sun, 11 Sep 2022 07:05:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bz13so11360069wrb.2;
        Sun, 11 Sep 2022 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=xy3jsuuJ4zCilYhU/W2SjNwM7uHu+A5Gny+CvFwYDsg=;
        b=Wr88NjqVdeLxNuJK2qDGSr5jxWXMLViXiciXRO0sBOX6KppOCOoRD72kKQP3HnYJXB
         V9HRjTKZQgysqG+dw5yqP13iZxNNpzmuDLjVZw4qUW9SH8EXZR9qfhJqotqlBwxBUhNL
         +SD+1JTD7Tnou9aBRX/FBc418NIWpUXEeD0sjH+wA34w2GxZIlqZ8CLL95x9I5re2S+r
         J9+vJeUZrJaDF36svxEpIDpTzTJioPHx7ee59uWIPEqAaTE1I4bscmq3o4lOO/PpvLjf
         RamzIiR0KHPCrYxqmrsiGdSlZs4RWFC7wt5eKZEjSKB9fhQ7Xqou8/WLW/b6QH5TA74u
         RneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xy3jsuuJ4zCilYhU/W2SjNwM7uHu+A5Gny+CvFwYDsg=;
        b=32xT7MmAI0IPmy5wklttv4J9u9k/GWKwkPBmFxKWEgFfPjHneQEgvaZ/Cyc2TDChFD
         JQo1xTNvd+gkB+T8Lpohw3xVj52LnJKxJeMiM3bSjHxS7pXq9FMRJpFDNUzAqonP3lDi
         kceQy4wKCm3FvgtoPF1ugZa6HADVndaRXOWuxXXbgTJhQ2ITtyYq7tzdDXMFCN7DvDVa
         LXzVHGuEl7dVHwKdlOjIjTPgJFrIrc3uec/m1TkQ4cL2vIm9ZhhvDxWfhpq6JVeu7++r
         Vl9W66aLUltVkX7pLLMx3jtTcLlM8I4v6YizUlCiJblsaUj/fZ2MaAUTrN4xvzbN6fJ7
         Nz8A==
X-Gm-Message-State: ACgBeo3GoQHjDTx/AWX64puyme/nORiW5wqOY62v9YV61k93KvAOZhYN
        21BtU741wSGuMPs3m7IplxxBO6PY2g==
X-Google-Smtp-Source: AA6agR63qcc4iXO1scAzZ86HQ62Pk96zE2n/4eJyjWw0bZklQp7Ud1n/HnzBrqsKizfq+PTWMgrRTg==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id s5-20020a5d4ec5000000b0022867078472mr13234861wrv.12.1662905118237;
        Sun, 11 Sep 2022 07:05:18 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0022a9246c853sm59955wrb.41.2022.09.11.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 07:05:17 -0700 (PDT)
Date:   Sun, 11 Sep 2022 15:05:07 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Add missing annotation for iput_final()
Message-ID: <Yx3rE3zkN7p8/Znz@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at iput_final()

warning: context imbalance in iput_final - unexpected unlock

The root cause is the missing annotation at iput_final()

Add the missing __releases(&inode->i_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index ba1de23c13c1..a1dd9a976add 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1706,6 +1706,7 @@ EXPORT_SYMBOL(generic_delete_inode);
  * shutting down.
  */
 static void iput_final(struct inode *inode)
+	__releases(&inode->i_lock)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
-- 
2.35.1

