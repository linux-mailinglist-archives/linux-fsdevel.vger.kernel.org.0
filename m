Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43977638AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjGZOMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjGZOL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DC3C10
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:19 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E006940821
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380651;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gHAO2qLRJ1GqQqXuFhKhEB9NlTY0x0uRAek5YoVEyJb7ntGRfuCnMV0n0ZD4QSVQT
         Cla+hmCcVN45ZZ3yvag8qCdS785zL62XK/TRGsUsFUxTPazVd8zgT0NiCvgyIkBb3Q
         q15NHsuSYhkPy2unGXSaBH20u6n6U5xqnKK0c1NSvp8GYoQFND6+U3OHtOwmrXA1f6
         /GxHWSHMFvbebaxUmpqITSmnM1LJCEJtF8dj1kncJu0OImI4UT89iENhUsZLIu4x2T
         eaLMOE70qRymYmj8jeLfDK8OmwD73RwdYaASTIfzvMYzNN6m9N+c/SLMJzmW/qxYI9
         bGx8ign7BA+Pg==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9bb2d0b1bso4086721fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380643; x=1690985443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        b=KqEh8MrRdeuvGAOUP5QBOl8LsqenTBNcijEP5FpC6DcrKJYo95KmM2Pc+xdaIAHPVS
         AGfdl2953U0EizDJkqGTS12MSDAH9yCGjACGzUBqaL98Wu/68w/F/0XMOURFkNQaW6RD
         ay6DFI6NYA47YgpQQYNlhQDAhIiCapygOSqNm9kOZdtjsE6EdbQWPDlLu9RFN04nxED+
         P8xkEwxUV5QdSQ0gwGcOJFds44QPzkLFmbPOgXiCtskMZJbRlXK41Nrw9pdG+GIl5rGy
         zwJhoGgQVZXqKmw7o2PlK2HSaiLn4MYPaLOotkwD4iUVhVJzqGk/fN1Q0ye6jR2t6L6w
         beyQ==
X-Gm-Message-State: ABy/qLZ2Ne1i2w4GY7Pp/JFDEqiLrW2b868kVTnGjDru9el5O6Xm4aE6
        WCBHW57/GdQ29VyXTSmMEM8I64dtFdcdH2m/nXjGVrdSebh5PmyFm/ibZHpEuNrxTp1fPwaJ7wk
        P5PpDSQ0tvpFmCeyXh82Fuoe802R/lJGkzjd/YOeRHTkQHizTCY8=
X-Received: by 2002:a2e:984b:0:b0:2b6:decf:5cbd with SMTP id e11-20020a2e984b000000b002b6decf5cbdmr1578250ljj.36.1690380643776;
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzfOvSVHgN1R2U97B5NMYqDDnWYxKIdEobLA7c0AI/5Ct5RedFqzwWPJru7Kk1HPoq0AB4Rg==
X-Received: by 2002:a2e:984b:0:b0:2b6:decf:5cbd with SMTP id e11-20020a2e984b000000b002b6decf5cbdmr1578241ljj.36.1690380643620;
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Wed, 26 Jul 2023 16:10:19 +0200
Message-Id: <20230726141026.307690-5-aleksandr.mikhalitsyn@canonical.com>
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

