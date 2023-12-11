Return-Path: <linux-fsdevel+bounces-5503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D96C80CF51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D37281CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698E4AF78;
	Mon, 11 Dec 2023 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PANjyrmr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3int6fk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PANjyrmr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3int6fk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947CD6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:20:31 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8127B1F8D7;
	Mon, 11 Dec 2023 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702308029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opt87pw32JwNI49AFFrKHvPuae/gx9UKCdg6r3SZyvU=;
	b=PANjyrmrnPLFOE8nhikEBr2fyYLr7p8qcRqGZabB5FqpqP/h8IrEt0xVn1bIq17HkC+hFE
	JQQa8UiqTysjr3KU2i/Tst2Ch7fkhRZYd52rc2gZe/lDoX5b1Q+sqst4YgRCnjSCmwcjxc
	DfsTUqhtm0KmUvvZ7S4I6cb6lxVy+Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702308029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opt87pw32JwNI49AFFrKHvPuae/gx9UKCdg6r3SZyvU=;
	b=Y3int6fkkwadbHqRQUYGnSD5shH3zI85jiqAq+DaZGfJRH1rE/wtlz6DOVgzixDFWLNwr9
	dQTlnRXal1+r1ZDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702308029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opt87pw32JwNI49AFFrKHvPuae/gx9UKCdg6r3SZyvU=;
	b=PANjyrmrnPLFOE8nhikEBr2fyYLr7p8qcRqGZabB5FqpqP/h8IrEt0xVn1bIq17HkC+hFE
	JQQa8UiqTysjr3KU2i/Tst2Ch7fkhRZYd52rc2gZe/lDoX5b1Q+sqst4YgRCnjSCmwcjxc
	DfsTUqhtm0KmUvvZ7S4I6cb6lxVy+Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702308029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=opt87pw32JwNI49AFFrKHvPuae/gx9UKCdg6r3SZyvU=;
	b=Y3int6fkkwadbHqRQUYGnSD5shH3zI85jiqAq+DaZGfJRH1rE/wtlz6DOVgzixDFWLNwr9
	dQTlnRXal1+r1ZDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B994134B0;
	Mon, 11 Dec 2023 15:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mbJUFr0od2ULeAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 15:20:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7ADAA07E3; Mon, 11 Dec 2023 16:20:28 +0100 (CET)
Date: Mon, 11 Dec 2023 16:20:28 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fsnotify: optionally pass access range in file
 permission hooks
Message-ID: <20231211152028.uwuram3p3qshxtvr@quack3>
References: <20231210141901.47092-1-amir73il@gmail.com>
 <20231210141901.47092-6-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210141901.47092-6-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Spam-Flag: NO

On Sun 10-12-23 16:19:01, Amir Goldstein wrote:
> In preparation for pre-content permission events with file access range,
> move fsnotify_file_perm() hook out of security_file_permission() and into
> the callers.
> 
> Callers that have the access range information call the new hook
> fsnotify_file_area_perm() with the access range.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

