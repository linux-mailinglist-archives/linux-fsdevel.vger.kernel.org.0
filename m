Return-Path: <linux-fsdevel+bounces-79506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL3+C3SuqWn+CAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:25:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C621564E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51CB53002F57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A43CE488;
	Thu,  5 Mar 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+4RAIir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lw8ztmxw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+4RAIir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lw8ztmxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6139F181
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727915; cv=none; b=svNK3cW+VpJVIay2WNvtv5nEt6ka3M8V0fC+yR4T6X+aMvUzX13/CTEInGQ0E26JA0VXM+EZKOb3usUYks7oJZJ8G4n3lrUordzgp4ZXGHeTz5gXc7NX8KGu1a+ytpRmDSo2rhK6nMquPtds1yQCSwl9GgDA2oLUwpa8HcP7ENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727915; c=relaxed/simple;
	bh=Ry2aeVw+sOdu/a7gUi0TJvqFAqOSkhPnjSkI/QlZ7ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCdZNJFmgJNZOs83buNDLpCDRq/1jQuv0FNAiOxHfAgA2Cbjz/bubhGizlOmqw8pTE69zvCU0hiqlzH1DPKOmBSMc1lNDG01mI3icYUAhd/NbpSwz6bgq6NA9aJKyfP/SHfqmOHOqAMChXOw8nDruTWqhWrgFC+uiZTyk3Om5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+4RAIir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lw8ztmxw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+4RAIir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lw8ztmxw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 747055BD0A;
	Thu,  5 Mar 2026 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8pGZQYxiUwSuJ7FDd38iB99LH7LuXz309mskHRqXZ8=;
	b=2+4RAIirMnd079VjgxNdQ+WhBPJIG6qFlRH38xVHshJ+BCiI+HappKXxbfEG2SdE6cgh1F
	3cqgO+ZpNVqU0D2MZ94fRGOaYDNlUB7SC8fBM0S3aGWFE/3UGy0q55QbiawBRVob9uR2qA
	k6Oq4NkjJVOzDdmdZShqobUXNM/b8+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8pGZQYxiUwSuJ7FDd38iB99LH7LuXz309mskHRqXZ8=;
	b=lw8ztmxw8oFgrhLWMhjRYKEl2VMALU5IC7O1566rTsJE4ol4G6bDJnZGsOq/6FBvfHW4I0
	sFNxmIUMnxfFXPAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2+4RAIir;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lw8ztmxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8pGZQYxiUwSuJ7FDd38iB99LH7LuXz309mskHRqXZ8=;
	b=2+4RAIirMnd079VjgxNdQ+WhBPJIG6qFlRH38xVHshJ+BCiI+HappKXxbfEG2SdE6cgh1F
	3cqgO+ZpNVqU0D2MZ94fRGOaYDNlUB7SC8fBM0S3aGWFE/3UGy0q55QbiawBRVob9uR2qA
	k6Oq4NkjJVOzDdmdZShqobUXNM/b8+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8pGZQYxiUwSuJ7FDd38iB99LH7LuXz309mskHRqXZ8=;
	b=lw8ztmxw8oFgrhLWMhjRYKEl2VMALU5IC7O1566rTsJE4ol4G6bDJnZGsOq/6FBvfHW4I0
	sFNxmIUMnxfFXPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69FAA3EA68;
	Thu,  5 Mar 2026 16:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MKHdGWiuqWlycAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 16:25:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B2F2A0A8D; Thu,  5 Mar 2026 17:25:12 +0100 (CET)
Date: Thu, 5 Mar 2026 17:25:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 31/32] kvm: Use private inode list instead of
 i_private_list
Message-ID: <f45xf3bgzioldigntjshfl44jj2pqbewtbyesmoxv4blm4dz4f@35t3bco6hfys>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-63-jack@suse.cz>
 <aag2yYtENaE3SFwF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aag2yYtENaE3SFwF@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 2E1C621564E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79506-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 05:42:33, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 11:34:20AM +0100, Jan Kara wrote:
> > Instead of using mapping->i_private_list use a list in private part of
> > the inode.
> 
> Similarly here, I'd be this toward the front with all the other
> switching from i_private_list to private members.

OK, moved.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

