Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448F7283EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjFHPnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjFHPnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B82D7C
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:31 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14E323F36A
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239009;
        bh=MVopSiFXJtuCZDFmw4k6EoX9EHPj+DJ/m9lrNV/HJJI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JWdaS8R3Biql39BOapnIA4ExxbHPU42lNZA3icuDXDdH8D8EG2AWOPhiNIMZi90Bx
         /KTTieD2fAkKQ6jUwEXtn3PqveQc78LM+jR4k3X456qZ/8ezTkRD5DiLqtAVkYQ71M
         60DJBH2xhvn3z70XvH3rSXV1sdE1BE1PtzbXhtivV5ICcvbdjwtC0rZN5Wgv5fplHo
         w5bEZEP8DFPL1RKQmu3Ho5GBV3PI+ggGzj3dS3IcIuqog9QWJ5K2SR1WplivRuV47a
         E6Pk1KcPiYsi7wffaxKsXMjWbTfCv6407UdjnkIFcwvey/jpPrUZI1t/HhhBKF2vla
         7LOdcyS+Lx0Ow==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-514bcf60cd1so758627a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239008; x=1688831008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVopSiFXJtuCZDFmw4k6EoX9EHPj+DJ/m9lrNV/HJJI=;
        b=jl4W9M2clKsMH2Hx6aAnmcy93DLdhfe5JxlzRLI+xcjUpedU6ca8fECoperWC6V4Xh
         ZEyqeskQMZfV314M/f48PjYSFyY0eJ07lGXP5bACfbS3Xa/DoVjW3p3FhxmVpuRf4zRa
         1g9Pgxi4F8Mnv9VMvrYSXu4c+7s/7sctwpH0D6JmgEE+7IjPoN8IMXcyfTZV7u+KSk4n
         YnzwoJCMS/Tfzwv5aS7K6kLPPftEBE+lG/5c/QAu91bxCNVx9yKSGfyehwFY5tXzsMQJ
         fVOrfwa3plN0ua3LhPUZyiP6BUhB6BGkON6eSXccD7dy/Fbo7BnCk271e4OUWLydxPpX
         Hn8A==
X-Gm-Message-State: AC+VfDyXpX9Xw4mGFMQkekVfBS1Q0Fy9+7UCOnyQgdqxnt9z5atcQUSJ
        tcL6LI+FgnjTzVl43NbsgZC0SJtddBc0aQDK1bR0kqgYjSCUSwiGn7d08qUfjjUi2TOVUoV4Th/
        7iPMEWCL1RVXmvxeN6CZtJZs3w+9dbu4sQ6+AfKlp4E0=
X-Received: by 2002:a05:6402:1218:b0:50e:412:5a50 with SMTP id c24-20020a056402121800b0050e04125a50mr7251917edw.29.1686239008688;
        Thu, 08 Jun 2023 08:43:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aHZ5F2WlbAZXf+JA7fUchj6Pwo85kKEqXk5pWSEZo0h3QxyhCK3FkPsP0UU6edRHkd19sAw==
X-Received: by 2002:a05:6402:1218:b0:50e:412:5a50 with SMTP id c24-20020a056402121800b0050e04125a50mr7251892edw.29.1686239008441;
        Thu, 08 Jun 2023 08:43:28 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:28 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/14] ceph: handle idmapped mounts in create_request_message()
Date:   Thu,  8 Jun 2023 17:42:44 +0200
Message-Id: <20230608154256.562906-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Inode operations that create a new filesystem object such as ->mknod,
->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
Instead the caller's fs{g,u}id is used for the {g,u}id of the new
filesystem object.

Cephfs mds creation request argument structures mirror this filesystem
behavior. They don't encode a {g,u}id explicitly. Instead the caller's
fs{g,u}id that is always sent as part of any mds request is used by the
servers to set the {g,u}id of the new filesystem object.

In order to ensure that the correct {g,u}id is used map the caller's
fs{g,u}id for creation requests. This doesn't require complex changes.
It suffices to pass in the relevant idmapping recorded in the request
message. If this request message was triggered from an inode operation
that creates filesystem objects it will have passed down the relevant
idmaping. If this is a request message that was triggered from an inode
operation that doens't need to take idmappings into account the initial
idmapping is passed down which is an identity mapping and thus is
guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.

