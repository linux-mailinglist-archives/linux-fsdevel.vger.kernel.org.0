Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D776FC7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjHDIuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHDItj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33134C18
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:35 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 754D444278
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138974;
        bh=Sm84/KT93swuS/ikVEAwSnx6TJ8Tr5bzLLYRGJZTQPA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ETsG7J1SVkjD7bA7aDMbcMogsJdV7zbpbnY77WKzdPdK4ELDje+5qO2jugfg0cGMh
         PbVKbCutnTjaDCt3IciwUsns3WS1CZNUl+TcCxa/x1WxILY7NbGg9DsqnO0mfPTn//
         ZTJNk+HTBiDlVHnwr1uPh6mmJp/H+80vNa8og0FLyVHpflyqc0vTa31aIVAGHjJozZ
         HjIodifTOLJo6q51O8D7cmfduOxXTRSZs70p9G3z8iyEoxjsZLvbJxmtD2a0J9rtjX
         LjHqEsYlHf+iVXiuug07msgpRsU0iktd75P1WWjETKBY8k7AaQulBhrKj7K6ZpS9DR
         Px12znWVBt5Kw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a348facbbso127956066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138974; x=1691743774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm84/KT93swuS/ikVEAwSnx6TJ8Tr5bzLLYRGJZTQPA=;
        b=RLJoP9SSCgXm0ohT40/a5lwh/OAPy+5AFSFxqKIfmxyTLZ7syccI+FT5BcZx052kxx
         r1gSiKYugIp6gAAJ9iJ7jM2MeDyVWeJNQLyiDoKVxYoslTnCt0MoSxCwhMWNM+tzVRqC
         VG5nIExeP/MRNZ2g4eaqIY+B50pNDqOUm2lQzj/LVlIQ++0a+mekkrqw6akPSVj11KEv
         9md83au+ucyGwWQnAsoGsDcTDlrVgAG2D6EFxPy4LYCUONncJmOB+4YCQiy0v//Npjg+
         ZHvrBOpwIRH5JWGtJhmdqK0xp+8Bx+D9GmmROdcz+v6TSChbBlhCPmfwST+X2ZN8OaO1
         vQcQ==
X-Gm-Message-State: AOJu0Ywcmuhn/I7ZVF8NfRU89eIXdGAR9PQjyFAgj2WvCARxs9VCa6iE
        spYyGGDth338A8iMbfJiMp7dvMzlrSYxzoqARPKO8xhEy52ZdYZyD7v2VpOpAsAY1CuxFLftHC/
        j33Kwyqg4lxf3CB9hCxWzi4iqOIV/4TUcdUE4htUjzb0=
X-Received: by 2002:a17:906:2112:b0:99c:4ea0:ed18 with SMTP id 18-20020a170906211200b0099c4ea0ed18mr952381ejt.8.1691138973828;
        Fri, 04 Aug 2023 01:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdSPLTZJvYlL3Mzi5CnZ68sMi9r2jxcre66CKNzUiIEhpEQczFn48u3hw7bTM9iJAgWJeVg==
X-Received: by 2002:a17:906:2112:b0:99c:4ea0:ed18 with SMTP id 18-20020a170906211200b0099c4ea0ed18mr952369ejt.8.1691138973644;
        Fri, 04 Aug 2023 01:49:33 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:33 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/12] ceph: handle idmapped mounts in create_request_message()
Date:   Fri,  4 Aug 2023 10:48:49 +0200
Message-Id: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

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

Link: https://github.com/ceph/ceph/pull/52575
Link: https://tracker.ceph.com/issues/62217
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v7:
	- reworked to use two new fields for owner UID/GID (https://github.com/ceph/ceph/pull/52575)
v8:
	- properly handled case when old MDS used with new kernel client
---
 fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h         |  5 +++-
 include/linux/ceph/ceph_fs.h |  5 +++-
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8829f55103da..41e4bf3811c4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **p, const struct ceph_mds_request *
 	}
 }
 
+static inline u16 mds_supported_head_version(struct ceph_mds_session *session)
+{
+	if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features))
+		return 1;
+
+	if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features))
+		return 2;
+
+	return CEPH_MDS_REQUEST_HEAD_VERSION;
+}
+
 static struct ceph_mds_request_head_legacy *
 find_legacy_request_head(void *p, u64 features)
 {
@@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 {
 	int mds = session->s_mds;
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct ceph_mds_request_head_legacy *lhead;
 	const char *path1 = NULL;
@@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	void *p, *end;
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
-	bool old_version = !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_features);
+	u16 request_head_version = mds_supported_head_version(session);
 
 	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
@@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	 */
 	if (legacy)
 		len = sizeof(struct ceph_mds_request_head_legacy);
-	else if (old_version)
+	else if (request_head_version == 1)
 		len = sizeof(struct ceph_mds_request_head_old);
+	else if (request_head_version == 2)
+		len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
 	else
 		len = sizeof(struct ceph_mds_request_head);
 
@@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
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
@@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	if (legacy) {
 		msg->hdr.version = cpu_to_le16(3);
 		p = msg->front.iov_base + sizeof(*lhead);
-	} else if (old_version) {
+	} else if (request_head_version == 1) {
 		struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
 
 		msg->hdr.version = cpu_to_le16(4);
 		ohead->version = cpu_to_le16(1);
 		p = msg->front.iov_base + sizeof(*ohead);
+	} else if (request_head_version == 2) {
+		struct ceph_mds_request_head *nhead = msg->front.iov_base;
+
+		msg->hdr.version = cpu_to_le16(6);
+		nhead->version = cpu_to_le16(2);
+
+		p = msg->front.iov_base + offsetofend(struct ceph_mds_request_head, ext_num_fwd);
 	} else {
 		struct ceph_mds_request_head *nhead = msg->front.iov_base;
+		kuid_t owner_fsuid;
+		kgid_t owner_fsgid;
 
 		msg->hdr.version = cpu_to_le16(6);
 		nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
+		nhead->struct_len = sizeof(struct ceph_mds_request_head);
+
+		owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+					  VFSUIDT_INIT(req->r_cred->fsuid));
+		owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+					  VFSGIDT_INIT(req->r_cred->fsgid));
+		nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
+		nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
 		p = msg->front.iov_base + sizeof(*nhead);
 	}
 
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
index 5f2301ee88bc..b91699b08f26 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
 	union ceph_mds_request_args args;
 } __attribute__ ((packed));
 
-#define CEPH_MDS_REQUEST_HEAD_VERSION  2
+#define CEPH_MDS_REQUEST_HEAD_VERSION  3
 
 struct ceph_mds_request_head_old {
 	__le16 version;                /* struct version */
@@ -530,6 +530,9 @@ struct ceph_mds_request_head {
 
 	__le32 ext_num_retry;          /* new count retry attempts */
 	__le32 ext_num_fwd;            /* new count fwd attempts */
+
+	__le32 struct_len;             /* to store size of struct ceph_mds_request_head */
+	__le32 owner_uid, owner_gid;   /* used for OPs which create inodes */
 } __attribute__ ((packed));
 
 /* cap/lease release record */
-- 
2.34.1

