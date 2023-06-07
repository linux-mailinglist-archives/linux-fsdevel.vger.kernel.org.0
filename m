Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD670726441
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbjFGPXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjFGPWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148092713
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:52 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E06153F15E
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151309;
        bh=8yrq/kS6S1HbL22xkrZbDKXNe0OGSicmb8/p7/WTma4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Tr82GG5907vuuuZ+W26PJMKEM5TISV5bFvafEacdXcQemivJKlCUYkVA2lb8R4wnM
         sWu87Jx1GU8CRf5ng7U9ZrjcnD8DWhWpz/QqEbVUHjrZa12VCn1/5s12ys5pQvphb3
         iKNl9eFV39S6XpNOmaOesJNxcm/DyPwbnfDhrut1neHi+NNUpCMg/X/kUbZAzurfIJ
         HBoIylF1KVmTlqSJYNorPST5+8B5LbNznMckE1y9kQj/HS7/9uinnxzCZmPXEur6s+
         wgAxYa9fwQwv85OkyJQjhrOk9TVEEseYzkUb1lerBD0wflg0I/Ypks5JJetw6f167s
         DOeKZQXPoEuUQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-97542592eb9so437022966b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151305; x=1688743305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yrq/kS6S1HbL22xkrZbDKXNe0OGSicmb8/p7/WTma4=;
        b=Wa4Ez0pJ15zGII25nS4fS0JOOysKghJUp05PrRLfdNuBsXyQCubx7aNjL/U3vu9FJA
         Do54qWPWNS3j9BHSAW/wTwAQIo5PIqQz27jBXuN+c62KI15Dc/4Q638uTZz0PbGZnrrQ
         nvcanuuDp/bcQnxOweJfdTAxBqMs2itu4gL1nXnRsnSIxiefmT6A5najTE4npbsz7Fkx
         p76BwsVI7WCNu58UpWP+zyQeoQQrrLUh7RZpALup3MfokJIgBNEbhL1cA5q7VwmbiQV+
         QFG1jqQB5XvMmyXtssJz4fMpF23HvTe46PHN787Kquncv128xWXcsTdPAcPkv+tADiN4
         bCNw==
X-Gm-Message-State: AC+VfDxkcWux+nj31sVFxl+fh63PuRGYUkFTKnsVE+ZaCj69fGosgou4
        XBKYj+QgTjKyzF5A0w54PouWLQMRbWBfKFhQXoS/PYljo4j+GoQKilBQ/OX0bEEfpLftnNzx2jl
        1thIb1WR/idBV68YY/wIUOt4cKYdU0ccppMkdpb0G734=
X-Received: by 2002:a17:907:96a5:b0:973:d7cd:44ac with SMTP id hd37-20020a17090796a500b00973d7cd44acmr8178826ejc.54.1686151305694;
        Wed, 07 Jun 2023 08:21:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ggVe7wDE5SOQqDg+vq57il5KB0EjAQDxZT8QD29c6P56wPDpWnjzO86HAqhF3eNRy/maJKA==
X-Received: by 2002:a17:907:96a5:b0:973:d7cd:44ac with SMTP id hd37-20020a17090796a500b00973d7cd44acmr8178808ejc.54.1686151305491;
        Wed, 07 Jun 2023 08:21:45 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:45 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] ceph/file: allow idmapped atomic_open inode op
Date:   Wed,  7 Jun 2023 17:20:37 +0200
Message-Id: <20230607152038.469739-14-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_atomic_open() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
[ adapted to 5fadbd9929 ("ceph: rely on vfs for setgid stripping") ]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f4d8bf7dec88..f00bfda4b1d2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -654,7 +654,9 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	in.truncate_seq = cpu_to_le32(1);
 	in.truncate_size = cpu_to_le64(-1ULL);
 	in.xattr_version = cpu_to_le64(1);
-	in.uid = cpu_to_le32(from_kuid(&init_user_ns, current_fsuid()));
+	in.uid = cpu_to_le32(from_kuid(&init_user_ns,
+				       mapped_fsuid(req->r_mnt_idmap,
+						    &init_user_ns)));
 	if (dir->i_mode & S_ISGID) {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, dir->i_gid));
 
@@ -662,7 +664,9 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else {
-		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
+		in.gid = cpu_to_le32(from_kgid(&init_user_ns,
+				     mapped_fsgid(req->r_mnt_idmap,
+						  &init_user_ns)));
 	}
 	in.mode = cpu_to_le32((u32)mode);
 
@@ -731,6 +735,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -786,6 +791,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		mask |= CEPH_CAP_XATTR_SHARED;
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
+	req->r_mnt_idmap = idmap;
 	ihold(dir);
 
 	if (flags & O_CREAT) {
-- 
2.34.1

