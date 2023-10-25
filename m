Return-Path: <linux-fsdevel+bounces-1132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601157D617C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 08:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6923FB211DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 06:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9EF156D1;
	Wed, 25 Oct 2023 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmCrEewM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134E15485
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 06:11:25 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E2A6;
	Tue, 24 Oct 2023 23:11:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c59a4dcdacso16035621fa.1;
        Tue, 24 Oct 2023 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698214282; x=1698819082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjREnK1xDi9U0NJUrdaQZ7C6GoivK/F80JCHW1qci0s=;
        b=DmCrEewMY9MuAujOQU96YsLMPmhvng+gsymauH0S4IeIUf17RrlDv9UsCc3f+gYJWD
         HAxNICHS22ec39uzrc6U5/ggZF65YrUcLK077dQd41qVlMbZbywkdJthpTHv5ai8zSH9
         2wxMmXxd1ys5KBzfD3ZZHZ5xA9ZHN5mpL5pmmaZdeST7D1gn3GV1XrKjP8uAxDNBAI31
         4wOlTsGKfF9bcJ741QB2dLfyCcqHSa4qtlnt3W2le5Qak/nEfZc4X4NFNFPJX/DwM2gA
         A6pB8WgJioPwL+yubDUTenbmM+xhUGcybmMU1qzAuOJtzZY/Zngmi8KmdU2TA2lAHEIP
         JvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698214282; x=1698819082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjREnK1xDi9U0NJUrdaQZ7C6GoivK/F80JCHW1qci0s=;
        b=w9EoquK/TrA7bSKXU0CBTIsnro+HzHtH74sq60yKCu9eefx60YyYCIr2kaDggkqniL
         TxGb12UurCjSCr7B6Hy3yoHyM9rrGXYKn6HLRPquOglqqmGO442uc7tXRxh4EyUIuYIH
         Sr82g+1tNKfSqnDatdjL+FWthy30l1ksnV7jQZDHckU0Tet2DB31AYJj0I7XUxSTqa4+
         qHT4THzj98Xa3dCbBHC8c+vVaTOjYv80xh9kTN9hVxxr8mpGiK+bO7i7YVMCxWC+VfeH
         BxP8lI7vYt9j3v6mQvT+TlAzDEVc8uVL8+hLlxUP5XEMojPSQLN3Q2aT2Gf6rKeQT7DC
         P4TQ==
X-Gm-Message-State: AOJu0YxNlwy1CT9OniM3Z8vLSAoeaznZg1orGWnDCSTYsqFckbsXevVQ
	r1VhQjw8y60xcarUW39+9fA=
X-Google-Smtp-Source: AGHT+IH9OwCRFt1pqzmRWheSzpG/QU4mVEMac9+bClSl1skqD+sciZ6amKAQf/982cz0Ffk+uQUAiA==
X-Received: by 2002:a2e:8899:0:b0:2bc:c650:81b with SMTP id k25-20020a2e8899000000b002bcc650081bmr9828416lji.15.1698214281551;
        Tue, 24 Oct 2023 23:11:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c471300b00405959bbf4fsm13851112wmo.19.2023.10.24.23.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:11:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs: derive f_fsid from s_dev and server's fsid
Date: Wed, 25 Oct 2023 09:11:17 +0300
Message-Id: <20231025061117.3068417-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use s_dev number and the server's fsid to report f_fsid in statfs(2).

The server's fsid could be zero for NFSv4 root export and is not unique
across different servers, so we use the s_dev number to avoid local
f_fsid collisions.

The s_dev number could be easily recycled, so we use a 32bit hash of the
server's fsid to try to avoid the recycling of same local f_fsid for
different remote fs.  The anon bdev number is only 20 bits (major is 0),
so we could use more bits for the server's fsid hash, but avoiding f_fsid
recycling is not critical, so 32bit hash is enough.

This allows nfs client to be monitored by fanotify filesystem watch
for local client access if nfs supports re-export.

For example, with inotify-tools 4.23.8.0, the following command can be
used to watch local client access over entire nfs filesystem:

  fsnotifywatch --filesystem /mnt/nfs

Note that fanotify filesystem watch does not report remote changes on
server.  It provides the same notifications as inotify, but it watches
over the entire filesystem and reports file handle of objects and fsid
with events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Anna, Trond,

I have changed v2 according to feedback from Ben.

I would like to refer you to the documentation of f_fsid in statfs(2):

"Nobody knows what f_fsid is supposed to contain...
 The general idea is that f_fsid contains some random stuff such that the
 pair (f_fsid,ino) uniquely determines a file.  Some operating systems use
 (a variation on) the device number, or the device number combined with the
 filesystem type..."

This definition leaves a lot of room for interpretations.
I chose f_fsid format {dev_num, fsid_hash}, because I think that it nicely
extends f_fsid format {dev_num, 0}, used by many fs without persistent fsid.

Thanks,
Amir.

Changes since v1:
- Use d_sev number to avoid collisions (bcodding)

 fs/nfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..30bcd53da3bc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -295,6 +295,15 @@ int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = res.afiles;
 
 	buf->f_namelen = server->namelen;
+	/*
+	 * Using the anon bdev number to avoid local f_fsid collisions.
+	 * Server's fsid could be zero for NFSv4 root export and is not unique
+	 * across different servers, but we use it as best effort to try to
+	 * avoid the recycling of same local f_fsid for different remote fs.
+	 */
+	buf->f_fsid.val[0] = new_encode_dev(server->s_dev);
+	buf->f_fsid.val[1] = hash_64(server->fsid.major, 32) ^
+			     hash_64(server->fsid.minor, 32);
 
 	return 0;
 
-- 
2.34.1


