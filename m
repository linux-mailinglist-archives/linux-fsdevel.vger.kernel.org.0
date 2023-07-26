Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F07638AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjGZOMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjGZOL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF73C0A
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:19 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B91BB42478
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380651;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=U8V11imsGxfiCZwru6xJ48C6eDW1/YSEvKCitfGf79x+ICXFL1TbKBJJ2me/kMeTl
         oZ9mwPzEBxAeSzA+nkk+Q6SbX4hT+iCIG51SHD5oaGOEUoEEWtsEnA610OzpiJEje1
         QHS186tIRHIvh2DPqYakl7nfCQFTDkEFNBLgiqtiCSt+QNkZvZmQVHgcgq6CnCT+OX
         egULFhquftgUTa9CIOwKai6jFRd1eSmnzfLGPaH9NGK4CMx+payjAC0rSXvm+NrBiL
         5JHQTeLOEqk6GmKzvX4KK2IcUqIkGW9rbbtvTyf3rbhnVHP5g1qrjaYKd3fAIvH1MM
         WfAdtQupuraPQ==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b70c44b5fdso64071991fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380648; x=1690985448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        b=c/KYvwlTtnRqbBAbg67ptFQP66fWXX4Gb3cglQ2aBLvAU9PWO6RcKVYMbhLQsRooMA
         Zl8RXaujheGS7x+3/sNOD+gGZ7JAGM8+8IWJytqRnj+dtLrI6foleXk7qrm3KCM+QQBq
         2fA1UUrVXbKMunyw4nStevpDIND1VEq8ROef5XZk9NPSLkvUHAIYS/t9ZEWRFuVP2oO3
         GMbLA1FDusQrjqHHs8jwzh/VufXNe2XwW/gAkhXzkSHx+jo+vnOd390jtn1kiIXkDhWn
         PVGRp7/iwnAmwKq3wFVfx5pmfttpNIT18iYs26DUWlLashH/kXUVBnW2TJVuctqS18/9
         hH+Q==
X-Gm-Message-State: ABy/qLbfzFxdnXEFrifxZ0nHLE/MXiq2fTB6yHRx7uuHm04VOifjXsbs
        W3EQVhgZRmFGJ7kKV6RQiEWzvRtuVFbbfXTdW7X3P923hQ3U10arIdCgjUapSpLswmOQX+AjASJ
        SxeDqjt4LvH5GNQqAhZpJmIOKFZOSeVsdxUDspx+TBvw=
X-Received: by 2002:a2e:86d7:0:b0:2b6:a7dd:e22 with SMTP id n23-20020a2e86d7000000b002b6a7dd0e22mr1518815ljj.48.1690380647892;
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpYu9WEgj2snc3ZtgSt1ExxcGBa/VYSWFcXye2JQbmsYlosKcGQTknjlNkzD2mlntMHE7P5A==
X-Received: by 2002:a2e:86d7:0:b0:2b6:a7dd:e22 with SMTP id n23-20020a2e86d7000000b002b6a7dd0e22mr1518793ljj.48.1690380647707;
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:47 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/11] ceph: allow idmapped permission inode op
Date:   Wed, 26 Jul 2023 16:10:21 +0200
Message-Id: <20230726141026.307690-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
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
index 136b68ccdbef..9b50861bd2b5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2977,7 +2977,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

