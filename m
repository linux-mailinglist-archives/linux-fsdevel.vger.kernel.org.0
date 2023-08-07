Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999387725AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjHGN3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHGN3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08892100
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3784844276
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414891;
        bh=9n6Y3+R2z8MxgQphIes473oPxL5sL8PFIQL+RUTLs6I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=m4qhKaTImBND8WcuT2ePvUE9SDmU/9xC+DMM6b6agp1PfWK+4M5QX6tqAei19opL8
         4YZ6E3TlUoP5M3BKJApBR/7cXAaKtk34tK1cszvtvfunqnZI/w00K0jXWrf2b+Ne3+
         PQJWKgap38TAqnN8tul3jHX5lSTgCJjjX0TP7mqYxYt/0BwTA3Z+RSqyjg1RMXmes3
         MEnQFx8B9laGDzxT++6cLlqK3npATjXC9uRHZGsuXkw5r52xyKRCb2aHlVfpnvTMQB
         +4i+5qRFUmgv7yArprYEAxfbUIvm3gt+kEGBLSmdG4CIlFYp/vrSfUE0E6U36052d0
         KhSHm+5vx6b5Q==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34a0b75eso300606466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414891; x=1692019691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n6Y3+R2z8MxgQphIes473oPxL5sL8PFIQL+RUTLs6I=;
        b=UcrQLv2MTBOGvusCWZJP0wXlkvibHJEy1EpF0NVlbZp9Fr5rit0YPrB+5XnmmWPPAJ
         k46b8Nz1xhkGv6L5E4rzfTBmXVNx+hcT/xZ4KONhpccpEmVYKlXwhd8D2ffB9wOXZDjI
         Mkm1s/6+UHcYUoUUtkJKaodUE20rLG/y+udQ6lpg4+8US3pgTF4H2Lee3YOVYEO8I/zj
         gYqYSG8Tsa/EF7yPrFdUGYjAgsXl6ZdR5E7e4KYSKamP1Ro+sBklUP+Ay83O3y4Z06Xi
         D7LUP+2Vbw5WzF+WiK54Aa+IuIbpMNOGwSjOvQQ17Su2fz6bHTrvMFa9Wdkh4WbPm1Dv
         SdyQ==
X-Gm-Message-State: AOJu0YyUYoQj6Ai8YJq17hDfpKCP8I1TmnN5kEiPMRTalScTy5crPY6B
        sK6dS4B42sexfkQp9JnkpLinOg7fhBWlFzUQcbyjKdZJVNlsvajRsrTFd7lvO+7p0xzQF2h3X7F
        B6EZfb2PUKlyQsYCOYhT2uo5XDSNfarwLr3fmyAZ8/xQ=
X-Received: by 2002:a17:907:2c44:b0:99c:825:6076 with SMTP id hf4-20020a1709072c4400b0099c08256076mr6544988ejc.35.1691414890932;
        Mon, 07 Aug 2023 06:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBU4i6R38ul+frqeZevZOxWpLNRxj0oiRwvcU1y4whm1La4MwJf9y9wAgsB1yXAlivGYfFGw==
X-Received: by 2002:a17:907:2c44:b0:99c:825:6076 with SMTP id hf4-20020a1709072c4400b0099c08256076mr6544975ejc.35.1691414890543;
        Mon, 07 Aug 2023 06:28:10 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:10 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 04/12] ceph: add enable_unsafe_idmap module parameter
Date:   Mon,  7 Aug 2023 15:26:18 +0200
Message-Id: <20230807132626.182101-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This parameter is used to decide if we allow
to perform IO on idmapped mount in case when MDS lacks
support of CEPHFS_FEATURE_HAS_OWNER_UIDGID feature.

In this case we can't properly handle MDS permission
checks and if UID/GID-based restrictions are enabled
on the MDS side then IO requests which go through an
idmapped mount may fail with -EACCESS/-EPERM.
Fortunately, for most of users it's not a case and
everything should work fine. But we put work "unsafe"
in the module parameter name to warn users about
possible problems with this feature and encourage
update of cephfs MDS.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Suggested-by: Stéphane Graber <stgraber@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/mds_client.c | 28 +++++++++++++++++++++-------
 fs/ceph/mds_client.h |  2 ++
 fs/ceph/super.c      |  5 +++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5114de5ea65e..90c4b0689cd6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2949,6 +2949,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
 	u16 request_head_version = mds_supported_head_version(session);
+	kuid_t caller_fsuid = req->r_cred->fsuid;
+	kgid_t caller_fsgid = req->r_cred->fsgid;
 
 	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
@@ -3046,12 +3048,24 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	    !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
 		WARN_ON_ONCE(!IS_CEPH_MDS_OP_NEWINODE(req->r_op));
 
-		pr_err_ratelimited_client(cl,
-			"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
-			" is not supported by MDS. Fail request with -EIO.\n");
+		if (enable_unsafe_idmap) {
+			pr_warn_once_client(cl,
+				"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
+				" is not supported by MDS. UID/GID-based restrictions may"
+				" not work properly.\n");
 
-		ret = -EIO;
-		goto out_err;
+			caller_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+						   VFSUIDT_INIT(req->r_cred->fsuid));
+			caller_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+						   VFSGIDT_INIT(req->r_cred->fsgid));
+		} else {
+			pr_err_ratelimited_client(cl,
+				"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
+				" is not supported by MDS. Fail request with -EIO.\n");
+
+			ret = -EIO;
+			goto out_err;
+		}
 	}
 
 	/*
@@ -3103,9 +3117,9 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	lhead->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
 	lhead->op = cpu_to_le32(req->r_op);
 	lhead->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
-						  req->r_cred->fsuid));
+						  caller_fsuid));
 	lhead->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
-						  req->r_cred->fsgid));
+						  caller_fsgid));
 	lhead->ino = cpu_to_le64(req->r_deleg_ino);
 	lhead->args = req->r_args;
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8f683e8203bd..0945ae4cf3c5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -619,4 +619,6 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
 extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
 extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
 extern int ceph_restore_deleg_ino(struct ceph_mds_session *session, u64 ino);
+
+extern bool enable_unsafe_idmap;
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 49fd17fbba9f..18bfdfd48cef 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1680,6 +1680,11 @@ static const struct kernel_param_ops param_ops_mount_syntax = {
 module_param_cb(mount_syntax_v1, &param_ops_mount_syntax, &mount_support, 0444);
 module_param_cb(mount_syntax_v2, &param_ops_mount_syntax, &mount_support, 0444);
 
+bool enable_unsafe_idmap = false;
+module_param(enable_unsafe_idmap, bool, 0644);
+MODULE_PARM_DESC(enable_unsafe_idmap,
+		 "Allow to use idmapped mounts with MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID");
+
 module_init(init_ceph);
 module_exit(exit_ceph);
 
-- 
2.34.1

