Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F587295E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbjFIJxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjFIJw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:52:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1F5B9D
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:44:57 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B20433F377
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303169;
        bh=/ZEyoJlFLaVuWVBzkT1cBDONkmXP3qyfK5/dTNb2H5c=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fJR+PgP6BObU7rwPDF9QcGNRBi4uWM2p+g16+PSQg7XVffUEsBrFD1UPygFVVBfwl
         qaGAnWXV93vl4Sf/FM8LSPgwESHw0WEduguC+aqE62NB/x2sHRh/CoVyfbZ7K/JKnd
         T6XSsoxMT6xK/ShthzXB/m8q4H861WaHXD45LNM3h2m5YvP/iBi0EubK1gLVnJPBBr
         ETNvEaX6+863zRWi9Z7kbx8amnNhtiW6M1IIGOMoCY21I98/JnZk7EITzOOaJTzx3C
         l4mz39oEpjyP7L99MSbnGJvpHbuQJHkjJV+HTk4F6o1EVUXlecBXj1LFfAoaIstaPI
         9LflhT5eSjlZA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355c9028so182121366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303167; x=1688895167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZEyoJlFLaVuWVBzkT1cBDONkmXP3qyfK5/dTNb2H5c=;
        b=aIMItFLU2FvJTbw/8uxo+k7Ott0deCq2iwpJsqlsQALmYbAI4TdMCZQx/NiZYkiP9O
         UYSabKL4GCDdnHqqKHa3NbZZpuKr/1V3aqeoV+5EKBswEOeEb+EoihuIVEk3bjGGzR3Y
         rFnpw6F7kcmuja6Tpp8JpSjTpaSZ+Zar+tTv00kuB5cLiSLL0sMm5ikBCobA/AQB3yXU
         cY8ji7ZLsKT6tGLr7frtRCMVmyUQZpLCKuLdKJDQuFuX2MvGyF99mPp3E/vl2GqX725p
         FwaZpDHSc2f4N2GLn28HPR9s+v3ud0jJLYEKOEX5m4N4v8sHlDJGC/1j1rBSdNVEzhZL
         8lUg==
X-Gm-Message-State: AC+VfDyaQu9cIj3lX3cfeqP4qQ87CTVPK5DzpY1PN7k0xg9Ss7+MWFvh
        txRcGIkxRM6JmPjVnBRIAb4F7oWpzycNlW8+Ncbap85JwxiIM6Gl7gyV2Su0Qjw3VUXQHNf8Flv
        SHqz4xs3CTnZa2St6jLfex/5X27Chl74xCR5/Z7ptrTI=
X-Received: by 2002:a17:906:4792:b0:96f:608c:5bdf with SMTP id cw18-20020a170906479200b0096f608c5bdfmr1229555ejc.64.1686303166891;
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40M5L5XkhSQA/QnoBcPEpFPgOUlmKAwDqyV+kolDwTxZ11t7xizkzr5a/UJGRyxfZTZYD9xg==
X-Received: by 2002:a17:906:4792:b0:96f:608c:5bdf with SMTP id cw18-20020a170906479200b0096f608c5bdfmr1229533ejc.64.1686303166625;
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/15] ceph: allow idmapped permission inode op
Date:   Fri,  9 Jun 2023 11:31:17 +0200
Message-Id: <20230609093125.252186-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 533349fe542f..f45d9c066523 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2922,7 +2922,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

