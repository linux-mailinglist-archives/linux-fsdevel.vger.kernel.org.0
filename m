Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F976EB92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjHCOB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbjHCOBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8492101
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:43 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C7FC4247E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071225;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hQ94tLgZhZxjBhm3kAse5zvk4HUg01EyK4tg2hWDiMgenUHO5qFaLo5onT4JteuHv
         xnCpv2WTPw9pWa25KpIIUIT5meatWbYpry//1uJqevvF8hlql3cYwaB1kgGwqFw/rs
         hkRbPguOIazISBDu7CmQrcGRp2XUIk+TmL6wwGRe4H4rq1Stbzyb2pBxAUTpC2AV5Z
         nOiZteY506lnZWNZ9JPdHaYE4K2wb7ja6yDb5QfNfMWOQ7+Yre21MEJ5kNj6KMs4+0
         dOvrKEioawt5/qph/tgILwHBbpoe5rZB+Fg/kDYvl+Ji1lJ9M3I69RXrwlA8+p5K/x
         1vLCBDyy0/2Uw==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so681779a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071223; x=1691676023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        b=a/jzQ817lcdcElDi3qGr5DjLPMz54aYPT1hs/hFNrc7r5BzLcv8SvL41F7K80vkohm
         3SVkyraA8RJ/182Fzwy/vj4Ukys0NhYyFVxNiGLeTBQUOKd14sUHV47X+FlBFPydUrGd
         KaR+536i1Lbd9W7C0+bj1WnRLhQHHXZ4i7taohC3zNf+UKNUWvOJ/6/iEvSxwxw0qLiD
         534jPgxuMakSj3iPVYlXJQZsIOL1P0eA27gGNP0E/kN/Qaxa5UAnxb6SPHsZmjwDHHVT
         psxmQ0Z5ptx37iEAnUxQNqPMNmVspw+94Yx8yE7ut1YmInkorj2ZL05/NDWFR4jTh1eY
         fqyQ==
X-Gm-Message-State: AOJu0YxrHJWAkr/huLlUoY/pSZ+4/wXMNDZiUZnPxe9fFYtt/opszsi3
        nUZ2JnoMFIARS4pumSXz/OHFHotta9ifNhVea7FSAs/9t9wCMOHgLPL46p8dWizj2daXFm3YRUY
        rDncM0NvK5trM1LG11msiaq1ZcmdJioFXaF/G+BpRuFw=
X-Received: by 2002:aa7:dbda:0:b0:523:f29:a912 with SMTP id v26-20020aa7dbda000000b005230f29a912mr1338861edt.21.1691071223232;
        Thu, 03 Aug 2023 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNXClq9w1vu3j+/MCpqQ1qf7yVb7U3H47Lv374blmqMtgY6wWk79A9/cAXoEkoeyvY03jUKw==
X-Received: by 2002:aa7:dbda:0:b0:523:f29:a912 with SMTP id v26-20020aa7dbda000000b005230f29a912mr1338852edt.21.1691071223066;
        Thu, 03 Aug 2023 07:00:23 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:22 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Thu,  3 Aug 2023 15:59:48 +0200
Message-Id: <20230803135955.230449-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable mknod/symlink/mkdir iops to handle idmapped mounts.
This is just a matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
v7:
	- don't pass idmapping for ceph_rename (no need)
---
 fs/ceph/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b752ed3ccdf0..397656ae7787 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -952,6 +952,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1067,6 +1068,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1146,6 +1148,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
 			     CEPH_CAP_XATTR_EXCL;
-- 
2.34.1

