Return-Path: <linux-fsdevel+bounces-5352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9743B80AC34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6511F211E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8E4CB38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5QvPTqd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="POX53lvA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OsByj8iX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50+V6Tu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423C10EF;
	Fri,  8 Dec 2023 09:22:57 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61CC91F461;
	Fri,  8 Dec 2023 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702056175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAUNZmXImFEly07WmlFPk/rsfz0i0CpByRb3j3+Iq3w=;
	b=n5QvPTqdKgnIQ7TkatCriUq/ZLfkJnZf0XONhD3dHvd9HhCnmP4AA4KZWTPIx1ipHIyTIi
	/3Hu+1qjCghRvq8cv/fyUKeHm+20wZA2GO7ZTiA4V7EhBqsWrJlPWOLweVuMQ5fCsA18cP
	VtlAzmzSLpR1VlnInB/hAIavhryomT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702056175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAUNZmXImFEly07WmlFPk/rsfz0i0CpByRb3j3+Iq3w=;
	b=POX53lvAyWq1i0hdNqrmb+7w6H+rtpn5UbMBV4yNZxlkZSuvwbb+ZVRwozcafxOsbyT1HJ
	zoyTu6+TinSJ76Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702056174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAUNZmXImFEly07WmlFPk/rsfz0i0CpByRb3j3+Iq3w=;
	b=OsByj8iXJQyBMkx30AGQOtPSKx+m+Lqk1WBsX9ZDoBadLPnJamq/fwffbg6garpPjycDNw
	cp1GlwGrDTOLf/OR1wa8DGBwnBhBi1xZrDKyGGHdZqv8u7nneAWjc3SkBXQU6DzWOz908w
	JIIIaS4pxDWfNKaz365sHpWfiEAm9Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702056174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAUNZmXImFEly07WmlFPk/rsfz0i0CpByRb3j3+Iq3w=;
	b=50+V6Tu6xyOcSIJou+0iGZ3Js9M6iFM6iIF7whqSMwix/y5OxSpB+RK8LqHgBSjw22TVtn
	FfGVjLPwaqglp8Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E5B213A6B;
	Fri,  8 Dec 2023 17:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZhbTEu5Qc2XTSwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 17:22:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD7E6A07DC; Fri,  8 Dec 2023 18:22:49 +0100 (CET)
Date: Fri, 8 Dec 2023 18:22:49 +0100
From: Jan Kara <jack@suse.cz>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: super: use GFP_KERNEL instead of GFP_USER for super
 block allocation
Message-ID: <20231208172249.3274eh4cjdnwhjch@quack3>
References: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Score: 8.85
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OsByj8iX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=50+V6Tu6;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [1.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,canonical.com:email,linux.org.uk:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.79
X-Rspamd-Queue-Id: 61CC91F461
X-Spam-Flag: NO

On Fri 08-12-23 16:10:22, Alexander Mikhalitsyn wrote:
> There is no reason to use a GFP_USER flag for struct super_block allocation
> in the alloc_super(). Instead, let's use GFP_KERNEL for that.
> 
> From the memory management perspective, the only difference between
> GFP_USER and GFP_KERNEL is that GFP_USER allocations are tied to a cpuset,
> while GFP_KERNEL ones are not.
> 
> There is no real issue and this is not a candidate to go to the stable,
> but let's fix it for a consistency sake.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Yeah, since we allocate other filesystem objects with GFP_KERNEL as well I
agree. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/super.c b/fs/super.c
> index 076392396e72..6fe482371633 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -323,7 +323,7 @@ static void destroy_unused_super(struct super_block *s)
>  static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  				       struct user_namespace *user_ns)
>  {
> -	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
> +	struct super_block *s = kzalloc(sizeof(struct super_block), GFP_KERNEL);
>  	static const struct super_operations default_op;
>  	int i;
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

