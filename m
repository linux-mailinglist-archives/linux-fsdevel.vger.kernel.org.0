Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9D66A262D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBYBQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBYBQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:27 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D6012879
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e21so828394oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adZFM1OM/LYAcH6+RB4uxm5KB114qE5sEdsKi5M/0yY=;
        b=xlxY+ORPfu/B/W9RJqrAwE3gdn8pZHNOJefSUx5tvYl9DMijsXnBVccQTyMjXBM9SS
         tStePYnFtkenRAyKk9gBiOeeq8nHSc93RlT3KmydmH5XvvXjruWubRDR2/w8L60TbnoQ
         CR1jhIUPvxVUqVPDKouQ5k8+lICwUASBzjgwPREyWbcmfeqdUPoeaVTe2sWit0XjltiI
         6aB79ygFm4PQea2c3lFpiW6ES1Y8BNkx45L7w3nBJKnnLT/uJsvGZZX+tHanrW/96qHh
         TxTWF0JXQH52nN6gqs5HErVBmF58Avy+ksRufhqyXlBqnbThGeJa/Sd7PIrzTLrVO0sp
         YH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adZFM1OM/LYAcH6+RB4uxm5KB114qE5sEdsKi5M/0yY=;
        b=Q9oOfU3GGuB870sVFQ2s8IMf2/VDqL+6NgqpgV9M3qsp7jw06WuEBeuj+I/tXqAmqD
         Dy907IhoS8PxuSS1kSmH5+262xANAspGFcWJzIPkDaLoXB5QQiN/8TKrODCT3dlyl6QY
         2/v4FGLkpWy4e8WUTgM0eLNehh+bxzDET55hn1U0jkd45xfL6lyY0Qw7LdZ12b53oW1Z
         cSLXyz7qRzhGuNVfNRi87vppRiKGec4T5/7TT1or7XSBWH5CqmVEKl+AYFlxxIQimZeP
         7I7k5yBZnqmuj59DryqnSnK8EKWcz+860ZMsThSdurCWw56XL8wgBEnTX8V+9LMqtyOq
         VfWQ==
X-Gm-Message-State: AO0yUKV4ohJCGqPFuIEF2zAhc8X3p3bdBEmP888vsyndO6izUBQNCWR6
        wJ7lSNbokA/nf5vjSeiVhhbswNyXUWXkluA5
X-Google-Smtp-Source: AK7set+OrxTOjgL/sHOilEHem0HFLWKID85aq3Tw9WZc4n7T5rgq9/yIfqbHZjIU4F1Ww3Gtun1+Ig==
X-Received: by 2002:a05:6808:b19:b0:35e:92bc:9f72 with SMTP id s25-20020a0568080b1900b0035e92bc9f72mr7815294oij.30.1677287763693;
        Fri, 24 Feb 2023 17:16:03 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:02 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 14/76] ssdfs: PEB block bitmap modification operations
Date:   Fri, 24 Feb 2023 17:08:25 -0800
Message-Id: <20230225010927.813929-15-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements PEB block bitmap modification
operations:
pre_allocate - pre_allocate page/range in aggregation of block bitmaps
allocate - allocate page/range in aggregation of block bitmaps
invalidate - invalidate page/range in aggregation of block bitmaps
update_range - change the state of range in aggregation of block bitmaps
collect_garbage - find contiguous range for requested state
start_migration - prepare PEB's environment for migration
migrate - move range from source block bitmap into destination one
finish_migration - clean source block bitmap and swap block bitmaps

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_block_bitmap.c | 2418 +++++++++++++++++++++++++++++++++++
 1 file changed, 2418 insertions(+)

diff --git a/fs/ssdfs/peb_block_bitmap.c b/fs/ssdfs/peb_block_bitmap.c
index 0011ed7dc306..1938e1ccc02a 100644
--- a/fs/ssdfs/peb_block_bitmap.c
+++ b/fs/ssdfs/peb_block_bitmap.c
@@ -1538,3 +1538,2421 @@ int ssdfs_dst_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *bmap)
 
 	return err;
 }
