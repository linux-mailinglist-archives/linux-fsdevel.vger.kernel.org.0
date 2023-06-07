Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061572641E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbjFGPV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjFGPVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FA1FC4
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:18 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B2F23F15C
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151277;
        bh=fRWJ/KMFF26C36Dkjhg/LzbtMqzlyKNGjI+Q2GqWstI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=V1Ff3BPEV8KTqjZ3lC12iPMVUr4IGgFNa6yBvib0AM4JrEfyxLvHN75YKU1hS3Kdy
         lMcZgnxfw78+7vd/C2J7DPd3N4QOoZJ9wcpxOl10/KBTJGEGHOtRPHGsuu24K6yv4M
         7a+tfmQkY+kjq6sP+EI0mtF9tXJppeOgWyAX9TFAszNn+FlHrx+aUnUsjVY1lT8/en
         M4Azyfq/TiwD5v5YT8TH8NTmDcwuqKbNhn9XESYDhSMmUX3JcNDdiKPIu1KkWii3IO
         7rjnt5s7is+ZbiuoX4zsYpuwgoQoPgaaY6hWjnKwwhC5EIbSrnJUuJpoLu7PlxY5SQ
         QPIO9hWFH5n3g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-516a17e29efso286138a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151276; x=1688743276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWJ/KMFF26C36Dkjhg/LzbtMqzlyKNGjI+Q2GqWstI=;
        b=aM8jsNMqapuCSrKZCcgVeZOfid9jvB/dOPe88xlavSA8nzcHnh0VUvEkWbiryC4TyK
         Dae/+vzJA/NV2XfkUU+Qk1LeGVL2Ou0dO5REiXrJ+LZVAhlDmOthvthz95oMZagVT0N5
         C38T5P/TFEUiLeM1BeA2nIszVX50Pjp4SOJC+FAMVlOd4XDAQlcmq+93JAsEtw/Oiscu
         tOmI3VIHcJx+jsod0S9nExVp0eg5Ptw1NNbIIywSEjww2YwUJCsfxS9HBcLFyeeJgyS/
         coSAFnKd83vTY77MF3RPZSJIS6qBKltMwmzAkumc6Evavjm81pKPOgKaig3+pkjWLSEK
         Dqng==
X-Gm-Message-State: AC+VfDz8sh8NrsJ56tZV+idrU1lUVLNbTn2Ey/sZxvrbe8Uja6FWodw/
        onrgyw7hbmK2J+2pbRuvmXp1ZsiICEZxQ5CqrKTHxYSkZRVnt+L26iQigQM3wOKcr63hwr4V1hS
        6C/fe51q0Og7hdFW0iULMaZaBP29aLhPQ3kzF1GIAgXI=
X-Received: by 2002:a50:fb08:0:b0:50d:fba2:7265 with SMTP id d8-20020a50fb08000000b0050dfba27265mr4999122edq.16.1686151276215;
        Wed, 07 Jun 2023 08:21:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NG1+7oNUL070e5Y2tOTLH7AP6HsR/R6XA9VHEAuvdEg/ihuA+9d3lvLxkxs+GGdNzAysGQQ==
X-Received: by 2002:a50:fb08:0:b0:50d:fba2:7265 with SMTP id d8-20020a50fb08000000b0050dfba27265mr4999105edq.16.1686151275926;
        Wed, 07 Jun 2023 08:21:15 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:15 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] ceph: stash idmapping in mdsc request
Date:   Wed,  7 Jun 2023 17:20:26 +0200
Message-Id: <20230607152038.469739-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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
 fs/ceph/mds_client.c | 7 +++++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4c0f22acf53d..810c3db2e369 100644
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
+	if (req->r_mnt_idmap != &nop_mnt_idmap)
+		mnt_idmap_put(req->r_mnt_idmap);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
 	put_request_session(req);
@@ -1018,6 +1021,10 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	insert_request(&mdsc->request_tree, req);
 
 	req->r_cred = get_current_cred();
+	if (!req->r_mnt_idmap)
+		req->r_mnt_idmap = &nop_mnt_idmap;
+	else
+		mnt_idmap_get(req->r_mnt_idmap);
 
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

