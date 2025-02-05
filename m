Return-Path: <linux-fsdevel+bounces-40949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE63A29875
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878A3163D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94F21FCD1F;
	Wed,  5 Feb 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYUUOYCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d1Qnv4EQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OYUUOYCg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d1Qnv4EQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFC13D897;
	Wed,  5 Feb 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779058; cv=none; b=TUm76BYIBBTT48oPq5gM/LgQ9WkYj2AV2ZH1Lyq+IhEBD8T5D+R8bXyYXqkBLOAbh3fbVn4NpKj34TefjfOMMJ39JBhibz9M9Z9LADg44r1UzUKzKL9MUhalRBk0fz0l4YM7s/JwE9vhkY1WkWEGY6Zk/oNQoqaWJbsKoeEZ1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779058; c=relaxed/simple;
	bh=Gdy9Vhztq09MzRQ6HHq+YvEXVWw5ao/tdIpFHqJaSDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCHrfSobo+EYAGARrEyE/vR2U6f7xWPClLS7f4kdnKfrpeUc1/xNdQOLOKVicDeqnveD+Yqq2i0PasD1qcksrw84AFYmO902yb9U9NnyudtPc5blfiZa7rukj1SqvuUcEh9t7/HVIaY8V5xTRMN1d1luBMjjQ3Ut5SmfK16XTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYUUOYCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d1Qnv4EQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OYUUOYCg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d1Qnv4EQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06E9421134;
	Wed,  5 Feb 2025 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzkHlqIqgmLmzb3lgQAO6vMoEyt/Q9ueP+aWRwjkF4c=;
	b=OYUUOYCgYMIQ6aanDg3K22uOFKvOVKVhSGmsVr8Andq2KaQ2nPWM043enS4tE3jaeQzULh
	Ww9cCLZuKbFv5AqB7GE+9ziVS+yKxWendfV4mwJHaNAW0yKTkdJ3nKgYOs8T7qSi5dhlN8
	If4xtmDvrnvEaktDqNn4/fY956ONjF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzkHlqIqgmLmzb3lgQAO6vMoEyt/Q9ueP+aWRwjkF4c=;
	b=d1Qnv4EQpm9bG3SOuRp6ao+v9N3jEpg6JqrVHe/6e1ulBRHVN5Svl9v/f3/efZG4MdmctY
	4Y1bqQE1ImLqr/Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OYUUOYCg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d1Qnv4EQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzkHlqIqgmLmzb3lgQAO6vMoEyt/Q9ueP+aWRwjkF4c=;
	b=OYUUOYCgYMIQ6aanDg3K22uOFKvOVKVhSGmsVr8Andq2KaQ2nPWM043enS4tE3jaeQzULh
	Ww9cCLZuKbFv5AqB7GE+9ziVS+yKxWendfV4mwJHaNAW0yKTkdJ3nKgYOs8T7qSi5dhlN8
	If4xtmDvrnvEaktDqNn4/fY956ONjF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzkHlqIqgmLmzb3lgQAO6vMoEyt/Q9ueP+aWRwjkF4c=;
	b=d1Qnv4EQpm9bG3SOuRp6ao+v9N3jEpg6JqrVHe/6e1ulBRHVN5Svl9v/f3/efZG4MdmctY
	4Y1bqQE1ImLqr/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE16F13694;
	Wed,  5 Feb 2025 18:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6SwbOq2po2eZVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 18:10:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67543A28E9; Wed,  5 Feb 2025 19:10:49 +0100 (CET)
Date: Wed, 5 Feb 2025 19:10:49 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	tytso@mit.edu, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to
 inode_set_cached_link()
Message-ID: <vci2ejpu7eirvku6eg5ajrbsdlpztu2wgvm2n75lkiaenuxw7p@7ag5gflkjhus>
References: <20250205162819.380864-1-mjguzik@gmail.com>
 <20250205172946.GD21791@frogsfrogsfrogs>
 <CAGudoHENg_G7KaJT15bE0wVOT_yXw0yiPPqTf40zm9YzuaUPkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHENg_G7KaJT15bE0wVOT_yXw0yiPPqTf40zm9YzuaUPkw@mail.gmail.com>
X-Rspamd-Queue-Id: 06E9421134
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[48a99e426f29859818c0];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 05-02-25 18:33:23, Mateusz Guzik wrote:
> On Wed, Feb 5, 2025 at 6:29 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Feb 05, 2025 at 05:28:19PM +0100, Mateusz Guzik wrote:
> > > The call to nd_terminate_link() clamps the size to min(i_size,
> > > sizeof(ei->i_data) - 1), while the subsequent call to
> > > inode_set_cached_link() fails the possible update.
> > >
> > > The kernel used to always strlen(), so do it now as well.
> > >
> > > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> > >
> > > Per my comments in:
> > > https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com/#t
> > >
> > > There is definitely a pre-existing bug in ext4 which the above happens
> > > to run into. I suspect the nd_terminate_link thing will disappear once
> > > that gets sorted out.
> > >
> > > In the meantime the appropriate fix for 6.14 is to restore the original
> > > behavior of issuing strlen.
> > >
> > > syzbot verified the issue is fixed:
> > > https://lore.kernel.org/linux-hardening/67a381a3.050a0220.50516.0077.GAE@google.com/T/#m340e6b52b9547ac85471a1da5980fe0a67c790ac
> >
> > Again, this is evidence of inconsistent inode metadata, which should be
> > dealt with by returning EFSCORRUPTED, not arbitrarily truncating the
> > contents of a bad inode.
> >
> 
> I agree, rejecting the inode was something I was advocating for from the get go.
> 
> I don't know if a real patch(tm) will materialize for 6.14, so in the
> meantime I can at least damage-control this back to the original
> state.
> 
> If the ext4 folk do the right fix, I will be delighted to have this
> patch dropped. :)

Yeah, let me cook up proper ext4 fix for this (currently under testing).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

