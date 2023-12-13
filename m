Return-Path: <linux-fsdevel+bounces-5988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243A811AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BD51F219CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8556B90;
	Wed, 13 Dec 2023 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNZbo1C5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RiP4Uqcz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNZbo1C5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RiP4Uqcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50019F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 09:28:46 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C43391F451;
	Wed, 13 Dec 2023 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702488524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWK89+37BoTDJP6EBX/6a0z6wiR81v7zHd5JPh+8fn4=;
	b=gNZbo1C5kiRitGXnXsXUyCG18ZEK4CNDGqRQpch58otZkDKa/LO0EzWR8PKsZCwvQLq2xz
	hTEF+4nrRdDRKBFL/alXLx1RPaVglEFrDtffDbaObYM4Tiif7W7Jw79C73d8sl2es6JwKv
	Jng1TiJvgR2Q+N+EHo3kITM684ztb/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702488524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWK89+37BoTDJP6EBX/6a0z6wiR81v7zHd5JPh+8fn4=;
	b=RiP4Uqcz9t8uaZO7JxQpoyts1AA6YPqpBokQ+bmqG1C1xkM/ZOUPXEU8ZoRuCTMqJs4jXe
	uYD/cERr2sk4N1DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702488524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWK89+37BoTDJP6EBX/6a0z6wiR81v7zHd5JPh+8fn4=;
	b=gNZbo1C5kiRitGXnXsXUyCG18ZEK4CNDGqRQpch58otZkDKa/LO0EzWR8PKsZCwvQLq2xz
	hTEF+4nrRdDRKBFL/alXLx1RPaVglEFrDtffDbaObYM4Tiif7W7Jw79C73d8sl2es6JwKv
	Jng1TiJvgR2Q+N+EHo3kITM684ztb/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702488524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWK89+37BoTDJP6EBX/6a0z6wiR81v7zHd5JPh+8fn4=;
	b=RiP4Uqcz9t8uaZO7JxQpoyts1AA6YPqpBokQ+bmqG1C1xkM/ZOUPXEU8ZoRuCTMqJs4jXe
	uYD/cERr2sk4N1DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A8313240;
	Wed, 13 Dec 2023 17:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7IeYK8zpeWV1dgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 17:28:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B9DDA07E0; Wed, 13 Dec 2023 18:28:44 +0100 (CET)
Date: Wed, 13 Dec 2023 18:28:44 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20231213172844.ygjbkyl6i4gj52lt@quack3>
References: <20231208080135.4089880-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208080135.4089880-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Score: -2.60
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.963];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> With FAN_DENY response, user trying to perform the filesystem operation
> gets an error with errno set to EPERM.
> 
> It is useful for hierarchical storage management (HSM) service to be able
> to deny access for reasons more diverse than EPERM, for example EAGAIN,
> if HSM could retry the operation later.
> 
> Allow userspace to response to permission events with the response value
> FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error.
> 
> The change in fanotify_response is backward compatible, because errno is
> written in the high 8 bits of the 32bit response field and old kernels
> reject respose value with high bits set.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

So a couple of comments that spring to my mind when I'm looking into this
now (partly maybe due to my weak memory ;):

1) Do we still need the EAGAIN return? I think we have mostly dealt with
freezing deadlocks in another way, didn't we?

2) If answer to 1) is yes, then there is a second question - do we expect
the errors to propagate back to the unsuspecting application doing say
read(2) syscall? Because I don't think that will fly well with a big
majority of applications which basically treat *any* error from read(2) as
fatal. This is also related to your question about standard permission
events. Consumers of these error numbers are going to be random
applications and I see a potential for rather big confusion arising there
(like read(1) returning EINVAL or EBADF and now you wonder why the hell
until you go debug the kernel and find out the error is coming out of
fanotify handler). And the usecase is not quite clear to me for ordinary
fanotify permission events (while I have no doubts about creativity of
implementors of fanotify handlers ;)).

3) Given the potential for confusion, maybe we should stay conservative and
only allow additional EAGAIN error instead of arbitrary errno if we need it?

I'm leaving the API question aside for a moment until I have a clearer
picture of what we actually want to implement :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

