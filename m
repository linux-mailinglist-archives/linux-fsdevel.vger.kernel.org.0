Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65395726807
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFGSKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjFGSKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:10:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480C101
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:39 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9476A3F15C
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161437;
        bh=PnimYtsU8L1wziru+PbLo9AAv92Qytxkfm0LOSGrer8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OzrtS96FjLX+WxVt+JELE740HiCAXqMfMEgLkWCnxnuTMxDdoEXVPUDDGHnRL02N1
         2soXrgtQR1XD74mnYHomNhYuOliYDCYLJrwGZXaz0KzULJQpkyxr7yrgkhhA0ec428
         LrwmqIYK8GSUIW0atO8bkUT8Vzw9m6lq0Jak1fVYTWGZVrAmUplKruMIyo3D3Ugl3/
         cOhKAR/c3BNzdTn/sK4kFiBa0zh6V0RhSSyWlZpP9+6RhadYI7pntwQmHThqWJp0M9
         MTbX9m6Xg8KJrDak3AyuIXp0N3PC/YCBhBJmPYWv5Pck8xW2ijD++dCXT8zTbQduPU
         X5NqL/i9RB8iw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-970e0152da7so690897066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161435; x=1688753435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnimYtsU8L1wziru+PbLo9AAv92Qytxkfm0LOSGrer8=;
        b=cNUzG1BsAhZNRN2bpbhShOrKAN3FhGH1/JwIEDwg6JxBCauv0zhH3S3ZlPSBDHR1E0
         fwCchi37ZuHXRgZYto20r8+eHrNtuXoJ62M3hUCfLgNWge+WiPI75xCIZqeXBOS43TuP
         3iXAqoPO5fklbeK8x23VrDBJ76NkUB/BVH9+8LN6poc/1qhU/YuPy3Ph3GHYCL6ce/aM
         jLUZ57x6hH647OQlUf32ZF1uyKwBpmhBgavWwf1KNA+6dyko3Sfokx81V97yNcd0LAdO
         nPoYap6rDWaFSMm3QG67ra79SdPSxNO0i01Ue1njYnfNEA8IXIkWaBcmPfFRQrtDKRZU
         olTw==
X-Gm-Message-State: AC+VfDxjVtDJoP4/1u5N5hhpb/K69iT/tp8W5SMPe7cQNFPGSWxflYiB
        KwNG+IBRw6Rx3g4kCfZXe3deGzg5tQ1fDkxW/0LYNyi+PTbvCZE3ocOKjkcGwixSEJTF5/JeWYV
        hrgtDMe55VGv/AlYwXASOmiMraAMaLz6ieArjR/j82xQ=
X-Received: by 2002:a17:907:8a08:b0:973:d1cd:933d with SMTP id sc8-20020a1709078a0800b00973d1cd933dmr7874772ejc.47.1686161435289;
        Wed, 07 Jun 2023 11:10:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6noxHTypAyjkYYgzACU+3pomO8jr2HnNRQ/wBTwDkTdyTqSLpcYw7tUbeaV5I0WXpNEgp9uA==
X-Received: by 2002:a17:907:8a08:b0:973:d1cd:933d with SMTP id sc8-20020a1709078a0800b00973d1cd933dmr7874752ejc.47.1686161435119;
        Wed, 07 Jun 2023 11:10:35 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] ceph: stash idmapping in mdsc request
Date:   Wed,  7 Jun 2023 20:09:45 +0200
Message-Id: <20230607180958.645115-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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
index 4c0f22acf53d..05a99a8eb292 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/mnt_idmapping.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -962,6 +963,8 @@ void ceph_mdsc_release_request(struct kref *kref)
 	kfree(req->r_path1);
 	kfree(req->r_path2);
 	put_cred(req->r_cred);
+	if (req->r_mnt_idmap)
+		mnt_idmap_put(req->r_mnt_idmap);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
 	put_request_session(req);
@@ -1018,6 +1021,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	insert_request(&mdsc->request_tree, req);
 
 	req->r_cred = get_current_cred();
+	if (!req->r_mnt_idmap)
+		req->r_mnt_idmap = &nop_mnt_idmap;
 
 	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
 		mdsc->oldest_tid = req->r_tid;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 724307ff89cd..32001ade1ea7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -280,6 +280,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	int r_request_release_offset;
 	const struct cred *r_cred;
+	struct mnt_idmap *r_mnt_idmap;
 	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
-- 
2.34.1

