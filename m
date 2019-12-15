Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC511F77A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2019 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfLOLrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 06:47:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36186 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOLrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 06:47:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so3556891wma.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2019 03:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/S9klrQEcVZ4uJellxotXniTbK0PCcIczycW4/qcuRw=;
        b=t5GiBBrie9qIvfc8AkMQegAP2+tvZvoEQHBFjzD5QFdZFWH73zq7qie/w6QvLJMdtD
         GZkED759TmCEuaW4N/NHbJYAmTkhB5dNEJmtdazKgNXHoRjN6jgu9VzeQCctVWC8TgMm
         wi4ij9YqyE1vhfzQqNF7K6uZAZRDvuhTklOc5Ju1H57niiAi506LsvKebin90O60p/aG
         vF0jtppxGdzMSRPP8s2DX2B+fEnA2LMnC7Q5ZqXeEDE6D5A9GlN2p4UTMj7koAzC1OL0
         Q8Vu8D4MhODiF0fPQKMpckjnwW+M3iMemWSNkaJpCJxiRndaQ9wRxpzIAaQN8TlD6ypu
         GO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/S9klrQEcVZ4uJellxotXniTbK0PCcIczycW4/qcuRw=;
        b=Ra07kmlnpdY1OwhCpO9rmbh0E0LSLr+XVWCAs6wYS+93KKBIB0q8ENMwfTMV8P1sT/
         sg+IGZCY+08DJnioz78xrjTiykNsV0Q5MIMlwl6LKVkMmxYxeINt001nHSMo4Uwpx30S
         KLU3NhYUJdsAfmLsvYLnc2BJ1vVWIVb/VHG/0dKNRP4zmHIK8TzhXnHGCIVsZyn1O3Bf
         gAL/Yqwcr+H3MazfXUoYhB5kLHWgrots1fFnpA0klHW0ZsMoGy6r3DA2guUgClW2OoP9
         tVmYzw/oe7uFjCVV9MWEsmxw6wnnGJcwgGjr4zmN6XF39VDSPCEwmSxE2VH4+KtQDQvw
         q+ew==
X-Gm-Message-State: APjAAAWsBYYAKKb8sRZZ3Cp3xplQCKx7LjvCGtY9NnXuc7SlBOK0h+2k
        kWygAjZpClveFTpfPuPU27DaFsA=
X-Google-Smtp-Source: APXvYqwKcGIUD1YwjtXhCfXgw4csZnA42uWD4pfosxZTk4ufawlf/08+WdvPsDfJIdZ4Dn/ukDWyxw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr25594955wmj.90.1576410426605;
        Sun, 15 Dec 2019 03:47:06 -0800 (PST)
Received: from avx2 ([46.53.248.136])
        by smtp.gmail.com with ESMTPSA id s128sm9573228wme.39.2019.12.15.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 03:47:05 -0800 (PST)
Date:   Sun, 15 Dec 2019 14:47:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] ramfs: support O_TMPFILE
Message-ID: <20191215114703.GA4397@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: ramfs: support O_TMPFILE

Link: http://lkml.kernel.org/r/20190206073349.GA15311@avx2
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ramfs/inode.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/ramfs/inode.c~ramfs-support-o_tmpfile
+++ a/fs/ramfs/inode.c
@@ -147,6 +147,17 @@ static int ramfs_symlink(struct inode *
 	return error;
 }
 
+static int ramfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode;
+
+	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
+	if (!inode)
+		return -ENOSPC;
+	d_tmpfile(dentry, inode);
+	return 0;
+}
+
 static const struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
@@ -157,6 +168,7 @@ static const struct inode_operations ram
 	.rmdir		= simple_rmdir,
 	.mknod		= ramfs_mknod,
 	.rename		= simple_rename,
+	.tmpfile	= ramfs_tmpfile,
 };
 
 /*
_
