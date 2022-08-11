Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0158F717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 06:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiHKE6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 00:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKE6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:58:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1277CB55
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:58:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t1so24079803lft.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc;
        bh=Hc0ya6Q6mxxl473/hqgf6o1eqWqtGbL+bsi+QEQEisE=;
        b=8LI5JuCeUxK2U5iYkCnTp2crgETBibqJsYC+ekLQr6/TxIoIqzfGIbAah8jN9wHRDA
         L6mwtiJ31cIQcy5QWfH8JWRcQpzS6+vNjyRA+WAMdXZIkn3BdWGAGJ4zYNUipNWfwhpm
         5EEmy8LW7DI4cHnFnEDzXsZPcmlZU17uiYaOi3Svb1JD0E2L8syINA0ZfPZ3q6bJWG+L
         CU5+fIcr5Uxkjjxuy2Sozn54QekpuwOfQcsqcqBE6cBU4CNnAmDJjssqcowZD4LcyqmV
         5nhr9aduYDiAdZX24VLlEpW9050CCqCPP0Gq2Iltj7UsLJ08ekc9U4IKqMY4BsuZnTHV
         qooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hc0ya6Q6mxxl473/hqgf6o1eqWqtGbL+bsi+QEQEisE=;
        b=ZGKgbCT9SP0CGoqiBVqWvPpcuh1dX56NxGWBeMPqCk1lTB8fad65JjUswJ9P1h/+vq
         osl5y0aiBq+aXohLAbwxAuWlCMzXzmZBZbFAGd3920K5aUuKxxPh4cwNKcM+ovOkXu9f
         6fFfWLJ4bHRrzgphAtrx+WRlL12Zt+qx9Y269LwwFbKsPh6n7+aELT97SDhgGTx3fru3
         o0U2UV6I7OSMcQEgfFsIXUAYnuvpbSmbetkMbr17rqR6HDX+kVe9xmvmKY60AxLCbZe8
         UCiwBsRTMXt4o1RoKucxx65v1ITzXdPdZhdBj8gIWOZOJQLfebUWr4cidwmT/ePeynAn
         Kmyw==
X-Gm-Message-State: ACgBeo3pb8u32F62w3mJRRYO5sWg19gvupvSsHakruSGagI7gE3eLYEP
        DFqyc0FC3L2aXxPI4qgJK6l19w==
X-Google-Smtp-Source: AA6agR59aOIhrU6TjbtC66PYK9Yu4MkfYU39LPn1PglG/iS6306D9ZedjOJbH2/WPO/KOceQsdkzNQ==
X-Received: by 2002:a05:6512:48d:b0:48b:1bee:6833 with SMTP id v13-20020a056512048d00b0048b1bee6833mr10066135lfq.389.1660193927658;
        Wed, 10 Aug 2022 21:58:47 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id k22-20020a05651c10b600b0025d620892cdsm634169ljn.107.2022.08.10.21.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 21:58:47 -0700 (PDT)
Message-ID: <8ace5255-ce23-0a05-2d50-1455dd68acb6@openvz.org>
Date:   Thu, 11 Aug 2022 07:58:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [RFC PATCH] kernfs: enable per-inode limits for all xattr types
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org
References: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
Content-Language: en-US
In-Reply-To: <b816f58a-ce25-c079-c6b3-a3406df246f9@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently it's possible to create a huge number of xattr per inode,
and I would like to add USER-like restrcition to all xattr types.

I've prepared RFC patch and would like to discuss it.

This patch moves counters calculations into simple_xattr_set,
under simple_xattrs spinlock. This allows to replace atomic counters
used currently for USER xattr to ints.

To keep current behaviour for USER xattr I keep current limits
and counters and add separated limits and counters for all another
xattr types. However I would like to merge these limits and counters
together, because it simplifies the code even more.
Could someone please clarify if this is acceptable?

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/kernfs/inode.c           | 67 ++-----------------------------------
 fs/kernfs/kernfs-internal.h |  2 --
 fs/xattr.c                  | 56 +++++++++++++++++++------------
 include/linux/kernfs.h      |  2 ++
 include/linux/xattr.h       | 11 ++++--
 mm/shmem.c                  | 29 +++++++---------
 6 files changed, 61 insertions(+), 106 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..7cfdda41fc89 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -47,8 +47,6 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 	kn->iattr->ia_ctime = kn->iattr->ia_atime;
 
 	simple_xattrs_init(&kn->iattr->xattrs);
