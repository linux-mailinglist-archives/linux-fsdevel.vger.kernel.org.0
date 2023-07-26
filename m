Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB8763898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjGZOMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjGZOLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:46 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242993A89
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:01 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55E3E413C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380642;
        bh=ifNPKcEIq/Tv2vsoKX4zAa3gfholzjGLVEwPWVuZYK8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KnchRmlDTs1KiN/izXGpgRCki/d/1hYblcl7SKJiANjnVNkaNeWnKqqP7ftH0CJlo
         GXpMn6HRsmRuLdac9ExCAFn4krEElHIGreSpavTWHw5P1GQ326qN/b5viv6QWw9ihH
         o26T2xiduW5YwjSQmwiOj3oBtMBWXUEP8SXtiEXwsUp+v7HHRNwxk7vJel25N0IJeQ
         gNC48NxT020tXd78XQ1mVRXm0KFcr2zflKYwp99/uYWNpImXII+8DQothBJraJgTO9
         eWZOTciV/1nkRJfa0UsMII6s8QZjA0L98tgxuearAXrg4BE99X0I5mT3pISlHyA40x
         pEAlD/pc/XoNA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fdf1798575so3555085e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380641; x=1690985441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifNPKcEIq/Tv2vsoKX4zAa3gfholzjGLVEwPWVuZYK8=;
        b=jSmOdUgmvazMw4gOmrTIBChb1rlO8IPqGthh0O1qEKwCETohVHlH66XmOHQeyH4FsR
         iYrKRlznrY6nhY5+XW48oI0tUrHvo0lmavAUhtplcu/Jxg2NISawNzfvXuO9L3rqg/E5
         MAa4tf7BIgdG/bVfc2uIEEUed6mTbnc9EIg26iXx5XiR/r5B7ZkzJiGy0NWOkyGm7cA4
         C+icNOwl3RkANj52EQ4uuJpiyUCBY/KH0HKj+GEe5/Y8Pe0cWF+crbiStbIyy1tq37kr
         0h5DXG2Py8+zypSFseU3aRo6S+V7l+9Nob4ZW8Kx9bfOJJ60cxao0ELg8E8Il6fSRl/W
         DwIQ==
X-Gm-Message-State: ABy/qLYflIkkj+lsG+BAuWqTpWb5dtgoKfGEO7b0lLYO3OOvgOSccaDE
        Kz5JbNRglT1PM/Ak1iVSrhEXqx2T+Lr7n6fvbbmhqStJwq3LR6dM2GDhy4yhbMpvSBy5TDymiCc
        uyPlrs13BEtfC8eDA9/XvbFoBEJW+9tG5fFUaVjdsPVg=
X-Received: by 2002:a19:500b:0:b0:4f8:78c9:4f00 with SMTP id e11-20020a19500b000000b004f878c94f00mr1362283lfb.20.1690380641773;
        Wed, 26 Jul 2023 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOsfN9DOURtgnEN8jItCQbVwugH0zAkEFJPg2kq1n8HBsvjAAyJy3680KdLeYMx4tcM1GxEA==
X-Received: by 2002:a19:500b:0:b0:4f8:78c9:4f00 with SMTP id e11-20020a19500b000000b004f878c94f00mr1362257lfb.20.1690380641324;
        Wed, 26 Jul 2023 07:10:41 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
Date:   Wed, 26 Jul 2023 16:10:18 +0200
Message-Id: <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
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

