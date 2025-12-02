Return-Path: <linux-fsdevel+bounces-70460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453CC9BF22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 810B64E3BA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C208288530;
	Tue,  2 Dec 2025 15:29:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0525A633
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689365; cv=none; b=cQKFjQIfRx98WM9GXvqeHN07FfykD0HDFjYvUGMtbEINGpHWFgimicwRwCTyJ9bMov30+Y7395dQGpauzFUMMn3HSovcFFpp7MypHNAV4Kt+kxT9vgRJDikWI2NhpJVcmWvNeEaG4Xm0c3NWOHN7HC82rPDtLpZEoFioo5gCKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689365; c=relaxed/simple;
	bh=FIYqGpM1IyGqClwriylZkCgR358j3T2vsImf6FPQdBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uu7bzjjFSHpeODQ4vpXFIJtU8Oi9wMq2cWoBf5DUloyXUxIKm1IFjVJB2zUbGkzYmNKV1g8nailAv9vXwGS3fAK925XF77XRvg6j+HMt3GJms5eoGItpGHBeB6SuDsqseMCiw1T3RDOm/Eqr2RhDVsjKgt+HsC1he/ZaFtv92KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6d13986f8so4048752a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689362; x=1765294162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A6kRcsSTxQVe89CZtHebxpViGYsgG9Ml2myNrOME/Lo=;
        b=OIa4ICu9BxifeYGZsIR2ThIGp1901SL8U8SsnDXQO1BlVuqK41htDaipQC1KHcjsv8
         fWLHME2EhqjF+dokI5SMAMY3t8KLnmF6Pt2FMQvzrXS6D/jX2HkiUJ3CojS+I2YdmutJ
         2+1y9U8e0oLCCRkqJ69nHPio4UKM3w1yLD4FMqDuqxaVIP2RfBv05WdpzMccXONvjve9
         J5Gn91ut2bLdWGIT9rhY9Jw1IlkYKAJ9ZO27qG0qsqKOpsv2uyWoW0gFn0wcl1MMjyq/
         l5HZLxzNLSnBGfAjQ2XLKLAXAL5cdGyumWEmk6WDSUy67eZQtfb63Vk1DCm/OnHMo93b
         rNKg==
X-Forwarded-Encrypted: i=1; AJvYcCVvbTwgImUrBCqcX0IRTAdZ0zEnE6z6llDNBxYMJ0Z8BtItN3bGVlJm07ehofmgpZh+rVkCLKiWCZ/8I7Mb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5j3/YKePfmRFqn9Wf9P1pl/pZlY1fkFASGFH9fcUb309jwzT
	T+QqwthOsjMPesw2vka2jPK5+9UMcbgKrD9yAMD3a77a6ZzkW/4/e1xl
X-Gm-Gg: ASbGncvpwhYzspOomkbl3w4t8Fd2ZFZmLYEUf0JNXhdkrVMFzJZs9LqXcOmd+CvNoMP
	CpbYMQY7yX55QjkvtVuiMCmQ6T8b7xDlb0BMfo/2Oxg0fTU5CqDKY9vXQ2HHCuu827fVjTmb/F6
	gY9RouPIMMF4MwdHI+jPaJP3bAjeSEVtvl8iaGHZrva76uDMLCxJ4OrVELEaGdIF3wWTI+hsF30
	iLOFj4jagANdjuZmOVizgRflTxkvK/Apz/JdbLZAX9jOR+hjSAOXUP3apgSkSflBrxO6rXBzCds
	BOOF8b1p8bh7xm/Si5M3aoBinWrVSaUZ0Fn78weH2RFUN4xb3mmGkmkj9HUY9brDbtfT82CXl0/
	73lU9vURTqcegZipRISu+M3PgBtRLa+35sF3y5+X9R8IV40Q1sc85hi5e7LQkfv7TKewPNx5ks1
	owCQVKG3E09i/o4g==
X-Google-Smtp-Source: AGHT+IFx57reYompYCqN3lfJy/5+1CqSdFB86fexumX1BX8BCuA0OEnC2uBr5WnT+XMeBOsfVkmfcw==
X-Received: by 2002:a05:6830:270d:b0:785:6792:4b3 with SMTP id 46e09a7af769-7c9406dc93amr1942186a34.10.1764689362374;
        Tue, 02 Dec 2025 07:29:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm4299080eaf.9.2025.12.02.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:29:21 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Dec 2025 07:29:01 -0800
