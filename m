Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE5627B67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiKNLDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiKNLDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:03:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5997205EA
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:03:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k5so9995044pjo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkStbBXpav6WiwxGhKG/pG+D5F6PN27MWUZBS9IqbMM=;
        b=MvUaVHWCR0WHqix7Xtbq4mCnWVvQOHBgf0mKMshpKfCXy09L1StSI1p8tQBohFiGrw
         9u+oxJBk+xC8Hg5fVtsAZosjYS8aHKl3MWmiYVWvyE0y09sZPyud9uwZanttvl4k+2jc
         mJV64+oabvpzRKdllSoIha002RswqgpxM38mKl4v9CVB4zFQxLd/GQ/rqwu4k6bAtDQb
         JafuJwWJSfZjMS22KV6Hdgxk86AwZYlYRZ8ZjfZMPBmVNVuz34eJKw1nxC2bdkXVbCP1
         Szrrmsos8L0fKMdSdFL1ZtyL7gFlBKIgrfJQKr/FpSwZCwWYU46i717ysWNQTGNLSx6k
         3yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkStbBXpav6WiwxGhKG/pG+D5F6PN27MWUZBS9IqbMM=;
        b=F36Gp4tU7T/QdZG6AebkQUvjuFDZKMRQdH0Xb4w9WPE0VwpFPmKgXEYXtOjy7hNcj6
         ASQKPzoJynOGjNneokiGqnHrlGpCaojQNN6JvthfL5od2TD8viTRgosAI9MVtF5B+GRN
         fzBwJvlQJZgGsMUSMtdZqG1vlfQXsdH3//FMLBTNupFzvKwi0wzA1+/e3u8gHagP1AVE
         Xqh+fMmB7XN6NwUmLM7xiuJgV4iJb9tKcYtMdQurkoBY+laTTGPBPx1SF4Q6Diynj7Ms
         dlJ0IE0e3RUHSHQprWjpDxNL9DA7TuGK2GmzOUdP3SgYcNJKdMKquRbwjPBP8W1Rf6rw
         i+Yw==
X-Gm-Message-State: ANoB5pmM2jwW26DgAyhL+Lq7qS8gMhLRo1PoKe03b9LIY69ldXZs4Pt6
        5kgAS3/g8miovGYhT1pGfZF/kZ/EkFI=
X-Google-Smtp-Source: AA0mqf71n8fOTi5E0oX27NHtIwgyaR7yxY455jU3hCKMSBsn+wSYQZJX4ZNP1voTmXefXUVc1hvjwg==
X-Received: by 2002:a17:90b:4d89:b0:213:2173:f46a with SMTP id oj9-20020a17090b4d8900b002132173f46amr13214832pjb.103.1668423782837;
        Mon, 14 Nov 2022 03:03:02 -0800 (PST)
Received: from localhost ([223.104.213.82])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0017a032d7ae4sm7196930plg.104.2022.11.14.03.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Nov 2022 03:03:02 -0800 (PST)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] writeback: Remove meaningless comment
Date:   Mon, 14 Nov 2022 03:02:53 -0800
Message-Id: <20221114110253.8827-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nr_pages was removed in 9ba4b2dfafaa
("fs: kill 'nr_pages' argument from wakeup_flusher_threads()"),
but the comment for 'nr_pages' was missed. Remove that.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/fs-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..78be6762522a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2244,10 +2244,6 @@ void wb_workfn(struct work_struct *work)
 		wb_wakeup_delayed(wb);
 }
 
-/*
- * Start writeback of `nr_pages' pages on this bdi. If `nr_pages' is zero,
- * write back the whole world.
- */
 static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 					 enum wb_reason reason)
 {
-- 
2.17.1

