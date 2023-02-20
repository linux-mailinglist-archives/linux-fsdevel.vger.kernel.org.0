Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868C69D429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBTTiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjBTTiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D149775
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:20 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9E443F721
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921894;
        bh=IA26aCShKRrMxO7X4FNysG0cj87aSw923xvICaycoGk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=OIkpmIH8RNGetb96v6ymGLn3ezUt2ixxvMm9zhD/R0xF4L2rkxdoFFDYduZ8icFfE
         Qcaw+0A3KVwgfAWbYiUiq53tYK9Z/9NEdCeNsDfSpBcvslHlsz9M0UL7AAtL8aIk+R
         OHyjQNBtm/vtgH9S6MIlX6anxn9L/AYvCgr4t/EuJYv1Fy0S2pYriFgfVrMXnOnW7g
         sCOWm2ehHMW+vrjJfVMp9hm4IHsRrSgXPncPgMLfJN0fd9TdAQh8OQRtnUHO2R+lSN
         C+zqclmZk0XD7ATctZ1R8uwoUMZMZnlXXr77hhjNBaDP+JisCl9HuRwrrLhTnQuGKT
         i6E6b+gW4NWBg==
Received: by mail-ed1-f71.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso2647493edb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA26aCShKRrMxO7X4FNysG0cj87aSw923xvICaycoGk=;
        b=5ykj8Hg3CDyPftfRcqyuOqIt0z3jGgZ1c0l8QOCskuq+PyTvgmgz7y/bjAOT5w2ihy
         lb3p3Mn5cYbXvKPYa5pFTl1hEHrWdEMl/+RkVV8nHUVYSZlogEORRV6wchrXf2q10/rK
         tMLy6iFEgOEBIu6tpZChEH4+7uejSj4mJe9nZfF/5n/cfOVTJxL6MbmOHee60SAAdGiC
         E84QFx6jdB/WwLrhYyEQC1k5KEo3PpVnX21X1FLQJayUzWmo9O7vtcS5ewYgoiKX4cyx
         OTkFFzAMTTtAZdfRN5CXF5e2iHGSMCe4rW4J+ZaV0aVislv9e/aDXYMUzFtAF+3jwdls
         Lo3A==
X-Gm-Message-State: AO0yUKVw0peL9fVLcRI8ElYNCF6VRrZniVqpGPOrw7zwxHxtAle4p8nI
        erL50rXhE+7K+Mv+Xtl63Mx6i1r4sFomYxiV/W70/Bf+EylWTRL9+sEtJEpoF6IdGEiyegUUg2n
        u3zE8278mH3se/aFfO1H+Wa2cCD5N4ickP23/yqGMKKE=
X-Received: by 2002:a17:906:f4f:b0:8b1:2d35:2264 with SMTP id h15-20020a1709060f4f00b008b12d352264mr11644442ejj.73.1676921894604;
        Mon, 20 Feb 2023 11:38:14 -0800 (PST)
X-Google-Smtp-Source: AK7set/kzpSNlmX+NlKV1+qIODQptGJi5oLTQse0HNp9KgCX8jYq3jyxqDPdqMdITSdKmOX67REDXw==
X-Received: by 2002:a17:906:f4f:b0:8b1:2d35:2264 with SMTP id h15-20020a1709060f4f00b008b12d352264mr11644422ejj.73.1676921894361;
        Mon, 20 Feb 2023 11:38:14 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:14 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 2/9] fuse: add const qualifiers to common fuse helpers
Date:   Mon, 20 Feb 2023 20:37:47 +0100
Message-Id: <20230220193754.470330-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4be7c404da4b..d5fc2d89ff1c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -870,32 +870,32 @@ struct fuse_mount {
 	struct list_head fc_entry;
 };
 
-static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
+static inline struct fuse_mount *get_fuse_mount_super(const struct super_block *sb)
 {
 	return sb->s_fs_info;
 }
 
-static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
+static inline struct fuse_conn *get_fuse_conn_super(const struct super_block *sb)
 {
 	return get_fuse_mount_super(sb)->fc;
 }
 
-static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
+static inline struct fuse_mount *get_fuse_mount(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
+static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
 
-static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
+static inline struct fuse_inode *get_fuse_inode(const struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
 }
 
-static inline u64 get_node_id(struct inode *inode)
+static inline u64 get_node_id(const struct inode *inode)
 {
 	return get_fuse_inode(inode)->nodeid;
 }
@@ -905,7 +905,7 @@ static inline int invalid_nodeid(u64 nodeid)
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
 
-static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
+static inline u64 fuse_get_attr_version(const struct fuse_conn *fc)
 {
 	return atomic64_read(&fc->attr_version);
 }
@@ -923,7 +923,7 @@ static inline void fuse_make_bad(struct inode *inode)
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
-static inline bool fuse_is_bad(struct inode *inode)
+static inline bool fuse_is_bad(const struct inode *inode)
 {
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
-- 
2.34.1

