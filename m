Return-Path: <linux-fsdevel+bounces-5367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164C80AE0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F5F1C20380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6733DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3v/4ykO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iCJjZ0xx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jjWJPbSa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXRMugA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84611F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 10:53:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC0C021CA2;
	Fri,  8 Dec 2023 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702061588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6jzX640zk1UwMmN5qIGiAW5X21d9CHB3QYYUQ4J+ak=;
	b=I3v/4ykODj0T0VJlv+IikiFHkH52RUKmiJvDBh7IqG6w8jda+s2r42ykAkODWCXbAx/z9D
	9UcbscHI3etEjLXOPEH6kjUqj69NTzH23HfEsnxaL6eXLtwgqoDXsnZwAobH0X6Oqxqt/V
	5SGHR3rlVu6kvJniR+8t06U+NBbG4Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702061588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6jzX640zk1UwMmN5qIGiAW5X21d9CHB3QYYUQ4J+ak=;
	b=iCJjZ0xxxx0n2bjpnWNKITUCXBEdLgZJUH0u7R70gRF1Cxm0V5W6Ctckq1zqVcsepEKReb
	VAsnY2Ic39NxtSBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702061587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6jzX640zk1UwMmN5qIGiAW5X21d9CHB3QYYUQ4J+ak=;
	b=jjWJPbSauPCF8XrtWvzzy4RHpTDB/ZU9MXW7vGb8sj1lM+ros1EzQHXcJ76zUbyN4VUhPu
	Ysq9AVfc4hUuVP3vBaKOeCkw0/kozltKhyij8OMWP+i9twMB3Imk9ehjiJDkd5HKwBVhB0
	T1LwXYhFUUdzcKGcCKNzUpve1egO9ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702061587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6jzX640zk1UwMmN5qIGiAW5X21d9CHB3QYYUQ4J+ak=;
	b=DXRMugA+d+jLkTGMTguCszGuDmdT1gAYayLkF7Br4XAXCj2ZG2VP5Zl2Nr6f5eB+8Detsz
	/v/4Fd+uATDb3kDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 93708138FF;
	Fri,  8 Dec 2023 18:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VsKxIxNmc2W2YwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 08 Dec 2023 18:53:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6780A07DC; Fri,  8 Dec 2023 19:53:02 +0100 (CET)
Date: Fri, 8 Dec 2023 19:53:02 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
Message-ID: <20231208185302.wkzvwthf5vuuuk3s@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123825.4011620-5-amir73il@gmail.com>
X-Spam-Score: 11.66
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jjWJPbSa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DXRMugA+;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[23.15%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.79
X-Rspamd-Queue-Id: AC0C021CA2
X-Spam-Flag: NO

On Thu 07-12-23 14:38:25, Amir Goldstein wrote:
> In preparation for pre-content permission events with file access range,
> move fsnotify_file_perm() hook out of security_file_permission() and into
> the callers that have the access range information and pass the access
> range to fsnotify_file_perm().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

So why don't you pass the range into security_file_permission() instead of
pulling fsnotify out of the hook? I mean conceptually the accessed range
makes sense for the hook as well although no LSM currently cares about it.
Also it would address the Christian's concern.

> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 0a9d6a8a747a..45e6ecbca057 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  /*
>   * fsnotify_file_perm - permission hook before file access
>   */
> -static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> +static inline int fsnotify_file_perm(struct file *file, int perm_mask,
> +				     const loff_t *ppos, size_t count)
>  {
>  	__u32 fsnotify_mask = FS_ACCESS_PERM;

Also why do you actually pass in loff_t * instead of plain loff_t? You
don't plan to change it, do you?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