The last few weeks before Christmas 2021 I have spent time not just
reading and poking the cephfs kernel code but also took a look at the
ceph mds server userspace to ensure I didn't miss some subtlety.

This made me aware of one complication to solve. All requests send the
caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters for the
server in exactly two cases:

1. to set the ownership for creation requests
2. to determine whether this client is allowed access on this server

Case 1. we already covered and explained. Case 2. is only relevant for
servers where an explicit uid access restriction has been set. That is
to say the mds server restricts access to requests coming from a
specific uid. Servers without uid restrictions will grant access to
requests from any uid by setting MDS_AUTH_UID_ANY.

Case 2. introduces the complication because the caller's fs{g,u}id is
not just used to record ownership but also serves as the {g,u}id used
when checking access to the server.

Consider a user mounting a cephfs client and creating an idmapped mount
from it that maps files owned by uid 1000 to be owned uid 0:

mount -t cephfs -o [...] /unmapped
mount-idmapped --map-mount 1000:0:1 /idmapped

That is to say if the mounted cephfs filesystem contains a file "file1"
which is owned by uid 1000:

- looking at it via /unmapped/file1 will report it as owned by uid 1000
  (One can think of this as the on-disk value.)
- looking at it via /idmapped/file1 will report it as owned by uid 0

Now, consider creating new files via the idmapped mount at /idmapped.
When a caller with fs{g,u}id 1000 creates a file "file2" by going
through the idmapped mount mounted at /idmapped it will create a file
that is owned by uid 1000 on-disk, i.e.:

- looking at it via /unmapped/file2 will report it as owned by uid 1000
- looking at it via /idmapped/file2 will report it as owned by uid 0

Now consider an mds server that has a uid access restriction set and
only grants access to requests from uid 0.

If the client sends a creation request for a file e.g. /idmapped/file2
it will send the caller's fs{g,u}id idmapped according to the idmapped
mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,u}id
0 in the idmapped mount and will be sent over the wire allowing the
caller access to the mds server.

However, if the caller is not issuing a creation request the caller's
fs{g,u}id will be send without the mount's idmapping applied. So if the
caller that just successfully created a new file on the restricted mds
server sends a request as fs{g,u}id 1000 access will be refused. This
however is inconsistent.

From my perspective the root of the problem lies in the fact that
creation requests implicitly infer the ownership from the {g,u}id that
gets sent along with every mds request.

I have thought of multiple ways of addressing this problem but the one I
prefer is to give all mds requests that create a filesystem object a
proper, separate {g,u}id field entry in the argument struct. This is,
for example how ->setattr mds requests work.

This way the caller's fs{g,u}id can be used consistenly for server
access checks and is separated from the ownership for new filesystem
objects.

Servers could then be updated to refuse creation requests whenever the
{g,u}id used for access checking doesn't match the {g,u}id used for
creating the filesystem object just as is done for setattr requests on a
uid restricted server. But I am, of course, open to other suggestions.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/mds_client.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 05a99a8eb292..8826be3c209f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2581,6 +2581,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	void *p, *end;
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
+	kuid_t caller_fsuid;
+	kgid_t caller_fsgid;
 
 	ret = set_request_path_attr(req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
@@ -2649,10 +2651,22 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	head->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
 	head->op = cpu_to_le32(req->r_op);
-	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
-						 req->r_cred->fsuid));
-	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
-						 req->r_cred->fsgid));
+	/*
+	 * Inode operations that create filesystem objects based on the
+	 * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() etc. don't
+	 * have separate {g,u}id fields in their respective structs in the
+	 * ceph_mds_request_args union. Instead the caller_{g,u}id field is
+	 * used to set ownership of the newly created inode by the mds server.
+	 * For these inode operations we need to send the mapped fs{g,u}id over
+	 * the wire. For other cases we simple set req->r_mnt_idmap to the
+	 * initial idmapping meaning the unmapped fs{g,u}id is sent.
+	 */
+	caller_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+					VFSUIDT_INIT(req->r_cred->fsuid));
+	caller_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+					VFSGIDT_INIT(req->r_cred->fsgid));
+	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns, caller_fsuid));
+	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns, caller_fsgid));
 	head->ino = cpu_to_le64(req->r_deleg_ino);
 	head->args = req->r_args;
 
-- 
2.34.1

