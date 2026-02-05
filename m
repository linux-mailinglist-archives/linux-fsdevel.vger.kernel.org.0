Return-Path: <linux-fsdevel+bounces-76456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLUVJmKyhGk54wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 16:08:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33891F469E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 16:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FC41303FF39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A34218BF;
	Thu,  5 Feb 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdXI8sn1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MP3YT2lZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JuXF6GmV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2kLE0oCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453B421898
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303907; cv=none; b=I4+xxf+iohj5Jzfbq2JTI5YZ4oOrSroFGagYbvmPgFhciT0ckJj38SaO5h4uugLC06oyPSvyb3AT0I8706esZFbcRK7Uk7KJqU2X7CTTcFEq46OIWFyEXC4xWj1km1ITV5j2DIWNBZ2rJ2/Jde41MvY4a1GADSnBD/5WJRpO9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303907; c=relaxed/simple;
	bh=CQVGDFGlYChlB6R/V8lpFRIVjPSDDbr/hQZhWutKJo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQht7J9U4FEW8M9641Inc104t5bT3UEJ/dISV0CBM/iZLm4aL6ksIy8AV5P4s16RFkCp9dEoavdr2mmBP9eZzhiUYdoOQOJ7MM08Z0Csr8B+i8tWXv3A+AtPA/cL9r/8TTRR7e4DYjSaNH1bwEsjKXyqMhkXGjkINRubVy7ZfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdXI8sn1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MP3YT2lZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JuXF6GmV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2kLE0oCe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D944A5BDF8;
	Thu,  5 Feb 2026 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770303904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7FW08JmrXETMvKSav2pEuT5459pQgITKDvu+HUXeXQ=;
	b=wdXI8sn1u329MglYquRKUBQ7rEG8U/a3BqG0Dv5OmqNTIxafxE0LBoZcYHFlobGSdo2c89
	/FurjeMpwZGVeqCHpHa20z7sk4d1WszT5Zhy43W13eYq+4mnTY9k+0js3z3qmAcgLecA6G
	5ospzJzKSG0KjNwVl4f6kOpHjdX5IBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770303904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7FW08JmrXETMvKSav2pEuT5459pQgITKDvu+HUXeXQ=;
	b=MP3YT2lZhz9vD6o447tK9easX5Fe2zzG3ngl0zfgoIZmeSWL3a8DaRjPtjoHO5x51jH9wV
	P+nmokZqFCkDNzBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JuXF6GmV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2kLE0oCe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770303903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7FW08JmrXETMvKSav2pEuT5459pQgITKDvu+HUXeXQ=;
	b=JuXF6GmVXyMmynDtlvPSo/4FeYNi9lsCY+ex4bvOcvCJEDA3qiYCFeoRlnYU3AZrXueUOq
	Y/LCFxFq73bUETBjo8odUDVNDSHBb5xYYiZ1hYn/os2o5auuBff1iC11R1kqYkLzTK/+xS
	uVKD2HSLBFGsjfuK0At1pVa9OAlskpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770303903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7FW08JmrXETMvKSav2pEuT5459pQgITKDvu+HUXeXQ=;
	b=2kLE0oCeKGzbRJqygPnVzFypwN4vZcPkBaCCsFp5ZT8Se2xROgvDYo7crUMXy6wtN/wIfs
	8bP/uHBAD8Jt1tAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC3583EA63;
	Thu,  5 Feb 2026 15:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HN/mLZ6xhGkQawAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 15:05:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E4C2A09D8; Thu,  5 Feb 2026 16:05:02 +0100 (CET)
Date: Thu, 5 Feb 2026 16:05:02 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org, 
	djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76456-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 33891F469E
X-Rspamd-Action: no action

On Thu 05-02-26 15:50:38, Zhang Yi wrote:
> On 2/4/2026 10:18 PM, Jan Kara wrote:
> > So why do you need to get rid of these data=ordered
> > mode usages? I guess because with iomap keeping our transaction handle ->
> > folio lock ordering is complicated? Last time I looked it seemed still
> > possible to keep it though.
> 
> Yes, that's one reason. There's another reason is that we also need to
> implement partial folio submits for iomap.
> 
> When the journal process is waiting for a folio to be written back
> (which contains an ordered block), and the folio also contains unmapped
> blocks with a block size smaller than the folio size, if the regular
> writeback process has already started committing this folio (and set the
> writeback flag), then a deadlock may occur while mapping the remaining
> unmapped blocks. This is because the writeback flag is cleared only
> after the entire folio are processed and committed. If we want to support
> partial folio submit for iomap, we need to be careful to prevent adding
> additional performance overhead in the case of severe fragmentation.

Yeah, this logic is currently handled by ext4_bio_write_folio(). And the
deadlocks are currently resolved by grabbing transaction handle before we
go and lock any page for writeback. But I agree that with iomap it may be
tricky to keep this scheme.

> Therefore, this aspect of the logic is complicated and subtle. As we
> discussed in patch 0, if we can avoid using the data=ordered mode in
> append write and online defrag, then this would be the only remaining
> corner case. I'm not sure if it is worth implementing this and adjusting
> the lock ordering.
> 
> > Another possibility would be to just *submit* the write synchronously and
> > use data=ordered mode machinery only to wait for IO to complete before the
> > transaction commits. That way it should be safe to start a transaction
> 
> IIUC, this solution seems can avoid adjusting the lock ordering, but partial
> folio submission still needs to be implemented, is my understanding right?
> This is because although we have already submitted this zeroed partial EOF
> block, when the journal process is waiting for this folio, this folio is
> being written back, and there are other blocks in this folio that need to be
> mapped.

That's a good question. If we submit the tail folio from truncation code,
we could just submit the full folio write and there's no need to restrict
ourselves only to mapped blocks. But you are correct that if this IO
completes but the folio had holes in it and the hole gets filled in by
write before the transaction with i_disksize update commits, jbd2 commit
could still race with flush worker writing this folio again and the
deadlock could happen. Hrm...

So how about the following: We expand our io_end processing with the
ability to journal i_disksize updates after page writeback completes. Then
when doing truncate up or appending writes, we keep i_disksize at the old
value and just zero folio tails in the page cache, mark the folio dirty and
update i_size. When submitting writeback for a folio beyond current
i_disksize we make sure writepages submits IO for all the folios from
current i_disksize upwards. When io_end processing happens after completed
folio writeback, we update i_disksize to min(i_size, end of IO). This
should take care of non-zero data exposure issues and with "delay map"
processing Baokun works on all the inode metadata updates will happen after
IO completion anyway so it will be nicely batched up in one transaction.
It's a big change but so far I think it should work. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

