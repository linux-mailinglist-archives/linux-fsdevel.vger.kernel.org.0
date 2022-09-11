Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5185B5139
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 23:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIKVJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIKVJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:09:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF926F3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 14:09:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az6so5897835wmb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=UqfdQB8Jcm0DQHqLadWZ8tf5iSn5GHCrR9pnKxkvVD8=;
        b=eYPsn/BwCy4TX3OSUw4yO2T4SxW4iSrXh3J9PmMvhYnMANVQvWmjlzREP4VBgiZzQ9
         6WnbPmJjOIup5tCIIoGiP2wFLaVs6VehirSKDUROLmcbB3QR5zfN8i8vGaZxnBIM4grm
         xND5neE6bQXP6owa2ELjkn/VyoTUZ5V40BeiNfwDAxMsQrDnvRyD43I0tt23KOxX4Syc
         lOX8/kgNrDXqHZ+RHKPSn/SLBuEhXEm7OERkrbsRoVkPaTIzWHouo95G7tylPhk8OHYq
         tGn/9v/FfP0dIX9fqO7RTDoXvt5Wj741uqINWDeQEJdQDIAVc+bOEUbtE3Yxz+fl/vVi
         O/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UqfdQB8Jcm0DQHqLadWZ8tf5iSn5GHCrR9pnKxkvVD8=;
        b=3OhKpP8BZSLrVRRSXR0qIttlg9zKhh1pwDoNzduyZ2IrAKM+sNRKEpy4AT7QdjXKHB
         UZBnKmUc+uRSFekqSm6FqErlmoCLyO5s14/6NxmjjYHhDIPd0KygiIQPhe7B6jpf4XjQ
         QvVzzYsFNbgDMtkA++uQdm2PkDcXXof79FAylBl7hX2L7nnVbX+Q7O0YZiV7lwCVxUdS
         2dvzRGD/ErHeKS+XU5AwtlzSwfATKWlsQ3TCp01DO1HpCHVxCZkQRTFauEAP1ROhxVEY
         0M+fLi/Hd0+DxRoQbN+Bg5EYg9KB8kKLnDFUY0bdB6RL7sFRLAT6vsRIKTaXZZ0CAgXb
         QgIA==
X-Gm-Message-State: ACgBeo0B/wRcDuUYKMx17KqR7m4yq1NuXlScCAbc6eGo90f3LHqYOMGH
        Ew2MOR2O4QQXJpQTm5uJNPVhaKItZA==
X-Google-Smtp-Source: AA6agR6HrV4OZbtvD6yeGQuYs4XSY4pezSGB6CgRQh+Tc36YQNEzp+EoDsegwLiMeX9IX3qqYspoiA==
X-Received: by 2002:a05:600c:3543:b0:3b4:89d7:1561 with SMTP id i3-20020a05600c354300b003b489d71561mr293226wmq.161.1662930576531;
        Sun, 11 Sep 2022 14:09:36 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003a84375d0d1sm7903744wmb.44.2022.09.11.14.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 14:09:36 -0700 (PDT)
Date:   Sun, 11 Sep 2022 22:09:26 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Add missing annotation for __wait_on_freeing_inode()
Message-ID: <Yx5OhttjvyPDPB7B@playground>
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

Sparse reports a warning at __wait_on_freeing_inode()

warning: context imbalance in __wait_on_freeing_inode - unexpected unlock

The root cause is a missing annotation at __wait_on_freeing_inode()

Add the missing  __releases(&inode->i_lock)
 __must_hold(&inode_hash_lock) annotations

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index a1dd9a976add..b3ef550227b6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2219,6 +2219,7 @@ EXPORT_SYMBOL(inode_needs_sync);
  * will DTRT.
  */
 static void __wait_on_freeing_inode(struct inode *inode)
+	__releases(&inode->i_lock) __must_hold(&inode_hash_lock)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
-- 
2.35.1

