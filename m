Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B259A9DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiHTAGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiHTAGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC5C59E4;
        Fri, 19 Aug 2022 17:06:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u22so5339687plq.12;
        Fri, 19 Aug 2022 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=23iwxZamh1JEgq18njAg/viEEbo0VAoUS2TA2uIuZDg=;
        b=YyCHrHyPjuKNaRRTk9RaYmvlhjuo6O7OuT2tH5aZOpuJpNLMIw2dr9o8WXKc9YBOj3
         datSB4ecdKEBStjEHUhmKaeeqYAd+XfBEGVshJP/WSiEst2wADPEjGUz6axTTMDOdJaP
         gdy17avKmjVgcuVtV+EkfvmSWlsrS9xDqqix9J3h/5CfnSuoFEecfF4M+xuFjONAhSBa
         +bXOPTF3eg8DNUz1pb2ifHJRLZ2aD3TiT/kEH/ysNpnxhrzEIrS5v6oPSzvQ+UZJ+MQw
         uMxQ45ROm680Oz8rZJitoFKQpqV+eRL2N7dgfr9bHzjweqfWK4YI+gvOqaXCEhI2dJAl
         Ox6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=23iwxZamh1JEgq18njAg/viEEbo0VAoUS2TA2uIuZDg=;
        b=lMnFO+DqrZNFu0pbVhBJMX0K51f8bKjFsQa4gU7Xz9+IZ1nr3sH4U5ZoA0Y4h8EcVu
         bawcQt7lWthrvtDGQQ17zfVL9wSpNZZGWYmF8cvhKzhmmsAvfQDQXW1zhOOlR/3G18/e
         IdbrTLmHI59xAkiOkcDH3Lblb7MFxec9LY5U8IWBMczDezTn4lZtuzLUWsJgOyI2s3jq
         UmP+07LmAcjZWr5G9xrdH1W9VO9wQAfvCDkOeGT4ZBkLPCPZWEssp9p2pdfWtFLWlzT/
         /Ywnw9/QOEZq9DazFA0IMcs3to4gkiFeJj3QJD2raYW5vVUAalxFXWRJT+3P3R1dFECi
         MDmw==
X-Gm-Message-State: ACgBeo21td3XXDZzFzKKsrS8M4KX7DFwotjQyZyXT4iHyzVta77q4khb
        QWvrSZrh5MB5ES2xSIKQ/+U=
X-Google-Smtp-Source: AA6agR7LjbaEa9l7RiuecBW/EFvUtsGxhlp+HOf+iE+N7eulYlIf7TzgkxuH5xgHseoOiQVUcDGf4A==
X-Received: by 2002:a17:90a:66cf:b0:1f7:b8d2:c2d6 with SMTP id z15-20020a17090a66cf00b001f7b8d2c2d6mr11118303pjl.67.1660953965336;
        Fri, 19 Aug 2022 17:06:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id a23-20020aa794b7000000b0053638c4a6a3sm724900pfl.198.2022.08.19.17.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] kernfs: Drop unnecessary "mutex" local variable initialization
Date:   Fri, 19 Aug 2022 14:05:46 -1000
Message-Id: <20220820000550.367085-3-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are unnecessary and unconventional. Remove them. Also move variable
declaration into the block that it's used. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 32b16fe00a9e..6437f7c7162d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -555,7 +555,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
@@ -599,7 +599,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 
@@ -776,9 +776,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
-	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
+		struct mutex *mutex;
+
 		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
 		mutex_unlock(mutex);
@@ -796,7 +797,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
-- 
2.37.2

