Return-Path: <linux-fsdevel+bounces-76442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKq7JkSRhGkh3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:47:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E563EF2C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C501301A395
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5E3D3CFA;
	Thu,  5 Feb 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TRl95ldt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4soEF88X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TRl95ldt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4soEF88X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AD13C918
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295601; cv=none; b=jfMFtSs17BJRDIJwgpaah7iF3/UqmvMq+oih3DFF3eVIevYExzqwrSwFEVGIcMpu++3QIxQCYfhlYsoGgPBZMoc8/WegV0uV3uQfW7I/uBgsaTIAB8UPFTGgIe3tICSn1WKxG3vVpLhupVOqRvyw+C1FFNp46NkDCv8daaojMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295601; c=relaxed/simple;
	bh=OlqSvt3kbAQEnZKyJVl0KhLrrslsUBhZTXyrRZIlrXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+eNHSIB9gh4286rtYGVgUJ6OntVbV+2V8tn6nliCmZpFhjbw5vCO3v5plMM5re0SOyNqMf1iUAwJA3oAgCvuIofYNr39CnySwuDrNEXFPJmzJJ1JiydJVm+mgkyo33VyYCvj+0qEXsACxhWBWx66Dmg0+D+2T1viW308AQyIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TRl95ldt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4soEF88X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TRl95ldt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4soEF88X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E35C3E7BE;
	Thu,  5 Feb 2026 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770295599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Je5VLpD0iKMyLn3VUeOuAVknySQtLEMYXII+8K2luRA=;
	b=TRl95ldtNRl1encWD6NCcdicCw2T85sXGSrcf30xV1vtCHoSZUdXFJFMsvcr7oTCL+QLef
	RVANzGQRym92gVWj6uMn2zRjzqJjbM9XfynwTOxUTE0bbadhhwtXKRThd9T0pf4PVSX428
	6Fi0X2m3uXyYQtOo+zSkbMyTihK6nRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770295599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Je5VLpD0iKMyLn3VUeOuAVknySQtLEMYXII+8K2luRA=;
	b=4soEF88XS70nN/E7cfsOykjbol23a2G/0NzoT/ZYpeDlixJLYxy/5FvVlzQtk2UyYu6AKq
	rNsGvKE5YDHCvwCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TRl95ldt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4soEF88X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770295599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Je5VLpD0iKMyLn3VUeOuAVknySQtLEMYXII+8K2luRA=;
	b=TRl95ldtNRl1encWD6NCcdicCw2T85sXGSrcf30xV1vtCHoSZUdXFJFMsvcr7oTCL+QLef
	RVANzGQRym92gVWj6uMn2zRjzqJjbM9XfynwTOxUTE0bbadhhwtXKRThd9T0pf4PVSX428
	6Fi0X2m3uXyYQtOo+zSkbMyTihK6nRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770295599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Je5VLpD0iKMyLn3VUeOuAVknySQtLEMYXII+8K2luRA=;
	b=4soEF88XS70nN/E7cfsOykjbol23a2G/0NzoT/ZYpeDlixJLYxy/5FvVlzQtk2UyYu6AKq
	rNsGvKE5YDHCvwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261E13EA63;
	Thu,  5 Feb 2026 12:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x6lBCS+RhGlvRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 12:46:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6AFDA09D8; Thu,  5 Feb 2026 13:46:38 +0100 (CET)
Date: Thu, 5 Feb 2026 13:46:38 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, djwong@kernel.org, 
	Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, yangerkun@huawei.com, 
	yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com, libaokun9@gmail.com
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
Message-ID: <xxr5myyy2dkumgqmqk3qpwkkvwiwxntx2ovl6cuxifn7ody4bv@2ni65ps2mhjy>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
 <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
 <4a210be6-eced-4a47-a54b-3f2bc3f3bfbf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a210be6-eced-4a47-a54b-3f2bc3f3bfbf@huawei.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76442-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,huaweicloud.com,infradead.org,vger.kernel.org,dilger.ca,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E563EF2C51
X-Rspamd-Action: no action

On Thu 05-02-26 10:55:59, Baokun Li wrote:
> > I don't see how you want to get rid of data=journal mode - perhaps that's
> > related to the COW functionality?
> 
> Yes. The only real advantage of data=journal mode over data=ordered is
> its guarantee of data atomicity for overwrites.
> 
> If we can achieve this through COW-based software atomic writes, we can
> move away from the performance-heavy data=journal mode.

Hum, I don't think data=journal actually currently offers overwrite
atomicity - even in data=journal mode you can observe only part of the
write completed after a crash. But what it does offer and why people tend
to use it is that it offers strict linear ordering guarantees between all
data and metadata operations happening in the system. Thus if you can prove
that operation A completed before operation B started, then you are
guaranteed that even after crash you will not see B done and A not done.
This is a very strong consistency guarantee that makes life simpler for the
applications so people that can afford the performance cost and care a lot
about crash safety like it.

I think you are correct that with COW and a bit of care it could be
possible to achieve these guarantees even without journalling data. But I'd
need to think more about it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

