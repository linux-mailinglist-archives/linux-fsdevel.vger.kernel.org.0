Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06081387F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEDJqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 05:46:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34028 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 05:46:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so486961wrq.1;
        Sat, 04 May 2019 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dWGTITu5wxnYjjoHPdi7zsyNX8nWTtFOtirCihYMDeE=;
        b=BfUxKTXJd+ktJJukzWH/6i8sRmbii+ve0TFEuFSZZaom+Op4r7+gOZazMRBLs/nubC
         oeZF49GjnX9E+SZmB8S8Iq34XYGRVTdYWjrp+svtt4clkuYDAZXpon9PvgKfcPWZIEfz
         Dmk1+ItN27xHG4OilN1a8MMYr2W8CEu8DJc0eCABPTzfxUjJ7cVKQwVzi/DbLlrnNvtx
         UJ+ohBWuPk2vdryoih78FU1Cq+EOzDmew97s4zN4sI2R5HI7NlEvNcf7VSTyxoQp3L1n
         UmI5DE0adxfo5knR2fVKnL1+Qmdx/6sHJexVF9Ik08OWMy1ioxTb6tpoMrLHcB+LZvHy
         eFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWGTITu5wxnYjjoHPdi7zsyNX8nWTtFOtirCihYMDeE=;
        b=BtynRUPuBR4biuKqzDD5uUlHfB1M/gurm6xsifOgbiEfW0ErXjZAYtV6/VD+1jkDUn
         0lgU7GJRybAH77N0YtFZB9m6UX+oUHR3pBZEZo/DHpmr8mSIe+AIXA/6d+XAj3s5ajU9
         qnuvZUHhVghsVq2C+LRgsgvMc8FmbwZHg1ZC2WLhidvTLhUDSidRAaknZ32Sk3o5rV5w
         dcYjSEiDhZkQcYqaKAuknBsigQtp8g0VexyNxLCqcRR3wD69Uee28jq/iWdVv40gne/R
         DPxxT2m9He5MTxlowTv5ssE2i3wuqGRXUaygWkJD8wbOBp1PXaj9SHOro6ndjdfdgXPh
         Ix0A==
X-Gm-Message-State: APjAAAXDIrDQg0YhcEPlNFQktiz57Kcd81UN75NjtRmAKPvSFpblq9y2
        4O0cl7vJjg6cyx2hbzzRuUE=
X-Google-Smtp-Source: APXvYqxpEazTLMO3DvrY/AnT+veyBP73bp1DhBodLjoFmgTrPn3JVq6MbcUiGlY1CNtaAYaTXTUkag==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr11170977wrx.106.1556963164535;
        Sat, 04 May 2019 02:46:04 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-179-250-108.red.bezeqint.net. [79.179.250.108])
        by smtp.gmail.com with ESMTPSA id o6sm7624806wre.60.2019.05.04.02.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 02:46:03 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Use list.h instead of file_system_type next
Date:   Sat,  4 May 2019 05:45:48 -0400
Message-Id: <20190504094549.10021-2-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504094549.10021-1-carmeli.tamir@gmail.com>
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tamir <carmeli.tamir@gmail.com>

Changed file_system_type next field to list_head and refactored
the code to use list.h functions.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/filesystems.c   | 68 ++++++++++++++++++++++++----------------------
 include/linux/fs.h |  2 +-
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9135646e41ac..f12b98f2f079 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -31,7 +31,7 @@
  *	Once the reference is obtained we can drop the spinlock.
  */
 
-static struct file_system_type *file_systems;
+static LIST_HEAD(file_systems);
 static DEFINE_RWLOCK(file_systems_lock);
 
 /* WARNING: This can be used only if we _already_ own a reference */
@@ -46,14 +46,16 @@ void put_filesystem(struct file_system_type *fs)
 	module_put(fs->owner);
 }
 