Subject: [PATCH RFC 1/2] configfs: add kernel-space item registration API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-configfs_netcon-v1-1-b4738ead8ee8@debian.org>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
In-Reply-To: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, 
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, 
 calvin@wbinvd.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783; i=leitao@debian.org;
 h=from:subject:message-id; bh=FIYqGpM1IyGqClwriylZkCgR358j3T2vsImf6FPQdBA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpLwXQ6xc3qGvZPhOLjly3a7HHfPBIXQpUMV4A+
 /no/PNlsDCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaS8F0AAKCRA1o5Of/Hh3
 bWL3D/4oiGW5RJtPOPyG2heY+nT1odkK8dnPj8xUzIc6BovFbB2WI6FBoRXaoL+UM5LJzLSojth
 C0zVZNbr5uz49zIw7tn/WHqgj31P3qbqY98SW3pFXXrTH0joU5d+YJ55e5TQkCLEwR61hZUf0Q2
 mabZzzayBd0EQFJnAV3dXajJ6Zdvs/9vBWZpds/IzVngfHflikZNDXIvhU29xpgTq0zt1oKcCo7
 PLzDld+onH7yM/5/4GoXSQ7wfbYpUL6p7MkMrGNd5D0HavShC5iL4DA9/44xnLu+kf+J5QuIKeN
 yyHINRhmxhXkh9W3Px6DjzKisweAWoYFW7BF5MY7hxzZ8yr1ll5wsnPcDAlvOyZbFVTrbW5zWrb
 SmyfoFeNSpp7Bv5704LHOrgksFHoeJHQJl19xAHceWszyqgzXtggsQajFyFB+cjhD9JwJsU8x2T
 3T5vmsiQiyCF0gWKtyoliv0htkK27FVdlXRVQNG5zXS8Wdbm7G1AvhHYTL0Mizl737iHAiLf8J3
 Iw4C+pE6SLyxW5l7pu1jKGv9ke7i95TmixNnj1To9QWXHheC3mWcVATCa29PHcRKzBRpQcMTQAU
 RdzVEuJDSPRcj5o5lAED8+36HawbkBzEhmyQxORPac47+/X8RTVFpnYOeRJjUrQFJVxkcEW/B8D
 +fMAHSlLn/0Cd6Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add configfs_register_item() and configfs_unregister_item() functions
to allow kernel modules to register configfs items whose lifecycle is
controlled by kernel space rather than userspace.

This is useful for subsystems that need to expose configuration items
that are created based on kernel events (like boot parameters) rather
than explicit userspace mkdir operations. The items registered this
way are marked as default items (CONFIGFS_USET_DEFAULT) and cannot be
removed via rmdir.

The API follows the same pattern as configfs_register_group() but for
individual items:
- configfs_register_item() links the item into the parent group's
  hierarchy and creates the filesystem representation
- configfs_unregister_item() reverses the registration, removing the
  item from configfs

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/configfs/dir.c        | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/configfs.h |   4 +++
 2 files changed, 138 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 81f4f06bc87e..f7224bc51826 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1866,6 +1866,140 @@ void configfs_unregister_default_group(struct config_group *group)
 }
 EXPORT_SYMBOL(configfs_unregister_default_group);
 