-	atomic_set(&kn->iattr->nr_user_xattrs, 0);
-	atomic_set(&kn->iattr->user_xattr_size, 0);
 out_unlock:
 	ret = kn->iattr;
 	mutex_unlock(&iattr_mutex);
@@ -314,7 +312,7 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_set(&attrs->xattrs, name, value, size, flags, NULL);
+	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
 }
 
 static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
@@ -339,61 +337,6 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 	return kernfs_xattr_set(kn, name, value, size, flags);
 }
 
-static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
-				     const char *full_name,
-				     struct simple_xattrs *xattrs,
-				     const void *value, size_t size, int flags)
-{
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
-	ssize_t removed_size;
-	int ret;
-
-	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
-		ret = -ENOSPC;
-		goto dec_count_out;
-	}
-
-	if (atomic_add_return(size, sz) > KERNFS_USER_XATTR_SIZE_LIMIT) {
-		ret = -ENOSPC;
-		goto dec_size_out;
-	}
-
-	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
-			       &removed_size);
-
-	if (!ret && removed_size >= 0)
-		size = removed_size;
-	else if (!ret)
-		return 0;
-dec_size_out:
-	atomic_sub(size, sz);
-dec_count_out:
-	atomic_dec(nr);
-	return ret;
-}
-
-static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
-				    const char *full_name,
-				    struct simple_xattrs *xattrs,
-				    const void *value, size_t size, int flags)
-{
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
-	ssize_t removed_size;
-	int ret;
-
-	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
-			       &removed_size);
-
-	if (removed_size >= 0) {
-		atomic_sub(removed_size, sz);
-		atomic_dec(nr);
-	}
-
-	return ret;
-}
-
 static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 				     struct user_namespace *mnt_userns,
 				     struct dentry *unused, struct inode *inode,
@@ -411,13 +354,7 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (!attrs)
 		return -ENOMEM;
 
-	if (value)
-		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
-						 value, size, flags);
-	else
-		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
-						value, size, flags);
-
+	return simple_xattr_set(&attrs->xattrs, full_name, value, size, flags);
 }
 
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c..a2b89bd48c9d 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -27,8 +27,6 @@ struct kernfs_iattrs {
 	struct timespec64	ia_ctime;
 
 	struct simple_xattrs	xattrs;
-	atomic_t		nr_user_xattrs;
-	atomic_t		user_xattr_size;
 };
 
 struct kernfs_root {
diff --git a/fs/xattr.c b/fs/xattr.c
index b4875514a3ee..de4a2efc7fa4 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1037,6 +1037,11 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	return ret;
 }
 
+static bool xattr_is_user(const char *name)
+{
+	return !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+}
+
 /**
  * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
  * @xattrs: target simple_xattr list
@@ -1053,16 +1058,17 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * Returns 0 on success, -errno on failure.
  */
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags,
-		     ssize_t *removed_size)
+		     const void *value, size_t size, int flags)
 {
 	struct simple_xattr *xattr;
 	struct simple_xattr *new_xattr = NULL;
+	bool is_user_xattr = false;
+	int *sz = &xattrs->xattr_size;
+	int *nr = &xattrs->nr_xattrs;
+	int sz_limit = KERNFS_XATTR_SIZE_LIMIT;
+	int nr_limit = KERNFS_MAX_XATTRS;
 	int err = 0;
 
-	if (removed_size)
-		*removed_size = -1;
-
 	/* value == NULL means remove */
 	if (value) {
 		new_xattr = simple_xattr_alloc(value, size);
@@ -1076,6 +1082,14 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		}
 	}
 
