Return-Path: <linux-fsdevel+bounces-76455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LYcGPCkhGmI3wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 15:10:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127CF3D15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6085630581B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4723EF0DE;
	Thu,  5 Feb 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyRBEduu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QphShRST";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UyRBEduu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QphShRST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A328B7DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300457; cv=none; b=Xjnnci4aMZn/gK2LmZLKT0gxgHDJqu3k0yhXvse8UgPEtinS9p/sPnXR3wVmjxIXBteEZEgCGX1soXqxGD1DkFBhHlXCC9lj2jJ69cpcl+0DRYEnBZc5KhW5ktN8q/8tR5X4kToTe8O7Qx/iwfbMpD9009KxVHXt8Bi659oEmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300457; c=relaxed/simple;
	bh=5hx/cqxHxEpV3jNE2eWt1KVL4Bf8rWrHEGjP6Sfebg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nscba4M8dRH0s069NHQg3YsKcyR8MOh8EBP+eF4KOQ3o0d70P91GxNuq1UZokwB4KzQgy+u4oMxuG16FEVR5g4aF71IgHnyYWuTxWB6z1tyqRiLZLbsD9GIs5jKbFWXWr/zQcSmoOOHx5llD6nWIntWQ4n+B4NOU3dk/UFQI6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyRBEduu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QphShRST; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UyRBEduu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QphShRST; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4FC55BDA6;
	Thu,  5 Feb 2026 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770300455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq5UKb93psP804heOP3D7DfvO9NIXfWiHXqPIFMBhho=;
	b=UyRBEduuoo+ZRw/u2vYWbygcjt0Usn5GPXNdmM6F3iWik2jw6y36uFghgPkZ4iMPW13JSN
	fxlOHLDwjOseyttvZl/vpLQhdIcLZz7/PyKTBrjars1L5SQsapDrU7d/bXtEXOCE04bIaq
	TmXetB1kGWhTcnOZNUEl00fKSYluDZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770300455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq5UKb93psP804heOP3D7DfvO9NIXfWiHXqPIFMBhho=;
	b=QphShRSTc7osdvPdjxz67EuFyWBdwTazuktpTLrN7H4grSUBcUgQvJu5AaukBqpl4K9qPq
	e+cqeDCgIq3EYoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770300455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq5UKb93psP804heOP3D7DfvO9NIXfWiHXqPIFMBhho=;
	b=UyRBEduuoo+ZRw/u2vYWbygcjt0Usn5GPXNdmM6F3iWik2jw6y36uFghgPkZ4iMPW13JSN
	fxlOHLDwjOseyttvZl/vpLQhdIcLZz7/PyKTBrjars1L5SQsapDrU7d/bXtEXOCE04bIaq
	TmXetB1kGWhTcnOZNUEl00fKSYluDZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770300455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq5UKb93psP804heOP3D7DfvO9NIXfWiHXqPIFMBhho=;
	b=QphShRSTc7osdvPdjxz67EuFyWBdwTazuktpTLrN7H4grSUBcUgQvJu5AaukBqpl4K9qPq
	e+cqeDCgIq3EYoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAFFB3EA63;
	Thu,  5 Feb 2026 14:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDW3KSekhGmVUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 14:07:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 637BDA09D8; Thu,  5 Feb 2026 15:07:35 +0100 (CET)
Date: Thu, 5 Feb 2026 15:07:35 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org, 
	Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, yangerkun@huawei.com, yukuai@fnnas.com, 
	libaokun9@gmail.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <s434ifpengcthkmohmc6vvmvppx4o2k2ctk2p3it55ncgce3je@irbt7xpdnnzu>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <9b7e93da-65dd-4574-be7f-4ec88bce4da7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7e93da-65dd-4574-be7f-4ec88bce4da7@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76455-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.cz,huaweicloud.com,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0127CF3D15
X-Rspamd-Action: no action

