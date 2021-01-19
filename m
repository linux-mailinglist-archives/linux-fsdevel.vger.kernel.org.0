Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2982FBC52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbhASQXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 11:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731481AbhASQXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0d34g0cQgU3pUUMcwk4mh+TGyc8uh3BJ8u4e70DhUc=;
        b=IUYlsU1V9oJTjDGvC27Kw/THljz9Yef6xx1nT/7VC5goYHf3wv+gHnPTZNCA/8qAGa0tPA
        376Ge2xyyabGiOE2c/UrhFdY7dR81WINtlM+kQy7TNOX4ITLgPsVKB5OKAYc08cTyz6WN/
        9XkJrkFFlinn8RrzUveFok2qE/SmUK0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-JnS1LNJGM8WDRnXz7on3mA-1; Tue, 19 Jan 2021 11:22:11 -0500
X-MC-Unique: JnS1LNJGM8WDRnXz7on3mA-1
Received: by mail-ed1-f69.google.com with SMTP id 32so7511874edy.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 08:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0d34g0cQgU3pUUMcwk4mh+TGyc8uh3BJ8u4e70DhUc=;
        b=NtOY/LbcyTQ25eN19gcJqf3+MJ3Hv7cuA2CoHY0EWBrR47SPgGJn57pJPWPrmdJp4D
         Yrb4bmFmoCbKgRbtjkS3cIhXd+PUaFIjo1VF/5MsMQrFm6mWP5xTUCVGa/5+amW8Rvu8
         vP7LJSRpHWjVqMbkpzGH2ScJnB8Xe5k4vWXAR37k9GiHFDxXpUN0IRfshdy8NtMbE7t/
         V/ddQ+QIGbKpNvcjQ1nBeAyl5FzSVuniB6tNDg+l6Q1t72aGqkyxnpuabNlgMzpBhkQF
         TNsLE216dw6/+x08d49qkZ+H4pAdH3igEi8ARO1kX5KEVFvZbQKLCteB5TUvsv0YTQJm
         FcSg==
X-Gm-Message-State: AOAM533vSS6T62cJU4CeRN5t4eQIyN4b9cBlf77rGnHd/vwmntD6GEUJ
        NtIwLj6ywdhR1O3uXMaUHExgwTbslc5KphfUA34WLryWk9tnFEWMyPXnoVRol4cQyCSlt6Y6rlm
        L5xDbM4VBcdhPCSN8xRhVu6HXgQ==
X-Received: by 2002:a17:906:f18c:: with SMTP id gs12mr3548355ejb.422.1611073329719;
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywCQ8WKQ39LO/s3JpVfU0aRZ0r35Z4MSS7hLGLYpfP7iPEPDe7nnjVqIqyXKcESLiLAw5Qaw==
X-Received: by 2002:a17:906:f18c:: with SMTP id gs12mr3548339ejb.422.1611073329537;
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
Date:   Tue, 19 Jan 2021 17:22:03 +0100
Message-Id: <20210119162204.2081137-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119162204.2081137-1-mszeredi@redhat.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
vfs_setxattr()") the translation of nscap->rootid did not take stacked
filesystems (overlayfs and ecryptfs) into account.

That patch fixed the overlay case, but made the ecryptfs case worse.

Restore old the behavior for ecryptfs that existed before the overlayfs
fix.  This does not fix ecryptfs's handling of complex user namespace
setups, but it does make sure existing setups don't regress.

Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Tyler Hicks <code@tyhicks.com>
Fixes: 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into vfs_setxattr()")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/ecryptfs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..58d0f7187997 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1016,15 +1016,19 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct inode *lower_inode;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	if (!(d_inode(lower_dentry)->i_opflags & IOP_XATTR)) {
+	lower_inode = d_inode(lower_dentry);
+	if (!(lower_inode->i_opflags & IOP_XATTR)) {
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
+	inode_lock(lower_inode);
+	rc = __vfs_setxattr_locked(lower_dentry, name, value, size, flags, NULL);
+	inode_unlock(lower_inode);
 	if (!rc && inode)
-		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
+		fsstack_copy_attr_all(inode, lower_inode);
 out:
 	return rc;
 }
-- 
2.26.2

