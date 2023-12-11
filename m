Return-Path: <linux-fsdevel+bounces-5532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C080D2D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A6D1F21855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF24D11B;
	Mon, 11 Dec 2023 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KF7fZ16G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55atrZPO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KF7fZ16G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55atrZPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20EB3;
	Mon, 11 Dec 2023 08:52:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A65722413;
	Mon, 11 Dec 2023 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702313538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKyChubYQOLUssFrI8/z8khe3/ZNZIgTAEz8GE5ZHf8=;
	b=KF7fZ16GGZSNVIercO+eYb/zdHDuObhA9Onxa81BeqL3LeXtWEzJu+HqGO1kfleK3MMb9x
	jUugKN6DhI5mx4QzBnf4JH10nshySFJYQzot/cnv9bMAHLqxdYshFuHfymm3WHOgnJ+pWp
	7mgLY2fOp0ANNoP3kZ8g+YQPQxBLCuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702313538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKyChubYQOLUssFrI8/z8khe3/ZNZIgTAEz8GE5ZHf8=;
	b=55atrZPOIWUHCEdWSl7m1h0isEhBA3PJTsKW7m5NfRjFtXZtvlPhx1kYCCQxQNMKERbIiQ
	03X5sRIKKKs3qZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702313538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKyChubYQOLUssFrI8/z8khe3/ZNZIgTAEz8GE5ZHf8=;
	b=KF7fZ16GGZSNVIercO+eYb/zdHDuObhA9Onxa81BeqL3LeXtWEzJu+HqGO1kfleK3MMb9x
	jUugKN6DhI5mx4QzBnf4JH10nshySFJYQzot/cnv9bMAHLqxdYshFuHfymm3WHOgnJ+pWp
	7mgLY2fOp0ANNoP3kZ8g+YQPQxBLCuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702313538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKyChubYQOLUssFrI8/z8khe3/ZNZIgTAEz8GE5ZHf8=;
	b=55atrZPOIWUHCEdWSl7m1h0isEhBA3PJTsKW7m5NfRjFtXZtvlPhx1kYCCQxQNMKERbIiQ
	03X5sRIKKKs3qZCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 26D01134B0;
	Mon, 11 Dec 2023 16:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1uB1CUI+d2XzFAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 16:52:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A24EDA07E3; Mon, 11 Dec 2023 17:52:17 +0100 (CET)
Date: Mon, 11 Dec 2023 17:52:17 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
	konishi.ryusuke@gmail.com, willy@infradead.org,
	akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 01/18] block: add some bdev apis
Message-ID: <20231211165217.fil437byq7w2vcp7@quack3>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140552.973290-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140552.973290-2-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Spam-Score: -1.58
X-Spamd-Result: default: False [-1.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.96)[94.82%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLg7z3ka1nnoi3zj4x13ixbdfk)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[50];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,redhat.com,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,lists.linux.dev,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.26
Authentication-Results: smtp-out1.suse.de;
	none

On Mon 11-12-23 22:05:35, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Those apis will be used for other modules, so that bd_inode won't be
> accessed directly from other modules.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

...

> +void bdev_associated_mapping(struct block_device *bdev,
> +			     struct address_space *mapping)
> +{
> +	mapping->host = bdev->bd_inode;
> +}

Here I'm not sure - is the helper really a win? It seems a bit obscure to
me. This initialization of another mapping for a bdev looks really special.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

