Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033076FC86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHDIux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjHDItm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7054ECA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:38 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7A1FB417BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138977;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SwHT3qEFYsgQTrcZKivEqLIyocWHk2VxMCYuienXEU18fS4cv6hal/HXWkDzmt0oh
         Pm45Cs2lIcWL99S8Tyz8F7Njb0RorTEg0+vD9iyULOra7alfT0gn4t1492ra1bNlFI
         qQYdK+GbdZ5dt57SU/y9BrInO+GFuTXW72Fu3dnWs9NEWPBMqtQhPLS2hgbm+68FDI
         zFNd3fyxY2XOCZXjIASAmt1Qk8GUobh62c7RsYQoAtqTHrIx6HDWBAc4dztBIbhWvA
         uMdyUKDH/Mwij9CJqlHBJmTMWD86kmcO71VpmavIDTffnYcRR+Ixu5nBH2n43SyQSV
         Q2mHx0+ud503w==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bdee94b84so243393566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138977; x=1691743777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        b=A94w/7X/QayZSrQ/F0h7o/eVWyA0tScMuLGfOE6fNoL7ky4D6VuOz1q1sO16qIHI3Y
         D9ZKnZyigr0/xzULSDY0utqK/JaNyd4zxGftmO6d9obOaXAOGxiqNcZShqjHoWf0vv1C
         GQPBZAHOazuHlNxUgVfq5fGO4B8vsznZj01p2s5ZFiYK2ZFSsaYvQVPmS+BRoa4yJCmI
         0YszL9yVTif0NZdy876CLfQ/lBPBnJtqCeQN5cvOOBhpboECVSuACZuwWpofIluN6wIl
         JPn+sG3hUKPaS6HdP/5IYlC7pKcGNIs5HQYrVc6CKaF588UsXoeAsi7V9HPM4d5WuhRb
         jrlQ==
X-Gm-Message-State: AOJu0YxGn+FaReSlp038qBrgZ9ykGGZIe/66JXbIeXDhmks0QNuIdYCP
        4/Dh+QeYHWxGQ7JCj+Hd+HIcM9iaxFPWe2Tn0EChWM6viQrOdxf6HUFqPk8Ow+tYMWjua/WIWBx
        10fgllsjqY00WyLFfYkafhhXzN5VcE7jvD+tqA1PiWlQ=
X-Received: by 2002:a17:906:30c4:b0:99b:50ea:2f96 with SMTP id b4-20020a17090630c400b0099b50ea2f96mr1353114ejb.12.1691138977188;
        Fri, 04 Aug 2023 01:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENvJC3KHm+M7be5nN+fqKwo0plcwe5syTouQ0tjPAcuDJqmboM6FZDl+R6VHCgZD1KqsNuNA==
X-Received: by 2002:a17:906:30c4:b0:99b:50ea:2f96 with SMTP id b4-20020a17090630c400b0099b50ea2f96mr1353099ejb.12.1691138976964;
        Fri, 04 Aug 2023 01:49:36 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:36 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/12] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Fri,  4 Aug 2023 10:48:51 +0200
Message-Id: <20230804084858.126104-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

