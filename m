Return-Path: <linux-fsdevel+bounces-1014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42CE7D4E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23011C20BAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CED26284;
	Tue, 24 Oct 2023 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQaHMRlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A367498
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 11:01:17 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEF123;
	Tue, 24 Oct 2023 04:01:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d9effe314so2999377f8f.3;
        Tue, 24 Oct 2023 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698145274; x=1698750074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Hy9mjKVZEp592T+CI4HCA7TuFfPuvSuvsA6aj3cwg=;
        b=jQaHMRlf+a2eRckLdvetdSv1C/2tA+o/brpu6mLUnwCNjKRaCjaOj2YXOfiwR/f2uG
         soJK5q5DXU9+gUgRHgr53CFVLJEX9ZN/ZQ0a1rtAMD6ldULG1ymdz4RKADQVj5Pzwcy5
         b9VPDx18EjEpZXRbntbtho6iv5QWa4XLl4ELDY4j7jPumxmzXhUP83WJ84SwJ4RQUIRi
         OiSYMcyKbtjM3tfD2Z+UfNY0sjOdJ74eYT5KKSMKQ4aGwH3R9l47o40lYzLmpg5o3vNN
         DSkg0MCFvNVLTBQ17cFwJA7P72vfezyVkmSfkqrhUw/iSsuJ6AVRAd/Up0sUIIqL/62X
         E/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145274; x=1698750074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/Hy9mjKVZEp592T+CI4HCA7TuFfPuvSuvsA6aj3cwg=;
        b=lA2QRHKtrZIUO7iuJZNnD7ZNw6wM1V+eDVs1FfPz16Jp1nnpPoBYFysFibIAMKAOSs
         ckaRI6Xo5fgnKyxclPWtDWsoeJY2wHZgfuhTNqt8l6eFczdXR8axr595Gqvldl+vnFZL
         GFU7vO1vmYoC3NguWo2AMtgpDGiWMzIZmYKiQgz+Ae6ZlA9kT8Ks6WeHlU3Sx0k2u28m
         rT779GWhxqH3yLNYJWdlSddXhM/Va6fvYPJOsC5FBwT+h7MTVo6KmcIHK1K2kRcrV6rh
         5FypbBd2MU/5+U6F73om49KPfc47RNRRlp0Usbv09AJgEe7RhOodAXWDg4/d7Qq56IZk
         t34g==
X-Gm-Message-State: AOJu0YzmKRBOcbmvcYo9PvfwxaNO74qW82XxWbeYNQ1eYd5ntPW9Qctf
	N8PP3Uvm2MUNT0gXDA/PYyM=
X-Google-Smtp-Source: AGHT+IEU1jutgb9sVKgdnyuesST+oIr997jElQQEBnEoqERofOMlH9lBASsXRPh6FHq5zA9+MkhWyg==
X-Received: by 2002:a05:6000:b41:b0:32d:8f4c:a70b with SMTP id dk1-20020a0560000b4100b0032d8f4ca70bmr9844603wrb.9.1698145274217;
        Tue, 24 Oct 2023 04:01:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b0040775501256sm11707312wmq.16.2023.10.24.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:01:13 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: derive f_fsid from server's fsid
Date: Tue, 24 Oct 2023 14:01:09 +0300
Message-Id: <20231024110109.3007794-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold the server's 128bit fsid to report f_fsid in statfs(2).
This is similar to how uuid is folded for f_fsid of ext2/ext4/zonefs.

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

I realize that the value of watching local changes without getting
notifications on remote changes is questionable, but still, we want
fanotify to be on-par with inotify in that regard.

Remote notification via fanotify has been requested in the past for fuse
and for smb3. If we ever implement those, they will most likely require
a new opt-in flag to fanotify.

I think that exporting a digest of the server's fsid via statfs(2) on the
client mounts is useful regardless of fanotify, so please consider this
change to NFS client.

Thanks,
Amir.

 fs/nfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..d0f41f53b795 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -295,6 +295,7 @@ int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = res.afiles;
 
 	buf->f_namelen = server->namelen;
+	buf->f_fsid = u64_to_fsid(server->fsid.major ^ server->fsid.minor);
 
 	return 0;
 
-- 
2.34.1


