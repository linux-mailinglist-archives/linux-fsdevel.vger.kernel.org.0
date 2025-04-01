Return-Path: <linux-fsdevel+bounces-45479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA0A78425
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 23:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3609616C50E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749641EF378;
	Tue,  1 Apr 2025 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Tpv1vXyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915461E571A;
	Tue,  1 Apr 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743544199; cv=pass; b=cnf/bThPyqKxskh5l5ZFvAJAIWvIg6dXbJtkJaL4mvjAR98YDkQfVqeKJqU5r4dNt1MtnfxNdziJ2yMIrVTK39GGE9poff92p0exNEJWm44Gv5qNJBlA92kUpeoCrj4IBigKruFQZ3Hg/9KstoxaJo/otbiziepbQQ8HcR0Bamo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743544199; c=relaxed/simple;
	bh=Ee7ZhrYrrPHbAR83ceWSSd6J0FdhYVvcZcaZgQUsS6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQccWjslaXpnmP+zCFp9bGz5Fp5m5oMgmx7BnerC716ZJfDQkBUK2KSbLA9utJYCHRZjFbp9zOIlEoOpZdRTBG3JZft2qyL6AAJB46TvH7u+x5FT3oNgKvaz4atotlaGFpTN8sS097TATHB7py955drHpD8unAows5jkZdtywjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Tpv1vXyP; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B403E182C1C;
	Tue,  1 Apr 2025 21:49:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.125.203.131])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24643182A7B;
	Tue,  1 Apr 2025 21:49:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743544196; a=rsa-sha256;
	cv=none;
	b=nichnOZxr1pyxuOeQ+iX6n/n3yRMk73ZWDnCx4p1tzBUqZWUjmZfJDXQe4BYVPooYiWPgo
	iWR74060YGORvfdPgijP1hTCHX3tUfIb86pbA8RATZfs2p4xHpxF7dYuhKpCS7QvdONua0
	Iyx6DvqnM70pyY37c2Y/ujeTOPnaUDNQf+b0egh9C4BEbs0JwPZfxK9DOpO60mkG/LaPoM
	bde1WbyHb4F1xa+UI3yg+2WzwUQhUGXJSykoQrLkSgqci0iRg5N8jKQEdomEgCAqTi3xjz
	tXDb4cW1YsBqoJUNjGtj3sUS8u4aXGBQZ1jK0zLsytHRkTyMdDroS0Kal1ToKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743544196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sGlWmBOhS2CwuQbgKM4hR9ROVp92Ooxj6PLZQlRbhm4=;
	b=ye//Cm2L8aQZ0+DhVtlEacagJmMjBP2Tnx4d8fveuFzyQgd/7i6mACjRETwUKhR2WvYhdQ
	sy/GwdwBJhWz7snEqwje0yfq7v8z8aF3ZoNeRHnmw0h1QwzUC5gQs+wCVt6yl7AsCTA3JR
	jM7JXqg3wmQiZ1IvsNCUB1J1XGq71LHh7+2dnTBAqMBvGJedfi8KJncaVXIAbpc9/OldK2
	I4c/XOodj9wT+AdyqfMdQlS89NDHG7LH7TGVHjb8Nut5ks8zkKcdqMr+AjPEO9BDDTLMXF
	bZYlIi0hbHn1DODHX+OwFEURusTXdhQli6udQ1RZV2iI+thK1qel7y+dwbbxjg==
ARC-Authentication-Results: i=1;
	rspamd-7668cf9b8d-8g8x5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Left: 768fd03f78a578da_1743544196578_3753900963
X-MC-Loop-Signature: 1743544196578:1801671722
X-MC-Ingress-Time: 1743544196578
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.203.131 (trex/7.0.3);
	Tue, 01 Apr 2025 21:49:56 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4ZS1r25qzFzK5;
	Tue,  1 Apr 2025 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1743544196;
	bh=sGlWmBOhS2CwuQbgKM4hR9ROVp92Ooxj6PLZQlRbhm4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Tpv1vXyPmlYXrkZB6HH2lFjD1Ul4RH/H7pNsJmiOjDiQYQgb+QhJYhYsTB56Bu6cS
	 FE6AiFUBIJpUFD8x1fdSHuRTdSpSdTe8pSUxKNIstEmp9FtRXRSdEMIJimM1EZHfQ0
	 KbymcGPVJAId3EIfDw8vBX6yARkZm2mLaC09GmDfytO9rXlgpyi0850wK1JQadcuPK
	 KZ2MY+1VUIIjsHnL7ZGOlyt9vPqITfPx060uUnGwaqklpbmyBdsOlnbIBEKYUCFToi
	 MLRwfQc6zddBq7YHe06qwKlP9pxq9wZgb+8nU25wdnIXRb41VmMe+c/G9uuO6WGX4Y
	 ZM8SdIs8UvRTg==
