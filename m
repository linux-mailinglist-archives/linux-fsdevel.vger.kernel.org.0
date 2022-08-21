Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88659B5D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiHUSLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiHUSLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:11:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8361F62E;
        Sun, 21 Aug 2022 11:11:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c39so11311535edf.0;
        Sun, 21 Aug 2022 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xSc+zCgoKxwL9Nm5hCo9PDGdvwe/GSgOKgfEouLfAZQ=;
        b=Acx4OVI4Bkjv3z6rKateHfHQZvswRQnfj5bqlwzd8fAqLMGIju7zlixRkY8fSe3CeW
         IoyCFWjIjeheBMxEdtXEY7I3LuK3E0O+2pgHn8Mvpdlj7vY5GRAyN48mftTGR/BBm857
         3nSQwvChGywoHlAoUeb7bG6uHqqwx0gAqljDpj/NWZIY3PuOcwmTnGajkHBbg+SUObpl
         +TjNi69JlwqANiFfN8FDhegzyksSu7VHCqMhRj3afNiifAj6L+paHwamDqk9oyi7dVaI
         hvJaXcy4EYCyQFfh/GcMxuQQouMiaoyHj7P+l7ll7kRjYyWoKXOaVITIyV2vLs7XE5sr
         M1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xSc+zCgoKxwL9Nm5hCo9PDGdvwe/GSgOKgfEouLfAZQ=;
        b=TgfPovwPg0PbIDJlldok+LqotF8KGcoLiKwsDydjG6Gw4huChxYpsFog3n43zhp+/s
         3z91BBoigQ6QRMatWiWhlSRgyopfTSlz1BATAxz0k52tkfWk+gquQuTSs0GUibR4pB/6
         qA/k+w2cVi+ke+wPfRUMW/bkLJ1RGaJXZks8jcAjSuNyVr0KeRjwDbxiLdauDMQi7vH3
         COp7+Koy8S6prh03Qf9wBg9iO199yrUkW6Y92hQavaPeHtroiEvatDcvIWlpSpF/E9DQ
         vo1jYeQ8WsP0yfEiUVGGNMSj/QS5xDoiRU/K9t2FANYBpnjYcfJ3HJtz3GGE75D6N8ld
         reMA==
X-Gm-Message-State: ACgBeo3N095y1b+iNiOAsnkJtQzEiJP1pIeppt7VplVL1WhkaG0zHsqb
        GmYwmxFdf2NNd6IikHVdu+w=
X-Google-Smtp-Source: AA6agR53O5qdB5bjK4EoanRKtdvrBsKxtRZG7LZNAfJBTGsNFJvu+5nFekfVu3REws7mlODDUvMVYw==
X-Received: by 2002:a05:6402:176a:b0:445:d87f:b42d with SMTP id da10-20020a056402176a00b00445d87fb42dmr13119999edb.157.1661105462272;
        Sun, 21 Aug 2022 11:11:02 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402114c00b004404e290e7esm6854178edw.77.2022.08.21.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:11:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RESEND PATCH 4/4] hfsplus: Convert kmap() to kmap_local_page() in btree.c
Date:   Sun, 21 Aug 2022 20:10:45 +0200
Message-Id: <20220821181045.8528-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181045.8528-1-fmdefrancesco@gmail.com>
References: <20220821181045.8528-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in btree.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in btree.c.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/btree.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 3a917a9a4edd..9e1732a2b92a 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -163,7 +163,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
 		sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
@@ -240,12 +240,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		(tree->node_size + PAGE_SIZE - 1) >>
 		PAGE_SHIFT;
 
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
 	return tree;
 
  fail_page:
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
  free_inode:
 	tree->inode->i_mapping->a_ops = &hfsplus_aops;
@@ -292,7 +292,7 @@ int hfs_btree_write(struct hfs_btree *tree)
 		return -EIO;
 	/* Load the header */
 	page = node->page[0];
-	head = (struct hfs_btree_header_rec *)(kmap(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
 		sizeof(struct hfs_bnode_desc));
 
 	head->root = cpu_to_be32(tree->root);
@@ -304,7 +304,7 @@ int hfs_btree_write(struct hfs_btree *tree)
 	head->attributes = cpu_to_be32(tree->attributes);
 	head->depth = cpu_to_be16(tree->depth);
 
-	kunmap(page);
+	kunmap_local(head);
 	set_page_dirty(page);
 	hfs_bnode_put(node);
 	return 0;
@@ -395,7 +395,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap(*pagep);
+	data = kmap_local_page(*pagep);
 	off &= ~PAGE_MASK;
 	idx = 0;
 
@@ -408,7 +408,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 						idx += i;
 						data[off] |= m;
 						set_page_dirty(*pagep);
-						kunmap(*pagep);
+						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
@@ -418,14 +418,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 				}
 			}
 			if (++off >= PAGE_SIZE) {
-				kunmap(*pagep);
-				data = kmap(*++pagep);
+				kunmap_local(data);
+				data = kmap_local_page(*++pagep);
 				off = 0;
 			}
 			idx += 8;
 			len--;
 		}
-		kunmap(*pagep);
+		kunmap_local(data);
 		nidx = node->next;
 		if (!nidx) {
 			hfs_dbg(BNODE_MOD, "create new bmap node\n");
@@ -441,7 +441,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		off = off16;
 		off += node->page_offset;
 		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap(*pagep);
+		data = kmap_local_page(*pagep);
 		off &= ~PAGE_MASK;
 	}
 }
@@ -491,7 +491,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	}
 	off += node->page_offset + nidx / 8;
 	page = node->page[off >> PAGE_SHIFT];
-	data = kmap(page);
+	data = kmap_local_page(page);
 	off &= ~PAGE_MASK;
 	m = 1 << (~nidx & 7);
 	byte = data[off];
@@ -499,13 +499,13 @@ void hfs_bmap_free(struct hfs_bnode *node)
 		pr_crit("trying to free free bnode "
 				"%u(%d)\n",
 			node->this, node->type);
-		kunmap(page);
+		kunmap_local(data);
 		hfs_bnode_put(node);
 		return;
 	}
 	data[off] = byte & ~m;
 	set_page_dirty(page);
-	kunmap(page);
+	kunmap_local(data);
 	hfs_bnode_put(node);
 	tree->free_nodes++;
 	mark_inode_dirty(tree->inode);
-- 
2.37.1

