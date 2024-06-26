Return-Path: <linux-fsdevel+bounces-22509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489B9181F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DA91F21B86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7B1862B2;
	Wed, 26 Jun 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+lxx89s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCE181CE2;
	Wed, 26 Jun 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407286; cv=none; b=VPKYUbykOVPVsYfUoWrRwC348cOaEckICk8lALOsxuCuZfBdU67loR8cprVW3tUwqcGUQvwupd9sowZCQUfDhnesg+xZtm/iwKsECFNDhzrXV0kBpeb4NN1oidwPH+qJIRh873OMh3dRwmRBFRMwfxeYrzkSRaxBEZED+ByPhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407286; c=relaxed/simple;
	bh=ZUstgPHjqY5JKrpO42mF1d8ks4hIOJMdPpqtfyuce0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk/N8wbid6HZYXVJwAhesOO2G7tl9uvD5Kby+5kAiJcihhpzaN51ATuCU7dTWJe/wTMZoDn84FRcQVzgHETZJYaF3vCE80rjXJ69Yk2Pn53Dd3LjlOAZdx+Gb4Anjf3YjvYkuP+czFswnHL80z+iyNgcD5JlTqF2VtKcOYElPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q+lxx89s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=knQaeXO173yNERHjz9A2B7L+swNnkd1yL7SOMfdvQbk=; b=Q+lxx89shR6NswOm8DcLjEt1mK
	q+PMv7YoReu/vv6rt9uHWin8jyeaY/Qafqh2km/D5v90YoL9m2oQrz8xFSuDu5EQvMgx6Y7F4gdPd
	LZe4FdXtdmTGSFvdEi1Vh4wSfMo29FMfU3bmd8oKPmd1Fko/sr/73xD2ISFVfyUTiWPo5s63AsWv/
	RjrsJ6YBhBydPT6t/y3zISRp8mV4kFImTMy6fiJ9ynMEk9A6jPgtMaQKiq4mjNEHyne0IVl6seqGh
	ftsIqwoz00WzLfrMmIF4sRdZKBRvkCFrold2zk6zmm8IQ+DUMAKF0B5/xWLYv7M7RLS2eb1bO8ZqJ
	7/v1infQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSNT-0000000CL0V-0N0h;
	Wed, 26 Jun 2024 13:07:59 +0000
Date: Wed, 26 Jun 2024 14:07:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Message-ID: <ZnwSrjqHmOzSjShI@casper.infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625211803.2750563-3-willy@infradead.org>

On Tue, Jun 25, 2024 at 10:17:57PM +0100, Matthew Wilcox (Oracle) wrote:
> Rosebush is a resizing hash table.  See
> Docuemntation/core-api/rosebush.rst for details.

I thought I had more debugging enabled than I actually did, and
there's some unbalanced RCU locking.  I'll fold this fix in:

diff --git a/lib/rosebush.c b/lib/rosebush.c
index 47106a04d11d..ab2d314cecec 100644
--- a/lib/rosebush.c
+++ b/lib/rosebush.c
@@ -305,13 +305,14 @@ static int rbh_split_bucket(struct rbh *rbh, struct rbh_bucket *bucket,
 	rcu_read_unlock();
 
 	/* XXX: use slab */
+	err = -ENOMEM;
 	buckets[0] = kmalloc(sizeof(*bucket), GFP_KERNEL);
 	if (!buckets[0])
-		return -ENOMEM;
+		goto nomem;
 	buckets[1] = kmalloc(sizeof(*bucket), GFP_KERNEL);
 	if (!buckets[1]) {
 		kfree(buckets[0]);
-		return -ENOMEM;
+		goto nomem;
 	}
 
 //printk("%s: adding buckets %p %p for hash %d\n", __func__, buckets[0], buckets[1], hash);
@@ -320,6 +321,8 @@ static int rbh_split_bucket(struct rbh *rbh, struct rbh_bucket *bucket,
 	table = (struct rbh_table *)(tagged & (tagged + 1));
 	mask = tagged - (unsigned long)table;
 	hash &= mask;
+
+	err = 0;
 	if (rbh_dereference_protected(table->buckets[hash], rbh) != bucket)
 		goto free;
 
@@ -354,14 +357,17 @@ static int rbh_split_bucket(struct rbh *rbh, struct rbh_bucket *bucket,
 	rbh_resize_unlock(rbh);
 	kvfree_rcu_mightsleep(bucket);
 
+	rcu_read_lock();
 	return 0;
 free:
 	rbh_resize_unlock(rbh);
 //printk("%s: freeing bucket %p\n", __func__, bucket);
-	kfree(buckets[0]);
 	kfree(buckets[1]);
+nomem:
+	kfree(buckets[0]);
 
-	return 0;
+	rcu_read_lock();
+	return err;
 }
 
 static int __rbh_insert(struct rbh *rbh, u32 hash, void *p)

