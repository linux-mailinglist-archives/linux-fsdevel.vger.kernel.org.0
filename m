Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2EF7638A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjGZOMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGZOLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767B3AAD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:02 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B9D23F078
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380641;
        bh=1S1U/zjZd3rVIX0g7C71Py6TvgiMco2DPzTIrhllhdU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=k//FCegcf67zTG9QjoC689xkv6pn7qz3P5Nun5u7kQtbE2Gsrq4Dk7dnViCrld+MG
         Hu40Jv7Cr8ZE5Gm8PTH6llr+8WSQ9HAzuBl3CqU3eH/MOWA8ClMN7QXHWDhWiV3hOv
         fEYOm3/hWanTcR0BfjVxj5q7LNOJOxkaNU0Js+9VZ3pH9O0HzrWTToiAmcGcPdhlsZ
         6jCbI6JeWbgMBqwHN2AT8zRgKgWWx5KkPG3Ymc/bw7+kfAW/FwWCvnEX4wfiglN0hm
         b3dwTuEs+WQE3C1/OXUCU8t9cnJ+E6khsstBb1XUfpnJrZAAYcDEV0errcpzSy9aSF
         vKVfWGgyADjvQ==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd2d331e1eso20264375e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380639; x=1690985439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S1U/zjZd3rVIX0g7C71Py6TvgiMco2DPzTIrhllhdU=;
        b=blwyw/5gxaHV9WTQe7pxR3T5jkm89OA+XJ/TdKh7ckryHdjvPo+AgMKdJOqyHbg/b2
         rp7/2u2oTEhI0jjD8zbnShaoqPZUHoaVx3+ZzORXW9z8Hl5HdAhHHC9F4EPQ43nla8DE
         W6svC3r7ilk/YkAo/PpyRYY9wXVdkZa+aB89v9gygTeW2jZdGXvWSB7nWFm0W3DTwk16
         VeGDGqC1ev5Or666FC0m/S58zG4wE5RDWMRs95WMsuxTxrhMF7ncsW8TxjomwwSvmCyC
         osMK/mU1chG+Zt8lKW5JTIwSMq6am6Ly9lHnMcYB8jkDodYChbANNxdcKRwXu8Z3CiA7
         IwvQ==
X-Gm-Message-State: ABy/qLY3y7UpblI0THLVIJ6wfeMBHgbKInsuoUte1eNJglP2aL6O1ykO
        TV7JbCq84taUyPomsj9NARTbZr0tUvT7LVdhKq/3z+guTeHa/S9dDUo+RTF/eJMYl3UU2YcZIc8
        JXzB3msl1VG6idEXzGz0GAwtWZxaEcNrVh4eRb1j9MFA=
X-Received: by 2002:a05:600c:244:b0:3fb:cfe8:8d12 with SMTP id 4-20020a05600c024400b003fbcfe88d12mr1446349wmj.14.1690380639079;
        Wed, 26 Jul 2023 07:10:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzgaEB0z3LkeykLLNW2R5US/okV6KXf1+9oX3PnG0NxDJMH5Lmcd+ZcKK0yCyLfcKFYj8P/w==
X-Received: by 2002:a05:600c:244:b0:3fb:cfe8:8d12 with SMTP id 4-20020a05600c024400b003fbcfe88d12mr1446334wmj.14.1690380638896;
        Wed, 26 Jul 2023 07:10:38 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/11] ceph: stash idmapping in mdsc request
Date:   Wed, 26 Jul 2023 16:10:17 +0200
Message-Id: <20230726141026.307690-3-aleksandr.mikhalitsyn@canonical.com>
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

When sending a mds request cephfs will send relevant data for the
requested operation. For creation requests the caller's fs{g,u}id is
used to set the ownership of the newly created filesystem object. For
setattr requests the caller can pass in arbitrary {g,u}id values to
which the relevant filesystem object is supposed to be changed.

If the caller is performing the relevant operation via an idmapped mount
cephfs simply needs to take the idmapping into account when it sends the
relevant mds request.

In order to support idmapped mounts for cephfs we stash the idmapping
whenever they are relevant for the operation for the duration of the
request. Since mds requests can be queued and performed asynchronously
we make sure to keep the idmapping around and release it once the
request has finished.

In follow-up patches we will use this to send correct ownership
information over the wire. This patch just adds the basic infrastructure
to keep the idmapping around. The actual conversion patches are all
fairly minimal.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- don't call mnt_idmap_get(..) in __register_request
---
 fs/ceph/mds_client.c | 5 +++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 191bae3a4ee6..c641ab046e98 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/mnt_idmapping.h>
 
 #include "super.h"
 #include "crypto.h"
@@ -1121,6 +1122,8 @@ void ceph_mdsc_release_request(struct kref *kref)
 	kfree(req->r_path1);
 	kfree(req->r_path2);
 	put_cred(req->r_cred);
+	if (req->r_mnt_idmap)
+		mnt_idmap_put(req->r_mnt_idmap);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
 	kfree(req->r_fscrypt_auth);
@@ -1180,6 +1183,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	insert_request(&mdsc->request_tree, req);
 
 	req->r_cred = get_current_cred();
+	if (!req->r_mnt_idmap)
+		req->r_mnt_idmap = &nop_mnt_idmap;
 
 	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
 		mdsc->oldest_tid = req->r_tid;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 717a7399bacb..e3bbf3ba8ee8 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -300,6 +300,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	int r_request_release_offset;
 	const struct cred *r_cred;
+	struct mnt_idmap *r_mnt_idmap;
 	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
-- 
2.34.1

