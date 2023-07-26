Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A276387B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjGZOIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjGZOHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFAD2D78
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:11 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E996420BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380429;
        bh=ifNPKcEIq/Tv2vsoKX4zAa3gfholzjGLVEwPWVuZYK8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tYnz2I1ccQZ6h2XspujbLNxcEjfBACm/xeR1lEEmhIDh15YHU3THg6vnXLvJ1SV6F
         jo6AlEMMs4WgUMmv4gADUOfOwimW7pfa1arofUDFk4su8vaytlvs0htBTz7Dr0qlUa
         FWqNWptL3/2M/dT0bP5z6YVBhBVkhSFOfj9B6cEavAG8LvqBzBkvFoz/BpB29BNoXm
         e2CHD4bmZfN5aDHW5HWbMyJVBhhwQSfNdXeVQGhQRPvhZ9j3nYXPk1BGIQLcVzUX8o
         MJeHVrX2nSACazA+kEf+wr8GMPWDAo6p75REZIhr3EunrKD7rJWbrdnEJvkhvHqb0f
         G8hXE8bnoiDkQ==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b708d79112so61783351fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380429; x=1690985229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifNPKcEIq/Tv2vsoKX4zAa3gfholzjGLVEwPWVuZYK8=;
        b=SoUJYQLWknfFBLVG86bjIMPwIQU6g4oO9m91BjDwn6Uu5OD84w/h+X9u04uQhxtHNj
         hJltGhhUD2IO2kNihODCIdRGyJQlThwPRcaxdbu9PcTAyg5ItVnHM2E9ZQanUopZ9RA3
         jEOY6qs1SwuLyk+gXNoOdkMJrNjYxPev6hRqfvYpI0Lc/MwO8xtgdJYNONj7MNZp1Y9Q
         rpE0wdAmUO/ro910Htz1VkP+WhD2T4+32WOwo4QxagWJYEmjsmTxM3su/It0qc/gfDI+
         OOk0MarXdFnEd9Tu556AddtYXFhPZkPg7xLS6jJ4UOoOkMh+8Z7MAwXK8IHydaskAC08
         TzSA==
X-Gm-Message-State: ABy/qLbVWix3Di2lnQoIWpGg+sMPxM1QFc7OCC3T4IO+6NQyspLOb7vR
        3OnOFEZlUS5+p5yuvGDt9rHAoWxQhk7+Cl+PijEXPKWdYGC32TyqbwRezpDLk6XM0vs0pQZRj7q
        17HVQlpXnlUFBj3CEP58yyNV3aii7pFMs2DkuvBirNDI=
X-Received: by 2002:a2e:9556:0:b0:2b9:344c:a214 with SMTP id t22-20020a2e9556000000b002b9344ca214mr1564433ljh.42.1690380428840;
        Wed, 26 Jul 2023 07:07:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFECc8D6LZpee+Vcumz09/vLajMwMjm4GI72wcxAUrTie1a80vqAXBygVzN56hWSlHMd6q1fw==
X-Received: by 2002:a2e:9556:0:b0:2b9:344c:a214 with SMTP id t22-20020a2e9556000000b002b9344ca214mr1564414ljh.42.1690380428549;
        Wed, 26 Jul 2023 07:07:08 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:08 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
Date:   Wed, 26 Jul 2023 16:06:41 +0200
Message-Id: <20230726140649.307158-4-aleksandr.mikhalitsyn@canonical.com>
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

Inode operations that create a new filesystem object such as ->mknod,
->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
Instead the caller's fs{g,u}id is used for the {g,u}id of the new
filesystem object.

In order to ensure that the correct {g,u}id is used map the caller's
fs{g,u}id for creation requests. This doesn't require complex changes.
It suffices to pass in the relevant idmapping recorded in the request
message. If this request message was triggered from an inode operation
that creates filesystem objects it will have passed down the relevant
idmaping. If this is a request message that was triggered from an inode
operation that doens't need to take idmappings into account the initial
idmapping is passed down which is an identity mapping.

This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
which adds two new fields (owner_{u,g}id) to the request head structure.
So, we need to ensure that MDS supports it otherwise we need to fail
any IO that comes through an idmapped mount because we can't process it
in a proper way. MDS server without such an extension will use caller_{u,g}id
fields to set a new inode owner UID/GID which is incorrect because caller_{u,g}id
values are unmapped. At the same time we can't map these fields with an
idmapping as it can break UID/GID-based permission checks logic on the
MDS side. This problem was described with a lot of details at [1], [2].

[1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
[2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v7:
	- reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
---
 fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
 fs/ceph/mds_client.h         |  5 ++++-
 include/linux/ceph/ceph_fs.h |  4 +++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c641ab046e98..ac095a95f3d0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 {
 	int mds = session->s_mds;
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct ceph_mds_request_head_legacy *lhead;
 	const char *path1 = NULL;
@@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	lhead = find_legacy_request_head(msg->front.iov_base,
 					 session->s_con.peer_features);
 
+	if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
+	    !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
+		pr_err_ratelimited_client(cl,
+			"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
+			" is not supported by MDS. Fail request with -EIO.\n");
+
+		ret = -EIO;
+		goto out_err;
+	}
+
 	/*
 	 * The ceph_mds_request_head_legacy didn't contain a version field, and
 	 * one was added when we moved the message version from 3->4.
@@ -3043,10 +3054,19 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 		p = msg->front.iov_base + sizeof(*ohead);
 	} else {
 		struct ceph_mds_request_head *nhead = msg->front.iov_base;
+		kuid_t owner_fsuid;
+		kgid_t owner_fsgid;
 
 		msg->hdr.version = cpu_to_le16(6);
 		nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
 		p = msg->front.iov_base + sizeof(*nhead);
+
+		owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+					  VFSUIDT_INIT(req->r_cred->fsuid));
+		owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+					  VFSGIDT_INIT(req->r_cred->fsgid));
+		nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
+		nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
 	}
 
 	end = msg->front.iov_base + msg->front.iov_len;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index e3bbf3ba8ee8..8f683e8203bd 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -33,8 +33,10 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
 	CEPHFS_FEATURE_OP_GETVXATTR,
 	CEPHFS_FEATURE_32BITS_RETRY_FWD,
+	CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
+	CEPHFS_FEATURE_HAS_OWNER_UIDGID,
 
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_32BITS_RETRY_FWD,
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_HAS_OWNER_UIDGID,
 };
 
 #define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
@@ -49,6 +51,7 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,	\
 	CEPHFS_FEATURE_OP_GETVXATTR,		\
 	CEPHFS_FEATURE_32BITS_RETRY_FWD,	\
+	CEPHFS_FEATURE_HAS_OWNER_UIDGID,	\
 }
 
 /*
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 5f2301ee88bc..6eb83a51341c 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
 	union ceph_mds_request_args args;
 } __attribute__ ((packed));
 
-#define CEPH_MDS_REQUEST_HEAD_VERSION  2
+#define CEPH_MDS_REQUEST_HEAD_VERSION  3
 
 struct ceph_mds_request_head_old {
 	__le16 version;                /* struct version */
@@ -530,6 +530,8 @@ struct ceph_mds_request_head {
 
 	__le32 ext_num_retry;          /* new count retry attempts */
 	__le32 ext_num_fwd;            /* new count fwd attempts */
+
+	__le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
 } __attribute__ ((packed));
 
 /* cap/lease release record */
-- 
2.34.1

