Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE176387C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjGZOIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbjGZOHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3130C5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:12 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 617653F71D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380431;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Fp0W4RVXekWuD8zlOzeL2hTXYQxQEpu6bEcFPMmFVp9ATuJk/ZIQVy0xbE4quNrgQ
         LthcAkmNli3T+uNvRuPpZIE3dqCwz/byCwiiuCY8hxBCI+w2NkGW8pGYeiYQO4xe8Q
         MeJDDRO+zXoyte04+UF0A2T0P5kmCWlarK99Fl1Gbgz/3BH6b1zpl+T4cNWnT6Ssi5
         EVRyoaTZ5TLrLgWmzOwnn1SwV6s6nRKABNhyI3YLFN3imaDNyl98mXJeySM+m885Uw
         KVSdkpgIbeRnQzHntfWiEABm4g6G8EFXfq7xe6oMPbiAG2Hu0LaQtD0hZnw6TQV5ZM
         hV37rIM0OMFeQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso446270266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380431; x=1690985231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        b=I6SiNs47RNrzIKJ0PfIB5RN1YShbdzVkqKdVFqb57Vv/in9ipdlkREcyNQEEv2qW1z
         q7dgomLZaNp+BbTuJSXXc06EIC7tPXwFIA6PUBOheTePrS7b+OnzFU/loIOei6ZzvvYi
         2Fm0cQ1vHhOn7aSJS/2/A8zEQoTNu0NwLOasnXHgg+d38P4sk5VDxwEFzCKAhrAUJuIo
         J0dDsclcBT+UntqY5QbKPMY/rRBRlyLW/KKq5xgr6uRKfwNDUCIYsvp3oJjX8FBCScKp
         G7seFBmmnLxyfSaSRLeI5zej6XoeIWEF/X6/kyupnzeicGvyD9iu0yjiKYNvMxkYrsKK
         jetw==
X-Gm-Message-State: ABy/qLY30Q1jvCADSjbZIZ+igT28qoaKaTgxKI4IrSahi3G7YXgSXcIj
        rdr/E95iYu7pJiPUKe3Sn9BcVlfLUY8lVTvarpo5YcmARpMg/VEJrroR0s8nidCAqv4RBAZ+Dre
        gv2qhVF/rA99y+tvjJWyKkbHTFOB0cLY1oiOpFwrZGjs=
X-Received: by 2002:a17:907:75f6:b0:99b:c845:791d with SMTP id jz22-20020a17090775f600b0099bc845791dmr1434430ejc.76.1690380431058;
        Wed, 26 Jul 2023 07:07:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhdDccDulP51f0YoFndT67o/a/QXckCWhrmqiLKJI7lRzxtWwmVKfF+Whpzw+yT7Xf1d3qZQ==
X-Received: by 2002:a17:907:75f6:b0:99b:c845:791d with SMTP id jz22-20020a17090775f600b0099bc845791dmr1434417ejc.76.1690380430795;
        Wed, 26 Jul 2023 07:07:10 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:10 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 04/11] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Wed, 26 Jul 2023 16:06:42 +0200
Message-Id: <20230726140649.307158-5-aleksandr.mikhalitsyn@canonical.com>
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

Enable mknod/symlink/mkdir iops to handle idmapped mounts.
This is just a matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
v7:
	- don't pass idmapping for ceph_rename (no need)
---
 fs/ceph/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b752ed3ccdf0..397656ae7787 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -952,6 +952,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1067,6 +1068,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1146,6 +1148,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
 			     CEPH_CAP_XATTR_EXCL;
-- 
2.34.1

