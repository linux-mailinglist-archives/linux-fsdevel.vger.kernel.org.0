Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC87725A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjHGN24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjHGN2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:28:51 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76E1991
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:27 -0700 (PDT)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A1D77417BC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414885;
        bh=StxqveXF5moq9iJU4D0IjENKfN6jaIfCw60woBc2a1E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vw9pr0c6YCf32t2r70+2SVyfe7Hdbrf46brAr5cDFKgGWqmDfbqzKhE8LQzkpc8NZ
         Qw6JQDuC2glVDrjXwnOxWmnfSjUrcRDEUI2VajOnpEsl2IXwDOYWpLCrC1Oj8cWhqa
         NM+LeTkQW9xiuXdm26QwJ3bwZcTTRtiKUgyI7dSVmwfEsI8zmMPpG9cgm5GxOQ3zsU
         r6qBfyRaRvK5Tni3WVSea9geyI83KhYk4SSTXFQZJbwAFfQs6SrXSVcRm1Ua1zMgr4
         pv8YbSyUWf0hgOlFVNS+9CUyivRRIFOi05N3tBLQYEihQg3A3VugjDacigdbaDHbo+
         fWaYNgDBrFiuQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe2f3cd8caso4560147e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414885; x=1692019685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StxqveXF5moq9iJU4D0IjENKfN6jaIfCw60woBc2a1E=;
        b=jUFTncvX0/lHZ+ujEVjD9UBmllpPC7sIIKGvIwYWGkqeFqVbEV/jeXjM0VuhaerqkT
         qq0X1eJRORe47gyGgX8/ZaEdhKpX9qCo2CcBs7GvC3D/flhhVRc2hgKs7KMPUOq/aIUA
         uh0Z7o1J7g0RJyScWugjaayuIcDFfD97k3MJ0DT1NsyfyeREG9XMmrqPl2pe0nDwxpiu
         SjD1WzvSsF6cA5Ki5C7nXkbpY8HoRkmHwMjIjbBkksL7mthzQw2e4smHkjcLyrqSUqvX
         Rr9RTVWUKZmfYanmFYUHZRYIK8XcGbb5o5IwFpAnixdJ9rItDaxeOqK3TzdrgNHjja3Q
         nkMg==
X-Gm-Message-State: AOJu0Ywg5CwBRMwu7STL17QbcWtrhTG8ViwYQZ23Ye72KrQMoh30DXJz
        eju6D75N56Sl/9NE6onRThywxDMFUrup+wDgz3iGDUSrYFnVEiazpYX6PPlgy81JEHlrujskcEg
        4CGFKjoRLJB7+qwMJ+g448N1pOLtyent7Djnu51WMN8M=
X-Received: by 2002:a19:384d:0:b0:4fd:f85d:f67a with SMTP id d13-20020a19384d000000b004fdf85df67amr5042657lfj.61.1691414885028;
        Mon, 07 Aug 2023 06:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH8dpV5asuzqi3+idsYjvpcoY+P3TuwWpXio+/xGhWIZTKsOh87DyxGbqpTlfVO9qsRuKnSQ==
X-Received: by 2002:a19:384d:0:b0:4fd:f85d:f67a with SMTP id d13-20020a19384d000000b004fdf85df67amr5042642lfj.61.1691414884702;
        Mon, 07 Aug 2023 06:28:04 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:04 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/12] ceph: stash idmapping in mdsc request
Date:   Mon,  7 Aug 2023 15:26:16 +0200
Message-Id: <20230807132626.182101-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

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
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- don't call mnt_idmap_get(..) in __register_request
---
 fs/ceph/mds_client.c | 5 +++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 9aae39289b43..8829f55103da 100644
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

