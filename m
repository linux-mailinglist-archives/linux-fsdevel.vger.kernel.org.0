Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78E72680A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFGSLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFGSKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:10:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E71198B
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:43 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 212C83F15F
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161441;
        bh=iEnhNZXEpvf6z44xxB3rnp1IhVt5v+qShuvQ8nza8PQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=udW0A+gZPXbkTsyzbB/o2dZvkt+MYjxoHwrdL2QvgXbFK6uCHaL7uKfN9TgYq5b54
         oPTQXBzs3eayGfueSvGO6Fxx8iHz8DEtYl9zyWkf3pUlkhz7yVe8O7KDemAdrWGGHw
         IrDspX4yl4oUptkYl7YvyQaPlsN3wEBVlSIz5IMkJmTff+AUAU9ldSDp947uVT6xDA
         B2bRfxQ4x/YRZw9pa4ZAwnsiJ2RTG3TxqHI0QZfoglnv9kYZwXNvBYzhOv0wJqN0NI
         cLUlwkmeQ6tHArQuy1/bK2G6hSxxfBNdogYSjRdOTASfGd3Cndnrs7/7+myrIWF0qP
         r/8W4+d/rUS2w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9744659b7b5so692098166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161440; x=1688753440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEnhNZXEpvf6z44xxB3rnp1IhVt5v+qShuvQ8nza8PQ=;
        b=PfBAlIiGQfYkHK3SC6BNOKqUwKrraDPMgqqnUzbJgXxebitBaX66pE2D8EfUupTJcP
         /Ygqsu2KgTPQEvcur0gYfuoGketkIKp7k5a08TxSkIuLU2OidKeyDNoR6GYuz1h6eEZa
         opAJhxoD9Sj3ERrpNEbLX7sIZR8VeU1COQzpkKzVLLZ/1zvQaU9+I8kmixhNZF+q6zre
         cHQ038MQBm/oY3g/0Ym3FWBeP9p52yK3HxvusqZ8Pma3O3ja6Mpfm/VpxVI/4sBjUj5x
         Z20uetM9Uxpu1WDq6IukInhiiiItY4XMaSfmcOvZNjQhjzE4tRYvRxRTXxQjUkPeEdPB
         1EZQ==
X-Gm-Message-State: AC+VfDzsOxdt25MR77GrNyAR53WT3ghiF0fuu+fW3glZNEHuboa9P43r
        RF4GAZAC+DTScUI2mQlw1vAG1COsz/hAJT7pCkBKqYtCnic3RJ8uBkI8c3CWEGmmeNmQK7sxSnh
        jDbBAJO8Bl/loc2Pl98QrhkRr3+aTlt/MuwU4wm5Zqw0=
X-Received: by 2002:a17:907:6d98:b0:96f:ea85:3ef6 with SMTP id sb24-20020a1709076d9800b0096fea853ef6mr7344056ejc.62.1686161440261;
        Wed, 07 Jun 2023 11:10:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kN0yD5UKteqOZCdE8d2DUc0BogNgwOVnzz8+4Qovf99098TrosTx+jldMHixGqT6jVCGfZQ==
X-Received: by 2002:a17:907:6d98:b0:96f:ea85:3ef6 with SMTP id sb24-20020a1709076d9800b0096fea853ef6mr7344043ejc.62.1686161440120;
        Wed, 07 Jun 2023 11:10:40 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:39 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/14] ceph: allow idmapped mknod inode op
Date:   Wed,  7 Jun 2023 20:09:47 +0200
Message-Id: <20230607180958.645115-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_mknod() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cb67ac821f0e..aaae586de4de 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -884,6 +884,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
-- 
2.34.1

