Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6676EBAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHCOCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjHCOCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:02:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3D44A7
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:58 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D4F74247F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071241;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A+nWR5bgWoJQcgiYA023ok+0cjcbpeRqld769eF2RUOOJyu9S6/yPQy3Q/DXTYMVH
         hJd3fhso0wyEQ+XGgmdGdn3OHkfBvIbVL++6De/Iok51J7QGINVsfDI7txJcww8H25
         EEx4lbq9KSaY/Y3UlEHgcEDMzKGEgrsY9J2H4dhMH2/NS+M+OgXeI6NIf7ybyxVAim
         ZIFA45Jz3RLF+e3f+S+cspa9JagqwE+mvfzzUjovewMyCFCAsfKFFt6n8laaq7l8z2
         NN9zfPxcSRuopbvhDC3o/rUp+1d3F42c3xgQ5y5gdLlnOZ0aiYeJYJhpxr+15+Asf2
         rVXJzx3h7Osdg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5230e9ef0e6so539082a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071238; x=1691676038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        b=EEcE7BuX8w05XraMQuPMno4yrAaQ2PgnSir3z3Ykyb46YXqtUDmNw9+0joJw+sl6it
         mJpYKtm9MfDyTOvAC9Nru4EUfDZOtZGfnHaXw6i7ZI0Ss7uWKN/QBi/GTWGGjEucBZZu
         /xfptVMfS0KgsDPef0GWXocAkP6itGJOKe590mTD7+5NxQ7DgPaQz8caBwYm6cIyZk6C
         5MDCP5L5WeI545RTYKauoXvU/QQAoMK93vUxKhu3dBqSlHogI1bPeX/ARqjKs12gYFZj
         vYMYGDnVlcSnHyRsuoK3auWSA0/tU5RLizKzJCcouMrKBHcLC3Yqruy2dwRv22Ou7hPM
         heuQ==
X-Gm-Message-State: ABy/qLYzgrvTU5srdApl0JxNbDJog52jB0aOoE1JjYfFiXOyvSnzLrJf
        zC+c0UcyAAC1GSQ4isbTvlaku5aBe48Bo4F/1XqxHLdZpM/APi38ORv/22xTPFS01zQefwXVFX9
        30fPq5qZuldiuYIrY6LMSU9T9inimMPQKz7kzLVjANd4ojr43FMQ=
X-Received: by 2002:aa7:d7c9:0:b0:522:2b76:1985 with SMTP id e9-20020aa7d7c9000000b005222b761985mr7132496eds.2.1691071238722;
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0pp6lmcBwuEsjLXRAH6NybsqxtfW1AOq9hV5+FXgfxFhIOUTjX8q9MHOhwq4qu7jI+RVc6Q==
X-Received: by 2002:aa7:d7c9:0:b0:522:2b76:1985 with SMTP id e9-20020aa7d7c9000000b005222b761985mr7132484eds.2.1691071238558;
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] ceph/file: allow idmapped atomic_open inode op
Date:   Thu,  3 Aug 2023 15:59:54 +0200
Message-Id: <20230803135955.230449-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_atomic_open() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
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

