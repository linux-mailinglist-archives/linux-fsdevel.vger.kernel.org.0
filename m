Return-Path: <linux-fsdevel+bounces-4446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E17FF9F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F689B20BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C65A0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChMYBr83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OFNnkkkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C71A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:40:17 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E07DC1FD02;
	Thu, 30 Nov 2023 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701362414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvf+v2b5RIvd642SREo5j5SAC/i2oi0mKlmYGbsV54=;
	b=ChMYBr838flhamMweyv7qNxef6qBVVsn0uhCbIHA3z18wX7uI5A+/rH7DUTEJ60rrwdB3h
	gNhTabnFtLap7DKul/x4dwpwr9rkbRABYKmTlq4C+kv3oAuT+w65ivxfXBPC77xEtGwROD
	XqOZDdFOI0ES38j4jUo9kbQTP961l8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701362414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvf+v2b5RIvd642SREo5j5SAC/i2oi0mKlmYGbsV54=;
	b=OFNnkkkj6giNynJm87BtXmMYXbU5xm55ShUeLnj72yJbEz+rUqIimddmPYe0Fj4ou9qgbB
	wnGp0IqFqjeS+ECA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC6413A5C;
	Thu, 30 Nov 2023 16:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id v/97Me66aGVXFgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:40:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19455A06F9; Thu, 30 Nov 2023 17:40:10 +0100 (CET)
Date: Thu, 30 Nov 2023 17:40:10 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 2/5] file: remove pointless wrapper
Message-ID: <20231130164010.v3dnlijjznicapkj@quack3>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-2-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130-vfs-files-fixes-v1-2-e73ca6f4ea83@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.99)[-0.987];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.79

On Thu 30-11-23 13:49:08, Christian Brauner wrote:
> Only io_uring uses __close_fd_get_file(). All it does is hide
> current->files but io_uring accesses files_struct directly right now
> anyway so it's a bit pointless. Just rename pick_file() to
> file_close_fd_locked() and let io_uring use it. Add a lockdep assert in
> there that we expect the caller to hold file_lock while we're at it.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c            | 23 +++++++++--------------
>  fs/internal.h        |  2 +-
>  io_uring/openclose.c |  2 +-
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 66f04442a384..c8eaa0b29a08 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -629,19 +629,23 @@ void fd_install(unsigned int fd, struct file *file)
>  EXPORT_SYMBOL(fd_install);
>  
>  /**
> - * pick_file - return file associatd with fd
> + * file_close_fd_locked - return file associated with fd
>   * @files: file struct to retrieve file from
>   * @fd: file descriptor to retrieve file for
>   *
> + * Doesn't take a separate reference count.
> + *
>   * Context: files_lock must be held.
>   *
>   * Returns: The file associated with @fd (NULL if @fd is not open)
>   */
> -static struct file *pick_file(struct files_struct *files, unsigned fd)
> +struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
>  {
>  	struct fdtable *fdt = files_fdtable(files);
>  	struct file *file;
>  
> +	lockdep_assert_held(&files->file_lock);
> +
>  	if (fd >= fdt->max_fds)
>  		return NULL;
>  
> @@ -660,7 +664,7 @@ int close_fd(unsigned fd)
>  	struct file *file;
>  
>  	spin_lock(&files->file_lock);
> -	file = pick_file(files, fd);
> +	file = file_close_fd_locked(files, fd);
>  	spin_unlock(&files->file_lock);
>  	if (!file)
>  		return -EBADF;
> @@ -707,7 +711,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
>  	max_fd = min(max_fd, n);
>  
>  	for (; fd <= max_fd; fd++) {
> -		file = pick_file(files, fd);
> +		file = file_close_fd_locked(files, fd);
>  		if (file) {
>  			spin_unlock(&files->file_lock);
>  			filp_close(file, files);
> @@ -795,15 +799,6 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  	return 0;
>  }
>  
> -/*
> - * See file_close_fd() below, this variant assumes current->files->file_lock
> - * is held.
> - */
> -struct file *__close_fd_get_file(unsigned int fd)
> -{
> -	return pick_file(current->files, fd);
> -}
> -
>  /**
>   * file_close_fd - return file associated with fd
>   * @fd: file descriptor to retrieve file for
> @@ -818,7 +813,7 @@ struct file *file_close_fd(unsigned int fd)
>  	struct file *file;
>  
>  	spin_lock(&files->file_lock);
> -	file = pick_file(files, fd);
> +	file = file_close_fd_locked(files, fd);
>  	spin_unlock(&files->file_lock);
>  
>  	return file;
> diff --git a/fs/internal.h b/fs/internal.h
> index 273e6fd40d1b..a7469ddba9b6 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -179,7 +179,7 @@ extern struct file *do_file_open_root(const struct path *,
>  		const char *, const struct open_flags *);
>  extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flags *op);
> -extern struct file *__close_fd_get_file(unsigned int fd);
> +struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
>  
>  long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
>  int chmod_common(const struct path *path, umode_t mode);
> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index fb73adb89067..74fc22461f48 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -241,7 +241,7 @@ int io_close(struct io_kiocb *req, unsigned int issue_flags)
>  		return -EAGAIN;
>  	}
>  
> -	file = __close_fd_get_file(close->fd);
> +	file = file_close_fd_locked(files, close->fd);
>  	spin_unlock(&files->file_lock);
>  	if (!file)
>  		goto err;
> 
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

