Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00D272966E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjFIKMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbjFIKLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:11:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FEE5259
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:59:53 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A51AA3F56E
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303191;
        bh=2hwztFxZhmRTBhQzcOpavHgJ6h9g0DydFvSzqcbHOs4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WKwT+ppy2zEwnm5govOR6qxcyUn3U90t06j0quu7rMwBC4/j7SrsBalzFi+PRXrn7
         GxFE4zbXXRBbGCj9P6aWhKxFSMGD3bN0bpIjuF6ZwCJHkJ0CBXQtyKWG0mEDftk5TT
         0vmcASto/PT4+n1V4I+FcTqc/1seg6hN0iRZ14doNuvHKb+PVSN5Y2P7+THmlnSeB2
         0eYpBQN4C1r4b57D8vPms/LegHlpWgqBwNhpM0wlZvAIYhWKKmzBRRWb80QGQFKUy9
         HQhKVJOYfYtiLB3493HChj/Q87l4ItDfZ+SyfhuQMXVdu2oeiQf3NHoeef0rHeIHv0
         nDsDl75NSXVIw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-978a991c3f5so177505566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303190; x=1688895190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hwztFxZhmRTBhQzcOpavHgJ6h9g0DydFvSzqcbHOs4=;
        b=Kx1oHrqMJnSFe4uaahccsGfJBJuqfb27wW6iJz064m3QMON/WmYGt/zskwVS71p4aQ
         GyqoFs4yEzdm+WEH4IzeJqHMe/PL2BgB3eDnS7Bx9hZMOTb80L/fGyk/d251f6Irm3EG
         4HvcfOj0wDZhCHifWYTNc0GIEH8KWULxIsfZa2ZARH6ucxcQaQTu3si+YVJOKdjg8Q6+
         ZR97Huh+1WiY4SHS2xW9/CMmQRPHDkQKZl5f/NimOF+9l68w8t9xYBE3ZKa/79cN+Fv6
         WuHtDqiP2DcYuHOC/6C3M/CosQCeTy6r6/g+G5y2VkBHmiibGRaDdL5LgcgzP5vZKDqP
         6BMg==
X-Gm-Message-State: AC+VfDwNKgO4b2IHQ970ZcvVJ0ifqTxcwxYrujlVvp6fZs8a+vZ0CmNY
        C7mQRqfuS19FbUNWd/BD6gMAEbqkwapT4YDsLBvf+5uvERJjRD8Elw6WcktYGARVB0hG5TqM7e3
        l9xF3PuUxLzBs/Q2LXV374aVqYqy4qUMM3L3LID9pxmI=
X-Received: by 2002:a17:907:3d93:b0:94f:2a13:4e01 with SMTP id he19-20020a1709073d9300b0094f2a134e01mr1371730ejc.74.1686303190606;
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MsL6zC8MBPYxx1/IN/olzX93IyA3TrvCsZrn7wnZMo+W05KzTTK8rzx2rV8d5frIVKKWmuA==
X-Received: by 2002:a17:907:3d93:b0:94f:2a13:4e01 with SMTP id he19-20020a1709073d9300b0094f2a134e01mr1371717ejc.74.1686303190365;
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:33:10 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/15] ceph: pass idmap to ceph_netfs_issue_op_inline
Date:   Fri,  9 Jun 2023 11:31:25 +0200
Message-Id: <20230609093125.252186-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
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

Just pass down the mount's idmapping to ceph_netfs_issue_op_inline.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/addr.c  | 12 ++++++++++++
 fs/ceph/super.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0a32475ed034..2759a0cf2381 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -291,6 +291,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+	struct mnt_idmap *idmap = priv->mnt_idmap;
 	struct ceph_mds_reply_info_parsed *rinfo;
 	struct ceph_mds_reply_info_in *iinfo;
 	struct ceph_mds_request *req;
@@ -318,6 +320,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
+
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (err < 0)
 		goto out;
@@ -443,13 +447,18 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->mnt_idmap = &nop_mnt_idmap;
+
 	if (file) {
 		struct ceph_rw_context *rw_ctx;
 		struct ceph_file_info *fi = file->private_data;
+		struct mnt_idmap *idmap = file_mnt_idmap(file);
 
 		priv->file_ra_pages = file->f_ra.ra_pages;
 		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
 
+		priv->mnt_idmap = mnt_idmap_get(idmap);
+
 		rw_ctx = ceph_find_rw_context(fi);
 		if (rw_ctx) {
 			rreq->netfs_priv = priv;
@@ -496,6 +505,9 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 
 	if (priv->caps)
 		ceph_put_cap_refs(ceph_inode(rreq->inode), priv->caps);
+
+	mnt_idmap_put(priv->mnt_idmap);
+
 	kfree(priv);
 	rreq->netfs_priv = NULL;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d89e7b99ac5f..0badf58fb5fc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -481,6 +481,8 @@ struct ceph_netfs_request_data {
 
 	/* Set it if fadvise disables file readahead entirely */
 	bool file_ra_disabled;
+
+	struct mnt_idmap *mnt_idmap;
 };
 
 static inline struct ceph_inode_info *
-- 
2.34.1

