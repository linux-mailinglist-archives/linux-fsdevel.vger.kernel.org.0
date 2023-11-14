Return-Path: <linux-fsdevel+bounces-2825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C256D7EB3BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D731C20AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D124176D;
	Tue, 14 Nov 2023 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slpy++IM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769A4175D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10E131
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40a4d04af5cso24044445e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976007; x=1700580807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cTybT1DEdzk/cSRklxmUP0QlkFSlsXsUZjl8wvTj3U=;
        b=Slpy++IM1WwajGXPihGWx/xpkPKd8hPdEMnRQXK5s6clWWe4sJDMkj3aGhWz0L3YjD
         FcsZ5FRQbFSa5/uh9n4r/rilse5wlIxRgrn32wlls5ea8hXkjevhr7NS04nQD1rELXDj
         he0jkLctOyDK/zJua3kV7P9jnR/iImBQmtQmgXXLc+Ba2KLHnX/qqajCD9ceqTZ4JNao
         gRzJ4a4bdGzV/0HeE19wPjl9GIn42356eqdI9ZoVGuYCA66b3tPdT7tHsXrwB5LGCes2
         ViD/mYVj3i6kUOE9uY+YZzPHoAZp6nBuHe3fdLnkUDhs/bsfEAl5R8IK9Av0A6FazdaM
         nbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976007; x=1700580807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cTybT1DEdzk/cSRklxmUP0QlkFSlsXsUZjl8wvTj3U=;
        b=BWP7m4YYnNdylYlAdBSSLzP37/wS3sdBCug2GGmpsYXwDNgsN46BGEpetL8ZFytEY7
         0vl7TFwtZcOhEzeMVW0Z4WE0xxw/eqFwHAPB+Qlhtcf/UpIWlq301fmLyg72suEFYfoP
         nR7LC2IIOhiGxmWCzOQzPgVX77zdNq5rg/n4W4nHImq71mf3DtFYXbdZolKsrn5TfVv9
         HU6kD0pIvp7OWXCmSGsAgF5hEezqvRg1bVIoPyLEe2mbIa0rZ6iQuGQ+blO+qb0AlSOJ
         44KCyXB4f6ZNRf0NymqywBN9wZU4jAXcIRFvC95RPvhFMWtmosIb9+dE0BKSeoL3pLRY
         9IBg==
X-Gm-Message-State: AOJu0YxK2MolzpY4tg7yYmPJakV9Bhpuwk74k0hzif5ZprN392yYHvFH
	0e2kdwsTTXQm4ePiEPs3KR0=
X-Google-Smtp-Source: AGHT+IGPABLzMxLMS9Exibhsw9zyLPw8pVeIzVo3mijJROMolgs0+qPzuf4CMAk4UGGU4spATpLgFQ==
X-Received: by 2002:a05:600c:6019:b0:405:4daa:6e3d with SMTP id az25-20020a05600c601900b004054daa6e3dmr8743387wmb.39.1699976006735;
        Tue, 14 Nov 2023 07:33:26 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:26 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/15] ovl: add permission hooks outside of do_splice_direct()
Date: Tue, 14 Nov 2023 17:33:07 +0200
Message-Id: <20231114153321.1716028-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114153321.1716028-1-amir73il@gmail.com>
References: <20231114153321.1716028-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main callers of do_splice_direct() also call rw_verify_area() for
the entire range that is being copied, e.g. by vfs_copy_file_range()
or do_sendfile() before calling do_splice_direct().

The only caller that does not have those checks for entire range is
ovl_copy_up_file().  In preparation for removing the checks inside
do_splice_direct(), add rw_verify_area() call in ovl_copy_up_file().

For extra safety, perform minimal sanity checks from rw_verify_area()
for non negative offsets also in the copy up do_splice_direct() loop
without calling the file permission hooks.

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..106f8643af3b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -230,6 +230,19 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 	return ovl_real_fileattr_set(new, &newfa);
 }
 
+static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
+{
+	loff_t tmp;
+
+	if (WARN_ON_ONCE(pos != pos2))
+		return -EIO;
+	if (WARN_ON_ONCE(pos < 0 || len < 0 || totlen < 0))
+		return -EIO;
+	if (WARN_ON_ONCE(check_add_overflow(pos, len, &tmp)))
+		return -EIO;
+	return 0;
+}
+
 static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			    struct file *new_file, loff_t len)
 {
@@ -244,13 +257,20 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 	int error = 0;
 
 	ovl_path_lowerdata(dentry, &datapath);
-	if (WARN_ON(datapath.dentry == NULL))
+	if (WARN_ON_ONCE(datapath.dentry == NULL) ||
+	    WARN_ON_ONCE(len < 0))
 		return -EIO;
 
 	old_file = ovl_path_open(&datapath, O_LARGEFILE | O_RDONLY);
 	if (IS_ERR(old_file))
 		return PTR_ERR(old_file);
 
+	error = rw_verify_area(READ, old_file, &old_pos, len);
+	if (!error)
+		error = rw_verify_area(WRITE, new_file, &new_pos, len);
+	if (error)
+		goto out_fput;
+
 	/* Try to use clone_file_range to clone up within the same fs */
 	ovl_start_write(dentry);
 	cloned = do_clone_file_range(old_file, 0, new_file, 0, len, 0);
@@ -309,6 +329,10 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 			}
 		}
 
+		error = ovl_verify_area(old_pos, new_pos, this_len, len);
+		if (error)
+			break;
+
 		ovl_start_write(dentry);
 		bytes = do_splice_direct(old_file, &old_pos,
 					 new_file, &new_pos,
-- 
2.34.1


