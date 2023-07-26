Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F65763889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjGZOJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjGZOIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:08:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8A3AAD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:27 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D39CA3F078
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380444;
        bh=dyH4eLS/ZCdAMtA+4CRaXqW6UBtXDh7SsBX0oiAwXGM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=U6icKS4tOyNiNqHEAQ72at2ltw985YgsT0/rXyQRMSa76mPTr6N8CoQMKXM87mF8z
         +RI7lbxXXZQno3jTmGoxI17qo0z2F7qT7nKKcqPdhRVrxbtJ5XiDzzWCcoVyQUfwX8
         UtSWc6Uk66Jyo7LU99uzQ5WhQF+tjD8kbSPODGLDeUWCLSOoj179JxsYmOWU0cg3ti
         n8OYWuHLQz0x95+lEizsNrIZXnDZF0HWt7IKYvqyT7iLdEvJtq3Gvwfln9lC+62YZX
         aHLQ8j1lp/71n9MqBpZHYu3Q7HhSqLMGYemLH451gEzCC8thxVh+sl/zdOMIM60Z1F
         wZ2sTsJYVoF1Q==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d7ca4607so436750766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380443; x=1690985243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyH4eLS/ZCdAMtA+4CRaXqW6UBtXDh7SsBX0oiAwXGM=;
        b=WChmrFFDHqc7YU4m+DNb2HSxCfVr5l9l/MHUtrnkQ3/NwnZYsroH2MrLQOmCI8LBXd
         yoll9NOBxiev8rRBIPT68ehzU/YYCpdweM375gazS4xU+LmCgyyBrWz9B1LJ4YfoHOod
         F+2vCvSx0neuoNMJOep3iLo8VmmP5ePjpmJBYnKQ0OBcK/IIfqCayDF16mcNOD7aLPnQ
         MKPAQx3m7cY+RNwBv/aSmU9ClXMos6NkhXmSUHAM6LfBF+VrnL+n4HpXRLz6vI6JJSFr
         wybAxg1njKw+1M/9mh3ZbPvVXZSOAfxyy6IgGGIENukh0eV/VXE1pn263D0idfBXmJHt
         L+Ag==
X-Gm-Message-State: ABy/qLZhtA1X82vyMMwC0i9bpZKsYcCcx0hXNMf6mRB3SS4TcwyAgnoU
        /YKtacfjS2uBJ+C8kye5yKsZoCxL/cK+22qGNcgWCL4SIRiVKLUEN5f/rE7jb974uwjqU81BP3J
        uLlLiX+G/Lm0GQ9WMxRG48/T36P57+J8b9hXGoRO+LS8=
X-Received: by 2002:a17:907:7803:b0:99b:5e5f:1667 with SMTP id la3-20020a170907780300b0099b5e5f1667mr1659826ejc.15.1690380443105;
        Wed, 26 Jul 2023 07:07:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHh8YN+258wCb8Iy0b4bIWppeUTBwY5IAn5eS8RgWR/WcDmxH4egNCEl6+02yAn/k0ZBIoKlQ==
X-Received: by 2002:a17:907:7803:b0:99b:5e5f:1667 with SMTP id la3-20020a170907780300b0099b5e5f1667mr1659811ejc.15.1690380442913;
        Wed, 26 Jul 2023 07:07:22 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:22 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 10/11] ceph/file: allow idmapped atomic_open inode op
Date:   Wed, 26 Jul 2023 16:06:48 +0200
Message-Id: <20230726140649.307158-11-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_atomic_open() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
[ adapted to 5fadbd9929 ("ceph: rely on vfs for setgid stripping") ]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7470daafe595..f73d8b760682 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -668,7 +668,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	in.truncate_seq = cpu_to_le32(1);
 	in.truncate_size = cpu_to_le64(-1ULL);
 	in.xattr_version = cpu_to_le64(1);
-	in.uid = cpu_to_le32(from_kuid(&init_user_ns, current_fsuid()));
+	in.uid = cpu_to_le32(from_kuid(&init_user_ns,
+				       mapped_fsuid(req->r_mnt_idmap,
+						    &init_user_ns)));
 	if (dir->i_mode & S_ISGID) {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, dir->i_gid));
 
@@ -676,7 +678,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else {
-		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
+		in.gid = cpu_to_le32(from_kgid(&init_user_ns,
+				     mapped_fsgid(req->r_mnt_idmap,
+						  &init_user_ns)));
 	}
 	in.mode = cpu_to_le32((u32)mode);
 
@@ -743,6 +747,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -802,6 +807,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		mask |= CEPH_CAP_XATTR_SHARED;
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	ihold(dir);
 	if (IS_ENCRYPTED(dir)) {
 		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
-- 
2.34.1