+	is_user_xattr = xattr_is_user(name);
+	if (is_user_xattr) {
+		sz = &xattrs->user_xattr_size;
+		nr = &xattrs->nr_user_xattrs;
+		sz_limit = KERNFS_USER_XATTR_SIZE_LIMIT;
+		nr_limit = KERNFS_MAX_USER_XATTRS;
+	}
+
 	spin_lock(&xattrs->lock);
 	list_for_each_entry(xattr, &xattrs->head, list) {
 		if (!strcmp(name, xattr->name)) {
@@ -1083,13 +1097,19 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				xattr = new_xattr;
 				err = -EEXIST;
 			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
-				if (removed_size)
-					*removed_size = xattr->size;
+				int delta = new_xattr->size - xattr->size;
+
+				if (*sz + delta > sz_limit) {
+					xattr = new_xattr;
+					err = -ENOSPC;
+				} else {
+					*sz += delta;
+					list_replace(&xattr->list, &new_xattr->list);
+				}
 			} else {
+				*sz -= xattr->size;
+				(*nr)--;
 				list_del(&xattr->list);
-				if (removed_size)
-					*removed_size = xattr->size;
 			}
 			goto out;
 		}
@@ -1097,7 +1117,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 	if (flags & XATTR_REPLACE) {
 		xattr = new_xattr;
 		err = -ENODATA;
+	} else if ((*sz + new_xattr->size > sz_limit) || (*nr == nr_limit)) {
+		xattr = new_xattr;
+		err = -ENOSPC;
 	} else {
+		*sz += new_xattr->size;
+		(*nr)++;
 		list_add(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
@@ -1172,14 +1197,3 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 
 	return err ? err : size - remaining_size;
 }
-
-/*
- * Adds an extended attribute to the list
- */
-void simple_xattr_list_add(struct simple_xattrs *xattrs,
-			   struct simple_xattr *new_xattr)
-{
-	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
-	spin_unlock(&xattrs->lock);
-}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e2ae15a6225e..1972beb0d7b9 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -44,6 +44,8 @@ enum kernfs_node_type {
 #define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
 #define KERNFS_MAX_USER_XATTRS		128
 #define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
+#define KERNFS_MAX_XATTRS		128
+#define KERNFS_XATTR_SIZE_LIMIT		(128 << 10)
 
 enum kernfs_node_flag {
 	KERNFS_ACTIVATED	= 0x0010,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..c6b9258958d5 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -81,6 +81,10 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
 
 struct simple_xattrs {
 	struct list_head head;
+	int	nr_xattrs;
+	int	nr_user_xattrs;
+	int	xattr_size;
+	int	user_xattr_size;
 	spinlock_t lock;
 };
 
@@ -98,6 +102,10 @@ static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
 {
 	INIT_LIST_HEAD(&xattrs->head);
 	spin_lock_init(&xattrs->lock);
+	xattrs->nr_xattrs = 0;
+	xattrs->nr_user_xattrs = 0;
+	xattrs->xattr_size = 0;
+	xattrs->user_xattr_size = 0;
 }
 
 /*
@@ -117,8 +125,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size);
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags,
-		     ssize_t *removed_size);
+		     const void *value, size_t size, int flags);
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, char *buffer,
 			  size_t size);
 void simple_xattr_list_add(struct simple_xattrs *xattrs,
diff --git a/mm/shmem.c b/mm/shmem.c
index 66eed363e5c2..0215c16a2643 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3155,30 +3155,27 @@ static int shmem_initxattrs(struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	const struct xattr *xattr;
 	struct simple_xattr *new_xattr;
+	char *name;
 	size_t len;
+	int ret = 0;
 
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
-		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
-		if (!new_xattr)
-			return -ENOMEM;
-
 		len = strlen(xattr->name) + 1;
-		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
-					  GFP_KERNEL_ACCOUNT);
-		if (!new_xattr->name) {
-			kvfree(new_xattr);
+		name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len, GFP_KERNEL);
+		if (!name)
 			return -ENOMEM;
-		}
 
-		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
-		       XATTR_SECURITY_PREFIX_LEN);
-		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
-		       xattr->name, len);
+		memcpy(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
+		memcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name, len);
 
-		simple_xattr_list_add(&info->xattrs, new_xattr);
+		ret = simple_xattr_set(&info->xattrs, name, xattr->value,
+				       xattr->value_len, XATTR_CREATE);
+		kfree(name);
+		if (ret)
+			break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int shmem_xattr_handler_get(const struct xattr_handler *handler,
@@ -3200,7 +3197,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
+	return simple_xattr_set(&info->xattrs, name, value, size, flags);
 }
 
 static const struct xattr_handler shmem_security_xattr_handler = {
-- 
2.25.1

