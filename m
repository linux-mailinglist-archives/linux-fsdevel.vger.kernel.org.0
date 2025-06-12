Return-Path: <linux-fsdevel+bounces-51430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F419AD6C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AA47A8942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D522DF84;
	Thu, 12 Jun 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4g2x00U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lazIq7L/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDQWFtwP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V15LNSs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C43217704
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721753; cv=none; b=SXr7J+PMeBw3g+j/0ChIG4myvZuN5vOeAZWZEcdCNc0efHRSmtuH6dP74gs3Xr5x43SlqK2vcncESMaS20vSgs+jmqZ4mSxMo61fYYywcT4TRGAFDD+3Qs6uYQ2pLI8DNjejpII9zQlDrvg2ROQ1oEeXHjnRXeTrpFwQY8cFnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721753; c=relaxed/simple;
	bh=YD67daV/sh0oAnENBZMV2vwdUfWUI981+DHZ4CztA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir7On3q04D5TEL23GN/XGyZorm9VHHU0yMld1pHe/bWqs+IKGfv4pphaSCaU4rpJtVZQi/69qJNsMPi2rSC1fLYngJ/XGLCKG1Ek7gAFpKbInUiyC8AgqAa8vJLm1K29wVn6gaO+neh+vDKXeuK4Xy2ZZtEX5iE3TqSP6eq45K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4g2x00U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lazIq7L/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDQWFtwP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V15LNSs7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B297F202B8;
	Thu, 12 Jun 2025 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749721750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aQoZ9hateQPHSja0+LHPW8SP7JLzubYSoax7mQaH9k=;
	b=Q4g2x00U1KTyQJsb6R494Mr0EnvI/sRN7SbLlUy1Doyf1pwNawRtURcYCy8yvf9Uin+Eqi
	6oJi0fFSw1RO5CJ7j6joyvyPVD/q3YYsbsJyaDMWYmirPg5IrCRw/H2r3RPYL/VeIMpw09
	U/i7h5M9DcqBJu4Sf/H90qZYZOTYSek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749721750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aQoZ9hateQPHSja0+LHPW8SP7JLzubYSoax7mQaH9k=;
	b=lazIq7L/Qqx7hNXl+D2fwX28XaINqV9rlbAmDCRw2Am5Sf449/fizVEHjHkKq+K8r/2NOj
	inoO/DcbB7kTdTCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KDQWFtwP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V15LNSs7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749721748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aQoZ9hateQPHSja0+LHPW8SP7JLzubYSoax7mQaH9k=;
	b=KDQWFtwP0sZX3fPFwiVLZTfCokfoYLQFwP68ioULjmnK/9QPkzhEbVt5o9S7DhwEOo6sgf
	yUW1UZpRjiVGwBVKgb+YiUmPwZWaZI3TIberMtFTkeHm0Yl88iVwRVbwcPj1CUa8sk4tDY
	oduK3GA7jxHg7JcHu5R2G9COvsmmCcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749721748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aQoZ9hateQPHSja0+LHPW8SP7JLzubYSoax7mQaH9k=;
	b=V15LNSs7Ab8jhGwEs70ZDCvS1Xw77jHF2VukAgpKr2Us17voozes7boppxCnKrgzF32vCJ
	RAWeCLmcSCQM3FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A34CE132D8;
	Thu, 12 Jun 2025 09:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XnSVJ5SiSmg2RgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 09:49:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 547A1A099E; Thu, 12 Jun 2025 11:49:08 +0200 (CEST)
Date: Thu, 12 Jun 2025 11:49:08 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, NeilBrown <neil@brown.name>, Jan Kara <jack@suse.cz>, 
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, 
	gnoack@google.com
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <zlpjk36aplguzvc2feyu4j5levmbxlzwvrn3bo5jpsc5vjztm2@io27pkd44pow>
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
 <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
 <20250611.Bee1Iohoh4We@digikod.net>
 <CAPhsuW6jZxRBEgz00KV4SasiMhBGyMHoP5dMktoyCOeMbJwmgg@mail.gmail.com>
 <e7115b18-84fc-4e8f-afdb-0d3d3e574497@maowtm.org>
 <CAPhsuW4LfhtVCe8Kym4qM6s-7n5rRMY-bBkhwoWU7SPGQdk=bw@mail.gmail.com>
 <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <csh2jbt5gythdlqps7b4jgizfeww6siuu7de5ftr6ygpnta6bd@umja7wbmnw7j>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B297F202B8
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[maowtm.org,digikod.net,brown.name,suse.cz,vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,google.com,toxicpanda.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 12-06-25 11:01:16, Jan Kara wrote:
> On Wed 11-06-25 11:08:30, Song Liu wrote:
> > On Wed, Jun 11, 2025 at 10:50 AM Tingmao Wang <m@maowtm.org> wrote:
> > [...]
> > > > I think we will need some callback mechanism for this. Something like:
> > > >
> > > > for_each_parents(starting_path, root, callback_fn, cb_data, bool try_rcu) {
> > > >    if (!try_rcu)
> > > >       goto ref_walk;
> > > >
> > > >    __read_seqcount_begin();
> > > >     /* rcu walk parents, from starting_path until root */
> > > >    walk_rcu(starting_path, root, path) {
> > > >     callback_fn(path, cb_data);
> > > >   }
> > > >   if (!read_seqcount_retry())
> > > >     return xxx;  /* successful rcu walk */
> > > >
> > > > ref_walk:
> > > >   /* ref walk parents, from starting_path until root */
> > > >    walk(starting_path, root, path) {
> > > >     callback_fn(path, cb_data);
> > > >   }
> > > >   return xxx;
> > > > }
> > > >
> > > > Personally, I don't like this version very much, because the callback
> > > > mechanism is not very flexible, and it is tricky to use it in BPF LSM.
> > >
> > > Aside from the "exposing mount seqcounts" problem, what do you think about
> > > the parent_iterator approach I suggested earlier?  I feel that it is
> > > better than such a callback - more flexible, and also fits in right with
> > > the BPF API you already designed (i.e. with a callback you might then have
> > > to allow BPF to pass a callback?).  There are some specifics that I can
> > > improve - Mickaël suggested some in our discussion:
> > >
> > > - Letting the caller take rcu_read_lock outside rather than doing it in
> > > path_walk_parent_start
> > >
> > > - Instead of always requiring a struct parent_iterator, allow passing in
> > > NULL for the iterator to path_walk_parent to do a reference walk without
> > > needing to call path_walk_parent_start - this way might be simpler and
> > > path_walk_parent_start/end can just be for rcu case.
> > >
> > > but what do you think about the overall shape of it?
> > 
> > Personally, I don't have strong objections to this design. But VFS
> > folks may have other concerns with it.
> 
> From what I've read above I'm not sure about details of the proposal but I
> don't think mixing of RCU & non-RCU walk in a single function / iterator is
> a good idea. IMHO the code would be quite messy. After all we have
> follow_dotdot_rcu() and follow_dotdot() as separate functions for a reason.
> Also given this series went through several iterations and we don't yet
> have an acceptable / correct solution suggests getting even the standard
> walk correct is hard enough. RCU walk is going to be only worse. So I'd
> suggest to get the standard walk finished and agreed on first and
> investigate feasibility of RCU variant later.

OK, I've now read some of Tingmaon's and Christian's replies which I've
missed previously so I guess I now better understand why you complicate
things with RCU walking but still I'm of the opinion that we should start
with getting the standard walk working. IMHO pulling in RCU walk into the
iterator will bring it to a completely new complexity level...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

