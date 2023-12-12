Return-Path: <linux-fsdevel+bounces-5691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B938180EE70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD0F1C20C83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3C7318A;
	Tue, 12 Dec 2023 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B++bEOcu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYDemGbn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B++bEOcu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYDemGbn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B6D2;
	Tue, 12 Dec 2023 06:11:13 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF1351FB4F;
	Tue, 12 Dec 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702390271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nbhyN5crR1w3m66kOkHUMah0FU4U4vRvr/vSaOUKo=;
	b=B++bEOcuECOPLUS6gRl1BadE5Ojhg72LI17/Jf8so38UM+0K3tK3EM18zqdte42Rmdahip
	pT2NLWONXbbx1wHqSpSUPrJ6SV/khTkKgkoHLhS3Je5qcEna7m+A0ImkydNS5Hp2KL7ol5
	NGT5IsMbucBv49ZwMiTMIN/MTc8WjGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702390271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nbhyN5crR1w3m66kOkHUMah0FU4U4vRvr/vSaOUKo=;
	b=RYDemGbnXZfKi9uzTsokLLJFp3Q2IBX/Y+6xZm0LlYsd4XpI31h6ZqYPNIYrqGTAdxjsbq
	9DRT+9hTWhL8LpBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702390271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nbhyN5crR1w3m66kOkHUMah0FU4U4vRvr/vSaOUKo=;
	b=B++bEOcuECOPLUS6gRl1BadE5Ojhg72LI17/Jf8so38UM+0K3tK3EM18zqdte42Rmdahip
	pT2NLWONXbbx1wHqSpSUPrJ6SV/khTkKgkoHLhS3Je5qcEna7m+A0ImkydNS5Hp2KL7ol5
	NGT5IsMbucBv49ZwMiTMIN/MTc8WjGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702390271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/nbhyN5crR1w3m66kOkHUMah0FU4U4vRvr/vSaOUKo=;
	b=RYDemGbnXZfKi9uzTsokLLJFp3Q2IBX/Y+6xZm0LlYsd4XpI31h6ZqYPNIYrqGTAdxjsbq
	9DRT+9hTWhL8LpBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B6A8139E9;
	Tue, 12 Dec 2023 14:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lJX+If9peGUGTgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:11:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4786A06E5; Tue, 12 Dec 2023 15:11:10 +0100 (CET)
Date: Tue, 12 Dec 2023 15:11:10 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
	joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org,
	chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
	willy@infradead.org, akpm@linux-foundation.org,
	p.raghav@samsung.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 15/18] buffer: add a new helper to
 read sb block
Message-ID: <20231212141110.4pcetu5ozp3m33qc@quack3>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140753.975297-1-yukuai1@huaweicloud.com>
 <ZXhfRdocHfrViOos@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhfRdocHfrViOos@infradead.org>
X-Spam-Score: 1.39
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B++bEOcu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RYDemGbn;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 R_RATELIMIT(0.00)[to_ip_from(RLa8hd5fybgmzcyr9mhbq8ey7y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[51];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[22.45%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[huaweicloud.com,kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,redhat.com,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,lists.linux.dev,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: 4.79
X-Rspamd-Queue-Id: AF1351FB4F
X-Spam-Flag: NO

On Tue 12-12-23 05:25:25, Christoph Hellwig wrote:
> On Mon, Dec 11, 2023 at 10:07:53PM +0800, Yu Kuai wrote:
> > +static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
> > +{
> > +	/*
> > +	 * If the buffer has the write error flag, data was failed to write
> > +	 * out in the block. In this case, set buffer uptodate to prevent
> > +	 * reading old data.
> > +	 */
> > +	if (buffer_write_io_error(bh))
> > +		set_buffer_uptodate(bh);
> > +	return buffer_uptodate(bh);
> > +}
> 
> So - risking this blows up into a lot of nasty work: Why do we even
> clear the uptodate flag on write errors?  Doing so makes not sense to
> me as the data isn't any less uptodate just because we failed to write
> it..

Historic reasons I'd say (buffer_write_io_error isn't *that* old - from
2003 it seems). And yes, it would make a lot of sense to keep uptodate flag
set and just rely on buffer_write_io_error() but it also means going
through all buffer_uptodate() checks in filesystems and determining which
need changing to buffer_write_io_error() which is something nobody is keen
on doing ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

