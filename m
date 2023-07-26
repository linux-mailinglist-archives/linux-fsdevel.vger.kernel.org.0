Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080D763883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjGZOIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjGZOH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A412717
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:15 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A83F3F078
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380434;
        bh=ohgjgBD3cKcnIyJjD+KXey+VVqMnSRq4bkvBBBDC3os=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qAQ+J82XwuV9FDdGMVdIuy8B1et7LvDT2Hm5kbLaNVGmdLZQ63ns35t8RQvkJWgpv
         v+ZPLIRPsJj0gjdA0bKkAcjM4d4WnZzeX0SFzr6zPIm+ipR7QP5mWj3E/p0PiR+5aF
         o7JrrqirXMJKTJhV8t2jeGwrB3R0+sfE3g6e0HIg5DvJtrSIeeh0AZsSgH1fSVon+C
         pA5h0FLE7F0wODErHE30mYvhIKPM0kQC8uqVdLTOaYdxFcG5aYdm8GmZKa5IQ3BsaE
         MT9KdVt/Z7/ifnT9UIh32tvvUhRPesuGcpxc/nJExkFemTYqYva4gZhkOueaxlGbv1
         J6M2rCCNFF+eg==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb76659d54so5923215e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380433; x=1690985233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohgjgBD3cKcnIyJjD+KXey+VVqMnSRq4bkvBBBDC3os=;
        b=YsLKZjiH1+eVTSwOpS6kGj1UCBeLt2J1oxU7Rzg8owkxe6DRanQcgEF8ZfncQ87sLt
         xF/1gH1168Jrh/xOp9IdnFC7seYuhW+4n23/HMcK6y5V4U5trBp8jD2xZ6XhlKRThhuW
         9J4Ch0vcSjnTL0UOPj/veUZhmJTyGQHmt/x1gq+skFKfLEMuwIQDBX9srOAq7APXAgS7
         t9LLIpCFtyFAKRxKJBy+tTRxA0mDlutCrfM0foKg/IvQPYeeb2xndhgfbdVhftYQb8mj
         +54I0jzNpEwSA+K765o/gZmskV/DCK5psXlXEWSuqlfJuiYMzDhB89pMrph1y93eC3k1
         sDRA==
X-Gm-Message-State: ABy/qLbH1R73L0dAsCwks5MYlCnoE9yD+uQlsl3lwZ6K2QAePyEygVme
        MBk0EOt8o3HPyrsfNnJlJt4hCHiutR+Cv0T2FoLydrUtcc3R4YptV540oxYefD6dsqldCOgtaNA
        TzQraN1juavCE0zYpKVKmV/pfj8r6DrzpaKH/azQVCUNME1NeIJA=
X-Received: by 2002:a19:9106:0:b0:4fc:6e21:ff50 with SMTP id t6-20020a199106000000b004fc6e21ff50mr1449858lfd.55.1690380433170;
        Wed, 26 Jul 2023 07:07:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdJ7OYWoHTBaqKnosXcipdhiC3O5K9LGnu83OI+9Ye/T3iu/yoEjYD0YxZHw8dq89TPBBknw==
X-Received: by 2002:a19:9106:0:b0:4fc:6e21:ff50 with SMTP id t6-20020a199106000000b004fc6e21ff50mr1449844lfd.55.1690380432890;
        Wed, 26 Jul 2023 07:07:12 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 05/11] ceph: allow idmapped getattr inode op
Date:   Wed, 26 Jul 2023 16:06:43 +0200
Message-Id: <20230726140649.307158-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

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
index 3ff4f57f223f..136b68ccdbef 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3034,7 +3034,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