+
+/*
+ * ssdfs_peb_blk_bmap_reserve_metapages() - reserve metadata pages
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @count: amount of metadata pages
+ *
+ * This function tries to reserve some amount of metadata pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - unable to reserve metapages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_reserve_metapages(struct ssdfs_peb_blk_bmap *bmap,
+					 int bmap_index,
+					 u32 count)
+{
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	int reserving_blks = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("seg %llu, bmap %p, bmap_index %u, count %u, "
+		  "free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap, bmap_index, count,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		SSDFS_ERR("PEB block bitmap init failed: "
+			  "seg_id %llu, peb_index %u, "
+			  "err %d\n",
+			  bmap->parent->parent_si->seg_id,
+			  bmap->peb_index, err);
+		return err;
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	reserving_blks = min_t(int, (int)count,
+				atomic_read(&bmap->peb_free_blks));
+	reserving_blks = min_t(int, reserving_blks,
+				atomic_read(&bmap->parent->seg_free_blks));
+
+	if (count > atomic_read(&bmap->peb_free_blks) ||
+	    count > atomic_read(&bmap->parent->seg_free_blks)) {
+		err = -ENOSPC;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve: "
+			  "count %u, free_logical_blks %d, "
+			  "parent->free_logical_blks %d\n",
+			  count,
+			  atomic_read(&bmap->peb_free_blks),
+			  atomic_read(&bmap->parent->seg_free_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (reserving_blks > 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("try to reserve: "
+				  "reserving_blks %d\n",
+				  reserving_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else
+			goto finish_calculate_reserving_blks;
+	}
+
+	atomic_sub(reserving_blks, &bmap->peb_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_sub(reserving_blks, &bmap->parent->seg_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent->free_logical_blks %u, "
+		  "parent->valid_logical_blks %u, "
+		  "parent->invalid_logical_blks %u, "
+		  "pages_per_peb %u\n",
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks),
+		  bmap->parent->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_calculate_reserving_blks:
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+
+	if (reserving_blks <= 0 && err)
+		goto finish_reserve_metapages;
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE)
+		cur_bmap = bmap->src;
+	else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION)
+		cur_bmap = bmap->dst;
+	else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_reserve_metapages;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_reserve_metapages;
+	}
+
+	err = ssdfs_block_bmap_reserve_metadata_pages(cur_bmap,
+							reserving_blks);
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to reserve metadata pages: "
+			  "reserving_blks %d\n",
+			  reserving_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		down_write(&bmap->parent->modification_lock);
+		down_write(&bmap->modification_lock);
+		atomic_add(reserving_blks, &bmap->peb_free_blks);
+		atomic_add(reserving_blks, &bmap->parent->seg_free_blks);
+		up_write(&bmap->modification_lock);
+		up_write(&bmap->parent->modification_lock);
+
+		goto finish_reserve_metapages;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve metadata pages: "
+			  "reserving_blks %d, err %d\n",
+			  reserving_blks, err);
+
+		down_write(&bmap->parent->modification_lock);
+		down_write(&bmap->modification_lock);
+		atomic_add(reserving_blks, &bmap->peb_free_blks);
+		atomic_add(reserving_blks, &bmap->parent->seg_free_blks);
+		up_write(&bmap->modification_lock);
+		up_write(&bmap->parent->modification_lock);
+
+		goto finish_reserve_metapages;
+	}
+
+finish_reserve_metapages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_free_metapages() - free metadata pages
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @count: amount of metadata pages
+ *
+ * This function tries to free some amount of metadata pages.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_free_metapages(struct ssdfs_peb_blk_bmap *bmap,
+				      int bmap_index,
+				      u32 count)
+{
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("seg %llu, bmap %p, bmap_index %u, count %u, "
+		  "free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap, bmap_index, count,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE)
+		cur_bmap = bmap->src;
+	else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION)
+		cur_bmap = bmap->dst;
+	else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_free_metapages;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_free_metapages;
+	}
+
+	err = ssdfs_block_bmap_free_metadata_pages(cur_bmap, count);
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to free metadata pages: "
+			  "count %u, err %d\n",
+			  count, err);
+		goto finish_free_metapages;
+	}
+
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	atomic_add(count, &bmap->peb_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic_add(count, &bmap->parent->seg_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent->free_logical_blks %u, "
+		  "parent->valid_logical_blks %u, "
+		  "parent->invalid_logical_blks %u, "
+		  "pages_per_peb %u\n",
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks),
+		  bmap->parent->pages_per_peb);
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+
+finish_free_metapages:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_pre_allocate() - pre-allocate a range of blocks
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free blocks and
+ * to set the found range in pre-allocated state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_pre_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    u32 *len,
+				    struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	bool is_migrating = false;
+	int src_used_blks = 0;
+	int src_invalid_blks = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range || !bmap->src);
+
+	SSDFS_DBG("bmap %p, bmap_index %u, len %p\n",
+		  bmap, bmap_index, len);
+	SSDFS_DBG("seg %llu, free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	si = bmap->parent->parent_si;
+
+	if (bmap->peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  bmap->peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[bmap->peb_index];
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+		BUG_ON(bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION);
+		break;
+
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		is_migrating = true;
+		break;
+
+	default:
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&bmap->buffers_state));
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE) {
+		cur_bmap = bmap->src;
+		is_migrating = false;
+	} else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION) {
+		cur_bmap = bmap->src;
+
+		if (cur_bmap == NULL) {
+			err = -ERANGE;
+			SSDFS_WARN("bmap pointer is empty\n");
+			goto finish_pre_allocate;
+		}
+
+		err = ssdfs_block_bmap_lock(cur_bmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock block bitmap: err %d\n",
+				  err);
+			goto finish_pre_allocate;
+		}
+
+		src_used_blks = ssdfs_block_bmap_get_used_pages(cur_bmap);
+		if (src_used_blks < 0) {
+			err = src_used_blks;
+			SSDFS_ERR("fail to get SRC used blocks: err %d\n",
+				  err);
+			goto finish_check_src_bmap;
+		}
+
+		src_invalid_blks = ssdfs_block_bmap_get_invalid_pages(cur_bmap);
+		if (src_invalid_blks < 0) {
+			err = src_invalid_blks;
+			SSDFS_ERR("fail to get SRC invalid blocks: err %d\n",
+				  err);
+			goto finish_check_src_bmap;
+		}
+
+finish_check_src_bmap:
+		ssdfs_block_bmap_unlock(cur_bmap);
+
+		if (unlikely(err))
+			goto finish_pre_allocate;
+
+		cur_bmap = bmap->dst;
+	} else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_pre_allocate;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_pre_allocate;
+	}
+
+	if (is_migrating) {
+		int start_blk = src_used_blks + src_invalid_blks;
+
+		start_blk = max_t(int, start_blk,
+				  atomic_read(&bmap->peb_valid_blks));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("src_used_blks %d, src_invalid_blks %d, "
+			  "valid_blks %d, start_blk %d\n",
+			  src_used_blks, src_invalid_blks,
+			  atomic_read(&bmap->peb_valid_blks),
+			  start_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_block_bmap_pre_allocate(cur_bmap, start_blk,
+						    len, range);
+	} else
+		err = ssdfs_block_bmap_pre_allocate(cur_bmap, 0, len, range);
+
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to pre-allocate blocks: "
+			  "len %u, err %d\n",
+			  *len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_pre_allocate;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to pre-allocate blocks: "
+			  "len %u, err %d\n",
+			  *len, err);
+		goto finish_pre_allocate;
+	}
+
+	if (!is_migrating) {
+		if (range->len > atomic_read(&bmap->peb_free_blks)) {
+			err = -ERANGE;
+			SSDFS_ERR("range %u > free_logical_blks %d\n",
+				  range->len,
+				  atomic_read(&bmap->peb_free_blks));
+			goto finish_pre_allocate;
+		}
+
+		atomic_sub(range->len, &bmap->peb_free_blks);
+		atomic_add(range->len, &bmap->peb_valid_blks);
+		atomic_add(range->len, &bmap->parent->seg_valid_blks);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION) {
+		int shared_free_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range->len %u, shared_free_dst_blks %d\n",
+			  range->len,
+			  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		shared_free_blks =
+			atomic_sub_return(range->len,
+					  &pebc->shared_free_dst_blks);
+		if (shared_free_blks < 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("range->len %u, shared_free_dst_blks %d\n",
+				   range->len,
+				   atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent->free_logical_blks %u, "
+		  "parent->valid_logical_blks %u, "
+		  "parent->invalid_logical_blks %u, "
+		  "pages_per_peb %u\n",
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks),
+		  bmap->parent->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_pre_allocate:
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+	up_read(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PRE-ALLOCATED: range (start %u, len %u), err %d\n",
+		  range->start, range->len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_allocate() - allocate a range of blocks
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @len: pointer on variable with requested length of range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to find contiguous range of free blocks and
+ * to set the found range in allocated state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				int bmap_index,
+				u32 *len,
+				struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	bool is_migrating = false;
+	int src_used_blks = 0;
+	int src_invalid_blks = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range || !bmap->src);
+
+	SSDFS_DBG("bmap %p, bmap_index %u, len %p\n",
+		  bmap, bmap_index, len);
+	SSDFS_DBG("seg %llu, free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  bmap->parent->parent_si->seg_id,
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	si = bmap->parent->parent_si;
+
+	if (bmap->peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  bmap->peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[bmap->peb_index];
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+		BUG_ON(bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION);
+		break;
+
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		is_migrating = true;
+		break;
+
+	default:
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&bmap->buffers_state));
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE) {
+		cur_bmap = bmap->src;
+		is_migrating = false;
+	} else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION) {
+		cur_bmap = bmap->src;
+
+		if (cur_bmap == NULL) {
+			err = -ERANGE;
+			SSDFS_WARN("bmap pointer is empty\n");
+			goto finish_allocate;
+		}
+
+		err = ssdfs_block_bmap_lock(cur_bmap);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock block bitmap: err %d\n",
+				  err);
+			goto finish_allocate;
+		}
+
+		src_used_blks = ssdfs_block_bmap_get_used_pages(cur_bmap);
+		if (src_used_blks < 0) {
+			err = src_used_blks;
+			SSDFS_ERR("fail to get SRC used blocks: err %d\n",
+				  err);
+			goto finish_check_src_bmap;
+		}
+
+		src_invalid_blks = ssdfs_block_bmap_get_invalid_pages(cur_bmap);
+		if (src_invalid_blks < 0) {
+			err = src_invalid_blks;
+			SSDFS_ERR("fail to get SRC invalid blocks: err %d\n",
+				  err);
+			goto finish_check_src_bmap;
+		}
+
+finish_check_src_bmap:
+		ssdfs_block_bmap_unlock(cur_bmap);
+
+		if (unlikely(err))
+			goto finish_allocate;
+
+		cur_bmap = bmap->dst;
+	} else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_allocate;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_allocate;
+	}
+
+	if (is_migrating) {
+		int start_blk = src_used_blks + src_invalid_blks;
+
+		start_blk = max_t(int, start_blk,
+				  atomic_read(&bmap->peb_valid_blks));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("src_used_blks %d, src_invalid_blks %d, "
+			  "valid_blks %d, start_blk %d\n",
+			  src_used_blks, src_invalid_blks,
+			  atomic_read(&bmap->peb_valid_blks),
+			  start_blk);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_block_bmap_allocate(cur_bmap, start_blk,
+						len, range);
+	} else
+		err = ssdfs_block_bmap_allocate(cur_bmap, 0, len, range);
+
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to allocate blocks: "
+			  "len %u, err %d\n",
+			  *len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_allocate;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate blocks: "
+			  "len %u, err %d\n",
+			  *len, err);
+		goto finish_allocate;
+	}
+
+	if (!is_migrating) {
+		if (range->len > atomic_read(&bmap->peb_free_blks)) {
+			err = -ERANGE;
+			SSDFS_ERR("range %u > free_logical_blks %d\n",
+				  range->len,
+				  atomic_read(&bmap->peb_free_blks));
+			goto finish_allocate;
+		}
+
+		atomic_sub(range->len, &bmap->peb_free_blks);
+		atomic_add(range->len, &bmap->peb_valid_blks);
+		atomic_add(range->len, &bmap->parent->seg_valid_blks);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION) {
+		int shared_free_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range->len %u, shared_free_dst_blks %d\n",
+			  range->len,
+			  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		shared_free_blks =
+			atomic_sub_return(range->len,
+					  &pebc->shared_free_dst_blks);
+		if (shared_free_blks < 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("range->len %u, shared_free_dst_blks %d\n",
+				   range->len,
+				   atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("parent->free_logical_blks %u, "
+		  "parent->valid_logical_blks %u, "
+		  "parent->invalid_logical_blks %u, "
+		  "pages_per_peb %u\n",
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks),
+		  bmap->parent->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_allocate:
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+	up_read(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ALLOCATED: range (start %u, len %u), err %d\n",
+		  range->start, range->len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_invalidate() - invalidate a range of blocks
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to set the requested range of blocks in
+ * invalid state. At first, it checks that requested range contains
+ * valid blocks only. And, then, it sets the requested range of blocks
+ * in invalid state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_invalidate(struct ssdfs_peb_blk_bmap *bmap,
+				  int bmap_index,
+				  struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	bool is_migrating = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range || !bmap->src);
+
+	SSDFS_DBG("seg %llu, bmap %p, bmap_index %u, "
+		  "range (start %u, len %u)\n",
+		  bmap->parent->parent_si->seg_id,
+		  bmap, bmap_index, range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+		BUG_ON(bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION);
+		break;
+
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		is_migrating = true;
+		break;
+
+	default:
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&bmap->buffers_state));
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u, "
+		  "is_migrating %#x\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb, is_migrating);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&bmap->lock);
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE)
+		cur_bmap = bmap->src;
+	else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION)
+		cur_bmap = bmap->dst;
+	else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_invalidate;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_invalidate;
+	}
+
+	err = ssdfs_block_bmap_invalidate(cur_bmap, range);
+
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate blocks: "
+			  "len %u, err %d\n",
+			  range->len, err);
+		goto finish_invalidate;
+	}
+
+	if (!is_migrating) {
+		if (range->len > atomic_read(&bmap->peb_valid_blks)) {
+			err = -ERANGE;
+			SSDFS_ERR("range %u > valid_logical_blks %d\n",
+				  range->len,
+				  atomic_read(&bmap->peb_valid_blks));
+			goto finish_invalidate;
+		}
+
+		atomic_sub(range->len, &bmap->peb_valid_blks);
+		atomic_add(range->len, &bmap->peb_invalid_blks);
+
+		atomic_sub(range->len, &bmap->parent->seg_valid_blks);
+		atomic_add(range->len, &bmap->parent->seg_invalid_blks);
+	} else if (is_migrating &&
+			bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION) {
+		if (range->len > atomic_read(&bmap->peb_valid_blks)) {
+			err = -ERANGE;
+			SSDFS_ERR("range %u > valid_logical_blks %d\n",
+				  range->len,
+				  atomic_read(&bmap->peb_valid_blks));
+			goto finish_invalidate;
+		}
+
+		atomic_sub(range->len, &bmap->peb_valid_blks);
+		atomic_add(range->len, &bmap->peb_invalid_blks);
+
+		atomic_sub(range->len, &bmap->parent->seg_valid_blks);
+		atomic_add(range->len, &bmap->parent->seg_invalid_blks);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blks %u, valid_logical_blks %u, "
+		  "invalid_logical_blks %u, pages_per_peb %u\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks),
+		  bmap->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	SSDFS_DBG("parent->free_logical_blks %u, "
+		  "parent->valid_logical_blks %u, "
+		  "parent->invalid_logical_blks %u, "
+		  "pages_per_peb %u\n",
+		  atomic_read(&bmap->parent->seg_free_blks),
+		  atomic_read(&bmap->parent->seg_valid_blks),
+		  atomic_read(&bmap->parent->seg_invalid_blks),
+		  bmap->parent->pages_per_peb);
+
+	if (atomic_read(&bmap->peb_free_blks) < 0) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+
+	if ((atomic_read(&bmap->peb_free_blks) +
+	     atomic_read(&bmap->peb_valid_blks) +
+	     atomic_read(&bmap->peb_invalid_blks)) >
+					bmap->pages_per_peb) {
+		SSDFS_WARN("free_logical_blks %u, valid_logical_blks %u, "
+			   "invalid_logical_blks %u, pages_per_peb %u\n",
+			   atomic_read(&bmap->peb_free_blks),
+			   atomic_read(&bmap->peb_valid_blks),
+			   atomic_read(&bmap->peb_invalid_blks),
+			   bmap->pages_per_peb);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_invalidate:
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+	up_read(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("INVALIDATED: seg %llu, "
+		  "range (start %u, len %u), err %d\n",
+		  bmap->parent->parent_si->seg_id,
+		  range->start, range->len, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_update_range() - update a range of blocks' state
+ * @bmap: PEB's block bitmap object
+ * @bmap_index: source or destination block bitmap?
+ * @new_range_state: new state of the range
+ * @range: pointer on blocks' range [in | out]
+ *
+ * This function tries to change a range of blocks' state.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_update_range(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    int new_range_state,
+				    struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_block_bmap *cur_bmap = NULL;
+	int range_state;
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks, used_blks, invalid_blks;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range);
+	BUG_ON(!(new_range_state == SSDFS_BLK_PRE_ALLOCATED ||
+		 new_range_state == SSDFS_BLK_VALID));
+
+	SSDFS_DBG("bmap %p, peb_index %u, state %#x, "
+		  "new_range_state %#x, "
+		  "range (start %u, len %u)\n",
+		  bmap, bmap->peb_index,
+		  atomic_read(&bmap->state),
+		  new_range_state,
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	if (bmap_index < 0 || bmap_index >= SSDFS_PEB_BLK_BMAP_INDEX_MAX) {
+		SSDFS_WARN("invalid bmap_index %u\n",
+			   bmap_index);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+		BUG_ON(bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION);
+		break;
+
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&bmap->buffers_state));
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+
+	if (bmap_index == SSDFS_PEB_BLK_BMAP_SOURCE)
+		cur_bmap = bmap->src;
+	else if (bmap_index == SSDFS_PEB_BLK_BMAP_DESTINATION)
+		cur_bmap = bmap->dst;
+	else
+		cur_bmap = NULL;
+
+	if (cur_bmap == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_update_range;
+	}
+
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_update_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_block_bmap_get_free_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto finish_process_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto finish_process_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto finish_process_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+	if (unlikely(err))
+		goto finish_process_bmap;
+
+	SSDFS_DBG("BEFORE: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	range_state = ssdfs_get_range_state(cur_bmap, range);
+	if (range_state < 0) {
+		err = range_state;
+		SSDFS_ERR("fail to detect range state: "
+			  "range (start %u, len %u), err %d\n",
+			  range->start, range->len, err);
+		goto finish_process_bmap;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("current range_state %#x\n",
+		  range_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (range_state) {
+	case SSDFS_BLK_FREE:
+		/* valid block state */
+		break;
+
+	case SSDFS_BLK_PRE_ALLOCATED:
+		if (new_range_state == SSDFS_BLK_PRE_ALLOCATED) {
+			/* do nothing */
+			goto finish_process_bmap;
+		}
+		break;
+
+	case SSDFS_BLK_VALID:
+		if (new_range_state == SSDFS_BLK_PRE_ALLOCATED) {
+			err = -ERANGE;
+			SSDFS_WARN("fail to change state: "
+				   "range_state %#x, "
+				   "new_range_state %#x\n",
+				   range_state, new_range_state);
+			goto finish_process_bmap;
+		} else if (new_range_state == SSDFS_BLK_VALID) {
+			/* do nothing */
+			goto finish_process_bmap;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid range state: %#x\n",
+			  range_state);
+		goto finish_process_bmap;
+	};
+
+	if (new_range_state == SSDFS_BLK_PRE_ALLOCATED) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try to pre-allocate: "
+			  "range (start %u, len %u)\n",
+			  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_block_bmap_pre_allocate(cur_bmap, 0, NULL, range);
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("try to allocate: "
+			  "range (start %u, len %u)\n",
+			  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		err = ssdfs_block_bmap_allocate(cur_bmap, 0, NULL, range);
+	}
+
+finish_process_bmap:
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to update range: "
+			  "range (start %u, len %u), "
+			  "new_range_state %#x, err %d\n",
+			  range->start, range->len,
+			  new_range_state, err);
+		goto finish_update_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_block_bmap_lock(cur_bmap);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_update_range;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(cur_bmap);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_bmap:
+	ssdfs_block_bmap_unlock(cur_bmap);
+
+	if (unlikely(err))
+		goto finish_update_range;
+
+	SSDFS_DBG("AFTER: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_update_range:
+	up_read(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("UPDATED: range (start %u, len %u), "
+		  "new_range_state %#x, err %d\n",
+		  range->start, range->len,
+		  new_range_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_collect_garbage() - find range of valid blocks for GC
+ * @bmap: PEB's block bitmap object
+ * @start: starting position for search
+ * @max_len: maximum requested length of valid blocks' range
+ * @blk_state: requested block state (pre-allocated or valid)
+ * @range: pointer on blocks' range [out]
+ *
+ * This function tries to find range of valid or pre_allocated blocks
+ * for GC in source block bitmap. The length of requested range is
+ * limited by @max_len.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_collect_garbage(struct ssdfs_peb_blk_bmap *bmap,
+					u32 start, u32 max_len,
+					int blk_state,
+					struct ssdfs_block_bmap_range *range)
+{
+	struct ssdfs_block_bmap *src = NULL;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range || !bmap->src);
+
+	SSDFS_DBG("bmap %p, start %u, max_len %u\n",
+		  bmap, start, max_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+	case SSDFS_PEB_BMAP2_SRC:
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		/* valid state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid buffers_state %#x\n",
+			   atomic_read(&bmap->buffers_state));
+		return -ERANGE;
+	}
+
+	down_read(&bmap->lock);
+
+	src = bmap->src;
+
+	if (src == NULL) {
+		err = -ERANGE;
+		SSDFS_WARN("bmap pointer is empty\n");
+		goto finish_collect_garbage;
+	}
+
+	err = ssdfs_block_bmap_lock(src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_collect_garbage;
+	}
+
+	err = ssdfs_block_bmap_collect_garbage(src, start, max_len,
+						blk_state, range);
+
+	ssdfs_block_bmap_unlock(src);
+
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range (start %u, len %u) hasn't valid blocks\n",
+			  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_collect_garbage;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find valid blocks: "
+			  "len %u, err %d\n",
+			  range->len, err);
+		goto finish_collect_garbage;
+	}
+
+finish_collect_garbage:
+	up_read(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("GARBAGE: range (start %u, len %u), "
+		  "blk_state %#x, err %d\n",
+		  range->start, range->len,
+		  blk_state, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_start_migration() - prepare migration environment
+ * @bmap: PEB's block bitmap object
+ *
+ * This method tries to prepare PEB's environment for migration.
+ * The destination block bitmap is cleaned in buffer and pointer
+ * is set. Also valid/invalid/free block counters are prepared
+ * for migration operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_start_migration(struct ssdfs_peb_blk_bmap *bmap)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	int buffers_state, new_buffers_state;
+	int buffer_index;
+	int free_blks = 0;
+	int invalid_blks;
+	int used_blks;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->src);
+
+	SSDFS_DBG("bmap %p, peb_index %u, state %#x\n",
+		  bmap, bmap->peb_index,
+		  atomic_read(&bmap->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blocks %d, valid_logical_block %d, "
+		  "invalid_logical_block %d\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = bmap->parent->parent_si;
+
+	if (bmap->peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  bmap->peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[bmap->peb_index];
+
+	down_write(&bmap->lock);
+	down_write(&bmap->parent->modification_lock);
+	down_write(&bmap->modification_lock);
+
+	buffers_state = atomic_read(&bmap->buffers_state);
+
+	switch (buffers_state) {
+	case SSDFS_PEB_BMAP1_SRC:
+		new_buffers_state = SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST;
+		buffer_index = SSDFS_PEB_BLK_BMAP2;
+		break;
+
+	case SSDFS_PEB_BMAP2_SRC:
+		new_buffers_state = SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST;
+		buffer_index = SSDFS_PEB_BLK_BMAP1;
+		break;
+
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		err = -ENOENT;
+		SSDFS_WARN("bmap is under migration: "
+			   "peb_index %u, state %#x\n",
+			   bmap->peb_index, buffers_state);
+		goto finish_migration_start;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("fail to start migration: "
+			   "buffers_state %#x\n",
+			   buffers_state);
+		goto finish_migration_start;
+	}
+
+	err = ssdfs_block_bmap_lock(&bmap->buffer[buffer_index]);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migration_start;
+	}
+
+	switch (atomic_read(&bmap->buffers_state)) {
+	case SSDFS_PEB_BMAP1_SRC:
+#ifdef CONFIG_SSDFS_DEBUG
+		WARN_ON(buffers_state != SSDFS_PEB_BMAP1_SRC);
+		BUG_ON(!bmap->src || bmap->dst);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case SSDFS_PEB_BMAP2_SRC:
+#ifdef CONFIG_SSDFS_DEBUG
+		WARN_ON(buffers_state != SSDFS_PEB_BMAP2_SRC);
+		BUG_ON(!bmap->src || bmap->dst);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		err = -ENOENT;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("block bitmap has been prepared: "
+			  "peb_index %u\n",
+			  bmap->peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_block_bitmap_preparation;
+	}
+
+	err = ssdfs_block_bmap_clean(&bmap->buffer[buffer_index]);
+	if (unlikely(err == -ENOENT)) {
+		err = -ERANGE;
+		SSDFS_WARN("unable to clean block bitmap: "
+			   "peb_index %u\n",
+			   bmap->peb_index);
+		goto finish_block_bitmap_preparation;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to clean block bitmap: "
+			  "peb_index %u\n",
+			  bmap->peb_index);
+		goto finish_block_bitmap_preparation;
+	}
+
+	bmap->dst = &bmap->buffer[buffer_index];
+	atomic_set(&bmap->buffers_state, new_buffers_state);
+
+	free_blks = atomic_read(&bmap->peb_free_blks);
+	atomic_sub(free_blks, &bmap->peb_free_blks);
+	atomic_sub(free_blks, &bmap->parent->seg_free_blks);
+
+	invalid_blks = atomic_xchg(&bmap->peb_invalid_blks, 0);
+	atomic_sub(invalid_blks, &bmap->parent->seg_invalid_blks);
+	atomic_add(invalid_blks, &bmap->peb_free_blks);
+	atomic_set(&pebc->shared_free_dst_blks, invalid_blks);
+	atomic_add(invalid_blks, &bmap->parent->seg_free_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("shared_free_dst_blks %d\n",
+		  atomic_read(&pebc->shared_free_dst_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	used_blks = atomic_read(&bmap->peb_valid_blks);
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto finish_block_bitmap_preparation;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	if (free_blks < (invalid_blks + used_blks)) {
+		err = -ERANGE;
+		SSDFS_ERR("free_blks %d < (invalid_blks %d + used_blks %d)\n",
+			  free_blks, invalid_blks, used_blks);
+		goto finish_block_bitmap_preparation;
+	}
+
+	free_blks -= invalid_blks + used_blks;
+
+	atomic_add(free_blks, &bmap->peb_free_blks);
+	atomic_add(free_blks, &bmap->parent->seg_free_blks);
+
+finish_block_bitmap_preparation:
+	ssdfs_block_bmap_unlock(&bmap->buffer[buffer_index]);
+
+	if (unlikely(err))
+		goto finish_migration_start;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_block_bmap_lock(bmap->dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migration_start;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_dst_bmap:
+	ssdfs_block_bmap_unlock(bmap->dst);
+
+	if (unlikely(err))
+		goto finish_migration_start;
+
+	SSDFS_DBG("DST: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+
+	err = ssdfs_block_bmap_lock(bmap->src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migration_start;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_src_bmap:
+	ssdfs_block_bmap_unlock(bmap->src);
+
+	if (unlikely(err))
+		goto finish_migration_start;
+
+	SSDFS_DBG("SRC: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_migration_start:
+	up_write(&bmap->modification_lock);
+	up_write(&bmap->parent->modification_lock);
+	up_write(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_logical_blocks %d, valid_logical_block %d, "
+		  "invalid_logical_block %d\n",
+		  atomic_read(&bmap->peb_free_blks),
+		  atomic_read(&bmap->peb_valid_blks),
+		  atomic_read(&bmap->peb_invalid_blks));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -ENOENT)
+		return 0;
+	else if (unlikely(err))
+		return err;
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_migrate() - migrate valid blocks
+ * @bmap: PEB's block bitmap object
+ * @new_range_state: new state of range
+ * @range: pointer on blocks' range
+ *
+ * This method tries to move @range of blocks from source
+ * block bitmap into destination block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_migrate(struct ssdfs_peb_blk_bmap *bmap,
+				int new_range_state,
+				struct ssdfs_block_bmap_range *range)
+{
+	int buffers_state;
+	int range_state;
+	struct ssdfs_block_bmap *src;
+	struct ssdfs_block_bmap *dst;
+	int free_blks;
+#ifdef CONFIG_SSDFS_DEBUG
+	int used_blks, invalid_blks;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !range);
+	BUG_ON(!(new_range_state == SSDFS_BLK_PRE_ALLOCATED ||
+		 new_range_state == SSDFS_BLK_VALID));
+
+	SSDFS_DBG("bmap %p, peb_index %u, state %#x, "
+		  "new_range_state %#x, range (start %u, len %u)\n",
+		  bmap, bmap->peb_index,
+		  atomic_read(&bmap->state),
+		  new_range_state,
+		  range->start, range->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	down_read(&bmap->lock);
+
+	buffers_state = atomic_read(&bmap->buffers_state);
+
+	switch (buffers_state) {
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+		src = bmap->src;
+		dst = bmap->dst;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("fail to migrate: "
+			   "buffers_state %#x, "
+			   "range (start %u, len %u)\n",
+			   buffers_state,
+			   range->start, range->len);
+		goto finish_migrate;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!src || !dst) {
+		err = -ERANGE;
+		SSDFS_WARN("empty pointers\n");
+		goto finish_migrate;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_block_bmap_lock(src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migrate;
+	}
+
+	range_state = ssdfs_get_range_state(src, range);
+	if (range_state < 0) {
+		err = range_state;
+		SSDFS_ERR("fail to detect range state: "
+			  "range (start %u, len %u), err %d\n",
+			  range->start, range->len, err);
+		goto finish_process_source_bmap;
+	}
+
+	switch (range_state) {
+	case SSDFS_BLK_PRE_ALLOCATED:
+		/* valid block state */
+		err = ssdfs_block_bmap_invalidate(src, range);
+		break;
+
+	case SSDFS_BLK_VALID:
+		if (new_range_state == SSDFS_BLK_PRE_ALLOCATED) {
+			err = -ERANGE;
+			SSDFS_WARN("fail to change state: "
+				   "range_state %#x, "
+				   "new_range_state %#x\n",
+				   range_state, new_range_state);
+			goto finish_process_source_bmap;
+		}
+
+		err = ssdfs_block_bmap_invalidate(src, range);
+		break;
+
+	case SSDFS_BLK_INVALID:
+		/* range was invalidated already */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid range state: %#x\n",
+			  range_state);
+		goto finish_process_source_bmap;
+	};
+
+finish_process_source_bmap:
+	ssdfs_block_bmap_unlock(src);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate blocks: "
+			  "start %u, len %u, err %d\n",
+			  range->start, range->len, err);
+		goto finish_migrate;
+	}
+
+	err = ssdfs_block_bmap_lock(dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migrate;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto do_bmap_unlock;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	if (free_blks < range->len) {
+		u32 freed_metapages = range->len - free_blks;
+
+		err = ssdfs_block_bmap_free_metadata_pages(dst,
+							   freed_metapages);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to free metadata pages: err %d\n",
+				  err);
+			goto do_bmap_unlock;
+		}
+	}
+
+	if (new_range_state == SSDFS_BLK_PRE_ALLOCATED)
+		err = ssdfs_block_bmap_pre_allocate(dst, 0, NULL, range);
+	else
+		err = ssdfs_block_bmap_allocate(dst, 0, NULL, range);
+
+do_bmap_unlock:
+	ssdfs_block_bmap_unlock(dst);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate blocks: "
+			  "start %u, len %u, err %d\n",
+			  range->start, range->len, err);
+		goto finish_migrate;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_block_bmap_lock(src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migrate;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_src_bmap:
+	ssdfs_block_bmap_unlock(src);
+
+	if (unlikely(err))
+		goto finish_migrate;
+
+	SSDFS_DBG("SRC: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+
+	err = ssdfs_block_bmap_lock(dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migrate;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_dst_bmap:
+	ssdfs_block_bmap_unlock(dst);
+
+	if (unlikely(err))
+		goto finish_migrate;
+
+	SSDFS_DBG("DST: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_migrate:
+	up_read(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_blk_bmap_finish_migration() - stop migration
+ * @bmap: PEB's block bitmap object
+ *
+ * This method tries to make destination block bitmap as
+ * source and to forget about old source block bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_peb_blk_bmap_finish_migration(struct ssdfs_peb_blk_bmap *bmap)
+{
+	struct ssdfs_segment_info *si;
+	struct ssdfs_peb_container *pebc;
+	int buffers_state, new_buffers_state;
+	int buffer_index;
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks, used_blks, invalid_blks;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap || !bmap->src);
+
+	SSDFS_DBG("bmap %p, peb_index %u, state %#x\n",
+		  bmap, bmap->peb_index,
+		  atomic_read(&bmap->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+		err = SSDFS_WAIT_COMPLETION(&bmap->init_end);
+		if (unlikely(err)) {
+init_failed:
+			SSDFS_ERR("PEB block bitmap init failed: "
+				  "seg_id %llu, peb_index %u, "
+				  "err %d\n",
+				  bmap->parent->parent_si->seg_id,
+				  bmap->peb_index, err);
+			return err;
+		}
+
+		if (!ssdfs_peb_blk_bmap_initialized(bmap)) {
+			err = -ERANGE;
+			goto init_failed;
+		}
+	}
+
+	si = bmap->parent->parent_si;
+
+	if (bmap->peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= pebs_count %u\n",
+			  bmap->peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[bmap->peb_index];
+
+	down_write(&bmap->lock);
+
+	buffers_state = atomic_read(&bmap->buffers_state);
+
+	switch (buffers_state) {
+	case SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!bmap->src || !bmap->dst);
+#endif /* CONFIG_SSDFS_DEBUG */
+		new_buffers_state = SSDFS_PEB_BMAP2_SRC;
+		buffer_index = SSDFS_PEB_BLK_BMAP2;
+		break;
+
+	case SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!bmap->src || !bmap->dst);
+#endif /* CONFIG_SSDFS_DEBUG */
+		new_buffers_state = SSDFS_PEB_BMAP1_SRC;
+		buffer_index = SSDFS_PEB_BLK_BMAP1;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("fail to start migration: "
+			   "buffers_state %#x\n",
+			   buffers_state);
+		goto finish_migration_stop;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_block_bmap_lock(bmap->dst);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migration_stop;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->dst);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_dst_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_dst_bmap:
+	ssdfs_block_bmap_unlock(bmap->dst);
+
+	if (unlikely(err))
+		goto finish_migration_stop;
+
+	SSDFS_DBG("DST: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+
+	err = ssdfs_block_bmap_lock(bmap->src);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock block bitmap: err %d\n", err);
+		goto finish_migration_stop;
+	}
+
+	err = ssdfs_block_bmap_get_free_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get free pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		free_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_used_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get used pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		used_blks = err;
+		err = 0;
+	}
+
+	err = ssdfs_block_bmap_get_invalid_pages(bmap->src);
+	if (err < 0) {
+		SSDFS_ERR("fail to get invalid pages count: "
+			  "peb_index %u, err %d\n",
+			  bmap->peb_index, err);
+		goto unlock_src_bmap;
+	} else {
+		invalid_blks = err;
+		err = 0;
+	}
+
+unlock_src_bmap:
+	ssdfs_block_bmap_unlock(bmap->src);
+
+	if (unlikely(err))
+		goto finish_migration_stop;
+
+	SSDFS_DBG("SRC: free_blks %d, used_blks %d, invalid_blks %d\n",
+		  free_blks, used_blks, invalid_blks);
+
+	if ((free_blks + used_blks + invalid_blks) > bmap->pages_per_peb) {
+		SSDFS_WARN("free_blks %d, used_blks %d, "
+			   "invalid_blks %d, pages_per_peb %u\n",
+			   free_blks, used_blks, invalid_blks,
+			   bmap->pages_per_peb);
+		err = -ERANGE;
+		goto finish_migration_stop;
+	}
+
+	if (used_blks != 0) {
+		SSDFS_ERR("PEB contains valid blocks %d\n",
+			  used_blks);
+		err = -ERANGE;
+		goto finish_migration_stop;
+	}
+
+	SSDFS_DBG("shared_free_dst_blks %d, pages_per_peb %u\n",
+		  atomic_read(&pebc->shared_free_dst_blks),
+		  bmap->pages_per_peb);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_block_bmap_clear_dirty_state(bmap->src);
+
+	bmap->src = &bmap->buffer[buffer_index];
+	bmap->dst = NULL;
+	atomic_set(&bmap->buffers_state, new_buffers_state);
+
+finish_migration_stop:
+	up_write(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
-- 
2.34.1