+/**
+ * configfs_register_item() - registers a kernel-created item with a parent group
+ * @parent_group: parent group for the new item
+ * @item: item to be registered
+ *
+ * This function allows kernel code to register configfs items whose lifecycle
+ * is controlled by kernel space rather than userspace (via mkdir/rmdir).
+ * The item must be already initialized with config_item_init_type_name().
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int configfs_register_item(struct config_group *parent_group,
+			   struct config_item *item)
+{
+	struct configfs_subsystem *subsys = parent_group->cg_subsys;
+	struct configfs_fragment *frag;
+	struct dentry *parent, *child;
+	struct configfs_dirent *sd;
+	int ret;
+
+	if (!subsys || !item->ci_name)
+		return -EINVAL;
+
+	frag = new_fragment();
+	if (!frag)
+		return -ENOMEM;
+
+	parent = parent_group->cg_item.ci_dentry;
+	/* Allocate dentry for the item */
+	child = d_alloc_name(parent, item->ci_name);
+	if (!child) {
+		put_fragment(frag);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&subsys->su_mutex);
+	link_obj(&parent_group->cg_item, item);
+	mutex_unlock(&subsys->su_mutex);
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	d_add(child, NULL);
+
+	/* Attach the item to the filesystem */
+	ret = configfs_attach_item(&parent_group->cg_item, item, child, frag);
+	if (ret)
+		goto err_out;
+
+	/*
+	 * CONFIGFS_USET_DEFAULT mark item as kernel-created (cannot be removed
+	 * by userspace)
+	 */
+	sd = child->d_fsdata;
+	sd->s_type |= CONFIGFS_USET_DEFAULT;
+
+	/* Mark directory as ready */
+	spin_lock(&configfs_dirent_lock);
+	configfs_dir_set_ready(child->d_fsdata);
+	spin_unlock(&configfs_dirent_lock);
+
+	inode_unlock(d_inode(parent));
+	put_fragment(frag);
+	return 0;
+
+err_out:
+	d_drop(child);
+	dput(child);
+	inode_unlock(d_inode(parent));
+	mutex_lock(&subsys->su_mutex);
+	unlink_obj(item);
+	mutex_unlock(&subsys->su_mutex);
+	put_fragment(frag);
+	return ret;
+}
+EXPORT_SYMBOL(configfs_register_item);
+
+/**
+ * configfs_unregister_item() - unregisters a kernel-created item
+ * @item: item to be unregistered
+ *
+ * This function reverses the effect of configfs_register_item(), removing
+ * the item from the configfs filesystem and releasing associated resources.
+ * The item must have been previously registered with configfs_register_item().
+ */
+void configfs_unregister_item(struct config_item *item)
+{
+	struct config_group *group = item->ci_group;
+	struct dentry *dentry = item->ci_dentry;
+	struct configfs_subsystem *subsys;
+	struct configfs_fragment *frag;
+	struct configfs_dirent *sd;
+	struct dentry *parent;
+
+	if (!group || !dentry)
+		return;
+
+	subsys = group->cg_subsys;
+	if (!subsys)
+		return;
+
+	parent = item->ci_parent->ci_dentry;
+	sd = dentry->d_fsdata;
+	frag = get_fragment(sd->s_frag);
+
+	if (WARN_ON(!(sd->s_type & CONFIGFS_USET_DEFAULT))) {
+		put_fragment(frag);
+		return;
+	}
+
+	/* Mark fragment as dead */
+	down_write(&frag->frag_sem);
+	frag->frag_dead = true;
+	up_write(&frag->frag_sem);
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+	spin_lock(&configfs_dirent_lock);
+	configfs_detach_prep(dentry, NULL);
+	spin_unlock(&configfs_dirent_lock);
+
+	configfs_detach_item(item);
+	d_inode(dentry)->i_flags |= S_DEAD;
+	dont_mount(dentry);
+	d_drop(dentry);
+	fsnotify_rmdir(d_inode(parent), dentry);
+	dput(dentry);
+	inode_unlock(d_inode(parent));
+
+	mutex_lock(&subsys->su_mutex);
+	unlink_obj(item);
+	mutex_unlock(&subsys->su_mutex);
+
+	put_fragment(frag);
+}
+EXPORT_SYMBOL(configfs_unregister_item);
+
 int configfs_register_subsystem(struct configfs_subsystem *subsys)
 {
 	int err;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 698520b1bfdb..70f2d113b4b3 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -244,6 +244,10 @@ int configfs_register_group(struct config_group *parent_group,
 			    struct config_group *group);
 void configfs_unregister_group(struct config_group *group);
 
+int configfs_register_item(struct config_group *parent_group,
+			   struct config_item *item);
+void configfs_unregister_item(struct config_item *item);
+
 void configfs_remove_default_groups(struct config_group *group);
 
 struct config_group *

-- 
2.47.3


