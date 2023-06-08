Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE557283EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjFHPnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjFHPno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58930D3
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:33 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 75A6F3F15F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239011;
        bh=h11FfWaHHNNtwvZRIcKn5zgsctxJ3ebjyEZJ//czxrM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZbzhpZ1WUEeCCIPzPx7BcJ8KzYJ//hq8SPKPB30130rx/Fc7I3c8vs3CK4KrxNeQy
         xri1iTMbmTwBluBcy3BJYqd416ux4aiWCgNN3UFJMbZiFf+zMTH45nfEGQJs76XgyZ
         xnPTBS8DtIBze/v5sA6HjPz1r1DHmmCQ+P7q6dslzLKYWL4qRqoU/RNAKmHzUOKzhM
         w2TN1+p96bjt7YtgqFvQLMFoy5rDlYfDAVv5bkjmcPzA5ZirqQFGQhcQFO6KQNKfEJ
         e/70tQ3k/UKb09izzW8z3+k1BcaKuy3x8q56/7qF0wXDlc7ZsG3dUBZxOwPz9mk3JV
         kenl/VBogGctw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51664cc4c07so756503a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239011; x=1688831011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h11FfWaHHNNtwvZRIcKn5zgsctxJ3ebjyEZJ//czxrM=;
        b=kDlWM4oB20wYqT37TrYyWmjDimDqrz07RS+Tg05wbLPhWa4pQQz/lYhsE6hapgB1G9
         11erEVJODWYEwrGVRklyqN2cmgTs3FQT6w/0fWUQ+oIMbrh31sDxKZaPG4p077dLXXpI
         fGmcKXVyWNSQpipwKYoSOsOJzvZdIeXiwzWHDKgs5b/BSa92Jt56Jvuq2smKWc8vzGcl
         Jlz/lx5RoJYSzuTsw/vN8zpNsc1d+oDR0NwQNFPB5c7tCTS/eYB7ZgKGyi/02Fq9DxMO
         SfjF4zcdY876DiHrL25VmK7mrDr1Czt+qcucVjYbJdVm0j1gV3a1Wpz/1ZDiLghRmpqL
         JfaQ==
X-Gm-Message-State: AC+VfDxPRhp8lhzsExNkgXOKcSSj6AjhmvGVRbM7KsE4s4P0EGy6My/j
        hlIhwwIfoRN73DUHhSoYXGLkSP1AD0hkxYd17MdrIP9cTZYBqX3SBfhyxkMNDAlDs5MvnQdKyKY
        ihAd/qGHKO6fNA+wc7+NoKOUiwGdKjsrB/0rAQmxq6OM=
X-Received: by 2002:a05:6402:799:b0:514:a6bd:144a with SMTP id d25-20020a056402079900b00514a6bd144amr7678710edy.11.1686239011194;
        Thu, 08 Jun 2023 08:43:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46MI6AGDMIKSmvYESXHXyqShI61cTt9qF9ZEPOi25XHZ18WeG4MWokNCW+1PIE0IeOqUiLMA==
X-Received: by 2002:a05:6402:799:b0:514:a6bd:144a with SMTP id d25-20020a056402079900b00514a6bd144amr7678690edy.11.1686239010947;
        Thu, 08 Jun 2023 08:43:30 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:30 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/14] ceph: pass an idmapping to mknod/symlink/mkdir/rename
Date:   Thu,  8 Jun 2023 17:42:45 +0200
Message-Id: <20230608154256.562906-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable mknod/symlink/mkdir/rename iops to handle idmapped mounts.
This is just a matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cb67ac821f0e..355c5574ad27 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -884,6 +884,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
@@ -955,6 +956,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	if (as_ctx.pagelist) {
 		req->r_pagelist = as_ctx.pagelist;
 		as_ctx.pagelist = NULL;
@@ -1022,6 +1024,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
 	if (as_ctx.pagelist) {
@@ -1324,6 +1327,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	req->r_old_dentry_unless = CEPH_CAP_FILE_EXCL;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	/* release LINK_RDCACHE on source inode (mds will lock it) */
 	req->r_old_inode_drop = CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL;
 	if (d_really_is_positive(new_dentry)) {
-- 
2.34.1

