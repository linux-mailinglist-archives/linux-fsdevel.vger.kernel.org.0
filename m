Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF309763879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjGZOIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjGZOHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E342D60
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:10 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D13D3F078
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380427;
        bh=1S1U/zjZd3rVIX0g7C71Py6TvgiMco2DPzTIrhllhdU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cdaHVTWXg1x7w8X7K5A5/tz3sldhnQ4Bsg1RlDGZuXKobhyb4hKRH9Vj+jrgA2m24
         zNr2HJj5/PGOQhtp1agzwi4AmQuVcCyWh4vRE7OEhGLxE9tRmogDYyBSq+w4a3ypZv
         tOTxgYwdTt6pa3zgO6Gz2kt6uChGqsyOQAc5o9X1PQY+wcy1rrHdFQ+djsi+7je4DW
         BUXT8xeiIG2yFjus0YrR4kuaVbZWgVI+3qJYTc6oASn4Bq4K1pVMk/6rFbnIN92VGy
         1BTE0fmvcxFJhDQA6VnCd9Qxc2nOaUP1O3WShCNnA6pNNHnA4cdl5rZGim3+PTVrTE
         bY/6b2o/u7JQQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993eeb3a950so29174566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380426; x=1690985226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S1U/zjZd3rVIX0g7C71Py6TvgiMco2DPzTIrhllhdU=;
        b=ZQeUphY9z8EQu4gsG4RrP1PFzmDROCFiRu+1JdYch5uufbutnHOYN0ZKht3dhs0P18
         pkVJyEKbg4sDenmTXgi2IpA5wNpq9Qh6Wy3kn8Za+d5gFDL4t1Or5cpqYkPhShulYMeW
         XqR8LXFNbmUczt/bN27/daH6HE0wV2HNeWhgKeVUIGrNlNHH5kfXw9O87zPIvGHi9zk9
         ryizRQ/f2++Gn5i+sayL4kffAwfQAhmemuNprgzuL8NhYkWtHcJEe9DSy9xripujqqMF
         //Mft4OR9lpItmAsk5qaFauD/o6UR7o91laWhWUBeq4QdUdEx+2CfHzcBe4YKSvytFsv
         +dqQ==
X-Gm-Message-State: ABy/qLZ2wF02ifXDENgt1XpltPRTpLOC4zHdfMyyKlW7hye4rW0vgsxd
        5FMnQvp5+7iwL4AacT4xWXR64XLtzhlx+y8gNDKEP59ORi77sc4yNgnDwXC4HNVRZXW2uQrpm10
        83eQajYU7fbzW5fwQ8gKltz1jwHsaniegPN2zHYS+yf4=
X-Received: by 2002:a17:906:32ca:b0:99b:cf4f:909a with SMTP id k10-20020a17090632ca00b0099bcf4f909amr478124ejk.37.1690380426600;
        Wed, 26 Jul 2023 07:07:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdO9RMS5YiYtYtrxPBtrqWXq2pdOocz6Pc1y3mPKGm7kUZVGh/P2KJyIGVyp7VS0xvzWmGKQ==
X-Received: by 2002:a17:906:32ca:b0:99b:cf4f:909a with SMTP id k10-20020a17090632ca00b0099bcf4f909amr478114ejk.37.1690380426405;
        Wed, 26 Jul 2023 07:07:06 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:06 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 02/11] ceph: stash idmapping in mdsc request
Date:   Wed, 26 Jul 2023 16:06:40 +0200
Message-Id: <20230726140649.307158-3-aleksandr.mikhalitsyn@canonical.com>
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