Date: Tue, 1 Apr 2025 14:49:51 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <20250401214951.kikcrmu5k3q6qmcr@offworld>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
User-Agent: NeoMutt/20220429

On Tue, 01 Apr 2025, Jan Kara wrote:

>I find this problematic. It fixes the race with migration, alright
>(although IMO we should have a comment very well explaining the interplay
>of folio lock and mapping->private_lock to make this work - probably in
>buffer_migrate_folio_norefs() - and reference it from here), but there are
>places which expect that if __find_get_block() doesn't return anything,
>this block is not cached in the buffer cache. And your change breaks this
>assumption. Look for example at write_boundary_block(), that will fail to
>write the block it should write if it races with someone locking the folio
>after your changes. Similarly the code tracking state of deleted metadata
>blocks in fs/jbd2/revoke.c will fail to properly update buffer's state if
>__find_get_block() suddently starts returning NULL although the buffer is
>present in cache.

Yeah - one thing I was thinking about, _iff_ failing lookups (__find_get_block()
returning nil) during migration is in fact permitted, was adding a BH_migrate
flag and serialize vs __buffer_migrate_folio() entirely. Semantically there
are no users, and none are added during this window, but as a consequence I
suppose one thread could see the page not cached, act upon that, then see it
cached once the migration is done and get confused(?). So I don't see a problem
here for write_boundary_block() specifically, but I'm probably overlooking others.

Now, if bailing on the lookup is not an option, meaning it must wait for the
migration to complete, I'm not sure large folios will ever be compatible with
the "Various filesystems appear to want __find_get_block to be non-blocking."
comment.

So the below could be tucked in for norefs only (because this is about the addr
space i_private_lock), but this also shortens the hold time; if that matters
at all, of course, vs changing the migration semantics.

Thanks,
Davidlohr

---8<----------------------------
diff --git a/fs/buffer.c b/fs/buffer.c
index cc8452f60251..f585339ae2e4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -208,6 +208,14 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
	head = folio_buffers(folio);
	if (!head)
		goto out_unlock;
+
+	bh = head;
+	do {
+		if (test_bit(BH_migrate, &bh->b_state))
+			goto out_unlock;
+		bh = bh->b_this_page;
+	} while (bh != head);
+
	bh = head;
	do {
		if (!buffer_mapped(bh))
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 932139c5d46f..e956a1509a05 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -34,6 +34,7 @@ enum bh_state_bits {
	BH_Meta,	/* Buffer contains metadata */
	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
	BH_Defer_Completion, /* Defer AIO completion to workqueue */
+	BH_migrate,     /* Buffer is being migrated */

	BH_PrivateStart,/* not a state bit, but the first bit available
			 * for private allocation by other entities
diff --git a/mm/migrate.c b/mm/migrate.c
index a073eb6c5009..0ffa8b478fd3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -846,6 +846,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
	if (!buffer_migrate_lock_buffers(head, mode))
		return -EAGAIN;

+	bh = head;
+	do {
+		set_bit(BH_migrate, &bh->b_state);
+		bh = bh->b_this_page;
+	} while (bh != head);
+
	if (check_refs) {
		bool busy;
		bool invalidated = false;
@@ -861,12 +867,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
			}
			bh = bh->b_this_page;
		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
		if (busy) {
			if (invalidated) {
				rc = -EAGAIN;
				goto unlock_buffers;
			}
-			spin_unlock(&mapping->i_private_lock);
			invalidate_bh_lrus();
			invalidated = true;
			goto recheck_buffers;
@@ -884,10 +890,9 @@ static int __buffer_migrate_folio(struct address_space *mapping,
	} while (bh != head);

  unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
	bh = head;
	do {
+		clear_bit(BH_migrate, &bh->b_state)
		unlock_buffer(bh);
		bh = bh->b_this_page;
	} while (bh != head);

