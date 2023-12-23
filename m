Return-Path: <linux-fsdevel+bounces-6825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949F81D40B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F751C211AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B81D2F8;
	Sat, 23 Dec 2023 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jgvwLcqj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sLXgQir0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jgvwLcqj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sLXgQir0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06ED288;
	Sat, 23 Dec 2023 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B7051FD4A;
	Sat, 23 Dec 2023 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703335611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq6uZ1zPaOibUmv5NcqUrkQEVjzEQzNYsVkUK9LIluQ=;
	b=jgvwLcqjqQgdx+xT7fpuuhh6LblZT9Xd3e0TcUP6lT1gtOmDvZRudxq5W75OxI2p0eEXmu
	ckS8CKuNraMBOUETzbPi3fgesOVg342pJ+gwIkqXldXxp+4hLwgJ7XA2XubEGArJgdfdEv
	9vKlPuWUkZJiGa1mDfTJMiNWm2K9kKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703335611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq6uZ1zPaOibUmv5NcqUrkQEVjzEQzNYsVkUK9LIluQ=;
	b=sLXgQir0HjnmfUFa/BWbX0OLW9umv9djDIr3Dl+NtRzXSbqCslPqHbsBe75Z/MPz6Yyyg7
	8ZJXpqMr1K1RTtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703335611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq6uZ1zPaOibUmv5NcqUrkQEVjzEQzNYsVkUK9LIluQ=;
	b=jgvwLcqjqQgdx+xT7fpuuhh6LblZT9Xd3e0TcUP6lT1gtOmDvZRudxq5W75OxI2p0eEXmu
	ckS8CKuNraMBOUETzbPi3fgesOVg342pJ+gwIkqXldXxp+4hLwgJ7XA2XubEGArJgdfdEv
	9vKlPuWUkZJiGa1mDfTJMiNWm2K9kKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703335611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq6uZ1zPaOibUmv5NcqUrkQEVjzEQzNYsVkUK9LIluQ=;
	b=sLXgQir0HjnmfUFa/BWbX0OLW9umv9djDIr3Dl+NtRzXSbqCslPqHbsBe75Z/MPz6Yyyg7
	8ZJXpqMr1K1RTtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 634D8136F5;
	Sat, 23 Dec 2023 12:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n6lDErvWhmUmDQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 23 Dec 2023 12:46:51 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>,  viro@zeniv.linux.org.uk,
  jaegeuk@kernel.org,  tytso@mit.edu,
  linux-f2fs-devel@lists.sourceforge.net,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ovl: Reject mounting case-insensitive filesystems
In-Reply-To: <CAOQ4uxjhWPB6W+EFyuE-eYbLHehOGRLSfs6K62+h8-f9izJG-A@mail.gmail.com>
	(Amir Goldstein's message of "Sat, 23 Dec 2023 08:20:09 +0200")
Organization: SUSE
References: <20231215211608.6449-1-krisman@suse.de>
	<20231219231222.GI38652@quark.localdomain>
	<87a5q1eecy.fsf_-_@mailhost.krisman.be>
	<CAOQ4uxjhWPB6W+EFyuE-eYbLHehOGRLSfs6K62+h8-f9izJG-A@mail.gmail.com>
Date: Sat, 23 Dec 2023 07:46:46 -0500
Message-ID: <875y0pdr2h.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: ****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.59)[92.33%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jgvwLcqj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sLXgQir0
X-Spam-Score: -3.90
X-Rspamd-Queue-Id: 9B7051FD4A

Amir Goldstein <amir73il@gmail.com> writes:

>> Amir, would you consider this for -rc8?
>
> IIUC, this fixes a regression from v5.10 with a very low likelihood of
> impact on anyone in the real world, so what's the rush?
> I would rather that you send this fix along with your patch set.
>
> Feel free to add:
>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
>
> after fixing nits below

Thanks for your review.

It is fine to wait, and I'll turn it into part of this series, with
your ack, after fixing the details you pointed out.

Thanks,


-- 
Gabriel Krisman Bertazi