-static struct file_system_type **find_filesystem(const char *name, unsigned len)
+static struct file_system_type *find_filesystem(const char *name, unsigned len)
 {
-	struct file_system_type **p;
-	for (p = &file_systems; *p; p = &(*p)->next)
-		if (strncmp((*p)->name, name, len) == 0 &&
-		    !(*p)->name[len])
-			break;
-	return p;
+	struct file_system_type *p;
+
+	list_for_each_entry(p, &file_systems, fs_types) {
+		if (strncmp(p->name, name, len) == 0 &&
+		    !p->name[len])
+			return p;
+	}
+	return NULL;
 }
 
 /**
@@ -72,20 +74,21 @@ static struct file_system_type **find_filesystem(const char *name, unsigned len)
 int register_filesystem(struct file_system_type * fs)
 {
 	int res = 0;
-	struct file_system_type ** p;
+	struct file_system_type *p;
 
 	if (fs->parameters && !fs_validate_description(fs->parameters))
 		return -EINVAL;
 
 	BUG_ON(strchr(fs->name, '.'));
-	if (fs->next)
-		return -EBUSY;
+
+	INIT_LIST_HEAD(&fs->fs_types);
+
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name, strlen(fs->name));
-	if (*p)
+	if (p)
 		res = -EBUSY;
 	else
-		*p = fs;
+		list_add_tail(&fs->fs_types, &file_systems);
 	write_unlock(&file_systems_lock);
 	return res;
 }
@@ -106,19 +109,16 @@ EXPORT_SYMBOL(register_filesystem);
  
 int unregister_filesystem(struct file_system_type * fs)
 {
-	struct file_system_type ** tmp;
+	struct file_system_type *tmp;
 
 	write_lock(&file_systems_lock);
-	tmp = &file_systems;
-	while (*tmp) {
-		if (fs == *tmp) {
-			*tmp = fs->next;
-			fs->next = NULL;
+	list_for_each_entry(tmp, &file_systems, fs_types) {
+		if (fs == tmp) {
+			list_del(&tmp->fs_types);
 			write_unlock(&file_systems_lock);
 			synchronize_rcu();
 			return 0;
 		}
-		tmp = &(*tmp)->next;
 	}
 	write_unlock(&file_systems_lock);
 
@@ -141,7 +141,8 @@ static int fs_index(const char __user * __name)
 
 	err = -EINVAL;
 	read_lock(&file_systems_lock);
-	for (tmp=file_systems, index=0 ; tmp ; tmp=tmp->next, index++) {
+	list_for_each_entry(tmp, &file_systems, fs_types) {
+		index++;
 		if (strcmp(tmp->name, name->name) == 0) {
 			err = index;
 			break;
@@ -158,9 +159,11 @@ static int fs_name(unsigned int index, char __user * buf)
 	int len, res;
 
 	read_lock(&file_systems_lock);
-	for (tmp = file_systems; tmp; tmp = tmp->next, index--)
+	list_for_each_entry(tmp, &file_systems, fs_types) {
+		index--;
 		if (index <= 0 && try_module_get(tmp->owner))
 			break;
+	}
 	read_unlock(&file_systems_lock);
 	if (!tmp)
 		return -EINVAL;
@@ -174,12 +177,13 @@ static int fs_name(unsigned int index, char __user * buf)
 
 static int fs_maxindex(void)
 {
-	struct file_system_type * tmp;
-	int index;
+	struct list_head *pos;
+	int index = 0;
 
 	read_lock(&file_systems_lock);
-	for (tmp = file_systems, index = 0 ; tmp ; tmp = tmp->next, index++)
-		;
+	list_for_each(pos, &file_systems) {
+		index++;
+	}
 	read_unlock(&file_systems_lock);
 	return index;
 }
@@ -214,12 +218,12 @@ int __init get_filesystem_list(char *buf)
 	struct file_system_type * tmp;
 
 	read_lock(&file_systems_lock);
-	tmp = file_systems;
-	while (tmp && len < PAGE_SIZE - 80) {
+	list_for_each_entry(tmp, &file_systems, fs_types) {
+		if (len >= PAGE_SIZE - 80)
+			break;
 		len += sprintf(buf+len, "%s\t%s\n",
 			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
 			tmp->name);
-		tmp = tmp->next;
 	}
 	read_unlock(&file_systems_lock);
 	return len;
@@ -231,12 +235,10 @@ static int filesystems_proc_show(struct seq_file *m, void *v)
 	struct file_system_type * tmp;
 
 	read_lock(&file_systems_lock);
-	tmp = file_systems;
-	while (tmp) {
+	list_for_each_entry(tmp, &file_systems, fs_types) {
 		seq_printf(m, "%s\t%s\n",
 			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
 			tmp->name);
-		tmp = tmp->next;
 	}
 	read_unlock(&file_systems_lock);
 	return 0;
@@ -255,7 +257,7 @@ static struct file_system_type *__get_fs_type(const char *name, int len)
 	struct file_system_type *fs;
 
 	read_lock(&file_systems_lock);
-	fs = *(find_filesystem(name, len));
+	fs = find_filesystem(name, len);
 	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
 	read_unlock(&file_systems_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..833ada15bc8a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2182,7 +2182,7 @@ struct file_system_type {
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
-	struct file_system_type * next;
+	struct list_head fs_types; /* All registered file_system_type structs */
 	struct hlist_head fs_supers;
 
 	struct lock_class_key s_lock_key;
-- 
2.19.1

