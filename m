Return-Path: <linux-fsdevel+bounces-20950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0548FB3BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915B91F21636
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2AE146A87;
	Tue,  4 Jun 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8oC+bxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCbHatkm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8oC+bxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCbHatkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FB12D758;
	Tue,  4 Jun 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507663; cv=none; b=TeTGY3IBzJ/IX4p3mCfIQH3xybRdzdRJZcxHtSzracFFEgeDdS2z1JEGwWXEHM5O0kuVDuF52xkBbclJprOUGf1ShMncwxganlwpRPMA1CZ+Kx4Bc3mEzo0a+8aV9oGzCUePar8Ro/vA9HJXK919un7iv9rvaPBcTtIpNXnPmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507663; c=relaxed/simple;
	bh=0Qy9AXHwqX38SWa8PE1Y+JZuC4siUhSC1/pt4wv78i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYA0Uwlsdw/Qsagy8Woxkk6S6ekTgUNnujjliclo4MLn/ccjKCMAYjtX5EA75eLa779gcDuT38O2i1JW3/aFFDbLJdoUfdJyBw4WPO8iTSus+IYUP8sgCwuIISBXTpSCULEh5TG8qMJeFWKmuCvSeRAX0BTdOR3fPgvLIFSEVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8oC+bxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCbHatkm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8oC+bxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCbHatkm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93B461F7EB;
	Tue,  4 Jun 2024 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717507658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7H+zBd5uiJxAyzbcMOhCgD45FH3MnrN+m8PM8GN1RQ=;
	b=i8oC+bxdH2LA0/2V2JUJqQo63efBps5CBWsXAENWvsLVyPsPZeM4C2QFAkhXKGiP7tpQwp
	ypdwyEP19VnUPEsugrb6lKuthOrDaHN2VOIRIbJ6lp3YLCsN4HIPjjwPstIb+gT1gD1bZp
	EOKDyI/E7i1JPhsCnvcUYfVuGID57yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717507658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7H+zBd5uiJxAyzbcMOhCgD45FH3MnrN+m8PM8GN1RQ=;
	b=gCbHatkm+GDg8CyHq5ji8eBAXu5QeIEp24DQHcwn//y25tWDFDZmBbeO2PLJUXvNetOLwI
	wgU/vbxemxVACxCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i8oC+bxd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gCbHatkm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717507658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7H+zBd5uiJxAyzbcMOhCgD45FH3MnrN+m8PM8GN1RQ=;
	b=i8oC+bxdH2LA0/2V2JUJqQo63efBps5CBWsXAENWvsLVyPsPZeM4C2QFAkhXKGiP7tpQwp
	ypdwyEP19VnUPEsugrb6lKuthOrDaHN2VOIRIbJ6lp3YLCsN4HIPjjwPstIb+gT1gD1bZp
	EOKDyI/E7i1JPhsCnvcUYfVuGID57yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717507658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7H+zBd5uiJxAyzbcMOhCgD45FH3MnrN+m8PM8GN1RQ=;
	b=gCbHatkm+GDg8CyHq5ji8eBAXu5QeIEp24DQHcwn//y25tWDFDZmBbeO2PLJUXvNetOLwI
	wgU/vbxemxVACxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8822013AB9;
	Tue,  4 Jun 2024 13:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hls1IUoWX2YUfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Jun 2024 13:27:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08289A087A; Tue,  4 Jun 2024 15:27:38 +0200 (CEST)
Date: Tue, 4 Jun 2024 15:27:37 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jan Kara <jack@suse.cz>, axboe@kernel.dk, brauner@kernel.org,
	viro@zeniv.linux.org.uk, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20240604132737.rpo464bhikcvkusy@quack3>
References: <20240604092431.2183929-1-max.kellermann@ionos.com>
 <20240604104151.73n3zmn24hxmmwj6@quack3>
 <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 93B461F7EB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 04-06-24 13:14:05, Max Kellermann wrote:
> On Tue, Jun 4, 2024 at 12:41 PM Jan Kara <jack@suse.cz> wrote:
> > Well, I can see your pain but after all the kernel does exactly what
> > userspace has asked for?
> 
> That is a valid point of view; indeed the kernel's behavior is correct
> according to the specification, but that was not my point.
> 
> This is about an exotic problem that occurs only in very rare
> circumstances (depending on hard disk speed, network speed and
> timing), but when it occurs, it blocks the calling process for a very
> long time, which can then cause problems more serious than user
> unhappiness (e.g. expiring timeouts). (As I said, nginx had to work
> around this problem.)
> 
> I'd like to optimize this special case, and adjust the kernel to
> always behave like the common case.
> 
> > After all there's no substantial difference between userspace issuing a 2GB read(2) and 2GB sendfile(2).
> 
> I understand your fear of breaking userspace, but this doesn't apply
> here, because yes, there is indeed a substantial difference: in the
> normal case, sendfile() stops when the destination socket buffer is
> full. That is the normal mode of operation, which all applications
> must be prepared for, because short sendfile() calls happen all the
> time, that's the common case.
> 
> My patch is ONLY about fixing that exotic special case where the
> socket buffer is drained over and over while sendfile() still runs.

OK, so that was not clear to me (and this may well be just my ignorance of
networking details). Do you say that your patch changes the behavior only
for this cornercase? Even if the socket fd is blocking? AFAIU with your
patch we'd return short write in that case as well (roughly 64k AFAICT
because that's the amount the internal splice pipe will take) but currently
we block waiting for more space in the socket bufs?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