On Thu 05-02-26 11:27:09, Baokun Li wrote:
> On 2026-02-04 22:18, Jan Kara wrote:
> > Hi Zhang!
> >
> > On Wed 04-02-26 14:42:46, Zhang Yi wrote:
> >> On 2/3/2026 5:59 PM, Jan Kara wrote:
> >>> On Tue 03-02-26 14:25:03, Zhang Yi wrote:
> >>>> Currently, __ext4_block_zero_page_range() is called in the following
> >>>> four cases to zero out the data in partial blocks:
> >>>>
> >>>> 1. Truncate down.
> >>>> 2. Truncate up.
> >>>> 3. Perform block allocation (e.g., fallocate) or append writes across a
> >>>>    range extending beyond the end of the file (EOF).
> >>>> 4. Partial block punch hole.
> >>>>
> >>>> If the default ordered data mode is used, __ext4_block_zero_page_range()
> >>>> will write back the zeroed data to the disk through the order mode after
> >>>> zeroing out.
> >>>>
> >>>> Among the cases 1,2 and 3 described above, only case 1 actually requires
> >>>> this ordered write. Assuming no one intentionally bypasses the file
> >>>> system to write directly to the disk. When performing a truncate down
> >>>> operation, ensuring that the data beyond the EOF is zeroed out before
> >>>> updating i_disksize is sufficient to prevent old data from being exposed
> >>>> when the file is later extended. In other words, as long as the on-disk
> >>>> data in case 1 can be properly zeroed out, only the data in memory needs
> >>>> to be zeroed out in cases 2 and 3, without requiring ordered data.
> >>> Hum, I'm not sure this is correct. The tail block of the file is not
> >>> necessarily zeroed out beyond EOF (as mmap writes can race with page
> >>> writeback and modify the tail block contents beyond EOF before we really
> >>> submit it to the device). Thus after this commit if you truncate up, just
> >>> zero out the newly exposed contents in the page cache and dirty it, then
> >>> the transaction with the i_disksize update commits (I see nothing
> >>> preventing it) and then you crash, you can observe file with the new size
> >>> but non-zero content in the newly exposed area. Am I missing something?
> >>>
> >> Well, I think you are right! I missed the mmap write race condition that
> >> happens during the writeback submitting I/O. Thank you a lot for pointing
> >> this out. I thought of two possible solutions:
> >>
> >> 1. We also add explicit writeback operations to the truncate-up and
> >>    post-EOF append writes. This solution is the most straightforward but
> >>    may cause some performance overhead. However, since at most only one
> >>    block is written, the impact is likely limited. Additionally, I
> >>    observed that the implementation of the XFS file system also adopts a
> >>    similar approach in its truncate up and down operation. (But it is
> >>    somewhat strange that XFS also appears to have the same issue with
> >>    post-EOF append writes; it only zero out the partial block in
> >>    xfs_file_write_checks(), but it neither explicitly writeback zeroed
> >>    data nor employs any other mechanism to ensure that the zero data
> >>    writebacks before the metadata is written to disk.)
> >>
> >> 2. Resolve this race condition, ensure that there are no non-zero data
> >>    in the post-EOF partial blocks on the disk. I observed that after the
> >>    writeback holds the folio lock and calls folio_clear_dirty_for_io(),
> >>    mmap writes will re-trigger the page fault. Perhaps we can filter out
> >>    the EOF folio based on i_size in ext4_page_mkwrite(),
> >>    block_page_mkwrite() and iomap_page_mkwrite(), and then call
> >>    folio_wait_writeback() to wait for this partial folio writeback to
> >>    complete. This seems can break the race condition without introducing
> >>    too much overhead (no?).
> >>
> >> What do you think? Any other suggestions are also welcome.
> > Hum, I like the option 2 because IMO non-zero data beyond EOF is a
> > corner-case quirk which unnecessarily complicates rather common paths. But
> > I'm not sure we can easily get rid of it. It can happen for example when
> > you do appending write inside a block. The page is written back but before
> > the transaction with i_disksize update commits we crash. Then again we have
> > a non-zero content inside the block beyond EOF.
> >
> > So the only realistic option I see is to ensure tail of the block gets
> > zeroed on disk before the transaction with i_disksize update commits in the
> > cases of truncate up or write beyond EOF. data=ordered mode machinery is an
> > asynchronous way how to achieve this. We could also just synchronously
> > writeback the block where needed but the latency hit of such operation is
> > going to be significant so I'm quite sure some workload somewhere will
> > notice although the truncate up / write beyond EOF operations triggering this
> > are not too common. So why do you need to get rid of these data=ordered
> > mode usages? I guess because with iomap keeping our transaction handle ->
> > folio lock ordering is complicated? Last time I looked it seemed still
> > possible to keep it though.
> >
> > Another possibility would be to just *submit* the write synchronously and
> > use data=ordered mode machinery only to wait for IO to complete before the
> > transaction commits. That way it should be safe to start a transaction
> > while holding folio lock and thus the iomap conversion would be easier.
> >
> > 								Honza
> 
> Can we treat EOF blocks as metadata and update them in the same
> transaction as i_disksize? Although this would introduce some
> management and journaling overhead, it could avoid the deadlock
> of "writeback -> start handle -> trigger writeback".

No, IMHO that would get too difficult. Just look at the hoops data=journal
mode has to jump through to make page cache handling work with the
journalling machinery. And you'd now have that for all the inodes. So I
think some form of data=ordered machinery is much simpler to reason about.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

